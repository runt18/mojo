#!mojo mojo:dart_content_handler
// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:common/tracing_helper.dart';
import 'package:mojo/application.dart';
import 'package:mojo/core.dart';

class StartupBenchmarkApp extends Application {
  TracingHelper _tracing;
  Timer _timer;

  StartupBenchmarkApp.fromHandle(MojoHandle handle) : super.fromHandle(handle);

  void initialize(List<String> args, String url) {
    // This sets up a connection between this application and the Mojo
    // tracing service.
    _tracing = new TracingHelper.fromApplication(
        this, "example_traced_application", TraceSendTiming.AT_END);
    _tracing.traceInstant("initialized", "traced_application");
  }

  @override
  void acceptConnection(String requestorUrl, String resolvedUrl,
      ApplicationConnection connection) {
    _tracing.traceInstant("connected", "traced_application");
  }
}

main(List args) {
  MojoHandle appHandle = new MojoHandle(args[0]);
  new StartupBenchmarkApp.fromHandle(appHandle);
}
