// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_ENGINE_ACTIVE_SINK_STAGE_H_
#define SERVICES_MEDIA_FRAMEWORK_ENGINE_ACTIVE_SINK_STAGE_H_

#include <deque>

#include "services/media/framework/models/active_sink.h"
#include "services/media/framework/stages/stage.h"

namespace mojo {
namespace media {

// A stage that hosts an ActiveSink.
class ActiveSinkStage : public Stage {
 public:
  ActiveSinkStage(ActiveSinkPtr source);

  ~ActiveSinkStage() override;

  // Stage implementation.
  uint32_t input_count() const override;

  StageInput& input(uint32_t index) override;

  uint32_t output_count() const override;

  StageOutput& output(uint32_t index) override;

  bool Prepare(UpdateCallback update_callback) override;

  void Prime() override;

  void Update(Engine* engine) override;

 private:
  StageInput input_;
  ActiveSinkPtr sink_;
  ActiveSink::DemandCallback demand_function_;
  Stage::UpdateCallback update_callback_;
  Demand sink_demand_;
};

}  // namespace media
}  // namespace mojo

#endif  // SERVICES_MEDIA_FRAMEWORK_ENGINE_ACTIVE_SINK_STAGE_H_
