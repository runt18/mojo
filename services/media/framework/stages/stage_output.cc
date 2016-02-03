// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/media/framework/engine.h"
#include "services/media/framework/stages/stage.h"
#include "services/media/framework/stages/stage_output.h"

namespace mojo {
namespace media {

StageOutput::StageOutput() :
    downstream_stage_(nullptr),
    input_index_(0),
    demand_(Demand::kNegative),
    copy_allocator_(nullptr) {}

StageOutput::~StageOutput() {}

void StageOutput::connect(Stage* downstream_stage, uint32_t input_index) {
  DCHECK(downstream_stage);
  DCHECK(input_index < downstream_stage->input_count());
  DCHECK(downstream_stage_ == nullptr);
  downstream_stage_ = downstream_stage;
  input_index_ = input_index;
}

StageInput& StageOutput::mate() const {
  DCHECK(downstream_stage_);
  DCHECK(input_index_ < downstream_stage_->input_count());
  return downstream_stage_->input(input_index_);
}

Allocator* StageOutput::Prepare(bool can_accept_allocator) {
  DCHECK(connected());
  StageInput& mate = this->mate();
  copy_allocator_ = nullptr;

  if (can_accept_allocator) {
    // We can use an allocator. Use our mate's allocator, if it has one.
    return mate.allocator();
  } else if (mate.must_allocate()) {
    // We can't use an allocator, but our mate needs us to. We'll need to copy
    // every packet.
    copy_allocator_ = mate.allocator();
    DCHECK(copy_allocator_);
    return nullptr;
  } else {
    // We can't use an allocator, and our mate doesn't need us to.
    return nullptr;
  }
}

Demand StageOutput::demand() const {
  DCHECK(connected());

  // Return negative demand if mate() already has a packet.
  // We check demand_ here to possibly avoid the second check.
  if (demand_ == Demand::kNegative || mate().packet_from_upstream()) {
    return Demand::kNegative;
  }

  return demand_;
}

void StageOutput::SupplyPacket(PacketPtr packet, Engine* engine) const {
  DCHECK(packet);
  DCHECK(engine);
  DCHECK(connected());

  if (copy_allocator_ != nullptr) {
    // Need to copy the packet due to an allocation conflict.
    uint64_t size = packet->size();
    void *buffer;

    if (size == 0) {
      buffer = nullptr;
    } else {
      buffer = copy_allocator_->AllocatePayloadBuffer(size);
      if (buffer == nullptr) {
        // Starved for buffer space.
        return;
      }
      memcpy(buffer, packet->payload(), size);
    }

    packet = Packet::Create(
        packet->presentation_time(),
        packet->duration(),
        packet->end_of_stream(),
        size,
        buffer,
        copy_allocator_);
  }

  SupplyPacketInternal(std::move(packet), engine);
}

bool StageOutput::UpdateDemand(Demand demand) {
  if (demand_ == demand) {
    return false;
  }
  demand_ = demand;
  return true;
}

LpcmStageOutput* StageOutput::get_lpcm() {
  return nullptr;
}

void StageOutput::SupplyPacketInternal(PacketPtr packet, Engine* engine)
    const {
  DCHECK(packet);
  DCHECK(engine);
  DCHECK(connected());
  if (mate().SupplyPacketFromOutput(std::move(packet))) {
    engine->PushToSupplyBacklogUnsafe(downstream_stage());
  }
}

}  // namespace media
}  // namespace mojo
