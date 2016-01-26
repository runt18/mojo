// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/ui/launcher/launcher_app.h"

#include "base/command_line.h"
#include "base/logging.h"
#include "base/trace_event/trace_event.h"
#include "mojo/application/application_runner_chromium.h"
#include "mojo/common/tracing_impl.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_connection.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "services/ui/launcher/launcher_view_tree.h"

namespace launcher {

LauncherApp::LauncherApp()
    : app_impl_(nullptr), viewport_event_dispatcher_binding_(this) {}

LauncherApp::~LauncherApp() {}

void LauncherApp::Initialize(mojo::ApplicationImpl* app_impl) {
  app_impl_ = app_impl;

  auto command_line = base::CommandLine::ForCurrentProcess();
  command_line->InitFromArgv(app_impl_->args());
  logging::LoggingSettings settings;
  settings.logging_dest = logging::LOG_TO_SYSTEM_DEBUG_LOG;
  logging::InitLogging(settings);

  tracing_.Initialize(app_impl_);
  TRACE_EVENT0("launcher", __func__);

  if (command_line->GetArgs().size() != 1) {
    LOG(ERROR) << "Invalid arguments.\n\n"
                  "Usage: mojo_shell \"mojo:launcher <app url>\"";
    app_impl_->Terminate();
    return;
  }

  app_impl_->ConnectToService("mojo:compositor_service", &compositor_);
  compositor_.set_connection_error_handler(base::Bind(
      &LauncherApp::OnCompositorConnectionError, base::Unretained(this)));

  app_impl_->ConnectToService("mojo:view_manager_service", &view_manager_);
  view_manager_.set_connection_error_handler(base::Bind(
      &LauncherApp::OnViewManagerConnectionError, base::Unretained(this)));

  InitViewport();
  LaunchClient(command_line->GetArgs()[0]);
}

void LauncherApp::OnCompositorConnectionError() {
  LOG(ERROR) << "Exiting due to compositor connection error.";
  Shutdown();
}

void LauncherApp::OnViewManagerConnectionError() {
  LOG(ERROR) << "Exiting due to view manager connection error.";
  Shutdown();
}

void LauncherApp::InitViewport() {
  app_impl_->ConnectToService("mojo:native_viewport_service", &viewport_);
  viewport_.set_connection_error_handler(base::Bind(
      &LauncherApp::OnViewportConnectionError, base::Unretained(this)));

  mojo::NativeViewportEventDispatcherPtr dispatcher;
  viewport_event_dispatcher_binding_.Bind(GetProxy(&dispatcher));
  viewport_->SetEventDispatcher(dispatcher.Pass());

  // Match the Nexus 5 aspect ratio initially.
  auto size = mojo::Size::New();
  size->width = 320;
  size->height = 640;

  auto requested_configuration = mojo::SurfaceConfiguration::New();
  viewport_->Create(
      size.Clone(), requested_configuration.Pass(),
      base::Bind(&LauncherApp::OnViewportCreated, base::Unretained(this)));
}

void LauncherApp::OnViewportConnectionError() {
  LOG(ERROR) << "Exiting due to viewport connection error.";
  Shutdown();
}

void LauncherApp::OnViewportCreated(mojo::ViewportMetricsPtr metrics) {
  viewport_->Show();

  mojo::ContextProviderPtr context_provider;
  viewport_->GetContextProvider(GetProxy(&context_provider));

  view_tree_.reset(new LauncherViewTree(
      compositor_.get(), view_manager_.get(), context_provider.Pass(),
      metrics.Pass(),
      base::Bind(&LauncherApp::Shutdown, base::Unretained(this))));
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
  viewport_->RequestMetrics(base::Bind(&LauncherApp::OnViewportMetricsChanged,
                                       base::Unretained(this)));
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
  Shutdown();
}

void LauncherApp::OnClientViewCreated(mojo::ui::ViewTokenPtr view_token) {
  client_view_token_ = view_token.Pass();
  UpdateClientView();
}

void LauncherApp::UpdateClientView() {
  if (view_tree_)
    view_tree_->SetRoot(client_view_token_.Clone());
}

void LauncherApp::Shutdown() {
  app_impl_->Terminate();
}

}  // namespace launcher
