// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:mojo/application.dart';
import 'package:mojo/core.dart';
import 'package:_mojo_for_test_only/mojo/examples/echo.mojom.dart';

class EchoClientApplication extends Application {
  final _echoProxy = new EchoProxy.unbound();

  EchoClientApplication.fromHandle(MojoHandle handle)
      : super.fromHandle(handle) {
    onError = ((_) {
      _closeHandles();
    });
  }

  @override
  void initialize(List<String> arguments, String url) {
    // See README.md for how to specify an alternate server on the command line.
    final server = (arguments.length > 0) ? arguments[1] : "dart_echo_server";
    connectToService(url.replaceAll("dart_echo_client", server), _echoProxy);

    _echoProxy.ptr.echoString("hello world").then((response) {
      print("${response.value}");
    }).whenComplete(_closeHandles);
  }

  Future _closeHandles() async {
    await _echoProxy.close();
    await close();
    MojoHandle.reportLeakedHandles();
  }
}

main(List args) {
  MojoHandle appHandle = new MojoHandle(args[0]);
  new EchoClientApplication.fromHandle(appHandle);
}
