// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_UI_VIEW_MANAGER_VIEW_TREE_HOST_IMPL_H_
#define SERVICES_UI_VIEW_MANAGER_VIEW_TREE_HOST_IMPL_H_

#include "base/macros.h"
#include "mojo/public/cpp/bindings/binding.h"
#include "mojo/services/ui/views/interfaces/view_trees.mojom.h"
#include "services/ui/view_manager/view_registry.h"
#include "services/ui/view_manager/view_tree_state.h"

namespace view_manager {

// ViewTreeHost interface implementation.
// This object is owned by its associated ViewTreeState.
class ViewTreeHostImpl : public mojo::ui::ViewTreeHost {
 public:
  ViewTreeHostImpl(
      ViewRegistry* registry,
      ViewTreeState* state,
      mojo::InterfaceRequest<mojo::ui::ViewTreeHost> view_tree_host_request);
  ~ViewTreeHostImpl() override;

  void set_view_tree_host_connection_error_handler(
      const base::Closure& handler) {
    binding_.set_connection_error_handler(handler);
  }

 private:
  // |ViewTreeHost|:
  void RequestLayout() override;
  void SetRoot(uint32_t root_key,
               mojo::ui::ViewTokenPtr root_view_token) override;
  void ResetRoot() override;
  void LayoutRoot(mojo::ui::ViewLayoutParamsPtr root_layout_params,
                  const LayoutRootCallback& callback) override;

  ViewRegistry* const registry_;
  ViewTreeState* const state_;
  mojo::Binding<mojo::ui::ViewTreeHost> binding_;

  DISALLOW_COPY_AND_ASSIGN(ViewTreeHostImpl);
};

}  // namespace view_manager

#endif  // SERVICES_UI_VIEW_MANAGER_VIEW_TREE_HOST_IMPL_H_
