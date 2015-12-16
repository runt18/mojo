// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library http_server_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo_services/http_server/http_request.mojom.dart' as http_request_mojom;
import 'package:mojo_services/http_server/http_response.mojom.dart' as http_response_mojom;



class _HttpServerSetHandlerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String pattern = null;
  Object handler = null;

  _HttpServerSetHandlerParams() : super(kVersions.last.size);

  static _HttpServerSetHandlerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _HttpServerSetHandlerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _HttpServerSetHandlerParams result = new _HttpServerSetHandlerParams();

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
      
      result.pattern = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.handler = decoder0.decodeServiceInterface(16, false, HttpHandlerProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeString(pattern, 8, false);
    
    encoder0.encodeInterface(handler, 16, false);
  }

  String toString() {
    return "_HttpServerSetHandlerParams("
           "pattern: $pattern" ", "
           "handler: $handler" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class HttpServerSetHandlerResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool success = false;

  HttpServerSetHandlerResponseParams() : super(kVersions.last.size);

  static HttpServerSetHandlerResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static HttpServerSetHandlerResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    HttpServerSetHandlerResponseParams result = new HttpServerSetHandlerResponseParams();

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
      
      result.success = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeBool(success, 8, 0);
  }

  String toString() {
    return "HttpServerSetHandlerResponseParams("
           "success: $success" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["success"] = success;
    return map;
  }
}


class _HttpServerGetPortParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _HttpServerGetPortParams() : super(kVersions.last.size);

  static _HttpServerGetPortParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _HttpServerGetPortParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _HttpServerGetPortParams result = new _HttpServerGetPortParams();

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
    return result;
  }

  void encode(bindings.Encoder encoder) {
    encoder.getStructEncoderAtOffset(kVersions.last);
  }

  String toString() {
    return "_HttpServerGetPortParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class HttpServerGetPortResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int port = 0;

  HttpServerGetPortResponseParams() : super(kVersions.last.size);

  static HttpServerGetPortResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static HttpServerGetPortResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    HttpServerGetPortResponseParams result = new HttpServerGetPortResponseParams();

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
      
      result.port = decoder0.decodeUint16(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint16(port, 8);
  }

  String toString() {
    return "HttpServerGetPortResponseParams("
           "port: $port" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["port"] = port;
    return map;
  }
}


class _HttpHandlerHandleRequestParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  http_request_mojom.HttpRequest request = null;

  _HttpHandlerHandleRequestParams() : super(kVersions.last.size);

  static _HttpHandlerHandleRequestParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _HttpHandlerHandleRequestParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _HttpHandlerHandleRequestParams result = new _HttpHandlerHandleRequestParams();

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
      
      var decoder1 = decoder0.decodePointer(8, false);
      result.request = http_request_mojom.HttpRequest.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(request, 8, false);
  }

  String toString() {
    return "_HttpHandlerHandleRequestParams("
           "request: $request" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class HttpHandlerHandleRequestResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  http_response_mojom.HttpResponse response = null;

  HttpHandlerHandleRequestResponseParams() : super(kVersions.last.size);

  static HttpHandlerHandleRequestResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static HttpHandlerHandleRequestResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    HttpHandlerHandleRequestResponseParams result = new HttpHandlerHandleRequestResponseParams();

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
      
      var decoder1 = decoder0.decodePointer(8, false);
      result.response = http_response_mojom.HttpResponse.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(response, 8, false);
  }

  String toString() {
    return "HttpHandlerHandleRequestResponseParams("
           "response: $response" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int _HttpServer_setHandlerName = 0;
const int _HttpServer_getPortName = 1;

abstract class HttpServer {
  static const String serviceName = null;
  dynamic setHandler(String pattern,Object handler,[Function responseFactory = null]);
  dynamic getPort([Function responseFactory = null]);
}


class _HttpServerProxyImpl extends bindings.Proxy {
  _HttpServerProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _HttpServerProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _HttpServerProxyImpl.unbound() : super.unbound();

  static _HttpServerProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _HttpServerProxyImpl"));
    return new _HttpServerProxyImpl.fromEndpoint(endpoint);
  }

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _HttpServer_setHandlerName:
        var r = HttpServerSetHandlerResponseParams.deserialize(
            message.payload);
        if (!message.header.hasRequestId) {
          proxyError("Expected a message with a valid request Id.");
          return;
        }
        Completer c = completerMap[message.header.requestId];
        if (c == null) {
          proxyError(
              "Message had unknown request Id: ${message.header.requestId}");
          return;
        }
        completerMap.remove(message.header.requestId);
        if (c.isCompleted) {
          proxyError("Response completer already completed");
          return;
        }
        c.complete(r);
        break;
      case _HttpServer_getPortName:
        var r = HttpServerGetPortResponseParams.deserialize(
            message.payload);
        if (!message.header.hasRequestId) {
          proxyError("Expected a message with a valid request Id.");
          return;
        }
        Completer c = completerMap[message.header.requestId];
        if (c == null) {
          proxyError(
              "Message had unknown request Id: ${message.header.requestId}");
          return;
        }
        completerMap.remove(message.header.requestId);
        if (c.isCompleted) {
          proxyError("Response completer already completed");
          return;
        }
        c.complete(r);
        break;
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  String toString() {
    var superString = super.toString();
    return "_HttpServerProxyImpl($superString)";
  }
}


