// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/bind.h"
#include "base/bind_helpers.h"
#include "services/ui/view_manager/view_host_impl.h"

namespace view_manager {

ViewHostImpl::ViewHostImpl(
    ViewRegistry* registry,
    ViewState* state,
    mojo::InterfaceRequest<mojo::ui::ViewHost> view_host_request)
    : registry_(registry),
      state_(state),
      binding_(this, view_host_request.Pass()) {}

ViewHostImpl::~ViewHostImpl() {}

void ViewHostImpl::GetServiceProvider(
    mojo::InterfaceRequest<mojo::ServiceProvider> service_provider) {
  state_->GetServiceProvider(service_provider.Pass());
}

void ViewHostImpl::RequestLayout() {
  registry_->RequestLayout(state_);
}

void ViewHostImpl::AddChild(uint32_t child_key,
                            mojo::ui::ViewTokenPtr child_view_token) {
  registry_->AddChild(state_, child_key, child_view_token.Pass());
}

void ViewHostImpl::RemoveChild(uint32_t child_key) {
  registry_->RemoveChild(state_, child_key);
}

static void RunLayoutChildCallback(
    const ViewHostImpl::LayoutChildCallback& callback,
    mojo::ui::ViewLayoutInfoPtr info) {
  callback.Run(info.Pass());
}

void ViewHostImpl::LayoutChild(
    uint32_t child_key,
    mojo::ui::ViewLayoutParamsPtr child_layout_params,
    const LayoutChildCallback& callback) {
  registry_->LayoutChild(state_, child_key, child_layout_params.Pass(),
                         base::Bind(&RunLayoutChildCallback, callback));
}

}  // namespace view_manager
