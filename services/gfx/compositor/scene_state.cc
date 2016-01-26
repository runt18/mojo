// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/gfx/compositor/scene_state.h"

namespace compositor {

SceneState::SceneState(mojo::gfx::composition::SceneTokenPtr scene_token,
                       const std::string& label)
    : scene_def_(scene_token.Pass(), label), weak_factory_(this) {}

SceneState::~SceneState() {
  // The scene implementation and all of its bindings must be destroyed
  // before any pending callbacks are dropped on the floor.
  scene_impl_.reset();
  pending_frame_callbacks_.clear();
}

void SceneState::AddSceneFrameCallback(const SceneFrameCallback& callback) {
  pending_frame_callbacks_.push_back(callback);
}

void SceneState::DispatchSceneFrameCallbacks(
    const mojo::gfx::composition::FrameInfo& frame_info) {
  for (auto& callback : pending_frame_callbacks_) {
    callback.Run(frame_info.Clone());
  }
  pending_frame_callbacks_.clear();
}

std::ostream& operator<<(std::ostream& os, SceneState* scene_state) {
  if (!scene_state)
    return os << "null";
  return os << scene_state->FormattedLabel();
}

}  // namespace compositor
