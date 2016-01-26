// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/ui/launcher/launcher_view_tree.h"

#include "base/bind.h"
#include "mojo/public/cpp/application/connect.h"
#include "mojo/services/gfx/composition/cpp/formatting.h"
#include "mojo/services/ui/views/cpp/formatting.h"

namespace launcher {

constexpr uint32_t kViewSceneResourceId = 1;
constexpr uint32_t kRootNodeId = mojo::gfx::composition::kSceneRootNodeId;
constexpr uint32_t kViewNodeId = 1;
constexpr uint32_t kFallbackNodeId = 2;

LauncherViewTree::LauncherViewTree(
    mojo::gfx::composition::Compositor* compositor,
    mojo::ui::ViewManager* view_manager,
    mojo::ContextProviderPtr context_provider,
    mojo::ViewportMetricsPtr viewport_metrics,
    const base::Closure& shutdown_callback)
    : compositor_(compositor),
      view_manager_(view_manager),
      context_provider_(context_provider.Pass()),
      viewport_metrics_(viewport_metrics.Pass()),
      shutdown_callback_(shutdown_callback),
      scene_listener_binding_(this),
      view_tree_binding_(this) {
  // Create the renderer.
  compositor_->CreateRenderer(context_provider_.Pass(), GetProxy(&renderer_),
                              "Launcher");
  renderer_.set_connection_error_handler(base::Bind(
      &LauncherViewTree::OnRendererConnectionError, base::Unretained(this)));

  // Create the root scene.
  compositor_->CreateScene(
      mojo::GetProxy(&scene_), "Launcher",
      base::Bind(&LauncherViewTree::OnSceneRegistered, base::Unretained(this)));
  mojo::gfx::composition::SceneListenerPtr scene_listener;
  scene_listener_binding_.Bind(mojo::GetProxy(&scene_listener));
  scene_->SetListener(scene_listener.Pass());
  scene_.set_connection_error_handler(base::Bind(
      &LauncherViewTree::OnSceneConnectionError, base::Unretained(this)));

  // Register the view tree.
  mojo::ui::ViewTreePtr view_tree;
  view_tree_binding_.Bind(mojo::GetProxy(&view_tree));
  view_manager_->RegisterViewTree(
      view_tree.Pass(), mojo::GetProxy(&view_tree_host_), "Launcher",
      base::Bind(&LauncherViewTree::OnViewTreeRegistered,
                 base::Unretained(this)));
  view_tree_host_.set_connection_error_handler(base::Bind(
      &LauncherViewTree::OnViewTreeConnectionError, base::Unretained(this)));

  // Get view tree services.
  mojo::ServiceProviderPtr view_tree_service_provider;
  view_tree_host_->GetServiceProvider(
      mojo::GetProxy(&view_tree_service_provider));
  mojo::ConnectToService<mojo::ui::InputDispatcher>(
      view_tree_service_provider.get(), &input_dispatcher_);
  input_dispatcher_.set_connection_error_handler(
      base::Bind(&LauncherViewTree::OnInputDispatcherConnectionError,
                 base::Unretained(this)));
}

LauncherViewTree::~LauncherViewTree() {}

void LauncherViewTree::SetRoot(mojo::ui::ViewTokenPtr token) {
  root_ = token.Pass();
  if (root_)
    view_tree_host_->SetRoot(++root_key_, root_.Clone());
  else
    view_tree_host_->ResetRoot();
  root_layout_info_.reset();
}

void LauncherViewTree::SetViewportMetrics(
    mojo::ViewportMetricsPtr viewport_metrics) {
  viewport_metrics_ = viewport_metrics.Pass();
  view_tree_host_->RequestLayout();
  SetRootScene();
}

void LauncherViewTree::DispatchEvent(mojo::EventPtr event) {
  if (input_dispatcher_)
    input_dispatcher_->DispatchEvent(event.Pass());
}

void LauncherViewTree::OnRendererConnectionError() {
  LOG(ERROR) << "Renderer connection error.";
  Shutdown();
}

void LauncherViewTree::OnSceneConnectionError() {
  LOG(ERROR) << "Scene connection error.";
  Shutdown();
}

void LauncherViewTree::OnViewTreeConnectionError() {
  LOG(ERROR) << "View tree connection error.";
  Shutdown();
}

void LauncherViewTree::OnInputDispatcherConnectionError() {
  // This isn't considered a fatal error right now since it is still useful
  // to be able to test a view system that has graphics but no input.
  LOG(WARNING) << "Input dispatcher connection error, input will not work.";
  input_dispatcher_.reset();
}

void LauncherViewTree::OnSceneRegistered(
    mojo::gfx::composition::SceneTokenPtr scene_token) {
  DVLOG(1) << "OnSceneRegistered: scene_token=" << scene_token;
  scene_token_ = scene_token.Pass();
  SetRootScene();
}

void LauncherViewTree::OnViewTreeRegistered(
    mojo::ui::ViewTreeTokenPtr view_tree_token) {
  DVLOG(1) << "OnViewTreeRegistered: view_tree_token=" << view_tree_token;
}

void LauncherViewTree::OnResourceUnavailable(
    uint32_t resource_id,
    const OnResourceUnavailableCallback& callback) {
  LOG(ERROR) << "Resource lost: resource_id=" << resource_id;
}

void LauncherViewTree::OnLayout(const OnLayoutCallback& callback) {
  LayoutRoot();
  callback.Run();
}

void LauncherViewTree::OnRootUnavailable(
    uint32_t root_key,
    const OnRootUnavailableCallback& callback) {
  if (root_key_ == root_key) {
    LOG(ERROR) << "Root view terminated unexpectedly.";
    Shutdown();
  }
  callback.Run();
}

void LauncherViewTree::LayoutRoot() {
  if (!root_)
    return;

  auto params = mojo::ui::ViewLayoutParams::New();
  params->constraints = mojo::ui::BoxConstraints::New();
  params->constraints->min_width = viewport_metrics_->size->width;
  params->constraints->max_width = viewport_metrics_->size->width;
  params->constraints->min_height = viewport_metrics_->size->height;
  params->constraints->max_height = viewport_metrics_->size->height;
  params->device_pixel_ratio = viewport_metrics_->device_pixel_ratio;
  view_tree_host_->LayoutRoot(
      params.Pass(),
      base::Bind(&LauncherViewTree::OnLayoutResult, base::Unretained(this)));
}

void LauncherViewTree::OnLayoutResult(mojo::ui::ViewLayoutInfoPtr info) {
  if (!info) {
    DVLOG(1) << "Root layout: <stale>";
    return;
  }

  DVLOG(1) << "Root layout: size.width=" << info->size->width
           << ", size.height=" << info->size->height
           << ", scene_token.value=" << info->scene_token->value;

  root_layout_info_ = info.Pass();
  PublishFrame();
}

void LauncherViewTree::SetRootScene() {
  if (scene_token_) {
    mojo::Rect viewport;
    viewport.width = viewport_metrics_->size->width;
    viewport.height = viewport_metrics_->size->height;
    scene_version_++;
    renderer_->SetRootScene(scene_token_.Clone(), scene_version_,
                            viewport.Clone());
    PublishFrame();
  }
}

void LauncherViewTree::PublishFrame() {
  mojo::Rect bounds;
  bounds.width = viewport_metrics_->size->width;
  bounds.height = viewport_metrics_->size->height;

  auto update = mojo::gfx::composition::SceneUpdate::New();

  if (root_layout_info_) {
    auto view_resource = mojo::gfx::composition::Resource::New();
    view_resource->set_scene(mojo::gfx::composition::SceneResource::New());
    view_resource->get_scene()->scene_token =
        root_layout_info_->scene_token.Clone();
    update->resources.insert(kViewSceneResourceId, view_resource.Pass());

    auto view_node = mojo::gfx::composition::Node::New();
    view_node->op = mojo::gfx::composition::NodeOp::New();
    view_node->op->set_scene(mojo::gfx::composition::SceneNodeOp::New());
    view_node->op->get_scene()->scene_resource_id = kViewSceneResourceId;
    update->nodes.insert(kViewNodeId, view_node.Pass());
  } else {
    update->resources.insert(kViewSceneResourceId, nullptr);
    update->nodes.insert(kViewNodeId, nullptr);
  }

  auto fallback_node = mojo::gfx::composition::Node::New();
  fallback_node->op = mojo::gfx::composition::NodeOp::New();
  fallback_node->op->set_rect(mojo::gfx::composition::RectNodeOp::New());
  fallback_node->op->get_rect()->content_rect = bounds.Clone();
  fallback_node->op->get_rect()->color = mojo::gfx::composition::Color::New();
  fallback_node->op->get_rect()->color->red = 255;
  fallback_node->op->get_rect()->color->alpha = 255;
  update->nodes.insert(kFallbackNodeId, fallback_node.Pass());

  auto root_node = mojo::gfx::composition::Node::New();
  root_node->combinator = mojo::gfx::composition::Node::Combinator::FALLBACK;
  if (root_layout_info_) {
    root_node->child_node_ids.push_back(kViewNodeId);
  }
  root_node->child_node_ids.push_back(kFallbackNodeId);
  update->nodes.insert(kRootNodeId, root_node.Pass());

  auto metadata = mojo::gfx::composition::SceneMetadata::New();
  metadata->version = scene_version_;

  scene_->Update(update.Pass());
  scene_->Publish(metadata.Pass());
}

void LauncherViewTree::Shutdown() {
  shutdown_callback_.Run();
}

}  // namespace launcher
