// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library cookie_store_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class _CookieStoreGetParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String url = null;

  _CookieStoreGetParams() : super(kVersions.last.size);

  static _CookieStoreGetParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CookieStoreGetParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CookieStoreGetParams result = new _CookieStoreGetParams();

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
      
      result.url = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeString(url, 8, false);
  }

  String toString() {
    return "_CookieStoreGetParams("
           "url: $url" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["url"] = url;
    return map;
  }
}




class CookieStoreGetResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String cookies = null;

  CookieStoreGetResponseParams() : super(kVersions.last.size);

  static CookieStoreGetResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static CookieStoreGetResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    CookieStoreGetResponseParams result = new CookieStoreGetResponseParams();

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
      
      result.cookies = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeString(cookies, 8, false);
  }

  String toString() {
    return "CookieStoreGetResponseParams("
           "cookies: $cookies" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["cookies"] = cookies;
    return map;
  }
}




class _CookieStoreSetParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String url = null;
  String cookie = null;

  _CookieStoreSetParams() : super(kVersions.last.size);

  static _CookieStoreSetParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CookieStoreSetParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CookieStoreSetParams result = new _CookieStoreSetParams();

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
      
      result.url = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.cookie = decoder0.decodeString(16, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeString(url, 8, false);
    
    encoder0.encodeString(cookie, 16, false);
  }

  String toString() {
    return "_CookieStoreSetParams("
           "url: $url" ", "
           "cookie: $cookie" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["url"] = url;
    map["cookie"] = cookie;
    return map;
  }
}




class CookieStoreSetResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool success = false;

  CookieStoreSetResponseParams() : super(kVersions.last.size);

  static CookieStoreSetResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static CookieStoreSetResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    CookieStoreSetResponseParams result = new CookieStoreSetResponseParams();

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
    return "CookieStoreSetResponseParams("
           "success: $success" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["success"] = success;
    return map;
  }
}




const int _CookieStore_getName = 0;
const int _CookieStore_setName = 1;



class _CookieStoreServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class CookieStore {
  static const String serviceName = null;
  dynamic get(String url,[Function responseFactory = null]);
  dynamic set(String url,String cookie,[Function responseFactory = null]);
}


class _CookieStoreProxyImpl extends bindings.Proxy {
  _CookieStoreProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _CookieStoreProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _CookieStoreProxyImpl.unbound() : super.unbound();

  static _CookieStoreProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _CookieStoreProxyImpl"));
    return new _CookieStoreProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _CookieStoreServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _CookieStore_getName:
        var r = CookieStoreGetResponseParams.deserialize(
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
      case _CookieStore_setName:
        var r = CookieStoreSetResponseParams.deserialize(
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
    return "_CookieStoreProxyImpl($superString)";
  }
}


class _CookieStoreProxyCalls implements CookieStore {
  _CookieStoreProxyImpl _proxyImpl;

  _CookieStoreProxyCalls(this._proxyImpl);
    dynamic get(String url,[Function responseFactory = null]) {
      var params = new _CookieStoreGetParams();
      params.url = url;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _CookieStore_getName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic set(String url,String cookie,[Function responseFactory = null]) {
      var params = new _CookieStoreSetParams();
      params.url = url;
      params.cookie = cookie;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _CookieStore_setName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class CookieStoreProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  CookieStore ptr;

  CookieStoreProxy(_CookieStoreProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _CookieStoreProxyCalls(proxyImpl);

  CookieStoreProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _CookieStoreProxyImpl.fromEndpoint(endpoint) {
    ptr = new _CookieStoreProxyCalls(impl);
  }

  CookieStoreProxy.fromHandle(core.MojoHandle handle) :
      impl = new _CookieStoreProxyImpl.fromHandle(handle) {
    ptr = new _CookieStoreProxyCalls(impl);
  }

  CookieStoreProxy.unbound() :
      impl = new _CookieStoreProxyImpl.unbound() {
    ptr = new _CookieStoreProxyCalls(impl);
  }

  factory CookieStoreProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    CookieStoreProxy p = new CookieStoreProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static CookieStoreProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CookieStoreProxy"));
    return new CookieStoreProxy.fromEndpoint(endpoint);
  }

  String get serviceName => CookieStore.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "CookieStoreProxy($impl)";
  }
}


class CookieStoreStub extends bindings.Stub {
  CookieStore _impl = null;

  CookieStoreStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  CookieStoreStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  CookieStoreStub.unbound() : super.unbound();

  static CookieStoreStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CookieStoreStub"));
    return new CookieStoreStub.fromEndpoint(endpoint);
  }


  CookieStoreGetResponseParams _CookieStoreGetResponseParamsFactory(String cookies) {
    var mojo_factory_result = new CookieStoreGetResponseParams();
    mojo_factory_result.cookies = cookies;
    return mojo_factory_result;
  }
  CookieStoreSetResponseParams _CookieStoreSetResponseParamsFactory(bool success) {
    var mojo_factory_result = new CookieStoreSetResponseParams();
    mojo_factory_result.success = success;
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
      case _CookieStore_getName:
        var params = _CookieStoreGetParams.deserialize(
            message.payload);
        var response = _impl.get(params.url,_CookieStoreGetResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _CookieStore_getName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _CookieStore_getName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _CookieStore_setName:
        var params = _CookieStoreSetParams.deserialize(
            message.payload);
        var response = _impl.set(params.url,params.cookie,_CookieStoreSetResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _CookieStore_setName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _CookieStore_setName,
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

  CookieStore get impl => _impl;
  set impl(CookieStore d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "CookieStoreStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _CookieStoreServiceDescription();
}



