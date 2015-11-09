// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:mojo/application.dart';
import 'package:mojo/bindings.dart';
import 'package:mojo/core.dart';
import 'package:mojom/mojo/examples/echo.mojom.dart';

class EchoImpl implements Echo {
  EchoStub _stub;
  EchoApplication _application;

  EchoImpl(this._application, MojoMessagePipeEndpoint endpoint) {
    _stub = new EchoStub.fromEndpoint(endpoint, this);
    _stub.onError = _errorHandler;
  }

  echoString(String value, [Function responseFactory]) =>
      responseFactory(value);

  Future close() => _stub.close();

  _errorHandler() => _application.removeService(this);
}

class EchoApplication extends Application {
  List<EchoImpl> _echoServices;
  bool _closing;

  EchoApplication.fromHandle(MojoHandle handle)
      : _closing = false,
        _echoServices = [],
        super.fromHandle(handle) {
    onError = _errorHandler;
  }

  @override
  void acceptConnection(String requestorUrl, String resolvedUrl,
      ApplicationConnection connection) {
    connection.provideService(EchoName, _createService);
  }

  void removeService(EchoImpl service) {
    if (!_closing) {
      _echoServices.remove(service);
    }
  }

  EchoImpl _createService(MojoMessagePipeEndpoint endpoint) {
    if (_closing) {
      endpoint.close();
      return null;
    }
    var echoService = new EchoImpl(this, endpoint);
    _echoServices.add(echoService);
    return echoService;
  }

  _errorHandler() async {
    _closing = true;
    for (var service in _echoServices) {
      await service.close();
    }
    MojoHandle.reportLeakedHandles();
  }
}

main(List args) {
  MojoHandle appHandle = new MojoHandle(args[0]);
  String url = args[1];
  new EchoApplication.fromHandle(appHandle);
}
