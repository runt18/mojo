// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/media/framework/engine.h"
#include "services/media/framework/stages/lpcm_stage_input.h"
#include "services/media/framework/stages/lpcm_stage_output.h"
#include "services/media/framework/stages/stage.h"

namespace mojo {
namespace media {

LpcmStageOutput::LpcmStageOutput() :
    buffer_(nullptr),
    frame_count_(0),
    mix_(false),
    synchronous_(false),
    next_presentation_time_(0) {}

LpcmStageOutput::~LpcmStageOutput() {}

void LpcmStageOutput::set_stream_type(const LpcmStreamType& stream_type) {
  lpcm_demand_.set_bytes_per_frame(stream_type.bytes_per_frame());
}

void LpcmStageOutput::SupplyFrames(bool end_of_stream, Engine* engine) {
  DCHECK(engine);
  DCHECK(connected());
  DCHECK(end_of_stream || buffer_);

  uint64_t duration = frame_count_ - lpcm_demand_.frame_count();
  if (allocator_ != nullptr) {
    SupplyPacketInternal(
        Packet::Create(
            next_presentation_time_,
            duration,
            end_of_stream,
            duration * lpcm_demand_.bytes_per_frame(),
            duration == 0 ? nullptr : buffer_,
            allocator_),
        engine);
  } else {
    SupplyPacketInternal(
        Packet::CreateNoAllocator(
            next_presentation_time_,
            duration,
            end_of_stream,
            duration * lpcm_demand_.bytes_per_frame(),
            duration == 0 ? nullptr : buffer_),
        engine);
  }

  next_presentation_time_ += duration;

  buffer_ = nullptr;
  frame_count_ = 0;
  mix_ = false;
  synchronous_ = false;
  lpcm_demand_.Reset();
}

Allocator* LpcmStageOutput::Prepare(bool can_accept_allocator) {
  // The stage isn't concerned with allocators, but we'll need one if our mate
  // isn't LPCM.
  Allocator* allocator = StageOutput::Prepare(true);
  DCHECK(!connected_to_lpcm() || allocator == nullptr);
  if (!connected_to_lpcm()) {
    // Our mate isn't lpcm, so we'll need an allocator to create packet buffers.
    // Use the provided one or the default.
    allocator_ = allocator == nullptr ? Allocator::GetDefault() : allocator;
  }

  return nullptr;
}

LpcmStageOutput* LpcmStageOutput::get_lpcm() {
  return this;
}

bool LpcmStageOutput::connected_to_lpcm() {
  return mate().get_lpcm() != nullptr;
}

}  // namespace media
}  // namespace mojo
