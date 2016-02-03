// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_ENGINE_STAGE_OUTPUT_H_
#define SERVICES_MEDIA_FRAMEWORK_ENGINE_STAGE_OUTPUT_H_

#include "services/media/framework/allocator.h"
#include "services/media/framework/packet.h"

namespace mojo {
namespace media {

class Stage;
class Engine;
class StageInput;
class LpcmStageOutput;

// Represents a stage's connector to an adjacent downstream stage.
class StageOutput {
 public:
  StageOutput();

  ~StageOutput();

  // The stage to which this output is connected.
  Stage* downstream_stage() const { return downstream_stage_; }

  // The index of the input to which this output is connected.
  uint32_t input_index() const { return input_index_; }

  // Establishes a connection. Called only by the engine.
  void connect(Stage* downstream_stage, uint32_t input_index);

  // Breaks a connection. Called only by the engine.
  void disconnect() {
    downstream_stage_ = nullptr;
    input_index_ = 0;
  }

  // Determines whether the output is connected to an input.
  bool connected() const {
    return downstream_stage_ != nullptr;
  }

  // The connected input.
  StageInput& mate() const;

  // Gets ready to move packets by negotiating the use of allocators. If the
  // downstream input provides an allocator, and we can use it, this method
  // returns the provided allocator. Otherwise, it returns nullptr.
  virtual Allocator* Prepare(bool can_accept_allocator);

  // Demand signalled from downstream, or kNegative if the downstream input
  // is currently holding a packet.
  Demand demand() const;

  // Supplies a packet to mate. Called only by Stage::Update implementations.
  void SupplyPacket(PacketPtr packet, Engine* engine) const;

  // Updates packet demand. Called only by StageInput instances.
  bool UpdateDemand(Demand demand);

  // Returns the LPCM specialization if this instance is an LpcmStageOutput,
  // nullptr otherwise.
  virtual LpcmStageOutput* get_lpcm();

 protected:
  void SupplyPacketInternal(PacketPtr packet, Engine* engine) const;

 private:
  Stage* downstream_stage_;
  uint32_t input_index_;
  Demand demand_;
  Allocator* copy_allocator_;
};

}  // namespace media
}  // namespace mojo

#endif  // SERVICES_MEDIA_FRAMEWORK_ENGINE_STAGE_OUTPUT_H_
