// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/trace_event/trace_event.h"
#include "mojo/application/application_runner_chromium.h"
#include "mojo/common/tracing_impl.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_connection.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/services/surfaces/cpp/surfaces_utils.h"
#include "mojo/services/surfaces/interfaces/quads.mojom.h"
#include "services/ui/launcher/launcher_app.h"
#include "services/ui/launcher/launcher_view_tree.h"

namespace launcher {

LauncherApp::LauncherApp()
    : app_impl_(nullptr), viewport_event_dispatcher_binding_(this) {}

LauncherApp::~LauncherApp() {}

void LauncherApp::Initialize(mojo::ApplicationImpl* app) {
  app_impl_ = app;
  tracing_.Initialize(app);
  TRACE_EVENT0("launcher", __func__);

  if (app->args().size() != 2) {
    LOG(ERROR) << "Invalid arguments.\n\n"
                  "Usage: mojo_shell \"mojo:launcher <app url>\"";
    app->Terminate();
    return;
  }

  InitViewport();
  LaunchClient(app->args()[1]);
}

void LauncherApp::InitViewport() {
  app_impl_->ConnectToService("mojo:native_viewport_service",
                              &viewport_service_);
  viewport_service_.set_connection_error_handler(base::Bind(
      &LauncherApp::OnViewportConnectionError, base::Unretained(this)));

  mojo::NativeViewportEventDispatcherPtr dispatcher;
  viewport_event_dispatcher_binding_.Bind(GetProxy(&dispatcher));
  viewport_service_->SetEventDispatcher(dispatcher.Pass());

  // Match the Nexus 5 aspect ratio initially.
  auto size = mojo::Size::New();
  size->width = 320;
  size->height = 640;

  auto requested_configuration = mojo::SurfaceConfiguration::New();
  viewport_service_->Create(
      size.Clone(), requested_configuration.Pass(),
      base::Bind(&LauncherApp::OnViewportCreated, base::Unretained(this)));
}

void LauncherApp::OnViewportConnectionError() {
  LOG(ERROR) << "Exiting due to viewport connection error.";
  app_impl_->Terminate();
}

void LauncherApp::OnViewportCreated(mojo::ViewportMetricsPtr metrics) {
  viewport_service_->Show();
  mojo::ContextProviderPtr context_provider;
  viewport_service_->GetContextProvider(GetProxy(&context_provider));

  mojo::DisplayFactoryPtr display_factory;
  app_impl_->ConnectToService("mojo:surfaces_service", &display_factory);

  mojo::DisplayPtr display;
  display_factory->Create(context_provider.Pass(), nullptr, GetProxy(&display));

  view_tree_.reset(
      new LauncherViewTree(app_impl_, display.Pass(), metrics.Pass()));
  UpdateClientView();
  RequestUpdatedViewportMetrics();
}

void LauncherApp::OnViewportMetricsChanged(mojo::ViewportMetricsPtr metrics) {
  if (view_tree_) {
    view_tree_->SetViewportMetrics(metrics.Pass());
    RequestUpdatedViewportMetrics();
  }
}

void LauncherApp::RequestUpdatedViewportMetrics() {
  viewport_service_->RequestMetrics(base::Bind(
      &LauncherApp::OnViewportMetricsChanged, base::Unretained(this)));
}

void LauncherApp::OnEvent(mojo::EventPtr event,
                          const mojo::Callback<void()>& callback) {
  if (view_tree_)
    view_tree_->DispatchEvent(event.Pass());
  callback.Run();
}

void LauncherApp::LaunchClient(std::string app_url) {
  DVLOG(1) << "Launching " << app_url;

  app_impl_->ConnectToService(app_url, &client_view_provider_);
  client_view_provider_.set_connection_error_handler(base::Bind(
      &LauncherApp::OnClientConnectionError, base::Unretained(this)));

  client_view_provider_->CreateView(
      nullptr, nullptr,
      base::Bind(&LauncherApp::OnClientViewCreated, base::Unretained(this)));
}

void LauncherApp::OnClientConnectionError() {
  LOG(ERROR) << "Exiting due to client application connection error.";
  app_impl_->Terminate();
}

void LauncherApp::OnClientViewCreated(mojo::ui::ViewTokenPtr view_token) {
  client_view_token_ = view_token.Pass();
  UpdateClientView();
}

void LauncherApp::UpdateClientView() {
  if (view_tree_)
    view_tree_->SetRoot(client_view_token_.Clone());
}

}  // namespace launcher
