// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library http_server_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/http_connection.mojom.dart' as http_connection_mojom;



class _HttpServerDelegateOnConnectedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  Object connection = null;
  Object delegate = null;

  _HttpServerDelegateOnConnectedParams() : super(kVersions.last.size);

  static _HttpServerDelegateOnConnectedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _HttpServerDelegateOnConnectedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _HttpServerDelegateOnConnectedParams result = new _HttpServerDelegateOnConnectedParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      result.connection = decoder0.decodeServiceInterface(8, false, http_connection_mojom.HttpConnectionProxy.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.delegate = decoder0.decodeInterfaceRequest(16, false, http_connection_mojom.HttpConnectionDelegateStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInterface(connection, 8, false);
    
    encoder0.encodeInterfaceRequest(delegate, 16, false);
  }

  String toString() {
    return "_HttpServerDelegateOnConnectedParams("
           "connection: $connection" ", "
           "delegate: $delegate" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




const int _HttpServerDelegate_onConnectedName = 0;



class _HttpServerDelegateServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class HttpServerDelegate {
  static const String serviceName = null;
  void onConnected(Object connection, Object delegate);
}


class _HttpServerDelegateProxyImpl extends bindings.Proxy {
  _HttpServerDelegateProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _HttpServerDelegateProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _HttpServerDelegateProxyImpl.unbound() : super.unbound();

  static _HttpServerDelegateProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _HttpServerDelegateProxyImpl"));
    return new _HttpServerDelegateProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _HttpServerDelegateServiceDescription();

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
    return "_HttpServerDelegateProxyImpl($superString)";
  }
}


class _HttpServerDelegateProxyCalls implements HttpServerDelegate {
  _HttpServerDelegateProxyImpl _proxyImpl;

  _HttpServerDelegateProxyCalls(this._proxyImpl);
    void onConnected(Object connection, Object delegate) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _HttpServerDelegateOnConnectedParams();
      params.connection = connection;
      params.delegate = delegate;
      _proxyImpl.sendMessage(params, _HttpServerDelegate_onConnectedName);
    }
}


class HttpServerDelegateProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  HttpServerDelegate ptr;

  HttpServerDelegateProxy(_HttpServerDelegateProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _HttpServerDelegateProxyCalls(proxyImpl);

  HttpServerDelegateProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _HttpServerDelegateProxyImpl.fromEndpoint(endpoint) {
    ptr = new _HttpServerDelegateProxyCalls(impl);
  }

  HttpServerDelegateProxy.fromHandle(core.MojoHandle handle) :
      impl = new _HttpServerDelegateProxyImpl.fromHandle(handle) {
    ptr = new _HttpServerDelegateProxyCalls(impl);
  }

  HttpServerDelegateProxy.unbound() :
      impl = new _HttpServerDelegateProxyImpl.unbound() {
    ptr = new _HttpServerDelegateProxyCalls(impl);
  }

  factory HttpServerDelegateProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    HttpServerDelegateProxy p = new HttpServerDelegateProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static HttpServerDelegateProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HttpServerDelegateProxy"));
    return new HttpServerDelegateProxy.fromEndpoint(endpoint);
  }

  String get serviceName => HttpServerDelegate.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "HttpServerDelegateProxy($impl)";
  }
}


class HttpServerDelegateStub extends bindings.Stub {
  HttpServerDelegate _impl = null;

  HttpServerDelegateStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  HttpServerDelegateStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  HttpServerDelegateStub.unbound() : super.unbound();

  static HttpServerDelegateStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HttpServerDelegateStub"));
    return new HttpServerDelegateStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _HttpServerDelegate_onConnectedName:
        var params = _HttpServerDelegateOnConnectedParams.deserialize(
            message.payload);
        _impl.onConnected(params.connection, params.delegate);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  HttpServerDelegate get impl => _impl;
  set impl(HttpServerDelegate d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "HttpServerDelegateStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _HttpServerDelegateServiceDescription();
}



