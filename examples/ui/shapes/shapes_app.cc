// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "examples/ui/shapes/shapes_app.h"

#include "examples/ui/shapes/shapes_view.h"

namespace examples {

ShapesApp::ShapesApp() {}

ShapesApp::~ShapesApp() {}

bool ShapesApp::CreateView(
    const std::string& connection_url,
    mojo::InterfaceRequest<mojo::ServiceProvider> services,
    mojo::ServiceProviderPtr exposed_services,
    const mojo::ui::ViewProvider::CreateViewCallback& callback) {
  new ShapesView(app_impl(), callback);
  return true;
}

}  // namespace examples
