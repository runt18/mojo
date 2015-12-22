// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <stdio.h>

#include "base/logging.h"
#include "base/strings/string_number_conversions.h"
#include "base/trace_event/trace_event.h"
#include "examples/echo/echo.mojom.h"
#include "mojo/application/application_runner_chromium.h"
#include "mojo/common/tracing_impl.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_delegate.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/public/cpp/application/application_runner.h"
#include "mojo/public/cpp/utility/run_loop.h"

namespace mojo {
namespace examples {

static const base::TimeDelta kWarmupTime =
    base::TimeDelta::FromMilliseconds(1000);

static const base::TimeDelta kDelayTime = base::TimeDelta::FromMicroseconds(50);

class EchoClientDelegate;

class EchoResponse {
 public:
  EchoResponse(EchoClientDelegate* echo, int idx, bool traced)
      : echoDelegate_(echo), idx_(idx), traced_(traced) {}

  void Run(const String& value) const;

 private:
  EchoClientDelegate* echoDelegate_;
  int idx_;
  bool traced_;
};

class EchoClientDelegate : public ApplicationDelegate {
 public:
  EchoClientDelegate()
      : warmup_(true),
        num_clients_(1),
        num_active_clients_(1),
        use_dart_server_(false),
        ending_(false),
        benchmark_duration_(base::TimeDelta::FromSeconds(10)) {}

  void Initialize(ApplicationImpl* app) override {
    tracing_.Initialize(app);

    ParseArguments(app);

    for (int i = 0; i < num_clients_; i++) {
      EchoPtr echo;
      if (use_dart_server_) {
        app->ConnectToService("mojo:dart_echo_server", &echo);
      } else {
        app->ConnectToService("mojo:echo_server", &echo);
      }
      echoClients_.push_back(echo.Pass());
    }
    BeginEcho(0);
    base::MessageLoop::current()->PostDelayedTask(
        FROM_HERE,
        base::Bind(&EchoClientDelegate::EndWarmup, base::Unretained(this)),
        kWarmupTime);
  }

  void BeginEcho(int idx) {
    if (ending_) return;
    if (idx == num_active_clients_) {
      idx = 0;
    }
    base::MessageLoop::current()->PostDelayedTask(
        FROM_HERE,
        base::Bind(&EchoClientDelegate::Run, base::Unretained(this), idx),
        kDelayTime);
    base::MessageLoop::current()->PostDelayedTask(
        FROM_HERE,
        base::Bind(&EchoClientDelegate::EndRun, base::Unretained(this)),
        benchmark_duration_);
  }

  void EndEcho(int idx, bool traced) {
    if (traced) {
      TRACE_EVENT_ASYNC_END0("echo_benchmark", "ping", echoClients_[idx].get());
    }
  }

 private:
  void Run(int idx) {
    if (ending_) return;
    if (warmup_) {
      echoClients_[idx]->EchoString("ping", EchoResponse(this, idx, false));
    } else {
      TRACE_EVENT_ASYNC_BEGIN0("echo_benchmark", "ping",
                               echoClients_[idx].get());
      echoClients_[idx]->EchoString("ping", EchoResponse(this, idx, true));
    }
  }

  bool GetBoolArgument(const std::string& argument,
                       const std::string& flag,
                       bool* value) {
    size_t start_pos = argument.find(flag);
    if (start_pos != std::string::npos) {
      *value = true;
      return true;
    }
    return false;
  }

  bool GetIntegerArgument(const std::string& argument,
                          const std::string& flag,
                          int* value) {
    size_t start_pos = argument.find(flag);
    if (start_pos != std::string::npos) {
      size_t equals_pos = argument.find("=", start_pos);
      if (equals_pos != std::string::npos) {
        base::StringToInt(argument.substr(equals_pos + 1), value);
        return true;
      }
    }
    return false;
  }

  void ParseArguments(ApplicationImpl* app) {
    int benchmark_duration_seconds = 0;
    for (size_t i = 0; i < app->args().size(); i++) {
      const std::string& argument = app->args()[i];
      if (GetBoolArgument(argument, "--dart-server", &use_dart_server_)) {
        continue;
      }
      if (GetIntegerArgument(argument, "--num-clients", &num_clients_)) {
        continue;
      }
      if (GetIntegerArgument(argument, "--num-active-clients",
                             &num_active_clients_)) {
        continue;
      }
      if (GetIntegerArgument(argument, "--benchmark-duration",
                             &benchmark_duration_seconds)) {
        benchmark_duration_ =
            base::TimeDelta::FromSeconds(benchmark_duration_seconds);
        continue;
      }
    }
  }

  void EndRun() { ending_ = true; }

  void EndWarmup() { warmup_ = false; }

  bool warmup_;
  int num_clients_;
  int num_active_clients_;
  bool use_dart_server_;
  bool ending_;
  base::TimeDelta benchmark_duration_;
  std::vector<EchoPtr> echoClients_;
  mojo::TracingImpl tracing_;
};

void EchoResponse::Run(const String& value) const {
  echoDelegate_->EndEcho(idx_, traced_);
  echoDelegate_->BeginEcho(idx_ + 1);
}

}  // namespace examples
}  // namespace mojo

MojoResult MojoMain(MojoHandle application_request) {
  mojo::ApplicationRunnerChromium runner(
      new mojo::examples::EchoClientDelegate);
  return runner.Run(application_request);
}
