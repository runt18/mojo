// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <utility>

#include "mojo/application/application_runner_chromium.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_connection.h"
#include "mojo/public/cpp/application/application_delegate.h"
#include "mojo/public/cpp/application/interface_factory.h"
#include "mojo/public/cpp/system/macros.h"
#include "mojo/services/log/interfaces/log.mojom.h"
#include "services/log/log_impl.h"

namespace mojo {
namespace log {

// Provides the mojo.log.Log service.  Binds a new Log implementation for each
// Log interface request.
class LogApp : public ApplicationDelegate, public InterfaceFactory<Log> {
 public:
  LogApp() {}
  ~LogApp() override {}

 private:
  // |ApplicationDelegate| override:
  bool ConfigureIncomingConnection(ApplicationConnection* connection) override {
    connection->AddService<Log>(this);
    return true;
  }

  // |InterfaceFactory<Log>| implementation:
  // We maintain a separate |LogImpl| for each incoming connection.
  void Create(ApplicationConnection* connection,
              InterfaceRequest<Log> request) override {
    LogImpl::Create(connection, std::move(request), stderr);
  }

  MOJO_DISALLOW_COPY_AND_ASSIGN(LogApp);
};

}  // namespace log
}  // namespace mojo

MojoResult MojoMain(MojoHandle application_request) {
  mojo::ApplicationRunnerChromium runner(new mojo::log::LogApp());
  return runner.Run(application_request);
}
