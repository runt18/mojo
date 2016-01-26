// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "apps/moterm/moterm_app.h"

#include "apps/moterm/moterm_view.h"

MotermApp::MotermApp() {}

MotermApp::~MotermApp() {}

bool MotermApp::CreateView(
    const std::string& connection_url,
    mojo::InterfaceRequest<mojo::ServiceProvider> services,
    mojo::ServiceProviderPtr exposed_services,
    const mojo::ui::ViewProvider::CreateViewCallback& callback) {
  new MotermView(app_impl(), services.Pass(), callback);
  return true;
}
