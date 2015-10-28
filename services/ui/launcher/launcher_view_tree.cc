// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/bind.h"
#include "services/ui/launcher/launcher_view_tree.h"

namespace launcher {

LauncherViewTree::LauncherViewTree(mojo::ApplicationImpl* app_impl,
                                   mojo::DisplayPtr display,
                                   mojo::ViewportMetricsPtr viewport_metrics)
    : display_(display.Pass()),
      viewport_metrics_(viewport_metrics.Pass()),
      binding_(this),
      root_key_(0),
      frame_scheduled_(false),
      frame_pending_(false) {
  app_impl->ConnectToService("mojo:view_manager_service", &view_manager_);
  view_manager_.set_connection_error_handler(base::Bind(
      &LauncherViewTree::OnViewManagerConnectionError, base::Unretained(this)));

  mojo::ui::ViewTreePtr view_tree;
  binding_.Bind(mojo::GetProxy(&view_tree));
  view_manager_->RegisterViewTree(
      view_tree.Pass(), mojo::GetProxy(&view_tree_host_),
      base::Bind(&LauncherViewTree::OnViewTreeRegistered,
                 base::Unretained(this)));

  ScheduleFrame();
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
}

void LauncherViewTree::DispatchEvent(mojo::EventPtr event) {
  // TODO(jeffbrown): Support input dispatch.
}

void LauncherViewTree::OnViewManagerConnectionError() {
  LOG(ERROR) << "View manager connection error.";
}

void LauncherViewTree::OnViewTreeRegistered() {}

void LauncherViewTree::OnLayout(const OnLayoutCallback& callback) {
  LayoutRoot();
  callback.Run();
}

void LauncherViewTree::OnRootUnavailable(
    uint32_t root_key,
    const OnRootUnavailableCallback& callback) {
  if (root_key_ == root_key) {
    // TODO(jeffbrown): We should probably shut down the launcher.
    LOG(ERROR) << "Root view terminated unexpectedly.";
    SetRoot(mojo::ui::ViewTokenPtr());
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
           << ", surface_id.id_namespace=" << info->surface_id->id_namespace
           << ", surface_id.local=" << info->surface_id->local;

  root_layout_info_ = info.Pass();
  ScheduleFrame();
}

void LauncherViewTree::ScheduleFrame() {
  frame_scheduled_ = true;
  FinishFrame();
}

void LauncherViewTree::FinishFrame() {
  if (!frame_scheduled_ || frame_pending_)
    return;
  frame_scheduled_ = false;

  mojo::FramePtr frame = mojo::Frame::New();
  frame->resources.resize(0u);

  mojo::Rect bounds;
  bounds.width = viewport_metrics_->size->width;
  bounds.height = viewport_metrics_->size->height;
  mojo::PassPtr pass = mojo::CreateDefaultPass(1, bounds);
  pass->shared_quad_states.push_back(
      mojo::CreateDefaultSQS(*viewport_metrics_->size));

  mojo::QuadPtr quad = mojo::Quad::New();
  quad->rect = bounds.Clone();
  quad->opaque_rect = bounds.Clone();
  quad->visible_rect = bounds.Clone();
  quad->shared_quad_state_index = 0u;

  if (root_layout_info_) {
    quad->material = mojo::Material::SURFACE_CONTENT;
    quad->surface_quad_state = mojo::SurfaceQuadState::New();
    quad->surface_quad_state->surface = root_layout_info_->surface_id.Clone();
  } else {
    quad->material = mojo::Material::SOLID_COLOR;
    quad->solid_color_quad_state = mojo::SolidColorQuadState::New();
    quad->solid_color_quad_state->color = mojo::Color::New();
    quad->solid_color_quad_state->color->rgba = 0xffff0000;
  }

  pass->quads.push_back(quad.Pass());
  frame->passes.push_back(pass.Pass());

  frame_pending_ = true;
  display_->SubmitFrame(
      frame.Pass(),
      base::Bind(&LauncherViewTree::OnFrameSubmitted, base::Unretained(this)));
}

void LauncherViewTree::OnFrameSubmitted() {
  DCHECK(frame_pending_);
  frame_pending_ = false;
  FinishFrame();
}

}  // namespace launcher
