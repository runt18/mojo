// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_ENGINE_DISTRIBUTOR_STAGE_H_
#define SERVICES_MEDIA_FRAMEWORK_ENGINE_DISTRIBUTOR_STAGE_H_

#include <vector>

#include "services/media/framework/models/multistream_packet_source.h"
#include "services/media/framework/stages/stage.h"

namespace mojo {
namespace media {

// A stage that hosts a MultiStreamPacketSource.
class DistributorStage : public Stage {
 public:
  DistributorStage(MultiStreamPacketSourcePtr packet_source);

  ~DistributorStage() override;

  // Stage implementation.
  uint32_t input_count() const override;

  StageInput& input(uint32_t index) override;

  uint32_t output_count() const override;

  StageOutput& output(uint32_t index) override;

  bool Prepare(UpdateCallback update_callback) override;

  void Update(Engine* engine) override;

 private:
  std::vector<StageOutput> outputs_;
  MultiStreamPacketSourcePtr packet_source_;
  PacketPtr cached_packet_;
  uint32_t cached_packet_output_index_;
  uint32_t ended_streams_;
};

}  // namespace media
}  // namespace mojo

#endif  // SERVICES_MEDIA_FRAMEWORK_ENGINE_DISTRIBUTOR_STAGE_H_
