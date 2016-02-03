// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_ENGINE_PACKET_TRANSFORM_STAGE_H_
#define SERVICES_MEDIA_FRAMEWORK_ENGINE_PACKET_TRANSFORM_STAGE_H_

#include "services/media/framework/models/packet_transform.h"
#include "services/media/framework/stages/stage.h"

namespace mojo {
namespace media {

// A stage that hosts a PacketTransform.
class PacketTransformStage : public Stage {
 public:
  PacketTransformStage(PacketTransformPtr transform);

  ~PacketTransformStage() override;

  // Stage implementation.
  uint32_t input_count() const override;

  StageInput& input(uint32_t index) override;

  uint32_t output_count() const override;

  StageOutput& output(uint32_t index) override;

  bool Prepare(const UpdateCallback update_callback) override;

  void Update(Engine* engine) override;

 private:
  StageInput input_;
  StageOutput output_;
  PacketTransformPtr transform_;
  Allocator* allocator_;
  bool input_packet_is_new_;
};

}  // namespace media
}  // namespace mojo

#endif  // SERVICES_MEDIA_FRAMEWORK_ENGINE_PACKET_TRANSFORM_STAGE_H_
