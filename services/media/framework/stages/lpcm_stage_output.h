// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_ENGINE_LPCM_STAGE_OUTPUT_H_
#define SERVICES_MEDIA_FRAMEWORK_ENGINE_LPCM_STAGE_OUTPUT_H_

#include "services/media/framework/allocator.h"
#include "services/media/framework/models/lpcm_frame_buffer.h"
#include "services/media/framework/stages/stage_output.h"

namespace mojo {
namespace media {

class LpcmStageInput;

// Represents a stage's connector to an adjacent downstream stage.
class LpcmStageOutput : public StageOutput {
 public:
  LpcmStageOutput();

  ~LpcmStageOutput();

  // Sets the stream type.
  void set_stream_type(const LpcmStreamType& stream_type);

  // Gets demand suggestion for the stage's input.
  uint64_t demand_suggestion() const {
    if (lpcm_demand_.frame_count() != 0) {
      return lpcm_demand_.frame_count();
    }

    return demand() == Demand::kPositive ? kDefaultFrameCount : 0;
  }

  // Gets the presentation time of the next packet to be supplied. Used for
  // adaptation to non-lpcm input.
  int64_t next_presentation_time() const {
    return next_presentation_time_;
  }

  // Sets the presentation time for the next packet to be supplied. Used for
  // adaptation to non-lpcm input.
  void set_next_presentation_time(int64_t next_presentation_time) {
    next_presentation_time_ = next_presentation_time;
  }

  // Gets the demand signalled from downstream.
  LpcmFrameBuffer& lpcm_demand(uint64_t suggested_frame_count = 0) {
    if (lpcm_demand_.frame_count() == 0 &&
        demand() == Demand::kPositive &&
        !connected_to_lpcm()) {
      DCHECK(buffer_ == nullptr);
      if (suggested_frame_count == 0) {
        suggested_frame_count = kDefaultFrameCount;
      }
      DCHECK(allocator_);
      void* buffer = allocator_->AllocatePayloadBuffer(
          suggested_frame_count * lpcm_demand_.bytes_per_frame());
      if (buffer != nullptr) {
        UpdateLpcmDemand(buffer, suggested_frame_count, false, false);
      }
    }
    return lpcm_demand_;
  }

  // Indicates whether supplied frames should be mixed.
  bool mix() const {
    return mix_;
  }

  // Indicates whether supplied frames need to be delivered synchronously.
  bool synchronous() const {
    return synchronous_;
  }

  // Indicates that all demanded frames have been supplied or we've hit end of
  // stream. Called only by Stage::Update implementations.
  void SupplyFrames(bool end_of_stream, Engine* engine);

  // Demands LPCM frames. Called only by LpcmStageInput instances and
  // LpcmStageOutput::lpcm_demand.
  void UpdateLpcmDemand(
      void* buffer,
      uint64_t frame_count,
      bool mix,
      bool synchronous) {
    buffer_ = buffer;
    frame_count_ = frame_count;
    mix_ = mix;
    synchronous_ = synchronous;

    lpcm_demand_.Set(buffer, frame_count);
  }

  // StageOutput override.
  Allocator* Prepare(bool can_accept_allocator) override;

  LpcmStageOutput* get_lpcm() override;

 private:
  static const uint64_t kDefaultFrameCount = 512;

  bool connected_to_lpcm();

  void* buffer_;
  uint64_t frame_count_;
  bool mix_;
  bool synchronous_;

  LpcmFrameBuffer lpcm_demand_;

  int64_t next_presentation_time_;
  Allocator* allocator_;
};

}  // namespace media
}  // namespace mojo

#endif  // SERVICES_MEDIA_FRAMEWORK_ENGINE_LPCM_STAGE_OUTPUT_H_
