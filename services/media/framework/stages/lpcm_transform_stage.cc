// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/media/framework/stages/lpcm_transform_stage.h"

namespace mojo {
namespace media {

LpcmTransformStage::LpcmTransformStage(LpcmTransformPtr transform) :
    transform_(transform) {
  DCHECK(transform_);
  input_.set_stream_type(transform_->input_stream_type());
  output_.set_stream_type(transform_->output_stream_type());
}

LpcmTransformStage::~LpcmTransformStage() {}

uint32_t LpcmTransformStage::input_count() const {
  return 1;
};

StageInput& LpcmTransformStage::input(uint32_t index) {
  DCHECK_EQ(index, 0u);
  return input_;
}

uint32_t LpcmTransformStage::output_count() const {
  return 1;
}

StageOutput& LpcmTransformStage::output(uint32_t index) {
  DCHECK_EQ(index, 0u);
  return output_;
}

bool LpcmTransformStage::Prepare(UpdateCallback update_callback) {
  output_.Prepare(false);
  input_.Prepare(nullptr, false);
  return false;
}

void LpcmTransformStage::Update(Engine* engine) {
  DCHECK(engine);

  LpcmFrameBuffer& supply = input_.lpcm_supply();

  if (supply.frame_count() != 0 || input_.end_of_stream()) {
    // TODO(dalesat): Assumes 1-1.
    LpcmFrameBuffer& demand = output_.lpcm_demand(supply.frame_count());

    if (demand.frame_count() != 0) {
      if (supply.frame_count() != 0) {
        transform_->TransformFrames(&supply, &demand, output_.mix());
      }

      if (demand.frame_count() == 0 || input_.end_of_stream()) {
        output_.SupplyFrames(input_.end_of_stream(), engine);
      }
    }
  }

  // TODO(dalesat): Assumes 1-1.
  input_.SuggestDemand(output_.demand_suggestion(), engine);
}

}  // namespace media
}  // namespace mojo
