// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_GFX_COMPOSITOR_GRAPH_SCENE_DEF_H_
#define SERVICES_GFX_COMPOSITOR_GRAPH_SCENE_DEF_H_

#include <iosfwd>
#include <memory>
#include <string>
#include <unordered_map>
#include <vector>

#include "base/callback.h"
#include "base/macros.h"
#include "mojo/services/gfx/composition/interfaces/scenes.mojom.h"
#include "services/gfx/compositor/graph/node_def.h"

namespace compositor {

class RenderLayer;
class RenderLayerBuilder;
class SceneDef;
class SnapshotBuilder;

// Resolves a scene token to a scene definition.
using SceneResolver =
    base::Callback<SceneDef*(mojo::gfx::composition::SceneToken*)>;

// Sends a scene unavailable message with the specified resource id.
using SceneUnavailableSender = base::Callback<void(uint32_t)>;

// Scene definition.
// Contains all of the resources and nodes of a published scene.
class SceneDef {
 public:
  // Outcome of a call to |Present|.
  enum class Disposition {
    kUnchanged,
    kSucceeded,
    kFailed,
  };

  SceneDef(mojo::gfx::composition::SceneTokenPtr scene_token,
           const std::string& label);
  ~SceneDef();

  // Gets the token used to refer to this scene globally.
  // Caller does not obtain ownership of the token.
  mojo::gfx::composition::SceneToken* scene_token() {
    return scene_token_.get();
  }

  // Gets the currently published scene graph version.
  uint32_t version() { return version_; }

  // Gets the root node, or nullptr if none.
  NodeDef* root_node() { return root_node_; }

  // Enqueues a pending update event to the scene graph.
  void EnqueueUpdate(mojo::gfx::composition::SceneUpdatePtr update);

  // Enqueues a pending publish event to the scene graph.
  // The changes are not applied until |ApplyChanges| is called.
  void EnqueuePublish(mojo::gfx::composition::SceneMetadataPtr metadata);

  // Applies published updates to the scene up to the point indicated by
  // |presentation_time|.
  //
  // Returns a value which indicates whether the updates succeded.
  // If the result is |kFailed|, the scene graph was left in an unusable
  // and inconsistent state and must be destroyed.
  Disposition Present(int64_t presentation_time,
                      const SceneResolver& resolver,
                      const SceneUnavailableSender& unavailable_sender,
                      std::ostream& err);

  // Unlinks references to another scene which has been unregistered.
  // Causes |OnResourceUnavailable()| to be delivered to the scene for all
  // invalidated scene resources.  Returns true if any changes were made.
  bool UnlinkReferencedScene(SceneDef* scene,
                             const SceneUnavailableSender& unavailable_sender);

  // Generates a snapshot of the scene.
  // Returns true if successful, false if the scene is blocked from rendering.
  bool Snapshot(SnapshotBuilder* snapshot_builder,
                RenderLayerBuilder* layer_builder);

  // Finds the resource with the specified id.
  // Returns nullptr if not found.
  ResourceDef* FindResource(uint32_t resource_id,
                            ResourceDef::Type resource_type);
  SceneResourceDef* FindSceneResource(uint32_t scene_resource_id) {
    return static_cast<SceneResourceDef*>(
        FindResource(scene_resource_id, ResourceDef::Type::kScene));
  }
  ImageResourceDef* FindImageResource(uint32_t image_resource_id) {
    return static_cast<ImageResourceDef*>(
        FindResource(image_resource_id, ResourceDef::Type::kImage));
  }

  // Finds the node with the specified id.
  // Returns nullptr if not found.
  NodeDef* FindNode(uint32_t node_id);

  const std::string& label() { return label_; }
  std::string FormattedLabel();

 private:
  struct Publication {
    Publication(mojo::gfx::composition::SceneMetadataPtr metadata);
    ~Publication();

    bool is_due(int64_t presentation_time) const {
      return metadata->presentation_time <= presentation_time;
    }

    mojo::gfx::composition::SceneMetadataPtr metadata;
    std::vector<mojo::gfx::composition::SceneUpdatePtr> updates;

   private:
    DISALLOW_COPY_AND_ASSIGN(Publication);
  };

  bool ApplyUpdate(mojo::gfx::composition::SceneUpdatePtr update,
                   const SceneResolver& resolver,
                   const SceneUnavailableSender& unavailable_sender,
                   std::ostream& err);
  bool Validate(std::ostream& err);

  bool SnapshotInner(SnapshotBuilder* snapshot_builder,
                     RenderLayerBuilder* layer_builder);
  std::shared_ptr<RenderLayer> SnapshotLayer(SnapshotBuilder* snapshot_builder);
  void Invalidate();
  bool HasSceneResources();

  ResourceDef* CreateResource(uint32_t resource_id,
                              mojo::gfx::composition::ResourcePtr resource_decl,
                              const SceneResolver& resolver,
                              const SceneUnavailableSender& unavailable_sender,
                              std::ostream& err);
  NodeDef* CreateNode(uint32_t node_id,
                      mojo::gfx::composition::NodePtr node_decl,
                      std::ostream& err);
  NodeOp* CreateNodeOp(uint32_t node_id,
                       mojo::gfx::composition::NodeOpPtr node_op_decl,
                       std::ostream& err);

  mojo::gfx::composition::SceneTokenPtr scene_token_;
  const std::string label_;
  std::string formatted_label_cache_;

  uint32_t version_ = mojo::gfx::composition::kSceneVersionNone;
  std::vector<mojo::gfx::composition::SceneUpdatePtr> pending_updates_;
  std::vector<std::unique_ptr<Publication>> pending_publications_;
  std::unordered_map<uint32_t, std::unique_ptr<ResourceDef>> resources_;
  std::unordered_map<uint32_t, std::unique_ptr<NodeDef>> nodes_;
  NodeDef* root_node_ = nullptr;

  std::shared_ptr<RenderLayer> cached_layer_;

  // Used to detect cycles during a snapshot operation.
  // This is safe because the object will only be used by a single thread.
  bool visited_ = false;

  DISALLOW_COPY_AND_ASSIGN(SceneDef);
};

}  // namespace compositor

#endif  // SERVICES_GFX_COMPOSITOR_GRAPH_SCENE_DEF_H_