class _HttpServerProxyCalls implements HttpServer {
  _HttpServerProxyImpl _proxyImpl;

  _HttpServerProxyCalls(this._proxyImpl);
    dynamic setHandler(String pattern,Object handler,[Function responseFactory = null]) {
      var params = new _HttpServerSetHandlerParams();
      params.pattern = pattern;
      params.handler = handler;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _HttpServer_setHandlerName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic getPort([Function responseFactory = null]) {
      var params = new _HttpServerGetPortParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _HttpServer_getPortName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class HttpServerProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  HttpServer ptr;

  HttpServerProxy(_HttpServerProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _HttpServerProxyCalls(proxyImpl);

  HttpServerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _HttpServerProxyImpl.fromEndpoint(endpoint) {
    ptr = new _HttpServerProxyCalls(impl);
  }

  HttpServerProxy.fromHandle(core.MojoHandle handle) :
      impl = new _HttpServerProxyImpl.fromHandle(handle) {
    ptr = new _HttpServerProxyCalls(impl);
  }

  HttpServerProxy.unbound() :
      impl = new _HttpServerProxyImpl.unbound() {
    ptr = new _HttpServerProxyCalls(impl);
  }

  factory HttpServerProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    HttpServerProxy p = new HttpServerProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static HttpServerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HttpServerProxy"));
    return new HttpServerProxy.fromEndpoint(endpoint);
  }

  String get serviceName => HttpServer.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "HttpServerProxy($impl)";
  }
}


class HttpServerStub extends bindings.Stub {
  HttpServer _impl = null;

  HttpServerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  HttpServerStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  HttpServerStub.unbound() : super.unbound();

  static HttpServerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HttpServerStub"));
    return new HttpServerStub.fromEndpoint(endpoint);
  }


