// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_UI_VIEW_MANAGER_VIEW_MANAGER_APP_H_
#define SERVICES_UI_VIEW_MANAGER_VIEW_MANAGER_APP_H_

#include <memory>

#include "base/macros.h"
#include "mojo/common/strong_binding_set.h"
#include "mojo/common/tracing_impl.h"
#include "mojo/public/cpp/application/application_delegate.h"
#include "mojo/services/gfx/composition/interfaces/compositor.mojom.h"
#include "mojo/services/ui/views/interfaces/view_manager.mojom.h"
#include "services/ui/view_manager/view_registry.h"

namespace view_manager {

// View manager application entry point.
class ViewManagerApp : public mojo::ApplicationDelegate,
                       public mojo::InterfaceFactory<mojo::ui::ViewManager> {
 public:
  ViewManagerApp();
  ~ViewManagerApp() override;

 private:
  // |ApplicationDelegate|:
  void Initialize(mojo::ApplicationImpl* app_impl) override;
  bool ConfigureIncomingConnection(
      mojo::ApplicationConnection* connection) override;

  // |InterfaceFactory<ViewManager>|:
  void Create(mojo::ApplicationConnection* connection,
              mojo::InterfaceRequest<mojo::ui::ViewManager> request) override;

  void OnCompositorConnectionError();
  void OnAssociateConnectionError(const std::string& url);

  void Shutdown();

  mojo::ApplicationImpl* app_impl_;
  mojo::TracingImpl tracing_;

  mojo::StrongBindingSet<mojo::ui::ViewManager> view_managers_;
  std::unique_ptr<ViewRegistry> registry_;

  DISALLOW_COPY_AND_ASSIGN(ViewManagerApp);
};

}  // namespace view_manager

#endif  // SERVICES_UI_VIEW_MANAGER_VIEW_MANAGER_APP_H_
