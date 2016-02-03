// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/media/framework/stages/active_source_stage.h"

namespace mojo {
namespace media {

ActiveSourceStage::ActiveSourceStage(ActiveSourcePtr source) : source_(source) {
  DCHECK(source_);

  supply_function_ = [this](PacketPtr packet) {
    bool packets_was_empty_ = packets_.empty();
    packets_.push_back(std::move(packet));
    if (packets_was_empty_ && update_callback_) {
      update_callback_(this);
    }
  };

  source_->SetSupplyCallback(supply_function_);
}

ActiveSourceStage::~ActiveSourceStage() {}

uint32_t ActiveSourceStage::input_count() const {
  return 0;
};

StageInput& ActiveSourceStage::input(uint32_t index) {
  NOTREACHED();
  static StageInput result;
  return result;
}

uint32_t ActiveSourceStage::output_count() const {
  return 1;
}

StageOutput& ActiveSourceStage::output(uint32_t index) {
  DCHECK_EQ(index, 0u);
  return output_;
}

bool ActiveSourceStage::Prepare(UpdateCallback update_callback) {
  update_callback_ = update_callback;
  Allocator* allocator = output_.Prepare(source_->can_accept_allocator());
  if (allocator) {
    DCHECK(source_->can_accept_allocator());
    source_->set_allocator(allocator);
  }
  return true;
}

void ActiveSourceStage::Update(Engine* engine) {
  DCHECK(engine);

  Demand demand = output_.demand();

  source_->SetDownstreamDemand(demand);

  if (demand != Demand::kNegative && !packets_.empty()) {
    output_.SupplyPacket(std::move(packets_.front()), engine);
    packets_.pop_front();
  }
}

}  // namespace media
}  // namespace mojo
