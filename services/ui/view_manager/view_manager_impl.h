// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_UI_VIEW_MANAGER_VIEW_MANAGER_IMPL_H_
#define SERVICES_UI_VIEW_MANAGER_VIEW_MANAGER_IMPL_H_

#include "base/macros.h"
#include "mojo/services/ui/views/interfaces/view_manager.mojom.h"
#include "services/ui/view_manager/view_registry.h"

namespace view_manager {

// ViewManager interface implementation.
class ViewManagerImpl : public mojo::ui::ViewManager {
 public:
  explicit ViewManagerImpl(ViewRegistry* registry);
  ~ViewManagerImpl() override;

 private:
  // |ViewManager|:
  void RegisterView(
      mojo::ui::ViewPtr view,
      mojo::InterfaceRequest<mojo::ui::ViewHost> view_host_request,
      const mojo::String& label,
      const RegisterViewCallback& callback) override;
  void RegisterViewTree(
      mojo::ui::ViewTreePtr view_tree,
      mojo::InterfaceRequest<mojo::ui::ViewTreeHost> view_tree_host_request,
      const mojo::String& label,
      const RegisterViewTreeCallback& callback) override;

  ViewRegistry* registry_;

  DISALLOW_COPY_AND_ASSIGN(ViewManagerImpl);
};

}  // namespace view_manager

#endif  // SERVICES_UI_VIEW_MANAGER_VIEW_MANAGER_IMPL_H_
