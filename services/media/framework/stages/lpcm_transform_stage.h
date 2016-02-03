// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_ENGINE_LPCM_TRANSFORM_STAGE_H_
#define SERVICES_MEDIA_FRAMEWORK_ENGINE_LPCM_TRANSFORM_STAGE_H_

#include "services/media/framework/models/lpcm_transform.h"
#include "services/media/framework/stages/stage.h"

namespace mojo {
namespace media {

// A stage that hosts an LpcmTransform.
class LpcmTransformStage : public Stage {
 public:
  LpcmTransformStage(LpcmTransformPtr transform);

  ~LpcmTransformStage() override;

  // Stage implementation.
  uint32_t input_count() const override;

  StageInput& input(uint32_t index) override;

  uint32_t output_count() const override;

  StageOutput& output(uint32_t index) override;

  bool Prepare(UpdateCallback update_callback) override;

  void Update(Engine* engine) override;

 private:
  LpcmStageInput input_;
  LpcmStageOutput output_;
  LpcmTransformPtr transform_;
};

}  // namespace media
}  // namespace mojo

#endif  // SERVICES_MEDIA_FRAMEWORK_ENGINE_LPCM_TRANSFORM_STAGE_H_
