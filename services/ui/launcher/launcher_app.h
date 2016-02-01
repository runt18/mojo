// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_UI_LAUNCHER_LAUNCHER_APP_H_
#define SERVICES_UI_LAUNCHER_LAUNCHER_APP_H_

#include <memory>

#include "mojo/common/tracing_impl.h"
#include "mojo/public/cpp/application/application_delegate.h"
#include "mojo/services/gfx/composition/interfaces/compositor.mojom.h"
#include "mojo/services/native_viewport/interfaces/native_viewport.mojom.h"
#include "mojo/services/native_viewport/interfaces/native_viewport_event_dispatcher.mojom.h"
#include "mojo/services/ui/views/interfaces/view_manager.mojom.h"
#include "mojo/services/ui/views/interfaces/view_provider.mojom.h"

namespace launcher {

class LauncherViewTree;

class LauncherApp : public mojo::ApplicationDelegate,
                    public mojo::NativeViewportEventDispatcher {
 public:
  LauncherApp();
  ~LauncherApp() override;

 private:
  // |ApplicationDelegate|:
  void Initialize(mojo::ApplicationImpl* app_impl) override;

  // |NativeViewportEventDispatcher|:
  void OnEvent(mojo::EventPtr event,
               const mojo::Callback<void()>& callback) override;

  void OnCompositorConnectionError();
  void OnViewManagerConnectionError();

  void InitViewport();
  void OnViewportConnectionError();
  void OnViewportCreated(mojo::ViewportMetricsPtr metrics);
  void OnViewportMetricsChanged(mojo::ViewportMetricsPtr metrics);
  void RequestUpdatedViewportMetrics();

  void LaunchClient(std::string app_url);
  void OnClientConnectionError();
  void OnClientViewCreated(mojo::ui::ViewTokenPtr view_token);

  void UpdateClientView();

  void Shutdown();

  mojo::ApplicationImpl* app_impl_;
  mojo::TracingImpl tracing_;

  mojo::gfx::composition::CompositorPtr compositor_;
  mojo::ui::ViewManagerPtr view_manager_;

  mojo::NativeViewportPtr viewport_;
  mojo::Binding<NativeViewportEventDispatcher>
      viewport_event_dispatcher_binding_;

  std::unique_ptr<LauncherViewTree> view_tree_;

  mojo::ui::ViewProviderPtr client_view_provider_;
  mojo::ui::ViewTokenPtr client_view_token_;

  DISALLOW_COPY_AND_ASSIGN(LauncherApp);
};

}  // namespace launcher

#endif  // SERVICES_UI_LAUNCHER_LAUNCHER_APP_H_
