// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// This Mojo app is a benchmark of Mojo/Dart IPC Round Trip Times.
// To run it, and the other RTT benchmarks:
//
// $ ./mojo/devtools/common/mojo_benchmark [--release] mojo/tools/data/rtt_benchmarks

import 'dart:async';

import 'package:common/tracing_helper.dart';
import 'package:mojo/application.dart';
import 'package:mojo/bindings.dart';
import 'package:mojo/core.dart';
import 'package:mojom/mojo/examples/echo.mojom.dart';

class EchoTracingApp extends Application {
  static const Duration _WARMUP_DURATION = const Duration(seconds: 1);
  static const Duration _DELAY = const Duration(microseconds: 50);
  TracingHelper _tracing;
  EchoProxy _echoProxy;
  bool _doEcho;
  bool _warmup;

  EchoTracingApp.fromHandle(MojoHandle handle) : super.fromHandle(handle) {
    onError = _errorHandler;
  }

  void initialize(List<String> args, String url) {
    // Initialize tracing.
    _tracing = new TracingHelper.fromApplication(this, "mojo_rtt_benchmark");
    _tracing.traceInstant("initialized", "traced_application");

    String echoUrl = "mojo:dart_echo_server";
    if (args.contains("--cpp-server")) {
      echoUrl = "mojo:echo_server";
    }

    // Setup the connection to the echo app.
    _echoProxy = new EchoProxy.unbound();
    connectToService(echoUrl, _echoProxy);

    // Start echoing.
    _doEcho = true;
    Timer.run(_run);

    // Begin tracing echo rtts after waiting for _WARMUP_DURATION.
    _warmup = true;
    new Timer(_WARMUP_DURATION, () => _warmup = false);
  }

  _run() {
    if (_doEcho) {
      if (_warmup) {
        _echo("ping").then((_) => new Timer(_DELAY, _run));
      } else {
        _tracedEcho().then((_) => new Timer(_DELAY, _run));
      }
    }
  }

  Future _tracedEcho() {
    int start = getTimeTicksNow();
    return _echo("ping").then((_) {
      int end = getTimeTicksNow();
      _tracing.traceDuration("ping", "mojo_rtt_benchmark", start, end);
    });
  }

  Future _echo(String s) {
    return _echoProxy.ptr.echoString(s).catchError((_) => _errorHandler());
  }

  _errorHandler() {
    _doEcho = false;
    return _echoProxy.close().then((_) {
      assert(MojoHandle.reportLeakedHandles());
    });
  }
}

main(List args) {
  MojoHandle appHandle = new MojoHandle(args[0]);
  new EchoTracingApp.fromHandle(appHandle);
}
