// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/gfx/compositor/compositor_app.h"

#include "base/command_line.h"
#include "base/logging.h"
#include "base/trace_event/trace_event.h"
#include "mojo/application/application_runner_chromium.h"
#include "mojo/common/tracing_impl.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_connection.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "services/gfx/compositor/compositor_impl.h"

namespace compositor {

CompositorApp::CompositorApp() : app_impl_(nullptr) {}

CompositorApp::~CompositorApp() {}

void CompositorApp::Initialize(mojo::ApplicationImpl* app_impl) {
  app_impl_ = app_impl;

  auto command_line = base::CommandLine::ForCurrentProcess();
  command_line->InitFromArgv(app_impl_->args());
  logging::LoggingSettings settings;
  settings.logging_dest = logging::LOG_TO_SYSTEM_DEBUG_LOG;
  logging::InitLogging(settings);

  tracing_.Initialize(app_impl_);

  engine_.reset(new CompositorEngine());
}

bool CompositorApp::ConfigureIncomingConnection(
    mojo::ApplicationConnection* connection) {
  connection->AddService<mojo::gfx::composition::Compositor>(this);
  return true;
}

void CompositorApp::Create(
    mojo::ApplicationConnection* connection,
    mojo::InterfaceRequest<mojo::gfx::composition::Compositor> request) {
  compositor_bindings_.AddBinding(new CompositorImpl(engine_.get()),
                                  request.Pass());
}

}  // namespace compositor
