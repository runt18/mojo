// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_ENGINE_STAGE_INPUT_H_
#define SERVICES_MEDIA_FRAMEWORK_ENGINE_STAGE_INPUT_H_

#include "services/media/framework/models/demand.h"
#include "services/media/framework/packet.h"

namespace mojo {
namespace media {

class Stage;
class Engine;
class StageOutput;
class LpcmStageInput;

// Represents a stage's connector to an adjacent upstream stage.
class StageInput {
 public:
  StageInput();

  ~StageInput();

  // The stage to which this input is connected.
  Stage* upstream_stage() const { return upstream_stage_; }

  // The index of the output to which this input is connected.
  uint32_t output_index() const { return output_index_; }

  // Establishes a connection. Called only by the engine.
  void connect(Stage* upstream_stage, uint32_t output_index);

  // Breaks a connection. Called only by the engine.
  void disconnect() {
    upstream_stage_ = nullptr;
    output_index_ = 0;
  }

  // Determines whether the input is connected to an output.
  bool connected() const { return upstream_stage_ != nullptr; }

  // The connected output.
  StageOutput& mate() const;

  // Prepare to move packets by providing an allocator for the upstream stage
  // if we have one and indicating whether we require its use.
  void Prepare(Allocator* allocator, bool must_allocate);

  // Returns the allocator provided by this input.
  Allocator* allocator() const;

  // Determines whether the input requires the use of its allocator.
  bool must_allocate() const;

  // A packet supplied from upstream.
  PacketPtr& packet_from_upstream() { return packet_from_upstream_; }

  // Updates mate's demand. Called only by Stage::Update implementations.
  void SetDemand(Demand demand, Engine* engine) const;

  // Updates packet_from_upstream. Return value indicates whether the stage for
  // this input should be added to the supply backlog. Called only by
  // StageOutput instances.
  virtual bool SupplyPacketFromOutput(PacketPtr packet);

  // Returns the LPCM specialization if this instance is an LpcmStageInput,
  // nullptr otherwise.
  virtual LpcmStageInput* get_lpcm();

 private:
  Stage* upstream_stage_;
  uint32_t output_index_;
  Allocator* allocator_;
  bool must_allocate_;
  PacketPtr packet_from_upstream_;
};

}  // namespace media
}  // namespace mojo

#endif  // SERVICES_MEDIA_FRAMEWORK_ENGINE_STAGE_INPUT_H_
