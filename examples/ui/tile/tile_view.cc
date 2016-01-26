// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/bind.h"
#include "examples/ui/tile/tile_view.h"
#include "mojo/services/geometry/cpp/geometry_util.h"

namespace examples {

namespace {
constexpr uint32_t kViewResourceIdBase = 100;
constexpr uint32_t kViewResourceIdSpacing = 100;

constexpr uint32_t kRootNodeId = mojo::gfx::composition::kSceneRootNodeId;
constexpr uint32_t kViewNodeIdBase = 100;
constexpr uint32_t kViewNodeIdSpacing = 100;
constexpr uint32_t kViewSceneNodeIdOffset = 1;
constexpr uint32_t kViewFallbackNodeIdOffset = 2;
}  // namespace

TileView::TileView(mojo::ApplicationImpl* app_impl,
                   const std::vector<std::string>& view_urls,
                   const mojo::ui::ViewProvider::CreateViewCallback& callback)
    : BaseView(app_impl, "Tile", callback), view_urls_(view_urls) {
  ConnectViews();
}

TileView::~TileView() {}

void TileView::ConnectViews() {
  uint32_t child_key = 0;
  for (const auto& url : view_urls_) {
    // Start connecting to the view provider.
    mojo::ui::ViewProviderPtr provider;
    app_impl()->ConnectToService(url, &provider);
    provider.set_connection_error_handler(
        base::Bind(&TileView::OnChildConnectionError, base::Unretained(this),
                   child_key, url));

    // Create the view.
    // We include the provider reference in the callback so that the
    // binding will be kept alive until the callback completes.
    LOG(INFO) << "Connecting to view: child_key=" << child_key
              << ", url=" << url;
    provider->CreateView(
        nullptr, nullptr,
        base::Bind(&TileView::OnChildCreated, base::Unretained(this), child_key,
                   url, base::Passed(provider.Pass())));
    child_key++;
  }
}

void TileView::OnChildConnectionError(uint32_t child_key,
                                      const std::string& url) {
  LOG(ERROR) << "Could not connect to view: child_key=" << child_key
             << ", url=" << url;
}

void TileView::OnChildCreated(uint32_t child_key,
                              const std::string& url,
                              mojo::ui::ViewProviderPtr provider,
                              mojo::ui::ViewTokenPtr token) {
  DCHECK(views_.find(child_key) == views_.end());
  LOG(INFO) << "View created: child_key=" << child_key << ", url=" << url;

  view_host()->AddChild(child_key, token.Pass());
  views_.emplace(std::make_pair(
      child_key, std::unique_ptr<ViewData>(new ViewData(url, child_key))));

  // Note that the view provider will be destroyed once this function
  // returns which is fine now that we are done creating the view.
}

void TileView::OnChildUnavailable(uint32_t child_key,
                                  const OnChildUnavailableCallback& callback) {
  auto it = views_.find(child_key);
  DCHECK(it != views_.end());
  LOG(ERROR) << "View died unexpectedly: child_key=" << child_key
             << ", url=" << it->second->url;

  std::unique_ptr<ViewData> view_data = std::move(it->second);
  views_.erase(it);

  view_host()->RemoveChild(child_key);

  if (view_data->layout_pending) {
    DCHECK(pending_child_layout_count_);
    pending_child_layout_count_--;
    FinishLayout();
  }

  callback.Run();
}

void TileView::OnLayout(mojo::ui::ViewLayoutParamsPtr layout_params,
                        mojo::Array<uint32_t> children_needing_layout,
                        const OnLayoutCallback& callback) {
  size_.width = layout_params->constraints->max_width;
  size_.height = layout_params->constraints->max_height;

  // Wipe out cached layout information for children needing layout.
  for (uint32_t child_key : children_needing_layout) {
    auto view_it = views_.find(child_key);
    if (view_it != views_.end())
      view_it->second->layout_info.reset();
  }

  // Layout all children in a row.
  if (!views_.empty()) {
    uint32_t index = 0;
    uint32_t base_width = size_.width / views_.size();
    uint32_t excess_width = size_.width % views_.size();
    uint32_t x = 0;
    for (auto it = views_.begin(); it != views_.end(); ++it, ++index) {
      ViewData* view_data = it->second.get();
      DCHECK(!view_data->layout_pending);

      // Distribute any excess width among the leading children.
      uint32_t child_width = base_width;
      if (excess_width) {
        child_width++;
        excess_width--;
      }
      uint32_t child_height = size_.height;
      uint32_t child_x = x;
      x += child_width;

      view_data->layout_bounds.x = child_x;
      view_data->layout_bounds.y = 0;
      view_data->layout_bounds.width = child_width;
      view_data->layout_bounds.height = child_height;

      mojo::ui::ViewLayoutParamsPtr params = mojo::ui::ViewLayoutParams::New();
      params->constraints = mojo::ui::BoxConstraints::New();
      params->constraints->min_width = child_width;
      params->constraints->max_width = child_width;
      params->constraints->min_height = child_height;
      params->constraints->max_height = child_height;
      params->device_pixel_ratio = layout_params->device_pixel_ratio;

      if (view_data->layout_info && view_data->layout_params.Equals(params))
        continue;  // no layout work to do

      pending_child_layout_count_++;
      view_data->layout_pending = true;
      view_data->layout_params = params.Clone();
      view_data->layout_info.reset();

      view_host()->LayoutChild(it->first, params.Pass(),
                               base::Bind(&TileView::OnChildLayoutFinished,
                                          base::Unretained(this), it->first));
    }
  }

  // Store the callback until layout of all children is finished.
  pending_layout_callback_ = callback;
  FinishLayout();
}

void TileView::OnChildLayoutFinished(
    uint32_t child_key,
    mojo::ui::ViewLayoutInfoPtr child_layout_info) {
  auto it = views_.find(child_key);
  if (it != views_.end()) {
    ViewData* view_data = it->second.get();
    DCHECK(view_data->layout_pending);
    DCHECK(pending_child_layout_count_);
    pending_child_layout_count_--;
    view_data->layout_pending = false;
    view_data->layout_info = child_layout_info.Pass();
    FinishLayout();
  }
}

void TileView::FinishLayout() {
  if (pending_layout_callback_.is_null())
    return;

  // Wait until all children have laid out.
  // TODO(jeffbrown): There should be a timeout on this.
  if (pending_child_layout_count_)
    return;

  // Update the scene.
  // TODO: only send the resources once, be more incremental
  auto update = mojo::gfx::composition::SceneUpdate::New();

  // Create the root node.
  auto root_node = mojo::gfx::composition::Node::New();

  // Add the children.
  for (auto it = views_.cbegin(); it != views_.cend(); it++) {
    const ViewData& view_data = *(it->second.get());
    const uint32_t scene_resource_id =
        kViewResourceIdBase + view_data.key * kViewResourceIdSpacing;
    const uint32_t container_node_id =
        kViewNodeIdBase + view_data.key * kViewNodeIdSpacing;
    const uint32_t scene_node_id = container_node_id + kViewSceneNodeIdOffset;
    const uint32_t fallback_node_id =
        container_node_id + kViewFallbackNodeIdOffset;

    mojo::Rect extent;
    extent.width = view_data.layout_bounds.width;
    extent.height = view_data.layout_bounds.height;

    // Create a container to represent the place where the child view
    // will be presented.  The children of the container provide
    // fallback behavior in case the view is not available.
    auto container_node = mojo::gfx::composition::Node::New();
    container_node->content_clip = extent.Clone();
    container_node->content_transform = mojo::Transform::New();
    SetTranslationTransform(container_node->content_transform.get(),
                            view_data.layout_bounds.x,
                            view_data.layout_bounds.y, 0.f);
    container_node->combinator =
        mojo::gfx::composition::Node::Combinator::FALLBACK;

    // If we have the view, add it to the scene.
    if (view_data.layout_info) {
      auto scene_resource = mojo::gfx::composition::Resource::New();
      scene_resource->set_scene(mojo::gfx::composition::SceneResource::New());
      scene_resource->get_scene()->scene_token =
          view_data.layout_info->scene_token.Clone();
      update->resources.insert(scene_resource_id, scene_resource.Pass());

      auto scene_node = mojo::gfx::composition::Node::New();
      scene_node->op = mojo::gfx::composition::NodeOp::New();
      scene_node->op->set_scene(mojo::gfx::composition::SceneNodeOp::New());
      scene_node->op->get_scene()->scene_resource_id = scene_resource_id;
      update->nodes.insert(scene_node_id, scene_node.Pass());
      container_node->child_node_ids.push_back(scene_node_id);
    } else {
      update->resources.insert(fallback_node_id, nullptr);
      update->nodes.insert(scene_node_id, nullptr);
    }

    // Add the fallback content.
    auto fallback_node = mojo::gfx::composition::Node::New();
    fallback_node->op = mojo::gfx::composition::NodeOp::New();
    fallback_node->op->set_rect(mojo::gfx::composition::RectNodeOp::New());
    fallback_node->op->get_rect()->content_rect = extent.Clone();
    fallback_node->op->get_rect()->color = mojo::gfx::composition::Color::New();
    fallback_node->op->get_rect()->color->red = 255;
    fallback_node->op->get_rect()->color->alpha = 255;
    update->nodes.insert(fallback_node_id, fallback_node.Pass());
    container_node->child_node_ids.push_back(fallback_node_id);

    // Add the container.
    update->nodes.insert(container_node_id, container_node.Pass());
    root_node->child_node_ids.push_back(container_node_id);
  }

  // Add the root node.
  update->nodes.insert(kRootNodeId, root_node.Pass());

  // Publish the scene.
  scene()->Update(update.Pass());
  scene()->Publish(nullptr);

  // Submit the new layout information.
  auto info = mojo::ui::ViewLayoutResult::New();
  info->size = size_.Clone();
  pending_layout_callback_.Run(info.Pass());
  pending_layout_callback_.reset();
}

TileView::ViewData::ViewData(const std::string& url, uint32_t key)
    : url(url), key(key), layout_pending(false) {}

TileView::ViewData::~ViewData() {}

}  // namespace examples
