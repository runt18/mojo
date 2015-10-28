// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "examples/ui/spinning_cube/spinning_cube_app.h"
#include "examples/ui/spinning_cube/spinning_cube_view.h"

namespace examples {

SpinningCubeApp::SpinningCubeApp() {}

SpinningCubeApp::~SpinningCubeApp() {}

void SpinningCubeApp::Initialize(mojo::ApplicationImpl* app_impl) {
  app_impl_ = app_impl;
}

bool SpinningCubeApp::ConfigureIncomingConnection(
    mojo::ApplicationConnection* connection) {
  connection->AddService<mojo::ui::ViewProvider>(this);
  return true;
}

void SpinningCubeApp::Create(
    mojo::ApplicationConnection* connection,
    mojo::InterfaceRequest<mojo::ui::ViewProvider> request) {
  bindings_.AddBinding(this, request.Pass());
}

void SpinningCubeApp::CreateView(
    mojo::InterfaceRequest<mojo::ServiceProvider> services,
    mojo::ServiceProviderPtr exposed_services,
    const CreateViewCallback& callback) {
  new SpinningCubeView(app_impl_, callback);
}

}  // namespace examples
