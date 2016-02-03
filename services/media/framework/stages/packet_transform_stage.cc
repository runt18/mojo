// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/media/framework/stages/packet_transform_stage.h"

namespace mojo {
namespace media {

PacketTransformStage::PacketTransformStage(
    PacketTransformPtr transform) :
    transform_(transform),
    allocator_(nullptr),
    input_packet_is_new_(true) {
  DCHECK(transform_);
}

PacketTransformStage::~PacketTransformStage() {}

uint32_t PacketTransformStage::input_count() const {
  return 1;
};

StageInput& PacketTransformStage::input(uint32_t index) {
  DCHECK_EQ(index, 0u);
  return input_;
}

uint32_t PacketTransformStage::output_count() const {
  return 1;
}

StageOutput& PacketTransformStage::output(uint32_t index) {
  DCHECK_EQ(index, 0u);
  return output_;
}

bool PacketTransformStage::Prepare(const UpdateCallback update_callback) {
  allocator_ = output_.Prepare(true);
  if (allocator_ == nullptr) {
    allocator_ = Allocator::GetDefault();
  }
  input_.Prepare(nullptr, false);
  return false;
}

void PacketTransformStage::Update(Engine* engine) {
  DCHECK(engine);
  DCHECK(allocator_);

  if (input_.packet_from_upstream() && output_.demand() != Demand::kNegative) {
    PacketPtr output_packet;
    if (transform_->TransformPacket(
        input_.packet_from_upstream(),
        input_packet_is_new_,
        allocator_,
        &output_packet)) {
      input_.packet_from_upstream().reset();
      input_packet_is_new_ = true;
    } else {
      input_packet_is_new_ = false;
    }

    if (output_packet) {
      output_.SupplyPacket(std::move(output_packet), engine);
    }
  }

  input_.SetDemand(output_.demand(), engine);
}

}  // namespace media
}  // namespace mojo
