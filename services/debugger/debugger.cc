// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <algorithm>

#include "base/bind.h"
#include "base/debug/profiler.h"
#include "base/strings/string_number_conversions.h"
#include "base/strings/stringprintf.h"
#include "mojo/application/application_runner_chromium.h"
#include "mojo/data_pipe_utils/data_pipe_utils.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_delegate.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/public/cpp/bindings/binding.h"
#include "mojo/services/http_server/cpp/http_server_util.h"
#include "mojo/services/http_server/interfaces/http_server.mojom.h"
#include "mojo/services/http_server/interfaces/http_server_factory.mojom.h"
#include "mojo/services/network/interfaces/net_address.mojom.h"
#include "mojo/services/tracing/interfaces/tracing.mojom.h"
#include "services/debugger/trace_collector.h"

// Debugger is a Mojo application that exposes an http server and talks to other
// mojo apps in response to url requests received by the server. Supported
// actions include tracing and profiling, allowing to interactively inspect how
// the shell is performing.

namespace debugger {

class Debugger : public mojo::ApplicationDelegate,
                 public http_server::HttpHandler {
 public:
  Debugger() : is_tracing_(false), app_(nullptr), handler_binding_(this) {}
  ~Debugger() override {}

 private:
  // mojo::ApplicationDelegate:
  void Initialize(mojo::ApplicationImpl* app) override {
    app_ = app;

    // Format: --args-for="app_url command_port"
    if (app->args().size() < 2) {
      LOG(ERROR) << "--args-for required to specify command_port";
      mojo::ApplicationImpl::Terminate();
      return;
    }
    base::StringToUint(app->args()[1], &command_port_);
    http_server::HttpServerFactoryPtr http_server_factory;
    app->ConnectToService("mojo:http_server", &http_server_factory);

    mojo::NetAddressPtr local_address(mojo::NetAddress::New());
    local_address->family = mojo::NetAddressFamily::IPV4;
    local_address->ipv4 = mojo::NetAddressIPv4::New();
    local_address->ipv4->addr.resize(4);
    local_address->ipv4->addr[0] = 127;
    local_address->ipv4->addr[1] = 0;
    local_address->ipv4->addr[2] = 0;
    local_address->ipv4->addr[3] = 1;
    local_address->ipv4->port = command_port_;
    http_server_factory->CreateHttpServer(GetProxy(&http_server_).Pass(),
                                          local_address.Pass());

    http_server::HttpHandlerPtr handler_ptr;
    handler_binding_.Bind(GetProxy(&handler_ptr).Pass());
    http_server_->SetHandler(".*", handler_ptr.Pass(),
                             [](bool result) { DCHECK(result); });
  }

  bool ConfigureIncomingConnection(
      mojo::ApplicationConnection* connection) override {
    return true;
  }

  // http_server::HttpHandler:
  void HandleRequest(http_server::HttpRequestPtr request,
                     const HandleRequestCallback& callback) override {
    // FIXME: We should use use a fancier lookup system more like what
    // services/http_server/http_server.cc does with AddHandler.
    if (request->relative_url == "/quit") {
      Exit();
    } else if (request->relative_url == "/start_tracing") {
      StartTracing(callback);
    } else if (request->relative_url == "/stop_tracing") {
      StopTracing(callback);
    } else {
      Help(callback, request->relative_url);
    }
  }

  void Error(const HandleRequestCallback& callback, std::string message) {
    callback.Run(http_server::CreateHttpResponse(500, message));
  }

  void Respond(const HandleRequestCallback& callback, std::string response) {
    callback.Run(http_server::CreateHttpResponse(200, response));
  }

  void Help(const HandleRequestCallback& callback, std::string path) {
    std::string help = base::StringPrintf(
        "Debugger running on port %d\n"
        "Supported URLs:\n"
        "/quit             -- Quit\n"
        "/start_tracing    -- Start Tracing\n"
        "/stop_tracing     -- Stop Tracing\n",
        command_port_);
    if (path != "/")
      help = "Unknown path: " + path + "\n\n" + help;
    Respond(callback, help);
  }

  void Exit() {
    // TODO(eseidel): We should orderly shutdown once mojo can.
    exit(0);
  }

  void StartTracing(const HandleRequestCallback& callback) {
    if (is_tracing_) {
      Error(callback, "Already tracing. Use stop_tracing to stop.\n");
      return;
    }

    if (!tracing_)
      app_->ConnectToService("mojo:tracing", &tracing_);
    is_tracing_ = true;
    mojo::DataPipe pipe;
    tracing_->Start(pipe.producer_handle.Pass(), mojo::String("*"));
    trace_collector_.reset(new TraceCollector(pipe.consumer_handle.Pass()));
    Respond(callback, "Starting trace (type 'stop_tracing' to stop)\n");
  }

  void StopTracing(const HandleRequestCallback& callback) {
    if (!is_tracing_) {
      Error(callback, "Not tracing yet. Use start_tracing to start.\n");
      return;
    }

    is_tracing_ = false;
    tracing_->StopAndFlush();
    trace_collector_->GetTrace(base::Bind(&Debugger::OnTraceAvailable,
                                          base::Unretained(this), callback));
  }

  void OnTraceAvailable(HandleRequestCallback callback, std::string trace) {
    trace_collector_.reset();
    Respond(callback, trace);
  }

  bool is_tracing_;
  mojo::ApplicationImpl* app_;
  tracing::TraceCollectorPtr tracing_;
  uint32_t command_port_;

  http_server::HttpServerPtr http_server_;
  mojo::Binding<http_server::HttpHandler> handler_binding_;

  scoped_ptr<TraceCollector> trace_collector_;

  DISALLOW_COPY_AND_ASSIGN(Debugger);
};

}  // namespace debugger

MojoResult MojoMain(MojoHandle application_request) {
  mojo::ApplicationRunnerChromium runner(new debugger::Debugger);
  runner.set_message_loop_type(base::MessageLoop::TYPE_IO);
  return runner.Run(application_request);
}
