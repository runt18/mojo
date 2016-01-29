// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library media_clock_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;

class ClockDisposition extends bindings.MojoEnum {
  static const ClockDisposition passive = const ClockDisposition._(0);
  static const ClockDisposition slave = const ClockDisposition._(1);
  static const ClockDisposition preferSlave = const ClockDisposition._(2);
  static const ClockDisposition indifferent = const ClockDisposition._(3);
  static const ClockDisposition preferMaster = const ClockDisposition._(4);
  static const ClockDisposition master = const ClockDisposition._(5);

  const ClockDisposition._(int v) : super(v);

  static const Map<String, ClockDisposition> valuesMap = const {
    "passive": passive,
    "slave": slave,
    "preferSlave": preferSlave,
    "indifferent": indifferent,
    "preferMaster": preferMaster,
    "master": master,
  };
  static const List<ClockDisposition> values = const [
    passive,
    slave,
    preferSlave,
    indifferent,
    preferMaster,
    master,
  ];

  static ClockDisposition valueOf(String name) => valuesMap[name];

  factory ClockDisposition(int v) {
    switch (v) {
      case 0:
        return passive;
      case 1:
        return slave;
      case 2:
        return preferSlave;
      case 3:
        return indifferent;
      case 4:
        return preferMaster;
      case 5:
        return master;
      default:
        return null;
    }
  }

  static ClockDisposition decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    ClockDisposition result = new ClockDisposition(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum ClockDisposition.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case passive:
        return 'ClockDisposition.passive';
      case slave:
        return 'ClockDisposition.slave';
      case preferSlave:
        return 'ClockDisposition.preferSlave';
      case indifferent:
        return 'ClockDisposition.indifferent';
      case preferMaster:
        return 'ClockDisposition.preferMaster';
      case master:
        return 'ClockDisposition.master';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}








class _ClockServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class Clock {
  static const String serviceName = null;
}


class _ClockProxyImpl extends bindings.Proxy {
  _ClockProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ClockProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _ClockProxyImpl.unbound() : super.unbound();

  static _ClockProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _ClockProxyImpl"));
    return new _ClockProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _ClockServiceDescription();

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
    return "_ClockProxyImpl($superString)";
  }
}


class _ClockProxyCalls implements Clock {
  _ClockProxyImpl _proxyImpl;

  _ClockProxyCalls(this._proxyImpl);
}


class ClockProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  Clock ptr;

  ClockProxy(_ClockProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ClockProxyCalls(proxyImpl);

  ClockProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _ClockProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ClockProxyCalls(impl);
  }

  ClockProxy.fromHandle(core.MojoHandle handle) :
      impl = new _ClockProxyImpl.fromHandle(handle) {
    ptr = new _ClockProxyCalls(impl);
  }

  ClockProxy.unbound() :
      impl = new _ClockProxyImpl.unbound() {
    ptr = new _ClockProxyCalls(impl);
  }

  factory ClockProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ClockProxy p = new ClockProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static ClockProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ClockProxy"));
    return new ClockProxy.fromEndpoint(endpoint);
  }

  String get serviceName => Clock.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "ClockProxy($impl)";
  }
}


class ClockStub extends bindings.Stub {
  Clock _impl = null;

  ClockStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  ClockStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  ClockStub.unbound() : super.unbound();

  static ClockStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ClockStub"));
    return new ClockStub.fromEndpoint(endpoint);
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

  Clock get impl => _impl;
  set impl(Clock d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "ClockStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _ClockServiceDescription();
}



