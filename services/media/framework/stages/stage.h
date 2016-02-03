// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_ENGINE_STAGE_H_
#define SERVICES_MEDIA_FRAMEWORK_ENGINE_STAGE_H_

#include <vector>

#include "services/media/framework/packet.h"
#include "services/media/framework/stages/lpcm_stage_input.h"
#include "services/media/framework/stages/lpcm_stage_output.h"
#include "services/media/framework/stages/stage_input.h"
#include "services/media/framework/stages/stage_output.h"

namespace mojo {
namespace media {

class Engine;

// Host for a source, sink or transform.
class Stage {
 public:
  using UpdateCallback = std::function<void(Stage* stage)>;

  Stage();

  virtual ~Stage();

  // Returns the number of input connections.
  virtual uint32_t input_count() const = 0;

  // Returns the indicated input connection.
  virtual StageInput& input(uint32_t index) = 0;

  // Returns the number of output connections.
  virtual uint32_t output_count() const = 0;

  // Returns the indicated output connection.
  virtual StageOutput& output(uint32_t index) = 0;

  // Prepares the stage for operation, providing a callback used to signal the
  // need to update this stage. Returns true if the stage will call the
  // callback, false if not. The default implementation of this method returns
  // false.
  // TODO(dalesat): Should this be const UpdateCallback&?
  virtual bool Prepare(UpdateCallback update_callback);

  // Initiates demand. Called on sink stages after the graph is prepared. The
  // default implementation does nothing.
  virtual void Prime();

  // Performs processing.
  virtual void Update(Engine* engine) = 0;

  // Returns a bool indicating whether the stage is prepared.
  bool prepared() {
    return prepared_;
  }

 private:
  bool prepared_;
  bool in_supply_backlog_;
  bool in_demand_backlog_;

  friend class Engine;
};

}  // namespace media
}  // namespace mojo

#endif  // SERVICES_MEDIA_FRAMEWORK_ENGINE_STAGE_H_
