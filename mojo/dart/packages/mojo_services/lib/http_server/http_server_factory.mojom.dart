// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library http_server_factory_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/http_server/http_server.mojom.dart' as http_server_mojom;
import 'package:mojo_services/mojo/net_address.mojom.dart' as net_address_mojom;



class _HttpServerFactoryCreateHttpServerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  Object serverRequest = null;
  net_address_mojom.NetAddress localAddress = null;

  _HttpServerFactoryCreateHttpServerParams() : super(kVersions.last.size);

  static _HttpServerFactoryCreateHttpServerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _HttpServerFactoryCreateHttpServerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _HttpServerFactoryCreateHttpServerParams result = new _HttpServerFactoryCreateHttpServerParams();

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
      
      result.serverRequest = decoder0.decodeInterfaceRequest(8, false, http_server_mojom.HttpServerStub.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.localAddress = net_address_mojom.NetAddress.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(serverRequest, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "serverRequest of struct _HttpServerFactoryCreateHttpServerParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(localAddress, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "localAddress of struct _HttpServerFactoryCreateHttpServerParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_HttpServerFactoryCreateHttpServerParams("
           "serverRequest: $serverRequest" ", "
           "localAddress: $localAddress" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




const int _HttpServerFactory_createHttpServerName = 0;



class _HttpServerFactoryServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class HttpServerFactory {
  static const String serviceName = "http_server::HttpServerFactory";
  void createHttpServer(Object serverRequest, net_address_mojom.NetAddress localAddress);
}


class _HttpServerFactoryProxyImpl extends bindings.Proxy {
  _HttpServerFactoryProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _HttpServerFactoryProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _HttpServerFactoryProxyImpl.unbound() : super.unbound();

  static _HttpServerFactoryProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _HttpServerFactoryProxyImpl"));
    return new _HttpServerFactoryProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _HttpServerFactoryServiceDescription();

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
    return "_HttpServerFactoryProxyImpl($superString)";
  }
}


class _HttpServerFactoryProxyCalls implements HttpServerFactory {
  _HttpServerFactoryProxyImpl _proxyImpl;

  _HttpServerFactoryProxyCalls(this._proxyImpl);
    void createHttpServer(Object serverRequest, net_address_mojom.NetAddress localAddress) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _HttpServerFactoryCreateHttpServerParams();
      params.serverRequest = serverRequest;
      params.localAddress = localAddress;
      _proxyImpl.sendMessage(params, _HttpServerFactory_createHttpServerName);
    }
}


class HttpServerFactoryProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  HttpServerFactory ptr;

  HttpServerFactoryProxy(_HttpServerFactoryProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _HttpServerFactoryProxyCalls(proxyImpl);

  HttpServerFactoryProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _HttpServerFactoryProxyImpl.fromEndpoint(endpoint) {
    ptr = new _HttpServerFactoryProxyCalls(impl);
  }

  HttpServerFactoryProxy.fromHandle(core.MojoHandle handle) :
      impl = new _HttpServerFactoryProxyImpl.fromHandle(handle) {
    ptr = new _HttpServerFactoryProxyCalls(impl);
  }

  HttpServerFactoryProxy.unbound() :
      impl = new _HttpServerFactoryProxyImpl.unbound() {
    ptr = new _HttpServerFactoryProxyCalls(impl);
  }

  factory HttpServerFactoryProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    HttpServerFactoryProxy p = new HttpServerFactoryProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static HttpServerFactoryProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HttpServerFactoryProxy"));
    return new HttpServerFactoryProxy.fromEndpoint(endpoint);
  }

  String get serviceName => HttpServerFactory.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "HttpServerFactoryProxy($impl)";
  }
}


class HttpServerFactoryStub extends bindings.Stub {
  HttpServerFactory _impl = null;

  HttpServerFactoryStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  HttpServerFactoryStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  HttpServerFactoryStub.unbound() : super.unbound();

  static HttpServerFactoryStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HttpServerFactoryStub"));
    return new HttpServerFactoryStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _HttpServerFactory_createHttpServerName:
        var params = _HttpServerFactoryCreateHttpServerParams.deserialize(
            message.payload);
        _impl.createHttpServer(params.serverRequest, params.localAddress);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  HttpServerFactory get impl => _impl;
  set impl(HttpServerFactory d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "HttpServerFactoryStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _HttpServerFactoryServiceDescription();
}



