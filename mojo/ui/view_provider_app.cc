// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/ui/view_provider_app.h"

#include "base/command_line.h"
#include "base/logging.h"

namespace mojo {
namespace ui {

class ViewProviderApp::DelegatingViewProvider : public mojo::ui::ViewProvider {
 public:
  DelegatingViewProvider(ViewProviderApp* app,
                         const std::string& view_provider_url)
      : app_(app), view_provider_url_(view_provider_url) {}

  ~DelegatingViewProvider() override {}

 private:
  // |ViewProvider|:
  void CreateView(
      mojo::InterfaceRequest<mojo::ServiceProvider> services,
      mojo::ServiceProviderPtr exposed_services,
      const mojo::ui::ViewProvider::CreateViewCallback& callback) override {
    app_->CreateView(this, view_provider_url_, services.Pass(),
                     exposed_services.Pass(), callback);
  }

  ViewProviderApp* app_;
  std::string view_provider_url_;

  MOJO_DISALLOW_COPY_AND_ASSIGN(DelegatingViewProvider);
};

ViewProviderApp::ViewProviderApp() {}

ViewProviderApp::~ViewProviderApp() {}

void ViewProviderApp::Initialize(mojo::ApplicationImpl* app_impl) {
  app_impl_ = app_impl;

  auto command_line = base::CommandLine::ForCurrentProcess();
  command_line->InitFromArgv(app_impl_->args());
  logging::LoggingSettings settings;
  settings.logging_dest = logging::LOG_TO_SYSTEM_DEBUG_LOG;
  logging::InitLogging(settings);
}

bool ViewProviderApp::ConfigureIncomingConnection(
    mojo::ApplicationConnection* connection) {
  connection->AddService<mojo::ui::ViewProvider>(this);
  return true;
}

void ViewProviderApp::Create(
    mojo::ApplicationConnection* connection,
    mojo::InterfaceRequest<mojo::ui::ViewProvider> request) {
  bindings_.AddBinding(
      new DelegatingViewProvider(this, connection->GetConnectionURL()),
      request.Pass());
}

void ViewProviderApp::CreateView(
    DelegatingViewProvider* provider,
    const std::string& view_provider_url,
    mojo::InterfaceRequest<mojo::ServiceProvider> services,
    mojo::ServiceProviderPtr exposed_services,
    const mojo::ui::ViewProvider::CreateViewCallback& callback) {
  if (!CreateView(view_provider_url, services.Pass(), exposed_services.Pass(),
                  callback)) {
    bindings_.RemoveBindings(provider);
    delete provider;
  }
}

}  // namespace ui
}  // namespace mojo
