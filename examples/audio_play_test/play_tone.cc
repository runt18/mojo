// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <math.h>
#include <memory>

#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_delegate.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/public/cpp/application/application_runner.h"
#include "mojo/public/cpp/utility/run_loop.h"
#include "mojo/services/media/audio/interfaces/audio_server.mojom.h"
#include "mojo/services/media/audio/interfaces/audio_track.mojom.h"
#include "mojo/services/media/common/cpp/circular_buffer_media_pipe_adapter.h"
#include "mojo/services/media/common/cpp/linear_transform.h"
#include "mojo/services/media/common/cpp/local_time.h"
#include "mojo/services/media/common/interfaces/rate_control.mojom.h"

namespace mojo {
namespace media {
namespace audio {
namespace examples {

static constexpr uint32_t SAMP_FREQ = 48000;
static constexpr uint32_t CHUNK_USEC = 1000;
static constexpr uint32_t BUF_LO_WATER_USEC = 50000;
static constexpr uint32_t BUF_HI_WATER_USEC = BUF_LO_WATER_USEC
                                            + (4 * CHUNK_USEC);
static constexpr uint32_t BUF_DEPTH_USEC    = BUF_HI_WATER_USEC
                                            + (4 * CHUNK_USEC);
static constexpr uint32_t FRAME_BYTES = sizeof(int16_t);

static inline constexpr uint32_t USecToBytes(uint64_t usec) {
  return ((usec * SAMP_FREQ) / 1000000) * FRAME_BYTES;
}

class PlayToneApp : public ApplicationDelegate {
 public:
  void Initialize(ApplicationImpl* app) override;

 private:
  bool GenerateToneCbk(MediaResult res);
  void PlayTone(double freq_hz, double amplitude, double duration_sec);
  void Cleanup();

  AudioServerPtr audio_server_;
  AudioTrackPtr  audio_track_;
  RateControlPtr rate_control_;
  std::unique_ptr<CircularBufferMediaPipeAdapter> pipe_;

