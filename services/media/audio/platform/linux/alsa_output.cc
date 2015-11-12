// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <limits>
#include <set>

#include "mojo/services/media/common/cpp/local_time.h"
#include "services/media/audio/platform/linux/alsa_output.h"

namespace mojo {
namespace media {
namespace audio {

static constexpr LocalDuration TARGET_LATENCY = local_time::from_msec(35);
static constexpr LocalDuration LOW_BUF_THRESH = local_time::from_msec(30);
static constexpr LocalDuration ERROR_RECOVERY_TIME = local_time::from_msec(300);
static constexpr LocalDuration WAIT_FOR_ALSA_DELAY = local_time::from_usec(500);
static const std::set<uint8_t> SUPPORTED_CHANNEL_COUNTS({ 1, 2 });
static const std::set<uint32_t> SUPPORTED_SAMPLE_RATES({
    48000, 32000, 24000, 16000, 8000, 4000,
    44100, 22050, 11025,
});

static inline bool IsRecoverableAlsaError(int error_code) {
  switch (error_code) {
  case -EINTR:
  case -EPIPE:
  case -ESTRPIPE:
    return true;
  default:
    return false;
  }
}

AudioOutputPtr CreateDefaultAlsaOutput(AudioOutputManager* manager) {
  // TODO(johngro): Do better than this.  If we really want to support
  // Linux/ALSA as a platform, we should be creating one output for each
  // physical output in the system, matching our configuration to the physical
  // output's configuration, and disabling resampling at the ALSA level.
  //
  // If we could own the output entirely and bypass the mixer to achieve lower
  // latency, that would be even better.
  AudioOutputPtr audio_out(audio::AlsaOutput::New(manager));
  if (!audio_out) { return nullptr; }

  AlsaOutput* alsa_out = static_cast<AlsaOutput*>(audio_out.get());
  DCHECK(alsa_out);

  LpcmMediaTypeDetailsPtr config(LpcmMediaTypeDetails::New());
  config->frames_per_second = 48000;
  config->samples_per_frame = 2;
  config->sample_format = LpcmSampleFormat::SIGNED_16;

  if (alsa_out->Configure(config.Pass()) != MediaResult::OK) {
    return nullptr;
  }

  return audio_out;
}

AlsaOutput::AlsaOutput(AudioOutputManager* manager)
  : StandardOutputBase(manager) {}

AlsaOutput::~AlsaOutput() {
  // We should have been cleaned up already, but in release builds, call cleanup
  // anyway, just in case something got missed.
  DCHECK(!alsa_device_);
  Cleanup();
}

AudioOutputPtr AlsaOutput::New(AudioOutputManager* manager) {
  return AudioOutputPtr(new AlsaOutput(manager));
}

MediaResult AlsaOutput::Configure(LpcmMediaTypeDetailsPtr config) {
  if (!config) { return MediaResult::INVALID_ARGUMENT; }
  if (output_format_) { return MediaResult::BAD_STATE; }

  uint32_t bytes_per_sample;
  switch (config->sample_format) {
  case LpcmSampleFormat::UNSIGNED_8:
    alsa_format_ = SND_PCM_FORMAT_U8;
    silence_byte_ = 0x80;
    bytes_per_sample = 1;
    break;

  case LpcmSampleFormat::SIGNED_16:
    alsa_format_ = SND_PCM_FORMAT_S16;
    silence_byte_ = 0x00;
    bytes_per_sample = 2;
    break;

  case LpcmSampleFormat::SIGNED_24_IN_32:
  default:
    return MediaResult::UNSUPPORTED_CONFIG;
  }

  if (SUPPORTED_SAMPLE_RATES.find(config->frames_per_second) ==
      SUPPORTED_SAMPLE_RATES.end()) {
    return MediaResult::UNSUPPORTED_CONFIG;
  }

  if (SUPPORTED_CHANNEL_COUNTS.find(config->samples_per_frame) ==
      SUPPORTED_CHANNEL_COUNTS.end()) {
    return MediaResult::UNSUPPORTED_CONFIG;
  }

  // Compute the ratio between frames and local time ticks.
  LinearTransform::Ratio sec_per_tick(LocalDuration::period::num,
                                      LocalDuration::period::den);
  LinearTransform::Ratio frames_per_sec(config->frames_per_second, 1);
  bool is_precise = LinearTransform::Ratio::Compose(frames_per_sec,
                                                    sec_per_tick,
                                                    &frames_per_tick_);
  DCHECK(is_precise);

  // Figure out how many bytes there are per frame.
  output_bytes_per_frame_ = bytes_per_sample * config->samples_per_frame;

  // Success
  output_format_ = config.Pass();
  return MediaResult::OK;
}

MediaResult AlsaOutput::Init() {
  static const char* kAlsaDevice = "default";

  if (!output_format_) { return MediaResult::BAD_STATE; }
  if (alsa_device_) { return MediaResult::BAD_STATE; }

  snd_pcm_sframes_t res;
  res = snd_pcm_open(&alsa_device_,
                     kAlsaDevice,
                     SND_PCM_STREAM_PLAYBACK,
                     SND_PCM_NONBLOCK);
  if (res != 0) {
    LOG(ERROR) << "Failed to open ALSA device \"" << kAlsaDevice << "\".";
    return MediaResult::INTERNAL_ERROR;
  }

  res = snd_pcm_set_params(alsa_device_,
                           alsa_format_,
                           SND_PCM_ACCESS_RW_INTERLEAVED,
                           output_format_->samples_per_frame,
                           output_format_->frames_per_second,
                           0,   // do not allow ALSA resample
                           local_time::to_usec<unsigned int>(TARGET_LATENCY));
  if (res) {
    LOG(ERROR) << "Failed to configure ALSA device \"" << kAlsaDevice << "\" "
               << "(res = " << res << ")";
    LOG(ERROR) << "Requested samples per frame: "
               << output_format_->samples_per_frame;
    LOG(ERROR) << "Requested frames per second: "
               << output_format_->frames_per_second;
    LOG(ERROR) << "Requested ALSA format      : " << alsa_format_;
    Cleanup();
    return MediaResult::INTERNAL_ERROR;
  }

  // Figure out how big our mixing buffer needs to be, then allocate it.
  res = snd_pcm_avail_update(alsa_device_);
  if (res <= 0) {
    LOG(ERROR) << "[" << this << "] : "
               << "Fatal error (" << res
               << ") attempting to determine ALSA buffer size.";
    Cleanup();
    return MediaResult::INTERNAL_ERROR;
  }

  mix_buf_frames_ = res;
  mix_buf_.reset(new uint8_t[mix_buf_frames_ * output_bytes_per_frame_]);

  return MediaResult::OK;
}

void AlsaOutput::Cleanup() {
  if (alsa_device_) {
    snd_pcm_close(alsa_device_);
    alsa_device_ = nullptr;
  }

  mix_buf_ = nullptr;
  mix_buf_frames_ = 0;
}

bool AlsaOutput::StartMixJob(MixJob* job, const LocalTime& process_start) {
  DCHECK(job);

  // Are we not primed?  If so, fill a mix buffer with silence and send it to
  // the alsa device.  Schedule a callback for a short time in the future so
  // ALSA has a chance to start the output and we can take our best guess of the
  // function which maps output frames to local time.
  if (!primed_) {
    HandleAsUnderflow();
    return false;
  }

  // Figure out how many frames of audio we need to produce in order to top off
  // the buffer.  If we are primed, but do not know the transformation between
  // audio frames and local time ticks, do our best to figure it out in the
  // process.
  snd_pcm_sframes_t avail;
  if (!local_to_output_known_) {
    snd_pcm_sframes_t delay;

    int res = snd_pcm_avail_delay(alsa_device_, &avail, &delay);
    LocalTime now = LocalClock::now();

    if (res < 0) {
      HandleAlsaError(res);
      return false;
    }

    DCHECK_GE(delay, 0);
    int64_t now_ticks = now.time_since_epoch().count();
    local_to_output_ = LinearTransform(now_ticks, frames_per_tick_, -delay);
    local_to_output_known_ = true;
    frames_sent_ = 0;
    while (++local_to_output_gen_ == MixJob::INVALID_GENERATION) {}
  } else {
    avail = snd_pcm_avail_update(alsa_device_);
    if (avail < 0) {
      HandleAlsaError(avail);
      return false;
    }
  }

  // Compute the time that we think we will completely underflow, then back off
  // from that by the low buffer threshold and use that to determine when we
  // should mix again.
  int64_t playout_time_ticks;
  bool trans_ok = local_to_output_.DoReverseTransform(frames_sent_,
                                                      &playout_time_ticks);
  DCHECK(trans_ok);
  LocalTime playout_time = LocalTime(LocalDuration(playout_time_ticks));
  LocalTime low_buf_time = playout_time - LOW_BUF_THRESH;

  if (process_start >= low_buf_time) {
    // Because of the way that ALSA consumes data and updates its internal
    // bookkeeping, it is possible that we are past our low buffer threshold,
    // but ALSA still thinks that there is no room to write new frames.  If this
    // is the case, just try again a short amount of time in the future.
    DCHECK_GE(avail, 0);
    if (!avail) {
      SetNextSchedDelay(WAIT_FOR_ALSA_DELAY);
      return false;
    }

    // Limit the amt that we queue to be no more than what ALSA will currently
    // accept, or what it currently will take to fill us to our target latency.
    //
    // The playout target had better be ahead of the playout time, or we are
    // almost certainly going to underflow.  If this happens, for whatever
    // reason, just try to send a full buffer and deal with the underflow when
    // ALSA notices it.
    int64_t fill_amt;
    LocalTime playout_target = LocalClock::now() + TARGET_LATENCY;
    if (playout_target > playout_time) {
      fill_amt = (playout_target - playout_time).count();
    } else {
      fill_amt = TARGET_LATENCY.count();
    }

    DCHECK_GE(fill_amt, 0);
    DCHECK_LE(fill_amt, std::numeric_limits<int32_t>::max());
    fill_amt *= frames_per_tick_.numerator;
    fill_amt += frames_per_tick_.denominator - 1;
    fill_amt /= frames_per_tick_.denominator;

    job->buf_frames = (avail < fill_amt) ? avail : fill_amt;
    if (job->buf_frames > mix_buf_frames_) {
      job->buf_frames = mix_buf_frames_;
    }

    job->buf = mix_buf_.get();
    job->start_pts_of = frames_sent_;
    job->local_to_output = &local_to_output_;
    job->local_to_output_gen = local_to_output_gen_;

    // TODO(johngro): optimize this if we can.  The first buffer we mix can just
    // put its samples directly into the output buffer, and does not need to
    // accumulate and clip.  In theory, we only need to put silence in the
    // places where our outputs are not going to already overwrite.
    FillMixBufWithSilence(job->buf_frames);
    return true;
  }

  // Wait until its time to mix some more data.
  SetNextSchedTime(low_buf_time);
  return false;
}

bool AlsaOutput::FinishMixJob(const MixJob& job) {
  DCHECK(job.buf == mix_buf_.get());
  DCHECK(job.buf_frames);

  // We should always be able to write all of the data that we mixed.
  snd_pcm_sframes_t res;
  res = snd_pcm_writei(alsa_device_, job.buf, job.buf_frames);
  if (res != job.buf_frames) {
    HandleAlsaError(res);
    return false;
  }

  frames_sent_ += res;
  return true;
}

void AlsaOutput::FillMixBufWithSilence(uint32_t frames) {
  DCHECK(mix_buf_);
  DCHECK(frames <= mix_buf_frames_);

  // TODO(johngro): someday, this may not be this simple.  Filling unsigned
  // multibyte sample formats, or floating point formats, will require something
  // more sophisticated than filling with a single byte pattern.
  ::memset(mix_buf_.get(), silence_byte_, frames * output_bytes_per_frame_);
}

void AlsaOutput::HandleAsUnderflow() {
  snd_pcm_sframes_t res;

  // If we were already primed, then this is a legitimate underflow, not the
  // startup case or recovery from some other error.
  if (primed_) {
    // TODO(johngro): come up with a way to properly throttle this.  Also, add a
    // friendly name to the output so the log helps to identify which output
    // underflowed.
    LOG(WARNING) << "[" << this << "] : underflow";
    res = snd_pcm_recover(alsa_device_, -EPIPE, true);
    if (res < 0) {
      HandleAsError(res);
      return;
    }
  }

  // TODO(johngro): We don't actually have to fill up the entire lead time with
  // silence.  When we have better control of our thread priorities, prime this
  // with the minimimum amt we can get away with and still be able to start
  // mixing without underflowing.
  FillMixBufWithSilence(mix_buf_frames_);
  res = snd_pcm_writei(alsa_device_, mix_buf_.get(), mix_buf_frames_);

  if (res < 0) {
    HandleAsError(res);
    return;
  }

  primed_ = true;
  local_to_output_known_ = false;
  SetNextSchedDelay(local_time::from_msec(1));
}

void AlsaOutput::HandleAsError(snd_pcm_sframes_t code) {
  // TODO(johngro): Throttle this somehow.
  LOG(WARNING) << "[" << this << "] : Attempting to recover from ALSA error "
               << code;

  if (IsRecoverableAlsaError(code)) {
    snd_pcm_sframes_t new_code;

    new_code = snd_pcm_recover(alsa_device_, code, true);
    DCHECK(!new_code || (new_code == code));

    // If we recovered, or we didn't and the original error was EINTR, schedule
    // a retry time in the future and unwind.
    //
    // TODO(johngro): revisit the topic of errors we fail to snd_pcm_recover
    // from.  If we cannot recover from them, we should probably close and
    // re-open the device.  No matter what, we should put some form of limit on
    // how many times we try before really giving up and shutting down the
    // output for good.  We also need to invent a good way to test these edge
    // cases.
    if (!new_code || (new_code == -EINTR)) {
      primed_ = false;
      local_to_output_known_ = false;
      SetNextSchedDelay(ERROR_RECOVERY_TIME);
    }
  }

  LOG(ERROR) << "[" << this << "] : Fatal ALSA error "
             << code << ".  Shutting down";
  ShutdownSelf();
}

void AlsaOutput::HandleAlsaError(snd_pcm_sframes_t code) {
  // ALSA signals an underflow by returning -EPIPE from jobs.  If the error code
  // is -EPIPE, treat this as an underflow and attempt to reprime the pipeline.
  if (code == -EPIPE) {
    HandleAsUnderflow();
  } else {
    HandleAsError(code);
  }
}

}  // namespace audio
}  // namespace media
}  // namespace mojo

