// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_UI_VIEW_MANAGER_VIEW_HOST_IMPL_H_
#define SERVICES_UI_VIEW_MANAGER_VIEW_HOST_IMPL_H_

#include "base/macros.h"
#include "mojo/public/cpp/bindings/binding.h"
#include "mojo/services/ui/views/interfaces/views.mojom.h"
#include "services/ui/view_manager/view_registry.h"
#include "services/ui/view_manager/view_state.h"

namespace view_manager {

// ViewHost interface implementation.
// This object is owned by its associated ViewState.
class ViewHostImpl : public mojo::ui::ViewHost {
 public:
  ViewHostImpl(ViewRegistry* registry,
               ViewState* state,
               mojo::InterfaceRequest<mojo::ui::ViewHost> view_host_request);
  ~ViewHostImpl() override;

  void set_view_host_connection_error_handler(const base::Closure& handler) {
    binding_.set_connection_error_handler(handler);
  }

 private:
  // |ViewHost|:
  void GetServiceProvider(
      mojo::InterfaceRequest<mojo::ServiceProvider> service_provider) override;
  void RequestLayout() override;
  void AddChild(uint32_t child_key,
                mojo::ui::ViewTokenPtr child_view_token) override;
  void RemoveChild(uint32_t child_key) override;
  void LayoutChild(uint32_t child_key,
                   mojo::ui::ViewLayoutParamsPtr child_layout_params,
                   const LayoutChildCallback& callback) override;

  ViewRegistry* const registry_;
  ViewState* const state_;
  mojo::Binding<mojo::ui::ViewHost> binding_;

  DISALLOW_COPY_AND_ASSIGN(ViewHostImpl);
};

}  // namespace view_manager

#endif  // SERVICES_UI_VIEW_MANAGER_VIEW_HOST_IMPL_H_