  bool     clock_started_ = false;
  uint64_t media_time_    = 0;
  double   freq_hz_       = 440.0;
  double   amplitude_     = 1.0;
};

void PlayToneApp::Initialize(ApplicationImpl* app) {
  MediaResult result = MediaResult::UNKNOWN_ERROR;

  app->ConnectToService("mojo:audio_server", &audio_server_);
  audio_server_->CreateTrack(GetProxy(&audio_track_));

  // Query the sink's format capabilities.
  AudioTrackDescriptorPtr sink_desc;
  auto desc_cbk = [&sink_desc](AudioTrackDescriptorPtr desc) {
    sink_desc = desc.Pass();
  };
  audio_track_->Describe(AudioTrack::DescribeCallback(desc_cbk));

  // TODO(johngro): this pattern is awkward.  We really don't want to be
  // calling WaitForIncomingResponse, even if we were able supply a timeout.
  // The best practice would be to defer to a handler for the message we are
  // expecting to eventually come back.
  //
  // But... what if the message never comes back?  Perhaps the service is not
  // implemented properly, or perhaps the service is malicious.  We could
  // queue a delayed message on our run loop which indicates a timeout, but
  // then what happens when when the response to Describe comes back (as
  // expected).  We don't really have a good way to cancel the "timeout"
  // message once we have queued it.  Maintaining all of the bookkeeping
  // required to nerf the callback when it happens and is discovered to be
  // useless is going to get very old, very fast.
  //
  // For now, we just do the evil thing and block during init, but I sure do
  // wish there was something nicer we could do.
  if (!audio_track_.WaitForIncomingResponse()) {
    MOJO_LOG(ERROR)
      << "Failed to fetch sync capabilities; no response received.";
    Cleanup();
    return;
  }

  // TODO(johngro): do something useful with our capabilities description.
  sink_desc.reset();

  // Grab the rate control interface for our audio renderer.
  auto get_rc_cbk = [&result](MediaResult res) { result = res; };
  audio_track_->GetRateControl(GetProxy(&rate_control_), get_rc_cbk);
  if (!audio_track_.WaitForIncomingResponse()) {
    MOJO_LOG(ERROR) <<
      "Failed to fetch rate control interface; no response received.";
    Cleanup();
    return;
  }

  if (result != MediaResult::OK) {
    MOJO_LOG(ERROR) << "Failed to get rate control interface.  (res = "
               << result << ")";
    Cleanup();
    return;
  }

  // Configure our sink for 16-bit 48KHz mono.
  AudioTrackConfigurationPtr cfg = AudioTrackConfiguration::New();
  cfg->max_frames = USecToBytes(BUF_DEPTH_USEC) / FRAME_BYTES;

  LpcmMediaTypeDetailsPtr pcm_cfg = LpcmMediaTypeDetails::New();
  pcm_cfg->sample_format     = LpcmSampleFormat::SIGNED_16;
  pcm_cfg->samples_per_frame = 1;
  pcm_cfg->frames_per_second = SAMP_FREQ;

  cfg->media_type = MediaType::New();
  cfg->media_type->scheme = MediaTypeScheme::LPCM;
  cfg->media_type->details = MediaTypeDetails::New();
  cfg->media_type->details->set_lpcm(pcm_cfg.Pass());

  MediaPipePtr pipe;
  {
    auto cbk = [&result](MediaResult res) {
      result = res;
    };
    audio_track_->Configure(cfg.Pass(), GetProxy(&pipe), cbk);
  }

  if (!audio_track_.WaitForIncomingResponse()) {
    MOJO_LOG(ERROR) << "Failed to configure sink; no response received.";
    Cleanup();
    return;
  }

  if (result != MediaResult::OK) {
    MOJO_LOG(ERROR) << "Failed to configure sink.  (res = "
                    << result << ")";
    Cleanup();
    return;
  }

  // Now that we are configured and have our media pipe, pass its interface to
  // our circular buffer helper, set up our high/low water marks, register our
  // callback, and start to buffer our audio.
  pipe_.reset(new CircularBufferMediaPipeAdapter(pipe.Pass()));
  pipe_->SetSignalCallback(
    [this](MediaResult res) -> bool {
      return GenerateToneCbk(res);
    });
  pipe_->SetWatermarks(USecToBytes(BUF_HI_WATER_USEC),
                       USecToBytes(BUF_LO_WATER_USEC));
}

bool PlayToneApp::GenerateToneCbk(MediaResult res) {
  using MappedPacket = CircularBufferMediaPipeAdapter::MappedPacket;
  MappedPacket mapped_pkt;

  MOJO_DCHECK(freq_hz_ > 0.0);
  MOJO_DCHECK(amplitude_ >= 0.0);
  MOJO_DCHECK(amplitude_ <= 1.0);

  if (res != MediaResult::OK) {
    MOJO_LOG(ERROR) << "Fatal error in cbuf (" << res << ").";
    Cleanup();
    return false;
  }

  while (!pipe_->AboveHiWater()) {
    res = pipe_->CreateMediaPacket(USecToBytes(CHUNK_USEC),
                                   false,
                                   &mapped_pkt);
    if (res != MediaResult::OK) {
      MOJO_LOG(ERROR) << "Unexpected error when creating media packet ("
                 << res << ").";
      Cleanup();
      return false;
    }

    mapped_pkt.packet()->pts = media_time_;

    for (uint32_t i = 0; i < MappedPacket::kMaxRegions; ++i) {
      int16_t* data = reinterpret_cast<int16_t*>(mapped_pkt.data(i));
      uint64_t len;

      if (!data) continue;
      len = mapped_pkt.length(i);

      MOJO_DCHECK(len && !(len % FRAME_BYTES));
      len /= FRAME_BYTES;
      for (uint64_t i = 0; i < len; ++i, ++media_time_) {
        double tmp = ((M_PI * 2.0) / SAMP_FREQ) * freq_hz_ * media_time_;
        data[i] = std::numeric_limits<int16_t>::max() * amplitude_ * sin(tmp);
      }
    }

    res = pipe_->SendMediaPacket(&mapped_pkt);
    if (res != MediaResult::OK) {
      MOJO_LOG(ERROR) << "Unexpected error when sending media packet ("
                 << res << ").";
      pipe_->CancelMediaPacket(&mapped_pkt);
      Cleanup();
      return false;
    }
  }

  if (!clock_started_) {
    // In theory, this could be done at compile time using std::ratio, but
    // std::ratio is prohibited.
    LinearTransform::Ratio audio_rate(SAMP_FREQ, 1);
    LinearTransform::Ratio local_time_rate(LocalDuration::period::num,
                                           LocalDuration::period::den);
    LinearTransform::Ratio rate;
    bool success = LinearTransform::Ratio::Compose(local_time_rate,
                                                   audio_rate,
                                                   &rate);
    MOJO_DCHECK(success);  // assert that there was no loss of precision.

    MOJO_LOG(INFO) << "Setting rate " << rate;

    rate_control_->SetRate(rate.numerator, rate.denominator);
    clock_started_ = true;
  }

  return true;
}

void PlayToneApp::Cleanup() {
  audio_track_.reset();
  audio_server_.reset();
  RunLoop::current()->Quit();
}

}  // namespace examples
}  // namespace audio
}  // namespace media
}  // namespace mojo

MojoResult MojoMain(MojoHandle app_request) {
  mojo::ApplicationRunner runner(new mojo::media::audio::examples::PlayToneApp);
  return runner.Run(app_request);
}
