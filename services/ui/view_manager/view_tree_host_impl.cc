// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/bind.h"
#include "base/bind_helpers.h"
#include "services/ui/view_manager/view_tree_host_impl.h"

namespace view_manager {

ViewTreeHostImpl::ViewTreeHostImpl(
    ViewRegistry* registry,
    ViewTreeState* state,
    mojo::InterfaceRequest<mojo::ui::ViewTreeHost> view_tree_host_request)
    : registry_(registry),
      state_(state),
      binding_(this, view_tree_host_request.Pass()) {}

ViewTreeHostImpl::~ViewTreeHostImpl() {}

void ViewTreeHostImpl::RequestLayout() {
  registry_->RequestLayout(state_);
}

void ViewTreeHostImpl::SetRoot(uint32_t root_key,
                               mojo::ui::ViewTokenPtr root_view_token) {
  registry_->SetRoot(state_, root_key, root_view_token.Pass());
}

void ViewTreeHostImpl::ResetRoot() {
  registry_->ResetRoot(state_);
}

static void RunLayoutRootCallback(
    const ViewTreeHostImpl::LayoutRootCallback& callback,
    mojo::ui::ViewLayoutInfoPtr info) {
  callback.Run(info.Pass());
}

void ViewTreeHostImpl::LayoutRoot(
    mojo::ui::ViewLayoutParamsPtr root_layout_params,
    const LayoutRootCallback& callback) {
  registry_->LayoutRoot(state_, root_layout_params.Pass(),
                        base::Bind(&RunLayoutRootCallback, callback));
}

}  // namespace view_manager
