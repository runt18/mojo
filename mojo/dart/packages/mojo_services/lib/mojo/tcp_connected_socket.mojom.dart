// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library tcp_connected_socket_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;






class _TcpConnectedSocketServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class TcpConnectedSocket {
  static const String serviceName = null;
}


class _TcpConnectedSocketProxyImpl extends bindings.Proxy {
  _TcpConnectedSocketProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _TcpConnectedSocketProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _TcpConnectedSocketProxyImpl.unbound() : super.unbound();

  static _TcpConnectedSocketProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _TcpConnectedSocketProxyImpl"));
    return new _TcpConnectedSocketProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _TcpConnectedSocketServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  String toString() {
    var superString = super.toString();
    return "_TcpConnectedSocketProxyImpl($superString)";
  }
}


class _TcpConnectedSocketProxyCalls implements TcpConnectedSocket {
  _TcpConnectedSocketProxyImpl _proxyImpl;

  _TcpConnectedSocketProxyCalls(this._proxyImpl);
}


class TcpConnectedSocketProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  TcpConnectedSocket ptr;

  TcpConnectedSocketProxy(_TcpConnectedSocketProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _TcpConnectedSocketProxyCalls(proxyImpl);

  TcpConnectedSocketProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _TcpConnectedSocketProxyImpl.fromEndpoint(endpoint) {
    ptr = new _TcpConnectedSocketProxyCalls(impl);
  }

  TcpConnectedSocketProxy.fromHandle(core.MojoHandle handle) :
      impl = new _TcpConnectedSocketProxyImpl.fromHandle(handle) {
    ptr = new _TcpConnectedSocketProxyCalls(impl);
  }

  TcpConnectedSocketProxy.unbound() :
      impl = new _TcpConnectedSocketProxyImpl.unbound() {
    ptr = new _TcpConnectedSocketProxyCalls(impl);
  }

  factory TcpConnectedSocketProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    TcpConnectedSocketProxy p = new TcpConnectedSocketProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static TcpConnectedSocketProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TcpConnectedSocketProxy"));
    return new TcpConnectedSocketProxy.fromEndpoint(endpoint);
  }

  String get serviceName => TcpConnectedSocket.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "TcpConnectedSocketProxy($impl)";
  }
}


class TcpConnectedSocketStub extends bindings.Stub {
  TcpConnectedSocket _impl = null;

  TcpConnectedSocketStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  TcpConnectedSocketStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  TcpConnectedSocketStub.unbound() : super.unbound();

  static TcpConnectedSocketStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TcpConnectedSocketStub"));
    return new TcpConnectedSocketStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  TcpConnectedSocket get impl => _impl;
  set impl(TcpConnectedSocket d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "TcpConnectedSocketStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _TcpConnectedSocketServiceDescription();
}



