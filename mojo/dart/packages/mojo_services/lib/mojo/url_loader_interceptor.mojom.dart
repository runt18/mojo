// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library url_loader_interceptor_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo/mojo/url_request.mojom.dart' as url_request_mojom;
import 'package:mojo/mojo/url_response.mojom.dart' as url_response_mojom;



class UrlLoaderInterceptorResponse extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  url_request_mojom.UrlRequest request = null;
  url_response_mojom.UrlResponse response = null;

  UrlLoaderInterceptorResponse() : super(kVersions.last.size);

  static UrlLoaderInterceptorResponse deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UrlLoaderInterceptorResponse decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UrlLoaderInterceptorResponse result = new UrlLoaderInterceptorResponse();

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
      result.request = url_request_mojom.UrlRequest.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.response = url_response_mojom.UrlResponse.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(request, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "request of struct UrlLoaderInterceptorResponse: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(response, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "response of struct UrlLoaderInterceptorResponse: $e";
      rethrow;
    }
  }

  String toString() {
    return "UrlLoaderInterceptorResponse("
           "request: $request" ", "
           "response: $response" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




class _UrlLoaderInterceptorFactoryCreateParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object interceptor = null;

  _UrlLoaderInterceptorFactoryCreateParams() : super(kVersions.last.size);

  static _UrlLoaderInterceptorFactoryCreateParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _UrlLoaderInterceptorFactoryCreateParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _UrlLoaderInterceptorFactoryCreateParams result = new _UrlLoaderInterceptorFactoryCreateParams();

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
      
      result.interceptor = decoder0.decodeInterfaceRequest(8, false, UrlLoaderInterceptorStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(interceptor, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "interceptor of struct _UrlLoaderInterceptorFactoryCreateParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_UrlLoaderInterceptorFactoryCreateParams("
           "interceptor: $interceptor" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




class _UrlLoaderInterceptorInterceptRequestParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  url_request_mojom.UrlRequest request = null;

  _UrlLoaderInterceptorInterceptRequestParams() : super(kVersions.last.size);

  static _UrlLoaderInterceptorInterceptRequestParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _UrlLoaderInterceptorInterceptRequestParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _UrlLoaderInterceptorInterceptRequestParams result = new _UrlLoaderInterceptorInterceptRequestParams();

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
          "request of struct _UrlLoaderInterceptorInterceptRequestParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_UrlLoaderInterceptorInterceptRequestParams("
           "request: $request" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




class UrlLoaderInterceptorInterceptRequestResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  UrlLoaderInterceptorResponse response = null;

  UrlLoaderInterceptorInterceptRequestResponseParams() : super(kVersions.last.size);

  static UrlLoaderInterceptorInterceptRequestResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UrlLoaderInterceptorInterceptRequestResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UrlLoaderInterceptorInterceptRequestResponseParams result = new UrlLoaderInterceptorInterceptRequestResponseParams();

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
      result.response = UrlLoaderInterceptorResponse.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(response, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "response of struct UrlLoaderInterceptorInterceptRequestResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "UrlLoaderInterceptorInterceptRequestResponseParams("
           "response: $response" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




class _UrlLoaderInterceptorInterceptFollowRedirectParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _UrlLoaderInterceptorInterceptFollowRedirectParams() : super(kVersions.last.size);

  static _UrlLoaderInterceptorInterceptFollowRedirectParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _UrlLoaderInterceptorInterceptFollowRedirectParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _UrlLoaderInterceptorInterceptFollowRedirectParams result = new _UrlLoaderInterceptorInterceptFollowRedirectParams();

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
    return "_UrlLoaderInterceptorInterceptFollowRedirectParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}




class UrlLoaderInterceptorInterceptFollowRedirectResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  UrlLoaderInterceptorResponse response = null;

  UrlLoaderInterceptorInterceptFollowRedirectResponseParams() : super(kVersions.last.size);

  static UrlLoaderInterceptorInterceptFollowRedirectResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UrlLoaderInterceptorInterceptFollowRedirectResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UrlLoaderInterceptorInterceptFollowRedirectResponseParams result = new UrlLoaderInterceptorInterceptFollowRedirectResponseParams();

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
      result.response = UrlLoaderInterceptorResponse.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(response, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "response of struct UrlLoaderInterceptorInterceptFollowRedirectResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "UrlLoaderInterceptorInterceptFollowRedirectResponseParams("
           "response: $response" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




class _UrlLoaderInterceptorInterceptResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  url_response_mojom.UrlResponse response = null;

  _UrlLoaderInterceptorInterceptResponseParams() : super(kVersions.last.size);

  static _UrlLoaderInterceptorInterceptResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _UrlLoaderInterceptorInterceptResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _UrlLoaderInterceptorInterceptResponseParams result = new _UrlLoaderInterceptorInterceptResponseParams();

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
          "response of struct _UrlLoaderInterceptorInterceptResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_UrlLoaderInterceptorInterceptResponseParams("
           "response: $response" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




class UrlLoaderInterceptorInterceptResponseResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  UrlLoaderInterceptorResponse response = null;

  UrlLoaderInterceptorInterceptResponseResponseParams() : super(kVersions.last.size);

  static UrlLoaderInterceptorInterceptResponseResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UrlLoaderInterceptorInterceptResponseResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UrlLoaderInterceptorInterceptResponseResponseParams result = new UrlLoaderInterceptorInterceptResponseResponseParams();

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
      result.response = UrlLoaderInterceptorResponse.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(response, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "response of struct UrlLoaderInterceptorInterceptResponseResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "UrlLoaderInterceptorInterceptResponseResponseParams("
           "response: $response" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




const int _UrlLoaderInterceptorFactory_createName = 0;



class _UrlLoaderInterceptorFactoryServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class UrlLoaderInterceptorFactory {
  static const String serviceName = null;
  void create(Object interceptor);
}


class _UrlLoaderInterceptorFactoryProxyImpl extends bindings.Proxy {
  _UrlLoaderInterceptorFactoryProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _UrlLoaderInterceptorFactoryProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _UrlLoaderInterceptorFactoryProxyImpl.unbound() : super.unbound();

  static _UrlLoaderInterceptorFactoryProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _UrlLoaderInterceptorFactoryProxyImpl"));
    return new _UrlLoaderInterceptorFactoryProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _UrlLoaderInterceptorFactoryServiceDescription();

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
    return "_UrlLoaderInterceptorFactoryProxyImpl($superString)";
  }
}


class _UrlLoaderInterceptorFactoryProxyCalls implements UrlLoaderInterceptorFactory {
  _UrlLoaderInterceptorFactoryProxyImpl _proxyImpl;

  _UrlLoaderInterceptorFactoryProxyCalls(this._proxyImpl);
    void create(Object interceptor) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _UrlLoaderInterceptorFactoryCreateParams();
      params.interceptor = interceptor;
      _proxyImpl.sendMessage(params, _UrlLoaderInterceptorFactory_createName);
    }
}


class UrlLoaderInterceptorFactoryProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  UrlLoaderInterceptorFactory ptr;

  UrlLoaderInterceptorFactoryProxy(_UrlLoaderInterceptorFactoryProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _UrlLoaderInterceptorFactoryProxyCalls(proxyImpl);

  UrlLoaderInterceptorFactoryProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _UrlLoaderInterceptorFactoryProxyImpl.fromEndpoint(endpoint) {
    ptr = new _UrlLoaderInterceptorFactoryProxyCalls(impl);
  }

  UrlLoaderInterceptorFactoryProxy.fromHandle(core.MojoHandle handle) :
      impl = new _UrlLoaderInterceptorFactoryProxyImpl.fromHandle(handle) {
    ptr = new _UrlLoaderInterceptorFactoryProxyCalls(impl);
  }

  UrlLoaderInterceptorFactoryProxy.unbound() :
      impl = new _UrlLoaderInterceptorFactoryProxyImpl.unbound() {
    ptr = new _UrlLoaderInterceptorFactoryProxyCalls(impl);
  }

  factory UrlLoaderInterceptorFactoryProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    UrlLoaderInterceptorFactoryProxy p = new UrlLoaderInterceptorFactoryProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static UrlLoaderInterceptorFactoryProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For UrlLoaderInterceptorFactoryProxy"));
    return new UrlLoaderInterceptorFactoryProxy.fromEndpoint(endpoint);
  }

  String get serviceName => UrlLoaderInterceptorFactory.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "UrlLoaderInterceptorFactoryProxy($impl)";
  }
}


class UrlLoaderInterceptorFactoryStub extends bindings.Stub {
  UrlLoaderInterceptorFactory _impl = null;

  UrlLoaderInterceptorFactoryStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  UrlLoaderInterceptorFactoryStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  UrlLoaderInterceptorFactoryStub.unbound() : super.unbound();

  static UrlLoaderInterceptorFactoryStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For UrlLoaderInterceptorFactoryStub"));
    return new UrlLoaderInterceptorFactoryStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _UrlLoaderInterceptorFactory_createName:
        var params = _UrlLoaderInterceptorFactoryCreateParams.deserialize(
            message.payload);
        _impl.create(params.interceptor);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  UrlLoaderInterceptorFactory get impl => _impl;
  set impl(UrlLoaderInterceptorFactory d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "UrlLoaderInterceptorFactoryStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _UrlLoaderInterceptorFactoryServiceDescription();
}

const int _UrlLoaderInterceptor_interceptRequestName = 0;
const int _UrlLoaderInterceptor_interceptFollowRedirectName = 1;
const int _UrlLoaderInterceptor_interceptResponseName = 2;



class _UrlLoaderInterceptorServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class UrlLoaderInterceptor {
  static const String serviceName = null;
  dynamic interceptRequest(url_request_mojom.UrlRequest request,[Function responseFactory = null]);
  dynamic interceptFollowRedirect([Function responseFactory = null]);
  dynamic interceptResponse(url_response_mojom.UrlResponse response,[Function responseFactory = null]);
}


class _UrlLoaderInterceptorProxyImpl extends bindings.Proxy {
  _UrlLoaderInterceptorProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _UrlLoaderInterceptorProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _UrlLoaderInterceptorProxyImpl.unbound() : super.unbound();

  static _UrlLoaderInterceptorProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _UrlLoaderInterceptorProxyImpl"));
    return new _UrlLoaderInterceptorProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _UrlLoaderInterceptorServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _UrlLoaderInterceptor_interceptRequestName:
        var r = UrlLoaderInterceptorInterceptRequestResponseParams.deserialize(
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
      case _UrlLoaderInterceptor_interceptFollowRedirectName:
        var r = UrlLoaderInterceptorInterceptFollowRedirectResponseParams.deserialize(
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
      case _UrlLoaderInterceptor_interceptResponseName:
        var r = UrlLoaderInterceptorInterceptResponseResponseParams.deserialize(
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
    return "_UrlLoaderInterceptorProxyImpl($superString)";
  }
}


class _UrlLoaderInterceptorProxyCalls implements UrlLoaderInterceptor {
  _UrlLoaderInterceptorProxyImpl _proxyImpl;

  _UrlLoaderInterceptorProxyCalls(this._proxyImpl);
    dynamic interceptRequest(url_request_mojom.UrlRequest request,[Function responseFactory = null]) {
      var params = new _UrlLoaderInterceptorInterceptRequestParams();
      params.request = request;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _UrlLoaderInterceptor_interceptRequestName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic interceptFollowRedirect([Function responseFactory = null]) {
      var params = new _UrlLoaderInterceptorInterceptFollowRedirectParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _UrlLoaderInterceptor_interceptFollowRedirectName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic interceptResponse(url_response_mojom.UrlResponse response,[Function responseFactory = null]) {
      var params = new _UrlLoaderInterceptorInterceptResponseParams();
      params.response = response;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _UrlLoaderInterceptor_interceptResponseName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class UrlLoaderInterceptorProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  UrlLoaderInterceptor ptr;

  UrlLoaderInterceptorProxy(_UrlLoaderInterceptorProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _UrlLoaderInterceptorProxyCalls(proxyImpl);

  UrlLoaderInterceptorProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _UrlLoaderInterceptorProxyImpl.fromEndpoint(endpoint) {
    ptr = new _UrlLoaderInterceptorProxyCalls(impl);
  }

  UrlLoaderInterceptorProxy.fromHandle(core.MojoHandle handle) :
      impl = new _UrlLoaderInterceptorProxyImpl.fromHandle(handle) {
    ptr = new _UrlLoaderInterceptorProxyCalls(impl);
  }

  UrlLoaderInterceptorProxy.unbound() :
      impl = new _UrlLoaderInterceptorProxyImpl.unbound() {
    ptr = new _UrlLoaderInterceptorProxyCalls(impl);
  }

  factory UrlLoaderInterceptorProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    UrlLoaderInterceptorProxy p = new UrlLoaderInterceptorProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static UrlLoaderInterceptorProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For UrlLoaderInterceptorProxy"));
    return new UrlLoaderInterceptorProxy.fromEndpoint(endpoint);
  }

  String get serviceName => UrlLoaderInterceptor.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "UrlLoaderInterceptorProxy($impl)";
  }
}


class UrlLoaderInterceptorStub extends bindings.Stub {
  UrlLoaderInterceptor _impl = null;

  UrlLoaderInterceptorStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  UrlLoaderInterceptorStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  UrlLoaderInterceptorStub.unbound() : super.unbound();

  static UrlLoaderInterceptorStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For UrlLoaderInterceptorStub"));
    return new UrlLoaderInterceptorStub.fromEndpoint(endpoint);
  }


  UrlLoaderInterceptorInterceptRequestResponseParams _UrlLoaderInterceptorInterceptRequestResponseParamsFactory(UrlLoaderInterceptorResponse response) {
    var mojo_factory_result = new UrlLoaderInterceptorInterceptRequestResponseParams();
    mojo_factory_result.response = response;
    return mojo_factory_result;
  }
  UrlLoaderInterceptorInterceptFollowRedirectResponseParams _UrlLoaderInterceptorInterceptFollowRedirectResponseParamsFactory(UrlLoaderInterceptorResponse response) {
    var mojo_factory_result = new UrlLoaderInterceptorInterceptFollowRedirectResponseParams();
    mojo_factory_result.response = response;
    return mojo_factory_result;
  }
  UrlLoaderInterceptorInterceptResponseResponseParams _UrlLoaderInterceptorInterceptResponseResponseParamsFactory(UrlLoaderInterceptorResponse response) {
    var mojo_factory_result = new UrlLoaderInterceptorInterceptResponseResponseParams();
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
      case _UrlLoaderInterceptor_interceptRequestName:
        var params = _UrlLoaderInterceptorInterceptRequestParams.deserialize(
            message.payload);
        var response = _impl.interceptRequest(params.request,_UrlLoaderInterceptorInterceptRequestResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _UrlLoaderInterceptor_interceptRequestName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _UrlLoaderInterceptor_interceptRequestName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _UrlLoaderInterceptor_interceptFollowRedirectName:
        var params = _UrlLoaderInterceptorInterceptFollowRedirectParams.deserialize(
            message.payload);
        var response = _impl.interceptFollowRedirect(_UrlLoaderInterceptorInterceptFollowRedirectResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _UrlLoaderInterceptor_interceptFollowRedirectName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _UrlLoaderInterceptor_interceptFollowRedirectName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _UrlLoaderInterceptor_interceptResponseName:
        var params = _UrlLoaderInterceptorInterceptResponseParams.deserialize(
            message.payload);
        var response = _impl.interceptResponse(params.response,_UrlLoaderInterceptorInterceptResponseResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _UrlLoaderInterceptor_interceptResponseName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _UrlLoaderInterceptor_interceptResponseName,
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

  UrlLoaderInterceptor get impl => _impl;
  set impl(UrlLoaderInterceptor d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "UrlLoaderInterceptorStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _UrlLoaderInterceptorServiceDescription();
}



