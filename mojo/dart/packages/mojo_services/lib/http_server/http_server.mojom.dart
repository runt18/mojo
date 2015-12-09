// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library http_server_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo_services/http_server/http_request.mojom.dart' as http_request_mojom;
import 'package:mojo_services/http_server/http_response.mojom.dart' as http_response_mojom;



class HttpServerSetHandlerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String pattern = null;
  Object handler = null;

  HttpServerSetHandlerParams() : super(kVersions.last.size);

  static HttpServerSetHandlerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static HttpServerSetHandlerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    HttpServerSetHandlerParams result = new HttpServerSetHandlerParams();

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
    return "HttpServerSetHandlerParams("
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


class HttpServerGetPortParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  HttpServerGetPortParams() : super(kVersions.last.size);

  static HttpServerGetPortParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static HttpServerGetPortParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    HttpServerGetPortParams result = new HttpServerGetPortParams();

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
    return "HttpServerGetPortParams("")";
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


class HttpHandlerHandleRequestParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  http_request_mojom.HttpRequest request = null;

  HttpHandlerHandleRequestParams() : super(kVersions.last.size);

  static HttpHandlerHandleRequestParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static HttpHandlerHandleRequestParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    HttpHandlerHandleRequestParams result = new HttpHandlerHandleRequestParams();

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
    return "HttpHandlerHandleRequestParams("
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

const int kHttpServer_setHandler_name = 0;
const int kHttpServer_getPort_name = 1;
const String HttpServerName = null;

abstract class HttpServer {
  dynamic setHandler(String pattern,Object handler,[Function responseFactory = null]);
  dynamic getPort([Function responseFactory = null]);

}


class HttpServerProxyImpl extends bindings.Proxy {
  HttpServerProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  HttpServerProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  HttpServerProxyImpl.unbound() : super.unbound();

  static HttpServerProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HttpServerProxyImpl"));
    return new HttpServerProxyImpl.fromEndpoint(endpoint);
  }

  String get name => HttpServerName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case kHttpServer_setHandler_name:
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
      case kHttpServer_getPort_name:
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
    return "HttpServerProxyImpl($superString)";
  }
}


class _HttpServerProxyCalls implements HttpServer {
  HttpServerProxyImpl _proxyImpl;

  _HttpServerProxyCalls(this._proxyImpl);
    dynamic setHandler(String pattern,Object handler,[Function responseFactory = null]) {
      var params = new HttpServerSetHandlerParams();
      params.pattern = pattern;
      params.handler = handler;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kHttpServer_setHandler_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic getPort([Function responseFactory = null]) {
      var params = new HttpServerGetPortParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kHttpServer_getPort_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class HttpServerProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  HttpServer ptr;
  final String name = HttpServerName;

  HttpServerProxy(HttpServerProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _HttpServerProxyCalls(proxyImpl);

  HttpServerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new HttpServerProxyImpl.fromEndpoint(endpoint) {
    ptr = new _HttpServerProxyCalls(impl);
  }

  HttpServerProxy.fromHandle(core.MojoHandle handle) :
      impl = new HttpServerProxyImpl.fromHandle(handle) {
    ptr = new _HttpServerProxyCalls(impl);
  }

  HttpServerProxy.unbound() :
      impl = new HttpServerProxyImpl.unbound() {
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

  static const String name = HttpServerName;


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
      case kHttpServer_setHandler_name:
        var params = HttpServerSetHandlerParams.deserialize(
            message.payload);
        var response = _impl.setHandler(params.pattern,params.handler,_HttpServerSetHandlerResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kHttpServer_setHandler_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kHttpServer_setHandler_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kHttpServer_getPort_name:
        var params = HttpServerGetPortParams.deserialize(
            message.payload);
        var response = _impl.getPort(_HttpServerGetPortResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kHttpServer_getPort_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kHttpServer_getPort_name,
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

const int kHttpHandler_handleRequest_name = 0;
const String HttpHandlerName = null;

abstract class HttpHandler {
  dynamic handleRequest(http_request_mojom.HttpRequest request,[Function responseFactory = null]);

}


class HttpHandlerProxyImpl extends bindings.Proxy {
  HttpHandlerProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  HttpHandlerProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  HttpHandlerProxyImpl.unbound() : super.unbound();

  static HttpHandlerProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HttpHandlerProxyImpl"));
    return new HttpHandlerProxyImpl.fromEndpoint(endpoint);
  }

  String get name => HttpHandlerName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case kHttpHandler_handleRequest_name:
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
    return "HttpHandlerProxyImpl($superString)";
  }
}


class _HttpHandlerProxyCalls implements HttpHandler {
  HttpHandlerProxyImpl _proxyImpl;

  _HttpHandlerProxyCalls(this._proxyImpl);
    dynamic handleRequest(http_request_mojom.HttpRequest request,[Function responseFactory = null]) {
      var params = new HttpHandlerHandleRequestParams();
      params.request = request;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kHttpHandler_handleRequest_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class HttpHandlerProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  HttpHandler ptr;
  final String name = HttpHandlerName;

  HttpHandlerProxy(HttpHandlerProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _HttpHandlerProxyCalls(proxyImpl);

  HttpHandlerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new HttpHandlerProxyImpl.fromEndpoint(endpoint) {
    ptr = new _HttpHandlerProxyCalls(impl);
  }

  HttpHandlerProxy.fromHandle(core.MojoHandle handle) :
      impl = new HttpHandlerProxyImpl.fromHandle(handle) {
    ptr = new _HttpHandlerProxyCalls(impl);
  }

  HttpHandlerProxy.unbound() :
      impl = new HttpHandlerProxyImpl.unbound() {
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

  static const String name = HttpHandlerName;


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
      case kHttpHandler_handleRequest_name:
        var params = HttpHandlerHandleRequestParams.deserialize(
            message.payload);
        var response = _impl.handleRequest(params.request,_HttpHandlerHandleRequestResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kHttpHandler_handleRequest_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kHttpHandler_handleRequest_name,
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


