// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library http_connection_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/network_error.mojom.dart' as network_error_mojom;
import 'package:mojo_services/mojo/http_message.mojom.dart' as http_message_mojom;
import 'package:mojo_services/mojo/web_socket.mojom.dart' as web_socket_mojom;



class _HttpConnectionSetSendBufferSizeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int size = 0;

  _HttpConnectionSetSendBufferSizeParams() : super(kVersions.last.size);

  static _HttpConnectionSetSendBufferSizeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _HttpConnectionSetSendBufferSizeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _HttpConnectionSetSendBufferSizeParams result = new _HttpConnectionSetSendBufferSizeParams();

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
      
      result.size = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(size, 8);
  }

  String toString() {
    return "_HttpConnectionSetSendBufferSizeParams("
           "size: $size" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["size"] = size;
    return map;
  }
}


class HttpConnectionSetSendBufferSizeResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  network_error_mojom.NetworkError result = null;

  HttpConnectionSetSendBufferSizeResponseParams() : super(kVersions.last.size);

  static HttpConnectionSetSendBufferSizeResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static HttpConnectionSetSendBufferSizeResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    HttpConnectionSetSendBufferSizeResponseParams result = new HttpConnectionSetSendBufferSizeResponseParams();

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
      result.result = network_error_mojom.NetworkError.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(result, 8, false);
  }

  String toString() {
    return "HttpConnectionSetSendBufferSizeResponseParams("
           "result: $result" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["result"] = result;
    return map;
  }
}


class _HttpConnectionSetReceiveBufferSizeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int size = 0;

  _HttpConnectionSetReceiveBufferSizeParams() : super(kVersions.last.size);

  static _HttpConnectionSetReceiveBufferSizeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _HttpConnectionSetReceiveBufferSizeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _HttpConnectionSetReceiveBufferSizeParams result = new _HttpConnectionSetReceiveBufferSizeParams();

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
      
      result.size = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(size, 8);
  }

  String toString() {
    return "_HttpConnectionSetReceiveBufferSizeParams("
           "size: $size" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["size"] = size;
    return map;
  }
}


class HttpConnectionSetReceiveBufferSizeResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  network_error_mojom.NetworkError result = null;

  HttpConnectionSetReceiveBufferSizeResponseParams() : super(kVersions.last.size);

  static HttpConnectionSetReceiveBufferSizeResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static HttpConnectionSetReceiveBufferSizeResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    HttpConnectionSetReceiveBufferSizeResponseParams result = new HttpConnectionSetReceiveBufferSizeResponseParams();

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
      result.result = network_error_mojom.NetworkError.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(result, 8, false);
  }

  String toString() {
    return "HttpConnectionSetReceiveBufferSizeResponseParams("
           "result: $result" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["result"] = result;
    return map;
  }
}