  HttpServerSetHandlerResponseParams _HttpServerSetHandlerResponseParamsFactory(bool success) {
    var mojo_factory_result = new HttpServerSetHandlerResponseParams();
    mojo_factory_result.success = success;
    return mojo_factory_result;
  }
  HttpServerGetPortResponseParams _HttpServerGetPortResponseParamsFactory(int port) {
    var mojo_factory_result = new HttpServerGetPortResponseParams();
    mojo_factory_result.port = port;
    return mojo_factory_result;
  }

  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _HttpServer_setHandlerName:
        var params = _HttpServerSetHandlerParams.deserialize(
            message.payload);
        var response = _impl.setHandler(params.pattern,params.handler,_HttpServerSetHandlerResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _HttpServer_setHandlerName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _HttpServer_setHandlerName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _HttpServer_getPortName:
        var params = _HttpServerGetPortParams.deserialize(
            message.payload);
        var response = _impl.getPort(_HttpServerGetPortResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _HttpServer_getPortName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _HttpServer_getPortName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  HttpServer get impl => _impl;
  set impl(HttpServer d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "HttpServerStub($superString)";
  }

  int get version => 0;
}

const int _HttpHandler_handleRequestName = 0;

abstract class HttpHandler {
  static const String serviceName = null;
  dynamic handleRequest(http_request_mojom.HttpRequest request,[Function responseFactory = null]);
}


class _HttpHandlerProxyImpl extends bindings.Proxy {
  _HttpHandlerProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _HttpHandlerProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _HttpHandlerProxyImpl.unbound() : super.unbound();

  static _HttpHandlerProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _HttpHandlerProxyImpl"));
    return new _HttpHandlerProxyImpl.fromEndpoint(endpoint);
  }

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _HttpHandler_handleRequestName:
        var r = HttpHandlerHandleRequestResponseParams.deserialize(
            message.payload);
        if (!message.header.hasRequestId) {
          proxyError("Expected a message with a valid request Id.");
          return;
        }
        Completer c = completerMap[message.header.requestId];
        if (c == null) {
          proxyError(
              "Message had unknown request Id: ${message.header.requestId}");
          return;
        }
        completerMap.remove(message.header.requestId);
        if (c.isCompleted) {
          proxyError("Response completer already completed");
          return;
        }
        c.complete(r);
        break;
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  String toString() {
    var superString = super.toString();
    return "_HttpHandlerProxyImpl($superString)";
  }
}


class _HttpHandlerProxyCalls implements HttpHandler {
  _HttpHandlerProxyImpl _proxyImpl;

  _HttpHandlerProxyCalls(this._proxyImpl);
    dynamic handleRequest(http_request_mojom.HttpRequest request,[Function responseFactory = null]) {
      var params = new _HttpHandlerHandleRequestParams();
      params.request = request;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _HttpHandler_handleRequestName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class HttpHandlerProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  HttpHandler ptr;

  HttpHandlerProxy(_HttpHandlerProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _HttpHandlerProxyCalls(proxyImpl);

  HttpHandlerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _HttpHandlerProxyImpl.fromEndpoint(endpoint) {
    ptr = new _HttpHandlerProxyCalls(impl);
  }

  HttpHandlerProxy.fromHandle(core.MojoHandle handle) :
      impl = new _HttpHandlerProxyImpl.fromHandle(handle) {
    ptr = new _HttpHandlerProxyCalls(impl);
  }

  HttpHandlerProxy.unbound() :
      impl = new _HttpHandlerProxyImpl.unbound() {
    ptr = new _HttpHandlerProxyCalls(impl);
  }

  factory HttpHandlerProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    HttpHandlerProxy p = new HttpHandlerProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static HttpHandlerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HttpHandlerProxy"));
    return new HttpHandlerProxy.fromEndpoint(endpoint);
  }

  String get serviceName => HttpHandler.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "HttpHandlerProxy($impl)";
  }
}


class HttpHandlerStub extends bindings.Stub {
  HttpHandler _impl = null;

  HttpHandlerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  HttpHandlerStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  HttpHandlerStub.unbound() : super.unbound();

  static HttpHandlerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HttpHandlerStub"));
    return new HttpHandlerStub.fromEndpoint(endpoint);
  }


  HttpHandlerHandleRequestResponseParams _HttpHandlerHandleRequestResponseParamsFactory(http_response_mojom.HttpResponse response) {
    var mojo_factory_result = new HttpHandlerHandleRequestResponseParams();
    mojo_factory_result.response = response;
    return mojo_factory_result;
  }

  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _HttpHandler_handleRequestName:
        var params = _HttpHandlerHandleRequestParams.deserialize(
            message.payload);
        var response = _impl.handleRequest(params.request,_HttpHandlerHandleRequestResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _HttpHandler_handleRequestName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _HttpHandler_handleRequestName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  HttpHandler get impl => _impl;
  set impl(HttpHandler d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "HttpHandlerStub($superString)";
  }

  int get version => 0;
}


