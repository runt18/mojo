// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <stdio.h>

#include "base/logging.h"
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
  EchoResponse(EchoClientDelegate* echo, bool traced)
      : echo_(echo), traced_(traced) {}

  void Run(const String& value) const;

 private:
  EchoClientDelegate* echo_;
  bool traced_;
};

class EchoClientDelegate : public ApplicationDelegate {
 public:
  EchoClientDelegate() : warmup_(true) {}

  void Initialize(ApplicationImpl* app) override {
    tracing_.Initialize(app);
    app->ConnectToService("mojo:echo_server", &echo_);
    BeginEcho();
    base::MessageLoop::current()->PostDelayedTask(
        FROM_HERE,
        base::Bind(&EchoClientDelegate::EndWarmup, base::Unretained(this)),
        kWarmupTime);
  }

  void BeginEcho() {
    base::MessageLoop::current()->PostDelayedTask(
        FROM_HERE, base::Bind(&EchoClientDelegate::Run, base::Unretained(this)),
        kDelayTime);
  }

  void EndEcho(bool traced) {
    if (traced) {
      TRACE_EVENT_ASYNC_END0("echo_benchmark", "ping", echo_.get());
    }
  }

 private:
  void Run() {
    if (warmup_) {
      echo_->EchoString("ping", EchoResponse(this, false));
    } else {
      TRACE_EVENT_ASYNC_BEGIN0("echo_benchmark", "ping", echo_.get());
      echo_->EchoString("ping", EchoResponse(this, true));
    }
  }

  void EndWarmup() { warmup_ = false; }

  bool warmup_;
  EchoPtr echo_;
  mojo::TracingImpl tracing_;
};

void EchoResponse::Run(const String& value) const {
  echo_->EndEcho(traced_);
  echo_->BeginEcho();
}

}  // namespace examples
}  // namespace mojo

MojoResult MojoMain(MojoHandle application_request) {
  mojo::ApplicationRunnerChromium runner(
      new mojo::examples::EchoClientDelegate);
  return runner.Run(application_request);
}
