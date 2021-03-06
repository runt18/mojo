// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_GFX_COMPOSITOR_SCENE_STATE_H_
#define SERVICES_GFX_COMPOSITOR_SCENE_STATE_H_

#include <memory>
#include <string>
#include <unordered_map>
#include <vector>

#include "base/callback.h"
#include "base/macros.h"
#include "base/memory/weak_ptr.h"
#include "mojo/services/gfx/composition/cpp/formatting.h"
#include "mojo/services/gfx/composition/interfaces/scenes.mojom.h"
#include "services/gfx/compositor/graph/scene_def.h"

namespace compositor {

using SceneFrameCallback =
    base::Callback<void(mojo::gfx::composition::FrameInfoPtr)>;

// Describes the state of a particular scene.
// This object is owned by the CompositorEngine that created it.
class SceneState {
 public:
  SceneState(mojo::gfx::composition::SceneTokenPtr scene_token,
             const std::string& label);
  ~SceneState();

  base::WeakPtr<SceneState> GetWeakPtr() { return weak_factory_.GetWeakPtr(); }

  // Gets the token used to refer to this scene globally.
  // Caller does not obtain ownership of the token.
  mojo::gfx::composition::SceneToken* scene_token() {
    return scene_def_.scene_token();
  }

  // Gets or sets the scene listener interface.
  mojo::gfx::composition::SceneListener* scene_listener() {
    return scene_listener_.get();
  }
  void set_scene_listener(mojo::gfx::composition::SceneListenerPtr listener) {
    scene_listener_ = listener.Pass();
  }

  // Sets the associated scene implementation and takes ownership of it.
  void set_scene_impl(mojo::gfx::composition::Scene* impl) {
    scene_impl_.reset(impl);
  }

  // Gets the underlying scene definition, never null.
  SceneDef* scene_def() { return &scene_def_; }

  void AddSceneFrameCallback(const SceneFrameCallback& callback);
  void DispatchSceneFrameCallbacks(
      const mojo::gfx::composition::FrameInfo& frame_info);

  const std::string& label() { return scene_def_.label(); }
  std::string FormattedLabel() { return scene_def_.FormattedLabel(); }

 private:
  std::unique_ptr<mojo::gfx::composition::Scene> scene_impl_;
  mojo::gfx::composition::SceneListenerPtr scene_listener_;
  std::vector<SceneFrameCallback> pending_frame_callbacks_;

  SceneDef scene_def_;

  base::WeakPtrFactory<SceneState> weak_factory_;

  DISALLOW_COPY_AND_ASSIGN(SceneState);
};

std::ostream& operator<<(std::ostream& os, SceneState* scene_state);

}  // namespace compositor

#endif  // SERVICES_GFX_COMPOSITOR_SCENE_STATE_H_
