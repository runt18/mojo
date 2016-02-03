// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library url_loader_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo/mojo/network_error.mojom.dart' as network_error_mojom;
import 'package:mojo/mojo/url_request.mojom.dart' as url_request_mojom;
import 'package:mojo/mojo/url_response.mojom.dart' as url_response_mojom;



class UrlLoaderStatus extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  network_error_mojom.NetworkError error = null;
  bool isLoading = false;

  UrlLoaderStatus() : super(kVersions.last.size);

  static UrlLoaderStatus deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UrlLoaderStatus decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UrlLoaderStatus result = new UrlLoaderStatus();

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
      
      var decoder1 = decoder0.decodePointer(8, true);
      result.error = network_error_mojom.NetworkError.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.isLoading = decoder0.decodeBool(16, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(error, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct UrlLoaderStatus: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(isLoading, 16, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "isLoading of struct UrlLoaderStatus: $e";
      rethrow;
    }
  }

  String toString() {
    return "UrlLoaderStatus("
           "error: $error" ", "
           "isLoading: $isLoading" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    map["isLoading"] = isLoading;
    return map;
  }
}




class _UrlLoaderStartParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  url_request_mojom.UrlRequest request = null;

  _UrlLoaderStartParams() : super(kVersions.last.size);

  static _UrlLoaderStartParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _UrlLoaderStartParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _UrlLoaderStartParams result = new _UrlLoaderStartParams();

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
      result.request = url_request_mojom.UrlRequest.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(request, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "request of struct _UrlLoaderStartParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_UrlLoaderStartParams("
           "request: $request" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




class UrlLoaderStartResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  url_response_mojom.UrlResponse response = null;

  UrlLoaderStartResponseParams() : super(kVersions.last.size);

  static UrlLoaderStartResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UrlLoaderStartResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UrlLoaderStartResponseParams result = new UrlLoaderStartResponseParams();

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
      result.response = url_response_mojom.UrlResponse.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(response, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "response of struct UrlLoaderStartResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "UrlLoaderStartResponseParams("
           "response: $response" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




class _UrlLoaderFollowRedirectParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _UrlLoaderFollowRedirectParams() : super(kVersions.last.size);

  static _UrlLoaderFollowRedirectParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _UrlLoaderFollowRedirectParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _UrlLoaderFollowRedirectParams result = new _UrlLoaderFollowRedirectParams();

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
    return "_UrlLoaderFollowRedirectParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}




class UrlLoaderFollowRedirectResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  url_response_mojom.UrlResponse response = null;

  UrlLoaderFollowRedirectResponseParams() : super(kVersions.last.size);

  static UrlLoaderFollowRedirectResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UrlLoaderFollowRedirectResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UrlLoaderFollowRedirectResponseParams result = new UrlLoaderFollowRedirectResponseParams();

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
      result.response = url_response_mojom.UrlResponse.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(response, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "response of struct UrlLoaderFollowRedirectResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "UrlLoaderFollowRedirectResponseParams("
           "response: $response" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




class _UrlLoaderQueryStatusParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _UrlLoaderQueryStatusParams() : super(kVersions.last.size);

  static _UrlLoaderQueryStatusParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _UrlLoaderQueryStatusParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _UrlLoaderQueryStatusParams result = new _UrlLoaderQueryStatusParams();

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
    return "_UrlLoaderQueryStatusParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}




class UrlLoaderQueryStatusResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  UrlLoaderStatus status = null;

  UrlLoaderQueryStatusResponseParams() : super(kVersions.last.size);

  static UrlLoaderQueryStatusResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UrlLoaderQueryStatusResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UrlLoaderQueryStatusResponseParams result = new UrlLoaderQueryStatusResponseParams();

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
      result.status = UrlLoaderStatus.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(status, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "status of struct UrlLoaderQueryStatusResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "UrlLoaderQueryStatusResponseParams("
           "status: $status" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["status"] = status;
    return map;
  }
}




const int _UrlLoader_startName = 0;
const int _UrlLoader_followRedirectName = 1;
const int _UrlLoader_queryStatusName = 2;



class _UrlLoaderServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class UrlLoader {
  static const String serviceName = null;
  dynamic start(url_request_mojom.UrlRequest request,[Function responseFactory = null]);
  dynamic followRedirect([Function responseFactory = null]);
  dynamic queryStatus([Function responseFactory = null]);
}


class _UrlLoaderProxyImpl extends bindings.Proxy {
  _UrlLoaderProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _UrlLoaderProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _UrlLoaderProxyImpl.unbound() : super.unbound();

  static _UrlLoaderProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _UrlLoaderProxyImpl"));
    return new _UrlLoaderProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _UrlLoaderServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _UrlLoader_startName:
        var r = UrlLoaderStartResponseParams.deserialize(
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
      case _UrlLoader_followRedirectName:
        var r = UrlLoaderFollowRedirectResponseParams.deserialize(
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
      case _UrlLoader_queryStatusName:
        var r = UrlLoaderQueryStatusResponseParams.deserialize(
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
    return "_UrlLoaderProxyImpl($superString)";
  }
}


class _UrlLoaderProxyCalls implements UrlLoader {
  _UrlLoaderProxyImpl _proxyImpl;

  _UrlLoaderProxyCalls(this._proxyImpl);
    dynamic start(url_request_mojom.UrlRequest request,[Function responseFactory = null]) {
      var params = new _UrlLoaderStartParams();
      params.request = request;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _UrlLoader_startName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic followRedirect([Function responseFactory = null]) {
      var params = new _UrlLoaderFollowRedirectParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _UrlLoader_followRedirectName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic queryStatus([Function responseFactory = null]) {
      var params = new _UrlLoaderQueryStatusParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _UrlLoader_queryStatusName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class UrlLoaderProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  UrlLoader ptr;

  UrlLoaderProxy(_UrlLoaderProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _UrlLoaderProxyCalls(proxyImpl);

  UrlLoaderProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _UrlLoaderProxyImpl.fromEndpoint(endpoint) {
    ptr = new _UrlLoaderProxyCalls(impl);
  }

  UrlLoaderProxy.fromHandle(core.MojoHandle handle) :
      impl = new _UrlLoaderProxyImpl.fromHandle(handle) {
    ptr = new _UrlLoaderProxyCalls(impl);
  }

  UrlLoaderProxy.unbound() :
      impl = new _UrlLoaderProxyImpl.unbound() {
    ptr = new _UrlLoaderProxyCalls(impl);
  }

  factory UrlLoaderProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    UrlLoaderProxy p = new UrlLoaderProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static UrlLoaderProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For UrlLoaderProxy"));
    return new UrlLoaderProxy.fromEndpoint(endpoint);
  }

  String get serviceName => UrlLoader.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "UrlLoaderProxy($impl)";
  }
}


class UrlLoaderStub extends bindings.Stub {
  UrlLoader _impl = null;

  UrlLoaderStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  UrlLoaderStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  UrlLoaderStub.unbound() : super.unbound();

  static UrlLoaderStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For UrlLoaderStub"));
    return new UrlLoaderStub.fromEndpoint(endpoint);
  }


  UrlLoaderStartResponseParams _UrlLoaderStartResponseParamsFactory(url_response_mojom.UrlResponse response) {
    var mojo_factory_result = new UrlLoaderStartResponseParams();
    mojo_factory_result.response = response;
    return mojo_factory_result;
  }
  UrlLoaderFollowRedirectResponseParams _UrlLoaderFollowRedirectResponseParamsFactory(url_response_mojom.UrlResponse response) {
    var mojo_factory_result = new UrlLoaderFollowRedirectResponseParams();
    mojo_factory_result.response = response;
    return mojo_factory_result;
  }
  UrlLoaderQueryStatusResponseParams _UrlLoaderQueryStatusResponseParamsFactory(UrlLoaderStatus status) {
    var mojo_factory_result = new UrlLoaderQueryStatusResponseParams();
    mojo_factory_result.status = status;
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
      case _UrlLoader_startName:
        var params = _UrlLoaderStartParams.deserialize(
            message.payload);
        var response = _impl.start(params.request,_UrlLoaderStartResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _UrlLoader_startName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _UrlLoader_startName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _UrlLoader_followRedirectName:
        var params = _UrlLoaderFollowRedirectParams.deserialize(
            message.payload);
        var response = _impl.followRedirect(_UrlLoaderFollowRedirectResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _UrlLoader_followRedirectName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _UrlLoader_followRedirectName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _UrlLoader_queryStatusName:
        var params = _UrlLoaderQueryStatusParams.deserialize(
            message.payload);
        var response = _impl.queryStatus(_UrlLoaderQueryStatusResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _UrlLoader_queryStatusName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _UrlLoader_queryStatusName,
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

  UrlLoader get impl => _impl;
  set impl(UrlLoader d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "UrlLoaderStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _UrlLoaderServiceDescription();
}



