// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/gfx/compositor/graph/node_def.h"

#include "base/logging.h"
#include "base/strings/stringprintf.h"
#include "mojo/services/gfx/composition/cpp/formatting.h"
#include "mojo/skia/type_converters.h"
#include "services/gfx/compositor/graph/scene_def.h"
#include "services/gfx/compositor/graph/snapshot.h"
#include "services/gfx/compositor/render/render_image.h"
#include "services/gfx/compositor/render/render_layer.h"

namespace compositor {
namespace {
SkColor MakeSkColor(const mojo::gfx::composition::Color& color) {
  return SkColorSetARGBInline(color.alpha, color.red, color.green, color.blue);
}

SkPaint MakePaintForBlend(const mojo::gfx::composition::Blend& blend) {
  SkPaint result;
  result.setAlpha(blend.alpha);
  return result;
}
}  // namespace

NodeDef::NodeDef(uint32_t node_id,
                 mojo::TransformPtr content_transform,
                 mojo::RectPtr content_clip,
                 uint32_t hit_id,
                 Combinator combinator,
                 const std::vector<uint32_t>& child_node_ids,
                 NodeOp* op)
    : node_id_(node_id),
      content_transform_(content_transform.Pass()),
      content_clip_(content_clip.Pass()),
      hit_id_(hit_id),
      combinator_(combinator),
      child_node_ids_(child_node_ids),
      op_(op) {}

NodeDef::~NodeDef() {}

bool NodeDef::Validate(SceneDef* scene, std::ostream& err) {
  child_nodes_.clear();
  for (uint32_t child_node_id : child_node_ids_) {
    NodeDef* child_node = scene->FindNode(child_node_id);
    if (!child_node) {
      err << "Node refers to unknown child: " << FormattedLabel(scene)
          << ", child_node_id=" << child_node_id;
      return false;
    }
    child_nodes_.push_back(child_node);
  }

  return !op_ || op_->Validate(scene, this, err);
}

bool NodeDef::Snapshot(SnapshotBuilder* snapshot_builder,
                       RenderLayerBuilder* layer_builder,
                       SceneDef* scene) {
  DCHECK(snapshot_builder);
  DCHECK(layer_builder);
  DCHECK(scene);

  // Detect cycles.
  if (visited_) {
    if (snapshot_builder->block_log()) {
      *snapshot_builder->block_log()
          << "Node blocked due to recursive cycle: " << FormattedLabel(scene)
          << std::endl;
    }
    return false;
  }

  // Snapshot the contents of the node.
  visited_ = true;
  bool success = SnapshotInner(snapshot_builder, layer_builder, scene);
  visited_ = false;
  return success;
}

bool NodeDef::SnapshotInner(SnapshotBuilder* snapshot_builder,
                            RenderLayerBuilder* layer_builder,
                            SceneDef* scene) {
  // TODO(jeffbrown): Frequently referenced and reused nodes, especially
  // layer nodes, may benefit from caching.
  layer_builder->PushNode(node_id_, hit_id_);
  if (content_transform_)
    layer_builder->ApplyTransform(content_transform_.To<SkMatrix>());
  if (content_clip_)
    layer_builder->ApplyClip(content_clip_->To<SkRect>());

  bool success =
      op_ ? op_->Snapshot(snapshot_builder, layer_builder, scene, this)
          : SnapshotChildren(snapshot_builder, layer_builder, scene);
  if (!success)
    return false;

  layer_builder->PopNode();
  return true;
}

bool NodeDef::SnapshotChildren(SnapshotBuilder* snapshot_builder,
                               RenderLayerBuilder* layer_builder,
                               SceneDef* scene) {
  DCHECK(snapshot_builder);
  DCHECK(layer_builder);
  DCHECK(scene);

  switch (combinator_) {
    // MERGE: All or nothing.
    case Combinator::MERGE: {
      for (NodeDef* child_node : child_nodes_) {
        if (!child_node->Snapshot(snapshot_builder, layer_builder, scene)) {
          if (snapshot_builder->block_log()) {
            *snapshot_builder->block_log()
                << "Node with MERGE combinator blocked since "
                   "one of its children is blocked: "
                << FormattedLabel(scene) << ", blocked child "
                << child_node->FormattedLabel(scene) << std::endl;
          }
          return false;  // blocked
        }
      }
      return true;
    }

    // PRUNE: Silently discard blocked children.
    case Combinator::PRUNE: {
      for (NodeDef* child_node : child_nodes_) {
        RenderLayerBuilder child_layer_builder;
        if (child_node->Snapshot(snapshot_builder, &child_layer_builder,
                                 scene)) {
          layer_builder->DrawLayer(child_layer_builder.Build());
        }
      }
      return true;
    }

    // FALLBACK: Keep only the first unblocked child.
    case Combinator::FALLBACK: {
      if (child_nodes_.empty())
        return true;
      for (NodeDef* child_node : child_nodes_) {
        RenderLayerBuilder child_layer_builder;
        if (child_node->Snapshot(snapshot_builder, &child_layer_builder,
                                 scene)) {
          layer_builder->DrawLayer(child_layer_builder.Build());
          return true;
        }
      }
      if (snapshot_builder->block_log()) {
        *snapshot_builder->block_log()
            << "Node with FALLBACK combinator blocked since "
               "all of its children are blocked: "
            << FormattedLabel(scene) << std::endl;
      }
      return false;  // blocked
    }

    default: {
      if (snapshot_builder->block_log()) {
        *snapshot_builder->block_log()
            << "Unrecognized combinator: " << FormattedLabel(scene)
            << std::endl;
      }
      return false;
    }
  }
}

std::string NodeDef::FormattedLabel(SceneDef* scene) {
  return base::StringPrintf("%s[%d]", scene->FormattedLabel().c_str(),
                            node_id_);
}

bool NodeOp::Validate(SceneDef* scene, NodeDef* node, std::ostream& err) {
  return true;
}

RectNodeOp::RectNodeOp(const mojo::Rect& content_rect,
                       const mojo::gfx::composition::Color& color)
    : content_rect_(content_rect), color_(color) {}

RectNodeOp::~RectNodeOp() {}

bool RectNodeOp::Snapshot(SnapshotBuilder* snapshot_builder,
                          RenderLayerBuilder* layer_builder,
                          SceneDef* scene,
                          NodeDef* node) {
  if (!node->SnapshotChildren(snapshot_builder, layer_builder, scene))
    return false;

  SkPaint paint;
  paint.setColor(MakeSkColor(color_));
  layer_builder->DrawRect(content_rect_.To<SkRect>(), paint);
  return true;
}

ImageNodeOp::ImageNodeOp(const mojo::Rect& content_rect,
                         mojo::RectPtr image_rect,
                         uint32 image_resource_id,
                         mojo::gfx::composition::BlendPtr blend)
    : content_rect_(content_rect),
      image_rect_(image_rect.Pass()),
      image_resource_id_(image_resource_id),
      blend_(blend.Pass()) {}

ImageNodeOp::~ImageNodeOp() {}

bool ImageNodeOp::Validate(SceneDef* scene, NodeDef* node, std::ostream& err) {
  image_resource_ = scene->FindImageResource(image_resource_id_);
  if (!image_resource_) {
    err << "Node refers to unknown or invalid image resource: "
        << node->FormattedLabel(scene)
        << ", image_resource_id=" << image_resource_id_;
    return false;
  }
  return true;
}

bool ImageNodeOp::Snapshot(SnapshotBuilder* snapshot_builder,
                           RenderLayerBuilder* layer_builder,
                           SceneDef* scene,
                           NodeDef* node) {
  DCHECK(image_resource_);

  if (!image_resource_->image()) {
    if (snapshot_builder->block_log()) {
      *snapshot_builder->block_log()
          << "Node blocked due to its referenced image "
             "resource being unavailable: "
          << node->FormattedLabel(scene) << std::endl;
    }
    return false;
  }

  if (!node->SnapshotChildren(snapshot_builder, layer_builder, scene))
    return false;

  layer_builder->DrawImage(
      image_resource_->image(), content_rect_.To<SkRect>(),
      image_rect_ ? image_rect_->To<SkRect>()
                  : SkRect::MakeWH(image_resource_->image()->width(),
                                   image_resource_->image()->height()),
      blend_ ? MakePaintForBlend(*blend_) : SkPaint());
  return true;
}

SceneNodeOp::SceneNodeOp(uint32_t scene_resource_id, uint32_t scene_version)
    : scene_resource_id_(scene_resource_id), scene_version_(scene_version) {}

SceneNodeOp::~SceneNodeOp() {}

bool SceneNodeOp::Validate(SceneDef* scene, NodeDef* node, std::ostream& err) {
  scene_resource_ = scene->FindSceneResource(scene_resource_id_);
  if (!scene_resource_) {
    err << "Node refers to unknown or invalid scene resource: "
        << node->FormattedLabel(scene)
        << ", scene_resource_id=" << scene_resource_id_;
    return false;
  }
  return true;
}

bool SceneNodeOp::Snapshot(SnapshotBuilder* snapshot_builder,
                           RenderLayerBuilder* layer_builder,
                           SceneDef* scene,
                           NodeDef* node) {
  DCHECK(scene_resource_);

  SceneDef* referenced_scene = scene_resource_->referenced_scene();
  if (!referenced_scene) {
    if (snapshot_builder->block_log()) {
      *snapshot_builder->block_log()
          << "Node blocked due to its referenced scene "
             "resource being unavailable: "
          << node->FormattedLabel(scene) << std::endl;
    }
    return false;
  }

  uint32_t actual_version = referenced_scene->version();
  if (scene_version_ != mojo::gfx::composition::kSceneVersionNone &&
      actual_version != mojo::gfx::composition::kSceneVersionNone &&
      scene_version_ != actual_version) {
    if (snapshot_builder->block_log()) {
      *snapshot_builder->block_log()
          << "Node blocked due to its referenced scene "
             "resource not having the desired version: "
          << node->FormattedLabel(scene)
          << ", requested_version=" << scene_version_
          << ", actual_version=" << actual_version << std::endl;
    }
    return false;
  }

  if (!node->SnapshotChildren(snapshot_builder, layer_builder, scene))
    return false;

  return referenced_scene->Snapshot(snapshot_builder, layer_builder);
}

LayerNodeOp::LayerNodeOp(const mojo::Size& size,
                         mojo::gfx::composition::BlendPtr blend)
    : size_(size), blend_(blend.Pass()) {}

LayerNodeOp::~LayerNodeOp() {}

bool LayerNodeOp::Snapshot(SnapshotBuilder* snapshot_builder,
                           RenderLayerBuilder* layer_builder,
                           SceneDef* scene,
                           NodeDef* node) {
  SkRect content_rect = SkRect::MakeWH(size_.width, size_.height);
  RenderLayerBuilder children_layer_builder(&content_rect);
  if (!node->SnapshotChildren(snapshot_builder, &children_layer_builder, scene))
    return false;

  layer_builder->DrawSavedLayer(
      children_layer_builder.Build(), content_rect,
      blend_ ? MakePaintForBlend(*blend_) : SkPaint());
  return true;
}

}  // namespace compositor
