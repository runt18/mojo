// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_GFX_COMPOSITOR_GRAPH_NODE_DEF_H_
#define SERVICES_GFX_COMPOSITOR_GRAPH_NODE_DEF_H_

#include <iosfwd>
#include <memory>
#include <string>
#include <vector>

#include "base/callback.h"
#include "base/macros.h"
#include "mojo/services/gfx/composition/interfaces/nodes.mojom.h"
#include "services/gfx/compositor/graph/resource_def.h"

namespace compositor {

class RenderImage;
class RenderLayerBuilder;
class SceneDef;
class SnapshotBuilder;
class NodeOp;

// Scene graph node definition.
class NodeDef {
 public:
  using Combinator = mojo::gfx::composition::Node::Combinator;

  NodeDef(uint32_t node_id,
          mojo::TransformPtr content_transform,
          mojo::RectPtr content_clip,
          uint32_t hit_id,
          Combinator combinator,
          const std::vector<uint32_t>& child_node_ids,
          NodeOp* op);
  ~NodeDef();

  uint32_t node_id() { return node_id_; }
  const mojo::Transform* content_transform() {
    return content_transform_.get();
  }
  const mojo::Rect* content_clip() { return content_clip_.get(); }
  uint32_t hit_id() { return hit_id_; }
  Combinator combinator() { return combinator_; }
  const std::vector<uint32_t>& child_node_ids() { return child_node_ids_; }
  NodeOp* op() { return op_.get(); }

  std::string FormattedLabel(SceneDef* scene);

  // Updated by |Validate()|.
  const std::vector<NodeDef*>& child_nodes() { return child_nodes_; }

  // Validates and prepares the object for rendering.
  // Returns true if successful, false if errors were reported.
  bool Validate(SceneDef* scene, std::ostream& err);

  // Generates a snapshot of the node into the specified builder.
  // Returns true if successful, false if the node is blocked from rendering.
  bool Snapshot(SnapshotBuilder* snapshot_builder,
                RenderLayerBuilder* layer_builder,
                SceneDef* scene);

  // Generates a snapshot of the node's children into the specified builder.
  // Returns true if successful, false if the children are blocked from
  // rendering.
  bool SnapshotChildren(SnapshotBuilder* snapshot_builder,
                        RenderLayerBuilder* layer_builder,
                        SceneDef* scene);

 private:
  bool SnapshotInner(SnapshotBuilder* snapshot_builder,
                     RenderLayerBuilder* layer_builder,
                     SceneDef* scene);

  uint32_t node_id_;
  mojo::TransformPtr const content_transform_;
  mojo::RectPtr const content_clip_;
  uint32_t const hit_id_;
  Combinator const combinator_;
  std::vector<uint32_t> const child_node_ids_;
  std::unique_ptr<NodeOp> const op_;

  std::vector<NodeDef*> child_nodes_;

  // Used to detect cycles during a snapshot operation.
  // This is safe because the object will only be used by a single thread.
  bool visited_ = false;

  DISALLOW_COPY_AND_ASSIGN(NodeDef);
};

// Abstract scene graph node operation.
class NodeOp {
 public:
  NodeOp() = default;
  virtual ~NodeOp() = default;

  // Validates and prepares the object for rendering.
  // Returns true if successful, false if errors were reported.
  virtual bool Validate(SceneDef* scene, NodeDef* node, std::ostream& err);

  // Generates a snapshot of the node operation into the specified builder.
  // This method is responsible for calling |SnapshotChildren| to process
  // the children of the node.  Returns true if successful, false if the node
  // is blocked from rendering.
  virtual bool Snapshot(SnapshotBuilder* snapshot_builder,
                        RenderLayerBuilder* layer_builder,
                        SceneDef* scene,
                        NodeDef* node) = 0;

 private:
  DISALLOW_COPY_AND_ASSIGN(NodeOp);
};

// A solid color filled rectangle node definition.
class RectNodeOp : public NodeOp {
 public:
  RectNodeOp(const mojo::Rect& content_rect,
             const mojo::gfx::composition::Color& color);
  ~RectNodeOp() override;

  const mojo::Rect& content_rect() { return content_rect_; }
  const mojo::gfx::composition::Color& color() { return color_; }

  bool Snapshot(SnapshotBuilder* snapshot_builder,
                RenderLayerBuilder* layer_builder,
                SceneDef* scene,
                NodeDef* node) override;

 private:
  mojo::Rect content_rect_;
  mojo::gfx::composition::Color color_;

  DISALLOW_COPY_AND_ASSIGN(RectNodeOp);
};

// An image filled rectangle node definition.
class ImageNodeOp : public NodeOp {
 public:
  ImageNodeOp(const mojo::Rect& content_rect,
              mojo::RectPtr image_rect,
              uint32 image_resource_id,
              mojo::gfx::composition::BlendPtr blend);
  ~ImageNodeOp() override;

  const mojo::Rect& content_rect() { return content_rect_; }
  mojo::Rect* image_rect() { return image_rect_.get(); }
  uint32_t image_resource_id() { return image_resource_id_; }
  mojo::gfx::composition::Blend* blend() { return blend_.get(); }

  // Updated by |Validate()|.
  ImageResourceDef* image_resource() { return image_resource_; }

  bool Validate(SceneDef* scene, NodeDef* node, std::ostream& err) override;

  bool Snapshot(SnapshotBuilder* snapshot_builder,
                RenderLayerBuilder* layer_builder,
                SceneDef* scene,
                NodeDef* node) override;

 private:
  mojo::Rect const content_rect_;
  mojo::RectPtr const image_rect_;
  uint32_t const image_resource_id_;
  mojo::gfx::composition::BlendPtr const blend_;

  ImageResourceDef* image_resource_ = nullptr;

  DISALLOW_COPY_AND_ASSIGN(ImageNodeOp);
};

// An embedded scene node definition.
class SceneNodeOp : public NodeOp {
 public:
  SceneNodeOp(uint32_t scene_resource_id, uint32_t scene_version);
  ~SceneNodeOp() override;

  uint32_t scene_resource_id() { return scene_resource_id_; }
  uint32_t scene_version() { return scene_version_; }

  // Updated by |Validate()|.
  SceneResourceDef* scene_resource() { return scene_resource_; }

  bool Validate(SceneDef* scene, NodeDef* node, std::ostream& err) override;

  bool Snapshot(SnapshotBuilder* snapshot_builder,
                RenderLayerBuilder* layer_builder,
                SceneDef* scene,
                NodeDef* node) override;

 private:
  uint32_t const scene_resource_id_;
  uint32_t const scene_version_;

  SceneResourceDef* scene_resource_ = nullptr;

  DISALLOW_COPY_AND_ASSIGN(SceneNodeOp);
};

// A composited layer node definition.
class LayerNodeOp : public NodeOp {
 public:
  LayerNodeOp(const mojo::Size& size, mojo::gfx::composition::BlendPtr blend);
  ~LayerNodeOp() override;

  const mojo::Size& size() { return size_; }
  mojo::gfx::composition::Blend* blend() { return blend_.get(); }

  bool Snapshot(SnapshotBuilder* snapshot_builder,
                RenderLayerBuilder* layer_builder,
                SceneDef* scene,
                NodeDef* node) override;

 private:
  mojo::Size const size_;
  mojo::gfx::composition::BlendPtr const blend_;

  DISALLOW_COPY_AND_ASSIGN(LayerNodeOp);
};

}  // namespace compositor

#endif  // SERVICES_GFX_COMPOSITOR_GRAPH_NODE_DEF_H_
