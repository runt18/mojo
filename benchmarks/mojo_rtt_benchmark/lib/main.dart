// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// This Mojo app is a benchmark of Mojo/Dart IPC Round Trip Times.
// It creates many proxies from a single isolate, and makes requests using those
// proxies round-robin.
// To run it, and the other RTT benchmarks:
//
// $ ./mojo/devtools/common/mojo_benchmark [--release] mojo/tools/data/rtt_benchmarks

import 'dart:async';

import 'package:args/args.dart' as args;
import 'package:common/tracing_helper.dart';
import 'package:mojo/application.dart';
import 'package:mojo/core.dart';
import 'package:_mojo_for_test_only/mojo/examples/echo.mojom.dart';

class EchoTracingApp extends Application {
  static const Duration kWarmupDuration = const Duration(seconds: 1);
  static const Duration kDelay = const Duration(microseconds: 50);
  TracingHelper _tracing;
  List<EchoProxy> _echoProxies;
  bool _doEcho;
  bool _warmup;
  int _numClients;
  int _numActiveClients;

  EchoTracingApp.fromHandle(MojoHandle handle) : super.fromHandle(handle) {
    onError = _errorHandler;
    _echoProxies = [];
  }

  void initialize(List<String> arguments, String url) {
    // Initialize tracing.
    _tracing = new TracingHelper.fromApplication(this, "mojo_rtt_benchmark");
    _tracing.traceInstant("initialized", "traced_application");

    var parser = new args.ArgParser(allowTrailingOptions: true);
    parser.addFlag('cpp-server', defaultsTo: false, negatable: false);
    parser.addOption('num-clients', defaultsTo: "1");
    parser.addOption('num-active-clients', defaultsTo: "1");
    var argResults = parser.parse(arguments);

    String echoUrl = "mojo:dart_echo_server";
    if (argResults["cpp-server"]) {
      echoUrl = "mojo:echo_server";
    }
    _numClients = int.parse(argResults["num-clients"]);
    _numActiveClients = int.parse(argResults["num-active-clients"]);

    // Setup the connection to the echo app.
    for (int i = 0; i < _numClients; i++) {
      var newProxy = new EchoProxy.unbound();
      newProxy.errorFuture.then((e) {
        _errorHandler(e);
      });
      connectToService(echoUrl, newProxy);
      _echoProxies.add(newProxy);
    }

    // Start echoing.
    _doEcho = true;
    Timer.run(() => _run(0));

    // Begin tracing echo rtts after waiting for kWarmupDuration.
    _warmup = true;
    new Timer(kWarmupDuration, () => _warmup = false);
  }

  _run(int idx) {
    if (idx == _numActiveClients) {
      idx = 0;
    }
    if (_doEcho) {
      if (_warmup) {
        _echo(idx, "ping").then((r) {
          new Timer(kDelay, () => _run(idx + 1));
        });
      } else {
        _tracedEcho(idx, "ping").then((r) {
          new Timer(kDelay, () => _run(idx + 1));
        });
      }
    }
  }

  Future _tracedEcho(int idx, String s) {
    int start = getTimeTicksNow();
    return _echo(idx, s).then((r) {
      int end = getTimeTicksNow();
      _tracing.traceDuration("ping", "mojo_rtt_benchmark", start, end);
      return r;
    });
  }

  Future _echo(int idx, String s) {
    return _echoProxies[idx].ptr.echoString(s);
  }

  _errorHandler(Object e) {
    _doEcho = false;
    return Future.wait(_echoProxies.map((p) => p.close())).then((_) {
      MojoHandle.reportLeakedHandles();
    });
  }
}

main(List args) {
  MojoHandle appHandle = new MojoHandle(args[0]);
  new EchoTracingApp.fromHandle(appHandle);
}
