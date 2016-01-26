// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/ui/content_viewer_app.h"

#include "base/command_line.h"
#include "base/logging.h"

namespace mojo {
namespace ui {

class ContentViewerApp::DelegatingContentHandler : public mojo::ContentHandler {
 public:
  DelegatingContentHandler(ContentViewerApp* app,
                           const std::string& content_handler_url)
      : app_(app), content_handler_url_(content_handler_url) {}

  ~DelegatingContentHandler() override {}

 private:
  // |ContentHandler|:
  void StartApplication(
      mojo::InterfaceRequest<mojo::Application> application_request,
      mojo::URLResponsePtr response) override {
    app_->StartViewer(content_handler_url_, application_request.Pass(),
                      response.Pass());
  }

  ContentViewerApp* app_;
  std::string content_handler_url_;

  MOJO_DISALLOW_COPY_AND_ASSIGN(DelegatingContentHandler);
};

ContentViewerApp::ContentViewerApp() {}

ContentViewerApp::~ContentViewerApp() {}

void ContentViewerApp::Initialize(mojo::ApplicationImpl* app_impl) {
  app_impl_ = app_impl;

  auto command_line = base::CommandLine::ForCurrentProcess();
  command_line->InitFromArgv(app_impl_->args());
  logging::LoggingSettings settings;
  settings.logging_dest = logging::LOG_TO_SYSTEM_DEBUG_LOG;
  logging::InitLogging(settings);
}

bool ContentViewerApp::ConfigureIncomingConnection(
    mojo::ApplicationConnection* connection) {
  connection->AddService<mojo::ContentHandler>(this);
  return true;
}

void ContentViewerApp::Create(
    mojo::ApplicationConnection* connection,
    mojo::InterfaceRequest<mojo::ContentHandler> request) {
  bindings_.AddBinding(
      new DelegatingContentHandler(this, connection->GetConnectionURL()),
      request.Pass());
}

void ContentViewerApp::StartViewer(
    const std::string& content_handler_url,
    mojo::InterfaceRequest<mojo::Application> application_request,
    mojo::URLResponsePtr response) {
  ViewProviderApp* app = LoadContent(content_handler_url, response.Pass());
  if (app)
    new mojo::ApplicationImpl(app, application_request.Pass());
}

}  // namespace ui
}  // namespace mojo
