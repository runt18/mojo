// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/media/framework/engine.h"
#include "services/media/framework/stages/lpcm_stage_input.h"
#include "services/media/framework/stages/lpcm_stage_output.h"
#include "services/media/framework/stages/stage.h"

namespace mojo {
namespace media {

LpcmStageInput::LpcmStageInput() :
    demand_pending_(false),
    buffer_(nullptr),
    frame_count_(0),
    mix_(false),
    synchronous_(false),
    end_of_stream_(false) {
  packet_exhausted_function_ = [this]() {
    DCHECK(packet_from_upstream());
    packet_from_upstream().reset();
  };
}

LpcmStageInput::~LpcmStageInput() {}

void LpcmStageInput::set_stream_type(const LpcmStreamType& stream_type) {
  lpcm_util_ = LpcmUtil::Create(stream_type);
  lpcm_supply_.set_bytes_per_frame(stream_type.bytes_per_frame());
  packet_frames_.set_bytes_per_frame(stream_type.bytes_per_frame());
  demand_frames_.set_bytes_per_frame(stream_type.bytes_per_frame());
}

void LpcmStageInput::SuggestDemand(uint64_t frame_count, Engine* engine) {
  DCHECK(engine);

  if (demand_pending_ || lpcm_supply_.frame_count() != 0) {
    // We've already demanded. Too late for this suggestion.
    return;
  }

  if (frame_count == 0) {
    // No demand is suggested.
    SetDemand(Demand::kNegative, engine);
    return;
  }

  if (!connected_to_lpcm()) {
    // Upstream output isn't LPCM. Demand packets.
    demand_pending_ = true;
    SetDemand(Demand::kPositive, engine);
    return;
  }

  SetLpcmDemand(
      GetDemandBuffer(frame_count),
      frame_count,
      false,
      false,
      engine);
}

void LpcmStageInput::SetLpcmDemand(
    void* buffer,
    uint64_t frame_count,
    bool mix,
    bool synchronous,
    Engine* engine) {
  DCHECK(engine);
  DCHECK(connected());

  demand_pending_ = true;

  buffer_ = buffer;
  frame_count_ = frame_count;
  mix_ = mix;
  synchronous_ = synchronous;

  if (synchronous) {
    // TODO
    //engine->AddToFallback([lpcm_mate](Engine* engine) {
    //  lpcm_mate->fallback(engine);
    //});
  }

  LpcmStageOutput* lpcm_mate = mate().get_lpcm();
  if (lpcm_mate != nullptr) {
    // The upstream output is LPCM.
    DCHECK(!packet_from_upstream());
    lpcm_mate->UpdateLpcmDemand(buffer, frame_count, mix, synchronous);
    engine->PushToDemandBacklogUnsafe(upstream_stage());
    return;
  }

  demand_frames_.Set(buffer, frame_count);

  // The upstream output isn't LPCM. See if we can satisfy demand with the
  // packet from upstream, if there is one.
  if (CopyOrMixFrames()) {
    // Frames supplied. Add this stage to the supply backlog.
    engine->PushToSupplyBacklogUnsafe(mate().downstream_stage());
  } else {
    // Frames not supplied. Demand another packet.
    SetDemand(Demand::kPositive, engine);
  }
}

bool LpcmStageInput::SupplyPacketFromOutput(PacketPtr packet) {
  StageInput::SupplyPacketFromOutput(std::move(packet));

  demand_pending_ = false;

  if (connected_to_lpcm()) {
    // The upstream output is LPCM, so the packet should be a wrapper for the
    // demand buffer (buffer_). In this case, we can release the packet,
    // because the frames are already where we want them.
    DCHECK(packet_from_upstream()->payload() == buffer_);
    DCHECK(packet_from_upstream()->duration() <= frame_count_);
    end_of_stream_ = packet_from_upstream()->end_of_stream();
    lpcm_supply_.Set(
        packet_from_upstream()->payload(),
        packet_from_upstream()->duration());
    packet_from_upstream().reset();
    return true;
  }

  if (buffer_ == nullptr) {
    // The upstream output isn't LPCM, and the stage hasn't supplied a buffer.
    // We'll supply frames right out of the packet payload and reset the
    // packet pointer when the frames are exhausted.
    DCHECK(!mix_);
    end_of_stream_ = packet_from_upstream()->end_of_stream();
    lpcm_supply_.Set(
        packet_from_upstream()->payload(),
        packet_from_upstream()->duration(),
        packet_exhausted_function_);
    return true;
  }

  // The upstream output isn't LPCM, and the stage has supplied a buffer. That
  // means we have to copy or mix from the packet to the supplied buffer. We
  // initialize packet_frames_ for that purpose and call CopyOrMixFrames.
  packet_frames_.Set(
      packet_from_upstream()->payload(),
      packet_from_upstream()->duration(),
      packet_exhausted_function_);

  return CopyOrMixFrames();
}

LpcmStageInput* LpcmStageInput::get_lpcm() {
  return this;
}

bool LpcmStageInput::connected_to_lpcm() {
  return mate().get_lpcm() != nullptr;
}

bool LpcmStageInput::CopyOrMixFrames() {
  DCHECK(buffer_);
  DCHECK(demand_frames_.buffer());

  uint64_t frame_count = std::min(
      packet_frames_.frame_count(),
      demand_frames_.frame_count());

  if (frame_count == 0) {
    return false;
  }

  DCHECK(packet_from_upstream());

  if (mix_) {
    lpcm_util_->Mix(
        packet_frames_.buffer(),
        demand_frames_.buffer(),
        frame_count);
  } else {
    lpcm_util_->Copy(
        packet_frames_.buffer(),
        demand_frames_.buffer(),
        frame_count);
  }

  bool end_of_stream = packet_from_upstream()->end_of_stream();

  packet_frames_.Advance(frame_count);
  demand_frames_.Advance(frame_count);

  if (demand_frames_.frame_count() == 0 ||
      (packet_frames_.frame_count() == 0 && end_of_stream)) {
    end_of_stream_ = end_of_stream;
    lpcm_supply_.Set(buffer_, frame_count_ - demand_frames_.frame_count());
    demand_frames_.Reset();
    return true;
  }

  return false;
}

void* LpcmStageInput::GetDemandBuffer(uint64_t frame_count) {
  if (demand_buffer_.size() < frame_count) {
    demand_buffer_.clear();
    demand_buffer_.resize(frame_count);
  }
  return &demand_buffer_[0];
}

}  // namespace media
}  // namespace mojo
