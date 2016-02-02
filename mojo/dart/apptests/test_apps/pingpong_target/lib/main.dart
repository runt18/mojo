// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:mojo/application.dart';
import 'package:mojo/bindings.dart';
import 'package:mojo/core.dart';

import 'package:_mojo_for_test_only/test/pingpong_service.mojom.dart';

class PingPongServiceImpl implements PingPongService {
  PingPongServiceStub _stub;
  Application _application;
  PingPongClientProxy _pingPongClient;

  PingPongServiceImpl(this._application, MojoMessagePipeEndpoint endpoint) {
    _stub = new PingPongServiceStub.fromEndpoint(endpoint, this);
  }

  void setClient(ProxyBase proxyBase) {
    assert(_pingPongClient == null);
    _pingPongClient = proxyBase;
  }

  void ping(int pingValue) => _pingPongClient.ptr.pong(pingValue + 1);

  // These methods are unimplemented; they merely throw on invocation.
  dynamic pingTargetUrl(String url, int count, [Function responseFactory]) =>
      throw "Unimplemented";
  dynamic pingTargetService(
      Object service, int count, [Function responseFactory]) =>
      throw "Unimplemented";
  void getPingPongService(Object service) => throw "Unimplemented";

  void quit() {
    if (_pingPongClient != null) {
      _pingPongClient.close();
      _pingPongClient = null;
    }
    _stub.close();
  }
}

class PingPongApplication extends Application {
  PingPongApplication.fromHandle(MojoHandle handle) : super.fromHandle(handle);

  @override
  void acceptConnection(String requestorUrl, String resolvedUrl,
      ApplicationConnection connection) {
    // Provide the service implemented by PingPongServiceImpl.
    connection.provideService(PingPongService.serviceName,
        (endpoint) => new PingPongServiceImpl(this, endpoint));

    // No services are required from the remote end.
    connection.remoteServiceProvider.close();

    // Close the application when the first connection goes down.
    connection.onError = ((_) {
      connection.close().then((_) {
        closeApplication();
      });
    });
  }

  Future closeApplication() async {
    await close();
    MojoHandle.reportLeakedHandles();
  }
}

main(List args) {
  MojoHandle appHandle = new MojoHandle(args[0]);
  String url = args[1];
  new PingPongApplication.fromHandle(appHandle);
}
