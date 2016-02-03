// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/media/framework/stages/active_sink_stage.h"

namespace mojo {
namespace media {

ActiveSinkStage::ActiveSinkStage(ActiveSinkPtr sink) : sink_(sink) {
  DCHECK(sink_);

  demand_function_ = [this](Demand demand) {
    DCHECK(update_callback_);
    if (sink_demand_ != demand) {
      sink_demand_ = demand;
      update_callback_(this);
    }
  };

  sink_->SetDemandCallback(demand_function_);
}

ActiveSinkStage::~ActiveSinkStage() {}

uint32_t ActiveSinkStage::input_count() const {
  return 1;
};

StageInput& ActiveSinkStage::input(uint32_t index) {
  DCHECK_EQ(index, 0u);
  return input_;
}

uint32_t ActiveSinkStage::output_count() const {
  return 0;
}

StageOutput& ActiveSinkStage::output(uint32_t index) {
  NOTREACHED();
  static StageOutput result;
  return result;
}

bool ActiveSinkStage::Prepare(UpdateCallback update_callback) {
  input_.Prepare(sink_->allocator(), sink_->must_allocate());
  update_callback_ = update_callback;
  return true;
}

void ActiveSinkStage::Prime() {
  sink_->Prime();
}

void ActiveSinkStage::Update(Engine* engine) {
  DCHECK(engine);

  if (input_.packet_from_upstream()) {
    sink_demand_ =
        sink_->SupplyPacket(std::move(input_.packet_from_upstream()));
  }

  input_.SetDemand(sink_demand_, engine);
}

}  // namespace media
}  // namespace mojo
