// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library echo_service_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;



class EchoServiceEchoStringParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String value = null;

  EchoServiceEchoStringParams() : super(kVersions.last.size);

  static EchoServiceEchoStringParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static EchoServiceEchoStringParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    EchoServiceEchoStringParams result = new EchoServiceEchoStringParams();

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
      
      result.value = decoder0.decodeString(8, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeString(value, 8, true);
  }

  String toString() {
    return "EchoServiceEchoStringParams("
           "value: $value" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["value"] = value;
    return map;
  }
}


class EchoServiceEchoStringResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String value = null;

  EchoServiceEchoStringResponseParams() : super(kVersions.last.size);

  static EchoServiceEchoStringResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static EchoServiceEchoStringResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    EchoServiceEchoStringResponseParams result = new EchoServiceEchoStringResponseParams();

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
      
      result.value = decoder0.decodeString(8, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeString(value, 8, true);
  }

  String toString() {
    return "EchoServiceEchoStringResponseParams("
           "value: $value" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["value"] = value;
    return map;
  }
}


class EchoServiceDelayedEchoStringParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String value = null;
  int millis = 0;

  EchoServiceDelayedEchoStringParams() : super(kVersions.last.size);

  static EchoServiceDelayedEchoStringParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static EchoServiceDelayedEchoStringParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    EchoServiceDelayedEchoStringParams result = new EchoServiceDelayedEchoStringParams();

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
      
      result.value = decoder0.decodeString(8, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.millis = decoder0.decodeInt32(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeString(value, 8, true);
    
    encoder0.encodeInt32(millis, 16);
  }

  String toString() {
    return "EchoServiceDelayedEchoStringParams("
           "value: $value" ", "
           "millis: $millis" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["value"] = value;
    map["millis"] = millis;
    return map;
  }
}


class EchoServiceDelayedEchoStringResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String value = null;

  EchoServiceDelayedEchoStringResponseParams() : super(kVersions.last.size);

  static EchoServiceDelayedEchoStringResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static EchoServiceDelayedEchoStringResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    EchoServiceDelayedEchoStringResponseParams result = new EchoServiceDelayedEchoStringResponseParams();

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
      
      result.value = decoder0.decodeString(8, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeString(value, 8, true);
  }

  String toString() {
    return "EchoServiceDelayedEchoStringResponseParams("
           "value: $value" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["value"] = value;
    return map;
  }
}

const int kEchoService_echoString_name = 0;
const int kEchoService_delayedEchoString_name = 1;

const String EchoServiceName =
      'test::EchoService';

abstract class EchoService {
  dynamic echoString(String value,[Function responseFactory = null]);
  dynamic delayedEchoString(String value,int millis,[Function responseFactory = null]);

}


class EchoServiceProxyImpl extends bindings.Proxy {
  EchoServiceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  EchoServiceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  EchoServiceProxyImpl.unbound() : super.unbound();

  static EchoServiceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For EchoServiceProxyImpl"));
    return new EchoServiceProxyImpl.fromEndpoint(endpoint);
  }

  String get name => EchoServiceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case kEchoService_echoString_name:
        var r = EchoServiceEchoStringResponseParams.deserialize(
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
      case kEchoService_delayedEchoString_name:
        var r = EchoServiceDelayedEchoStringResponseParams.deserialize(
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
    return "EchoServiceProxyImpl($superString)";
  }
}


class _EchoServiceProxyCalls implements EchoService {
  EchoServiceProxyImpl _proxyImpl;

  _EchoServiceProxyCalls(this._proxyImpl);
    dynamic echoString(String value,[Function responseFactory = null]) {
      var params = new EchoServiceEchoStringParams();
      params.value = value;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kEchoService_echoString_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic delayedEchoString(String value,int millis,[Function responseFactory = null]) {
      var params = new EchoServiceDelayedEchoStringParams();
      params.value = value;
      params.millis = millis;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kEchoService_delayedEchoString_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class EchoServiceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  EchoService ptr;
  final String name = EchoServiceName;

  EchoServiceProxy(EchoServiceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _EchoServiceProxyCalls(proxyImpl);

  EchoServiceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new EchoServiceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _EchoServiceProxyCalls(impl);
  }

  EchoServiceProxy.fromHandle(core.MojoHandle handle) :
      impl = new EchoServiceProxyImpl.fromHandle(handle) {
    ptr = new _EchoServiceProxyCalls(impl);
  }

  EchoServiceProxy.unbound() :
      impl = new EchoServiceProxyImpl.unbound() {
    ptr = new _EchoServiceProxyCalls(impl);
  }

  factory EchoServiceProxy.connectToService(
      bindings.ServiceConnector s, String url) {
    EchoServiceProxy p = new EchoServiceProxy.unbound();
    s.connectToService(url, p);
    return p;
  }

  static EchoServiceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For EchoServiceProxy"));
    return new EchoServiceProxy.fromEndpoint(endpoint);
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
    return "EchoServiceProxy($impl)";
  }
}


class EchoServiceStub extends bindings.Stub {
  EchoService _impl = null;

  EchoServiceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  EchoServiceStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  EchoServiceStub.unbound() : super.unbound();

  static EchoServiceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For EchoServiceStub"));
    return new EchoServiceStub.fromEndpoint(endpoint);
  }

  static const String name = EchoServiceName;


  EchoServiceEchoStringResponseParams _EchoServiceEchoStringResponseParamsFactory(String value) {
    var result = new EchoServiceEchoStringResponseParams();
    result.value = value;
    return result;
  }
  EchoServiceDelayedEchoStringResponseParams _EchoServiceDelayedEchoStringResponseParamsFactory(String value) {
    var result = new EchoServiceDelayedEchoStringResponseParams();
    result.value = value;
    return result;
  }

  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case kEchoService_echoString_name:
        var params = EchoServiceEchoStringParams.deserialize(
            message.payload);
        var response = _impl.echoString(params.value,_EchoServiceEchoStringResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kEchoService_echoString_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kEchoService_echoString_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kEchoService_delayedEchoString_name:
        var params = EchoServiceDelayedEchoStringParams.deserialize(
            message.payload);
        var response = _impl.delayedEchoString(params.value,params.millis,_EchoServiceDelayedEchoStringResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kEchoService_delayedEchoString_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kEchoService_delayedEchoString_name,
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

  EchoService get impl => _impl;
  set impl(EchoService d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "EchoServiceStub($superString)";
  }

  int get version => 0;
}


