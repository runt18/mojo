// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/trace_event/trace_event.h"
#include "mojo/application/application_runner_chromium.h"
#include "mojo/common/tracing_impl.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_connection.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "services/ui/view_manager/view_manager_app.h"
#include "services/ui/view_manager/view_manager_impl.h"

namespace view_manager {

ViewManagerApp::ViewManagerApp() : app_impl_(nullptr) {}

ViewManagerApp::~ViewManagerApp() {}

void ViewManagerApp::Initialize(mojo::ApplicationImpl* app_impl) {
  app_impl_ = app_impl;
  tracing_.Initialize(app_impl);

  mojo::SurfacePtr surfaces;
  app_impl->ConnectToService("mojo:surfaces_service", &surfaces);
  surface_manager_.reset(new SurfaceManager(surfaces.Pass()));

  registry_.reset(new ViewRegistry(surface_manager_.get()));
}

bool ViewManagerApp::ConfigureIncomingConnection(
    mojo::ApplicationConnection* connection) {
  connection->AddService<mojo::ui::ViewManager>(this);
  return true;
}

void ViewManagerApp::Create(
    mojo::ApplicationConnection* connection,
    mojo::InterfaceRequest<mojo::ui::ViewManager> request) {
  view_managers.AddBinding(new ViewManagerImpl(registry_.get()),
                           request.Pass());
}

}  // namespace view_manager
