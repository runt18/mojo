// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/ui/view_manager/view_host_impl.h"
#include "services/ui/view_manager/view_manager_impl.h"
#include "services/ui/view_manager/view_tree_host_impl.h"

namespace view_manager {

ViewManagerImpl::ViewManagerImpl(ViewRegistry* registry)
    : registry_(registry) {}

ViewManagerImpl::~ViewManagerImpl() {}

void ViewManagerImpl::RegisterView(
    mojo::ui::ViewPtr view,
    mojo::InterfaceRequest<mojo::ui::ViewHost> view_host_request,
    const RegisterViewCallback& callback) {
  mojo::ui::ViewTokenPtr view_token =
      registry_->RegisterView(view.Pass(), view_host_request.Pass());
  callback.Run(view_token.Pass());
}

void ViewManagerImpl::RegisterViewTree(
    mojo::ui::ViewTreePtr view_tree,
    mojo::InterfaceRequest<mojo::ui::ViewTreeHost> view_tree_host_request,
    const RegisterViewTreeCallback& callback) {
  registry_->RegisterViewTree(view_tree.Pass(), view_tree_host_request.Pass());
  callback.Run();
}

}  // namespace view_manager
