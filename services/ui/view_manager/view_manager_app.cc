// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/ui/view_manager/view_manager_app.h"

#include <string>
#include <vector>

#include "base/command_line.h"
#include "base/logging.h"
#include "base/trace_event/trace_event.h"
#include "mojo/application/application_runner_chromium.h"
#include "mojo/common/tracing_impl.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_connection.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "services/ui/view_manager/view_manager_impl.h"

namespace view_manager {

ViewManagerApp::ViewManagerApp() : app_impl_(nullptr) {}

ViewManagerApp::~ViewManagerApp() {}

void ViewManagerApp::Initialize(mojo::ApplicationImpl* app_impl) {
  app_impl_ = app_impl;

  auto command_line = base::CommandLine::ForCurrentProcess();
  command_line->InitFromArgv(app_impl_->args());
  logging::LoggingSettings settings;
  settings.logging_dest = logging::LOG_TO_SYSTEM_DEBUG_LOG;
  logging::InitLogging(settings);

  tracing_.Initialize(app_impl_);

  // Connect to compositor.
  mojo::gfx::composition::CompositorPtr compositor;
  app_impl_->ConnectToService("mojo:compositor_service", &compositor);
  compositor.set_connection_error_handler(base::Bind(
      &ViewManagerApp::OnCompositorConnectionError, base::Unretained(this)));

  // Create the registry.
  registry_.reset(new ViewRegistry(compositor.Pass()));

  // Connect to associates.
  // TODO(jeffbrown): Consider making the launcher register associates
  // with the view manager or perhaps per view tree.
  std::vector<std::string> associate_urls = command_line->GetArgs();
  if (associate_urls.empty()) {
    // TODO(jeffbrown): Replace this hardcoded list.
    associate_urls.push_back("mojo:input_manager_service");
  }
  registry_->ConnectAssociates(
      app_impl_, associate_urls,
      base::Bind(&ViewManagerApp::OnAssociateConnectionError,
                 base::Unretained(this)));
}

bool ViewManagerApp::ConfigureIncomingConnection(
    mojo::ApplicationConnection* connection) {
  connection->AddService<mojo::ui::ViewManager>(this);
  return true;
}

void ViewManagerApp::Create(
    mojo::ApplicationConnection* connection,
    mojo::InterfaceRequest<mojo::ui::ViewManager> request) {
  DCHECK(registry_);
  view_managers_.AddBinding(new ViewManagerImpl(registry_.get()),
                            request.Pass());
}

void ViewManagerApp::OnCompositorConnectionError() {
  LOG(ERROR) << "Exiting due to compositor connection error.";
  Shutdown();
}

void ViewManagerApp::OnAssociateConnectionError(const std::string& url) {
  LOG(ERROR) << "Exiting due to view associate connection error: url=" << url;
  Shutdown();
}

void ViewManagerApp::Shutdown() {
  app_impl_->Terminate();
}

}  // namespace view_manager
