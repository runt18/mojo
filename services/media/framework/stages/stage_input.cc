// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/media/framework/engine.h"
#include "services/media/framework/stages/stage.h"
#include "services/media/framework/stages/stage_input.h"

namespace mojo {
namespace media {

StageInput::StageInput() :
    upstream_stage_(nullptr),
    output_index_(0),
    allocator_(nullptr),
    must_allocate_(false) {}

StageInput::~StageInput() {}

void StageInput::connect(Stage* upstream_stage, uint32_t output_index) {
  DCHECK(upstream_stage);
  DCHECK(output_index < upstream_stage->output_count());
  DCHECK(upstream_stage_ == nullptr);
  upstream_stage_ = upstream_stage;
  output_index_ = output_index;
}

StageOutput& StageInput::mate() const {
  DCHECK(upstream_stage_);
  DCHECK(output_index_ < upstream_stage_->output_count());
  return upstream_stage_->output(output_index_);
}

void StageInput::Prepare(Allocator* allocator, bool must_allocate) {
  DCHECK(allocator != nullptr || must_allocate == false);
  allocator_ = allocator;
  must_allocate_ = must_allocate;
}

Allocator* StageInput::allocator() const {
  DCHECK(connected());
  DCHECK(mate().downstream_stage()->prepared());
  return allocator_;
}

bool StageInput::must_allocate() const {
  DCHECK(connected());
  DCHECK(mate().downstream_stage()->prepared());
  return must_allocate_;
}

void StageInput::SetDemand(Demand demand, Engine* engine) const {
  DCHECK(engine);
  DCHECK(connected());

  if (mate().UpdateDemand(demand)) {
    engine->PushToDemandBacklogUnsafe(upstream_stage());
  }
}

bool StageInput::SupplyPacketFromOutput(PacketPtr packet) {
  DCHECK(packet);
  DCHECK(!packet_from_upstream_);
  packet_from_upstream_ = std::move(packet);
  return true;
}

LpcmStageInput* StageInput::get_lpcm() {
  return nullptr;
}

}  // namespace media
}  // namespace mojo
