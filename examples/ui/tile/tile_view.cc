// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "examples/ui/tile/tile_view.h"
#include "mojo/services/surfaces/cpp/surfaces_utils.h"
#include "mojo/services/surfaces/interfaces/quads.mojom.h"

namespace examples {

TileView::TileView(mojo::ApplicationImpl* app_impl,
                   const std::vector<std::string>& view_urls,
                   const mojo::ui::ViewProvider::CreateViewCallback& callback)
    : app_impl_(app_impl),
      view_urls_(view_urls),
      callback_(callback),
      binding_(this),
      surface_id_namespace_(0),
      pending_child_layout_count_(0),
      frame_pending_(false),
      weak_ptr_factory_(this) {
  app_impl_->ConnectToService("mojo:surfaces_service", &surfaces_);
  app_impl_->ConnectToService("mojo:view_manager_service", &view_manager_);

  surfaces_->GetIdNamespace(base::Bind(&TileView::OnSurfaceIdNamespaceAvailable,
                                       base::Unretained(this)));
}

TileView::~TileView() {}

void TileView::OnSurfaceIdNamespaceAvailable(uint32_t id_namespace) {
  surface_id_namespace_ = id_namespace;
  InitView();
}

void TileView::InitView() {
  // Register the view.
  mojo::ui::ViewPtr view;
  binding_.Bind(mojo::GetProxy(&view));
  view_manager_->RegisterView(view.Pass(), mojo::GetProxy(&view_host_),
                              callback_);

  // Connect to all child views.
  uint32_t child_key = 0;
  for (const auto& url : view_urls_) {
    // Start connecting to the view provider.
    mojo::ui::ViewProviderPtr provider;
    app_impl_->ConnectToService(url, &provider);
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

  view_host_->AddChild(child_key, token.Pass());
  views_.emplace(
      std::make_pair(child_key, std::unique_ptr<ViewData>(new ViewData(url))));

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

  view_host_->RemoveChild(child_key);

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
  // Create a new surface the first time or if the size has changed.
  mojo::Size new_size;
  new_size.width = layout_params->constraints->max_width;
  new_size.height = layout_params->constraints->max_height;
  if (!surface_id_ || !size_.Equals(new_size)) {
    if (!surface_id_) {
      surface_id_ = mojo::SurfaceId::New();
      surface_id_->id_namespace = surface_id_namespace_;
    } else {
      surfaces_->DestroySurface(surface_id_->local);
    }
    surface_id_->local++;
    size_ = new_size;
    surfaces_->CreateSurface(surface_id_->local);
  }

  // Wipe out cached layout information for children needing layout.
  for (uint32_t child_key : children_needing_layout) {
    auto view_it = views_.find(child_key);
    if (view_it != views_.end())
      view_it->second->layout_info.reset();
  }

  // Layout all children in a row.
  if (!views_.empty()) {
    uint32_t index = 0;
    uint32_t base_width = new_size.width / views_.size();
    uint32_t excess_width = new_size.width % views_.size();
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
      uint32_t child_height = new_size.height;
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

      view_host_->LayoutChild(it->first, params.Pass(),
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
  if (frame_pending_ || pending_layout_callback_.is_null())
    return;

  // Wait until all children have laid out.
  // TODO(jeffbrown): There should be a timeout on this.
  if (pending_child_layout_count_)
    return;

  // Produce a new frame.
  mojo::FramePtr frame = mojo::Frame::New();
  frame->resources.resize(0u);

  mojo::Rect bounds;
  bounds.width = size_.width;
  bounds.height = size_.height;
  mojo::PassPtr pass = mojo::CreateDefaultPass(1, bounds);
  pass->shared_quad_states.resize(0u);
  pass->quads.resize(0u);

  for (auto it = views_.cbegin(); it != views_.cend(); it++) {
    const ViewData& view_data = *(it->second.get());

    mojo::QuadPtr quad = mojo::Quad::New();
    quad->rect = view_data.layout_bounds.Clone();
    quad->rect->x = 0;
    quad->rect->y = 0;
    quad->opaque_rect = quad->rect.Clone();
    quad->visible_rect = quad->rect.Clone();
    quad->shared_quad_state_index = pass->shared_quad_states.size();

    mojo::Size size;
    size.width = view_data.layout_bounds.width;
    size.height = view_data.layout_bounds.height;

    mojo::SharedQuadStatePtr quad_state = mojo::CreateDefaultSQS(size);
    quad_state->content_to_target_transform->matrix[3] =
        view_data.layout_bounds.x;
    pass->shared_quad_states.push_back(quad_state.Pass());

    if (it->second->layout_info) {
      quad->material = mojo::Material::SURFACE_CONTENT;
      quad->surface_quad_state = mojo::SurfaceQuadState::New();
      quad->surface_quad_state->surface =
          view_data.layout_info->surface_id.Clone();
    } else {
      quad->material = mojo::Material::SOLID_COLOR;
      quad->solid_color_quad_state = mojo::SolidColorQuadState::New();
      quad->solid_color_quad_state->color = mojo::Color::New();
      quad->solid_color_quad_state->color->rgba = 0xffff00ff;
    }

    pass->quads.push_back(quad.Pass());
  }

  frame->passes.push_back(pass.Pass());

  frame_pending_ = true;
  surfaces_->SubmitFrame(
      surface_id_->local, frame.Pass(),
      base::Bind(&TileView::OnFrameSubmitted, base::Unretained(this)));

  // Submit the new layout information.
  mojo::ui::ViewLayoutInfoPtr info = mojo::ui::ViewLayoutInfo::New();
  info->size = size_.Clone();
  info->surface_id = surface_id_->Clone();
  pending_layout_callback_.Run(info.Pass());
  pending_layout_callback_.reset();
}

void TileView::OnFrameSubmitted() {
  DCHECK(frame_pending_);

  frame_pending_ = false;
  FinishLayout();
}

TileView::ViewData::ViewData(const std::string& url)
    : url(url), layout_pending(false) {}

TileView::ViewData::~ViewData() {}

}  // namespace examples