class _HttpConnectionDelegateOnReceivedRequestParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  http_message_mojom.HttpRequest request = null;

  _HttpConnectionDelegateOnReceivedRequestParams() : super(kVersions.last.size);

  static _HttpConnectionDelegateOnReceivedRequestParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _HttpConnectionDelegateOnReceivedRequestParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _HttpConnectionDelegateOnReceivedRequestParams result = new _HttpConnectionDelegateOnReceivedRequestParams();

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
      result.request = http_message_mojom.HttpRequest.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(request, 8, false);
  }

  String toString() {
    return "_HttpConnectionDelegateOnReceivedRequestParams("
           "request: $request" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class HttpConnectionDelegateOnReceivedRequestResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  http_message_mojom.HttpResponse response = null;

  HttpConnectionDelegateOnReceivedRequestResponseParams() : super(kVersions.last.size);

  static HttpConnectionDelegateOnReceivedRequestResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static HttpConnectionDelegateOnReceivedRequestResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    HttpConnectionDelegateOnReceivedRequestResponseParams result = new HttpConnectionDelegateOnReceivedRequestResponseParams();

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
      result.response = http_message_mojom.HttpResponse.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(response, 8, false);
  }

  String toString() {
    return "HttpConnectionDelegateOnReceivedRequestResponseParams("
           "response: $response" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _HttpConnectionDelegateOnReceivedWebSocketRequestParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  http_message_mojom.HttpRequest request = null;

  _HttpConnectionDelegateOnReceivedWebSocketRequestParams() : super(kVersions.last.size);

  static _HttpConnectionDelegateOnReceivedWebSocketRequestParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _HttpConnectionDelegateOnReceivedWebSocketRequestParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _HttpConnectionDelegateOnReceivedWebSocketRequestParams result = new _HttpConnectionDelegateOnReceivedWebSocketRequestParams();

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
      result.request = http_message_mojom.HttpRequest.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(request, 8, false);
  }

  String toString() {
    return "_HttpConnectionDelegateOnReceivedWebSocketRequestParams("
           "request: $request" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class HttpConnectionDelegateOnReceivedWebSocketRequestResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  Object webSocket = null;
  core.MojoDataPipeConsumer sendStream = null;
  Object client = null;

  HttpConnectionDelegateOnReceivedWebSocketRequestResponseParams() : super(kVersions.last.size);

  static HttpConnectionDelegateOnReceivedWebSocketRequestResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static HttpConnectionDelegateOnReceivedWebSocketRequestResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    HttpConnectionDelegateOnReceivedWebSocketRequestResponseParams result = new HttpConnectionDelegateOnReceivedWebSocketRequestResponseParams();

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
      
      result.webSocket = decoder0.decodeInterfaceRequest(8, true, web_socket_mojom.WebSocketStub.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.sendStream = decoder0.decodeConsumerHandle(12, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.client = decoder0.decodeServiceInterface(16, true, web_socket_mojom.WebSocketClientProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInterfaceRequest(webSocket, 8, true);
    
    encoder0.encodeConsumerHandle(sendStream, 12, true);
    
    encoder0.encodeInterface(client, 16, true);
  }

  String toString() {
    return "HttpConnectionDelegateOnReceivedWebSocketRequestResponseParams("
           "webSocket: $webSocket" ", "
           "sendStream: $sendStream" ", "
           "client: $client" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int _HttpConnection_setSendBufferSizeName = 0;
const int _HttpConnection_setReceiveBufferSizeName = 1;

abstract class HttpConnection {
  static const String serviceName = null;
  dynamic setSendBufferSize(int size,[Function responseFactory = null]);
  dynamic setReceiveBufferSize(int size,[Function responseFactory = null]);
}


class _HttpConnectionProxyImpl extends bindings.Proxy {
  _HttpConnectionProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _HttpConnectionProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _HttpConnectionProxyImpl.unbound() : super.unbound();

  static _HttpConnectionProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _HttpConnectionProxyImpl"));
    return new _HttpConnectionProxyImpl.fromEndpoint(endpoint);
  }

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _HttpConnection_setSendBufferSizeName:
        var r = HttpConnectionSetSendBufferSizeResponseParams.deserialize(
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
      case _HttpConnection_setReceiveBufferSizeName:
        var r = HttpConnectionSetReceiveBufferSizeResponseParams.deserialize(
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
    return "_HttpConnectionProxyImpl($superString)";
  }
}


class _HttpConnectionProxyCalls implements HttpConnection {
  _HttpConnectionProxyImpl _proxyImpl;

  _HttpConnectionProxyCalls(this._proxyImpl);
    dynamic setSendBufferSize(int size,[Function responseFactory = null]) {
      var params = new _HttpConnectionSetSendBufferSizeParams();
      params.size = size;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _HttpConnection_setSendBufferSizeName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic setReceiveBufferSize(int size,[Function responseFactory = null]) {
      var params = new _HttpConnectionSetReceiveBufferSizeParams();
      params.size = size;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _HttpConnection_setReceiveBufferSizeName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class HttpConnectionProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  HttpConnection ptr;

  HttpConnectionProxy(_HttpConnectionProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _HttpConnectionProxyCalls(proxyImpl);

  HttpConnectionProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _HttpConnectionProxyImpl.fromEndpoint(endpoint) {
    ptr = new _HttpConnectionProxyCalls(impl);
  }

  HttpConnectionProxy.fromHandle(core.MojoHandle handle) :
      impl = new _HttpConnectionProxyImpl.fromHandle(handle) {
    ptr = new _HttpConnectionProxyCalls(impl);
  }

  HttpConnectionProxy.unbound() :
      impl = new _HttpConnectionProxyImpl.unbound() {
    ptr = new _HttpConnectionProxyCalls(impl);
  }

  factory HttpConnectionProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    HttpConnectionProxy p = new HttpConnectionProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static HttpConnectionProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HttpConnectionProxy"));
    return new HttpConnectionProxy.fromEndpoint(endpoint);
  }

  String get serviceName => HttpConnection.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "HttpConnectionProxy($impl)";
  }
}


class HttpConnectionStub extends bindings.Stub {
  HttpConnection _impl = null;

  HttpConnectionStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  HttpConnectionStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  HttpConnectionStub.unbound() : super.unbound();

  static HttpConnectionStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HttpConnectionStub"));
    return new HttpConnectionStub.fromEndpoint(endpoint);
  }


  HttpConnectionSetSendBufferSizeResponseParams _HttpConnectionSetSendBufferSizeResponseParamsFactory(network_error_mojom.NetworkError result) {
    var mojo_factory_result = new HttpConnectionSetSendBufferSizeResponseParams();
    mojo_factory_result.result = result;
    return mojo_factory_result;
  }
  HttpConnectionSetReceiveBufferSizeResponseParams _HttpConnectionSetReceiveBufferSizeResponseParamsFactory(network_error_mojom.NetworkError result) {
    var mojo_factory_result = new HttpConnectionSetReceiveBufferSizeResponseParams();
    mojo_factory_result.result = result;
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
      case _HttpConnection_setSendBufferSizeName:
        var params = _HttpConnectionSetSendBufferSizeParams.deserialize(
            message.payload);
        var response = _impl.setSendBufferSize(params.size,_HttpConnectionSetSendBufferSizeResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _HttpConnection_setSendBufferSizeName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _HttpConnection_setSendBufferSizeName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _HttpConnection_setReceiveBufferSizeName:
        var params = _HttpConnectionSetReceiveBufferSizeParams.deserialize(
            message.payload);
        var response = _impl.setReceiveBufferSize(params.size,_HttpConnectionSetReceiveBufferSizeResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _HttpConnection_setReceiveBufferSizeName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _HttpConnection_setReceiveBufferSizeName,
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

  HttpConnection get impl => _impl;
  set impl(HttpConnection d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "HttpConnectionStub($superString)";
  }

  int get version => 0;
}

const int _HttpConnectionDelegate_onReceivedRequestName = 0;
const int _HttpConnectionDelegate_onReceivedWebSocketRequestName = 1;

abstract class HttpConnectionDelegate {
  static const String serviceName = null;
  dynamic onReceivedRequest(http_message_mojom.HttpRequest request,[Function responseFactory = null]);
  dynamic onReceivedWebSocketRequest(http_message_mojom.HttpRequest request,[Function responseFactory = null]);
}


class _HttpConnectionDelegateProxyImpl extends bindings.Proxy {
  _HttpConnectionDelegateProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _HttpConnectionDelegateProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _HttpConnectionDelegateProxyImpl.unbound() : super.unbound();

  static _HttpConnectionDelegateProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _HttpConnectionDelegateProxyImpl"));
    return new _HttpConnectionDelegateProxyImpl.fromEndpoint(endpoint);
  }

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _HttpConnectionDelegate_onReceivedRequestName:
        var r = HttpConnectionDelegateOnReceivedRequestResponseParams.deserialize(
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
      case _HttpConnectionDelegate_onReceivedWebSocketRequestName:
        var r = HttpConnectionDelegateOnReceivedWebSocketRequestResponseParams.deserialize(
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
    return "_HttpConnectionDelegateProxyImpl($superString)";
  }
}


class _HttpConnectionDelegateProxyCalls implements HttpConnectionDelegate {
  _HttpConnectionDelegateProxyImpl _proxyImpl;

  _HttpConnectionDelegateProxyCalls(this._proxyImpl);
    dynamic onReceivedRequest(http_message_mojom.HttpRequest request,[Function responseFactory = null]) {
      var params = new _HttpConnectionDelegateOnReceivedRequestParams();
      params.request = request;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _HttpConnectionDelegate_onReceivedRequestName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic onReceivedWebSocketRequest(http_message_mojom.HttpRequest request,[Function responseFactory = null]) {
      var params = new _HttpConnectionDelegateOnReceivedWebSocketRequestParams();
      params.request = request;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _HttpConnectionDelegate_onReceivedWebSocketRequestName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class HttpConnectionDelegateProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  HttpConnectionDelegate ptr;

  HttpConnectionDelegateProxy(_HttpConnectionDelegateProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _HttpConnectionDelegateProxyCalls(proxyImpl);

  HttpConnectionDelegateProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _HttpConnectionDelegateProxyImpl.fromEndpoint(endpoint) {
    ptr = new _HttpConnectionDelegateProxyCalls(impl);
  }

  HttpConnectionDelegateProxy.fromHandle(core.MojoHandle handle) :
      impl = new _HttpConnectionDelegateProxyImpl.fromHandle(handle) {
    ptr = new _HttpConnectionDelegateProxyCalls(impl);
  }

  HttpConnectionDelegateProxy.unbound() :
      impl = new _HttpConnectionDelegateProxyImpl.unbound() {
    ptr = new _HttpConnectionDelegateProxyCalls(impl);
  }

  factory HttpConnectionDelegateProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    HttpConnectionDelegateProxy p = new HttpConnectionDelegateProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static HttpConnectionDelegateProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HttpConnectionDelegateProxy"));
    return new HttpConnectionDelegateProxy.fromEndpoint(endpoint);
  }

  String get serviceName => HttpConnectionDelegate.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "HttpConnectionDelegateProxy($impl)";
  }
}


class HttpConnectionDelegateStub extends bindings.Stub {
  HttpConnectionDelegate _impl = null;

  HttpConnectionDelegateStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  HttpConnectionDelegateStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  HttpConnectionDelegateStub.unbound() : super.unbound();

  static HttpConnectionDelegateStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HttpConnectionDelegateStub"));
    return new HttpConnectionDelegateStub.fromEndpoint(endpoint);
  }


  HttpConnectionDelegateOnReceivedRequestResponseParams _HttpConnectionDelegateOnReceivedRequestResponseParamsFactory(http_message_mojom.HttpResponse response) {
    var mojo_factory_result = new HttpConnectionDelegateOnReceivedRequestResponseParams();
    mojo_factory_result.response = response;
    return mojo_factory_result;
  }
  HttpConnectionDelegateOnReceivedWebSocketRequestResponseParams _HttpConnectionDelegateOnReceivedWebSocketRequestResponseParamsFactory(Object webSocket, core.MojoDataPipeConsumer sendStream, Object client) {
    var mojo_factory_result = new HttpConnectionDelegateOnReceivedWebSocketRequestResponseParams();
    mojo_factory_result.webSocket = webSocket;
    mojo_factory_result.sendStream = sendStream;
    mojo_factory_result.client = client;
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
      case _HttpConnectionDelegate_onReceivedRequestName:
        var params = _HttpConnectionDelegateOnReceivedRequestParams.deserialize(
            message.payload);
        var response = _impl.onReceivedRequest(params.request,_HttpConnectionDelegateOnReceivedRequestResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _HttpConnectionDelegate_onReceivedRequestName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _HttpConnectionDelegate_onReceivedRequestName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _HttpConnectionDelegate_onReceivedWebSocketRequestName:
        var params = _HttpConnectionDelegateOnReceivedWebSocketRequestParams.deserialize(
            message.payload);
        var response = _impl.onReceivedWebSocketRequest(params.request,_HttpConnectionDelegateOnReceivedWebSocketRequestResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _HttpConnectionDelegate_onReceivedWebSocketRequestName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _HttpConnectionDelegate_onReceivedWebSocketRequestName,
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

  HttpConnectionDelegate get impl => _impl;
  set impl(HttpConnectionDelegate d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "HttpConnectionDelegateStub($superString)";
  }

  int get version => 0;
}


