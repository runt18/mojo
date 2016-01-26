// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/gfx/compositor/graph/scene_def.h"

#include <ostream>

#include "base/bind.h"
#include "base/logging.h"
#include "base/message_loop/message_loop.h"
#include "base/strings/stringprintf.h"
#include "mojo/services/gfx/composition/cpp/formatting.h"
#include "services/gfx/compositor/graph/snapshot.h"
#include "services/gfx/compositor/render/render_image.h"
#include "services/gfx/compositor/render/render_layer.h"

namespace compositor {

namespace {
// TODO(jeffbrown): Determine and document a more appropriate size limit
// for transferred images as part of the image pipe abstraction instead.
const int32_t kMaxTextureWidth = 65536;
const int32_t kMaxTextureHeight = 65536;

void ReleaseMailboxTexture(
    mojo::gfx::composition::MailboxTextureCallbackPtr callback) {
  if (callback)
    callback->OnMailboxTextureReleased();
}
}  // namespace

SceneDef::SceneDef(mojo::gfx::composition::SceneTokenPtr scene_token,
                   const std::string& label)
    : scene_token_(scene_token.Pass()), label_(label) {
  DCHECK(scene_token_);
}

SceneDef::~SceneDef() {}

void SceneDef::EnqueueUpdate(mojo::gfx::composition::SceneUpdatePtr update) {
  DCHECK(update);
  pending_updates_.push_back(update.Pass());
}

void SceneDef::EnqueuePublish(
    mojo::gfx::composition::SceneMetadataPtr metadata) {
  DCHECK(metadata);
  pending_publications_.emplace_back(new Publication(metadata.Pass()));
  pending_updates_.swap(pending_publications_.back()->updates);
}

SceneDef::Disposition SceneDef::Present(
    int64_t presentation_time,
    const SceneResolver& resolver,
    const SceneUnavailableSender& unavailable_sender,
    std::ostream& err) {
  // Walk backwards through the pending publications to find the index
  // just beyond the last one which is due to be presented at or before the
  // presentation time.
  size_t end = pending_publications_.size();
  for (;;) {
    if (!end)
      return Disposition::kUnchanged;
    if (pending_publications_[end - 1]->is_due(presentation_time))
      break;  // found last presentable publication
    end--;
  }

  // Prepare to apply all publications up to this point.
  uint32_t version = pending_publications_[end - 1]->metadata->version;
  if (version_ != version) {
    version_ = version;
    formatted_label_cache_.clear();
  }
  Invalidate();

  // Apply all updates sequentially.
  for (size_t index = 0; index < end; ++index) {
    for (auto& update : pending_publications_[index]->updates) {
      if (!ApplyUpdate(update.Pass(), resolver, unavailable_sender, err))
        return Disposition::kFailed;
    }
  }

  // Dequeue the publications we processed.
  pending_publications_.erase(pending_publications_.begin(),
                              pending_publications_.begin() + end);

  // Ensure the scene is in a valid state.
  if (!Validate(err))
    return Disposition::kFailed;
  return Disposition::kSucceeded;
}

bool SceneDef::ApplyUpdate(mojo::gfx::composition::SceneUpdatePtr update,
                           const SceneResolver& resolver,
                           const SceneUnavailableSender& unavailable_sender,
                           std::ostream& err) {
  DCHECK(update);

  // Update resources.
  if (update->clear_resources) {
    resources_.clear();
  }
  for (auto it = update->resources.begin(); it != update->resources.end();
       ++it) {
    uint32_t resource_id = it.GetKey();
    mojo::gfx::composition::ResourcePtr& resource_decl = it.GetValue();
    if (resource_decl) {
      ResourceDef* resource = CreateResource(resource_id, resource_decl.Pass(),
                                             resolver, unavailable_sender, err);
      if (!resource)
        return false;
      resources_[resource_id].reset(resource);
    } else {
      resources_.erase(resource_id);
    }
  }

  // Update nodes.
  if (update->clear_nodes) {
    nodes_.clear();
  }
  for (auto it = update->nodes.begin(); it != update->nodes.end(); ++it) {
    uint32_t node_id = it.GetKey();
    mojo::gfx::composition::NodePtr& node_decl = it.GetValue();
    if (node_decl) {
      NodeDef* node = CreateNode(node_id, node_decl.Pass(), err);
      if (!node)
        return false;
      nodes_[node_id].reset(node);
    } else {
      nodes_.erase(node_id);
    }
  }
  return true;
}

bool SceneDef::Validate(std::ostream& err) {
  // Validate all nodes.
  // TODO(jeffbrown): Figure out how to do this incrementally if it gets
  // too expensive to process all nodes each time.
  root_node_ = nullptr;
  for (auto& pair : nodes_) {
    uint32_t node_id = pair.first;
    NodeDef* node = pair.second.get();
    if (!node->Validate(this, err))
      return false;
    if (node_id == mojo::gfx::composition::kSceneRootNodeId)
      root_node_ = node;
  }
  return true;
}

bool SceneDef::UnlinkReferencedScene(
    SceneDef* scene,
    const SceneUnavailableSender& unavailable_sender) {
  DCHECK(scene);

  bool changed = false;
  for (auto& pair : resources_) {
    if (pair.second->type() == ResourceDef::Type::kScene) {
      auto scene_resource = static_cast<SceneResourceDef*>(pair.second.get());
      if (scene_resource->referenced_scene() == scene) {
        scene_resource->clear_referenced_scene();
        Invalidate();
        changed = true;
        unavailable_sender.Run(pair.first);
      }
    }
  }
  return changed;
}

bool SceneDef::Snapshot(SnapshotBuilder* snapshot_builder,
                        RenderLayerBuilder* layer_builder) {
  DCHECK(snapshot_builder);
  DCHECK(layer_builder);

  // Detect cycles.
  if (visited_) {
    if (snapshot_builder->block_log()) {
      *snapshot_builder->block_log()
          << "Scene blocked due to recursive cycle: " << FormattedLabel()
          << std::endl;
    }
    return false;
  }

  // Snapshot the contents of the scene.
  visited_ = true;
  bool success = SnapshotInner(snapshot_builder, layer_builder);
  visited_ = false;
  return success;
}

bool SceneDef::SnapshotInner(SnapshotBuilder* snapshot_builder,
                             RenderLayerBuilder* layer_builder) {
  // Note the dependency even if blocked.
  snapshot_builder->AddSceneDependency(this);

  // Ensure we have a root node.
  if (!root_node_) {
    if (snapshot_builder->block_log()) {
      *snapshot_builder->block_log()
          << "Scene blocked due because it has no root node: "
          << FormattedLabel() << std::endl;
    }
    return false;
  }

  // Snapshot and draw the layer.
  std::shared_ptr<RenderLayer> scene_layer = SnapshotLayer(snapshot_builder);
  if (!scene_layer)
    return false;
  layer_builder->DrawLayer(scene_layer);
  return true;
}

std::shared_ptr<RenderLayer> SceneDef::SnapshotLayer(
    SnapshotBuilder* snapshot_builder) {
  if (cached_layer_)
    return cached_layer_;

  RenderLayerBuilder scene_layer_builder;
  scene_layer_builder.PushScene(scene_token_->value, version_);
  if (!root_node_->Snapshot(snapshot_builder, &scene_layer_builder, this))
    return nullptr;
  scene_layer_builder.PopScene();

  // TODO(jeffbrown): Implement caching even when the scene has dependencies.
  // There are some subtleties to be dealt with to ensure that caches
  // are properly invalidated and that we don't accidentally cache layers which
  // bake in decisions which counteract the intended cycle detection and
  // avoidance behavior.  Basically just need better bookkeeping.
  std::shared_ptr<RenderLayer> scene_layer = scene_layer_builder.Build();
  if (!HasSceneResources())
    cached_layer_ = scene_layer;
  return scene_layer;
}

void SceneDef::Invalidate() {
  cached_layer_.reset();
}

bool SceneDef::HasSceneResources() {
  for (auto& pair : resources_) {
    if (pair.second->type() == ResourceDef::Type::kScene)
      return true;
  }
  return false;
}

ResourceDef* SceneDef::CreateResource(
    uint32_t resource_id,
    mojo::gfx::composition::ResourcePtr resource_decl,
    const SceneResolver& resolver,
    const SceneUnavailableSender& unavailable_sender,
    std::ostream& err) {
  DCHECK(resource_decl);

  if (resource_decl->is_scene()) {
    auto& scene_resource_decl = resource_decl->get_scene();
    DCHECK(scene_resource_decl->scene_token);
    SceneDef* referenced_scene =
        resolver.Run(scene_resource_decl->scene_token.get());
    if (!referenced_scene) {
      unavailable_sender.Run(resource_id);
    }
    return new SceneResourceDef(referenced_scene);
  }

  if (resource_decl->is_mailbox_texture()) {
    auto& mailbox_texture_resource_decl = resource_decl->get_mailbox_texture();
    DCHECK(mailbox_texture_resource_decl->mailbox_name.size() ==
           GL_MAILBOX_SIZE_CHROMIUM);
    DCHECK(mailbox_texture_resource_decl->size);
    int32_t width = mailbox_texture_resource_decl->size->width;
    int32_t height = mailbox_texture_resource_decl->size->height;
    if (width < 1 || width > kMaxTextureWidth || height < 1 ||
        height > kMaxTextureHeight) {
      err << "MailboxTexture resource has invalid size: "
          << "resource_id=" << resource_id << ", width=" << width
          << ", height=" << height;
      return nullptr;
    }
    std::shared_ptr<RenderImage> image = RenderImage::CreateFromMailboxTexture(
        reinterpret_cast<GLbyte*>(
            mailbox_texture_resource_decl->mailbox_name.data()),
        mailbox_texture_resource_decl->sync_point, width, height,
        base::MessageLoop::current()->task_runner(),
        base::Bind(
            &ReleaseMailboxTexture,
            base::Passed(mailbox_texture_resource_decl->callback.Pass())));
    if (!image) {
      err << "Could not create MailboxTexture";
      return nullptr;
    }
    return new ImageResourceDef(image);
  }

  err << "Unsupported resource type: resource_id=" << resource_id;
  return nullptr;
}

NodeDef* SceneDef::CreateNode(uint32_t node_id,
                              mojo::gfx::composition::NodePtr node_decl,
                              std::ostream& err) {
  DCHECK(node_decl);

  NodeOp* op = nullptr;
  if (node_decl->op) {
    op = CreateNodeOp(node_id, node_decl->op.Pass(), err);
    if (!op)
      return nullptr;
  }

  return new NodeDef(node_id, node_decl->content_transform.Pass(),
                     node_decl->content_clip.Pass(), node_decl->hit_id,
                     node_decl->combinator, node_decl->child_node_ids.storage(),
                     op);
}

NodeOp* SceneDef::CreateNodeOp(uint32_t node_id,
                               mojo::gfx::composition::NodeOpPtr node_op_decl,
                               std::ostream& err) {
  DCHECK(node_op_decl);

  if (node_op_decl->is_rect()) {
    auto& rect_node_op_decl = node_op_decl->get_rect();
    DCHECK(rect_node_op_decl->content_rect);
    DCHECK(rect_node_op_decl->color);
    return new RectNodeOp(*rect_node_op_decl->content_rect,
                          *rect_node_op_decl->color);
  }

  if (node_op_decl->is_image()) {
    auto& image_node_op_decl = node_op_decl->get_image();
    DCHECK(image_node_op_decl->content_rect);
    return new ImageNodeOp(*image_node_op_decl->content_rect,
                           image_node_op_decl->image_rect.Pass(),
                           image_node_op_decl->image_resource_id,
                           image_node_op_decl->blend.Pass());
  }

  if (node_op_decl->is_scene()) {
    auto& scene_node_op_decl = node_op_decl->get_scene();
    return new SceneNodeOp(scene_node_op_decl->scene_resource_id,
                           scene_node_op_decl->scene_version);
  }

  if (node_op_decl->is_layer()) {
    auto& layer_node_op_decl = node_op_decl->get_layer();
    DCHECK(layer_node_op_decl->layer_size);
    return new LayerNodeOp(*layer_node_op_decl->layer_size,
                           layer_node_op_decl->blend.Pass());
  }

  err << "Unsupported node op type: node_id=" << node_id
      << ", node_op=" << node_op_decl;
  return nullptr;
}

NodeDef* SceneDef::FindNode(uint32_t node_id) {
  auto it = nodes_.find(node_id);
  return it != nodes_.end() ? it->second.get() : nullptr;
}

ResourceDef* SceneDef::FindResource(uint32_t resource_id,
                                    ResourceDef::Type resource_type) {
  auto it = resources_.find(resource_id);
  return it != resources_.end() && it->second->type() == resource_type
             ? it->second.get()
             : nullptr;
}

std::string SceneDef::FormattedLabel() {
  if (formatted_label_cache_.empty()) {
    formatted_label_cache_ =
        label_.empty()
            ? base::StringPrintf("<%d/%d>", scene_token_->value, version_)
            : base::StringPrintf("<%d:%s/%d>", scene_token_->value,
                                 label_.c_str(), version_);
  }
  return formatted_label_cache_;
}

SceneDef::Publication::Publication(
    mojo::gfx::composition::SceneMetadataPtr metadata)
    : metadata(metadata.Pass()) {
  DCHECK(this->metadata);
}

SceneDef::Publication::~Publication() {}

}  // namespace compositor
