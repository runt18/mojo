// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "examples/ui/noodles/noodles_app.h"

#include "examples/ui/noodles/noodles_view.h"

namespace examples {

NoodlesApp::NoodlesApp() {}

NoodlesApp::~NoodlesApp() {}

bool NoodlesApp::CreateView(
    const std::string& connection_url,
    mojo::InterfaceRequest<mojo::ServiceProvider> services,
    mojo::ServiceProviderPtr exposed_services,
    const mojo::ui::ViewProvider::CreateViewCallback& callback) {
  new NoodlesView(app_impl(), callback);
  return true;
}

}  // namespace examples
