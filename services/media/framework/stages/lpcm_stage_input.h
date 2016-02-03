// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_ENGINE_LPCM_STAGE_INPUT_H_
#define SERVICES_MEDIA_FRAMEWORK_ENGINE_LPCM_STAGE_INPUT_H_

#include <vector>

#include "services/media/framework/lpcm_util.h"
#include "services/media/framework/models/demand.h"
#include "services/media/framework/models/lpcm_frame_buffer.h"
#include "services/media/framework/stages/stage_input.h"

namespace mojo {
namespace media {

class LpcmStageOutput;

// Represents a stage's connector to an adjacent upstream stage, with LPCM
// optmizations.
class LpcmStageInput : public StageInput {
 public:
  LpcmStageInput();

  ~LpcmStageInput();

  // Sets the stream type.
  void set_stream_type(const LpcmStreamType& stream_type);

  // Suggests possible demand frame count, useful when !connected_to_lpcm().
  void SuggestDemand(uint64_t frame_count, Engine* engine);

  // Updates the demand signalled to the connected upstream output.
  void SetLpcmDemand(
      void* buffer,
      uint64_t frame_count,
      bool mix,
      bool synchronous,
      Engine* engine);

  // Indicates whether demand is pending.
  bool demand_pending() const {
    return demand_pending_;
  }

  // Returns supplied frames.
  LpcmFrameBuffer& lpcm_supply() {
    return lpcm_supply_;
  }

  // Indicates whether we've hit end-of-stream.
  bool end_of_stream() const {
    return end_of_stream_;
  }

  // Indicates the frame count originally demanded.
  uint64_t demand_frame_count() const {
    return frame_count_;
  }

  // StageInput overrides.
  bool SupplyPacketFromOutput(PacketPtr packet) override;

  LpcmStageInput* get_lpcm() override;

 private:
  static const uint64_t kDefaultFrameCount = 512;

  bool connected_to_lpcm();

  // Copies or mixes frames from packet_frames_ to demand_frames_. This is only
  // used when !connected_to_lpcm() and the stage has supplied a buffer. The
  // return value indicates whether the demand was met.
  bool CopyOrMixFrames();

  // Ensures demand_buffer_ can accommodate frame_count frames and returns it.
  void* GetDemandBuffer(uint64_t frame_count);

  bool demand_pending_;

  void* buffer_;
  uint64_t frame_count_;
  bool mix_;
  bool synchronous_;

  LpcmFrameBuffer lpcm_supply_; // Frames supplied to this stage.
  LpcmFrameBuffer packet_frames_; // Source for packet payload copy/mix.
  LpcmFrameBuffer demand_frames_; // Destination for packet payload copy/mix.

  bool end_of_stream_;

  std::unique_ptr<LpcmUtil> lpcm_util_;
  std::vector<uint8_t> demand_buffer_;

  LpcmFrameBuffer::ExhaustedCallback packet_exhausted_function_;
};

}  // namespace media
}  // namespace mojo

#endif  // SERVICES_MEDIA_FRAMEWORK_ENGINE_LPCM_STAGE_INPUT_H_
