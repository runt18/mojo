// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library cookie_store_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;



class CookieStoreGetParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String url = null;

  CookieStoreGetParams() : super(kVersions.last.size);

  static CookieStoreGetParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static CookieStoreGetParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    CookieStoreGetParams result = new CookieStoreGetParams();

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
    return "CookieStoreGetParams("
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


class CookieStoreSetParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String url = null;
  String cookie = null;

  CookieStoreSetParams() : super(kVersions.last.size);

  static CookieStoreSetParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static CookieStoreSetParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    CookieStoreSetParams result = new CookieStoreSetParams();

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
    return "CookieStoreSetParams("
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

const int kCookieStore_get_name = 0;
const int kCookieStore_set_name = 1;

const String CookieStoreName =
      'mojo::CookieStore';

abstract class CookieStore {
  dynamic get(String url,[Function responseFactory = null]);
  dynamic set(String url,String cookie,[Function responseFactory = null]);

}


class CookieStoreProxyImpl extends bindings.Proxy {
  CookieStoreProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  CookieStoreProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  CookieStoreProxyImpl.unbound() : super.unbound();

  static CookieStoreProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CookieStoreProxyImpl"));
    return new CookieStoreProxyImpl.fromEndpoint(endpoint);
  }

  String get name => CookieStoreName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case kCookieStore_get_name:
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
      case kCookieStore_set_name:
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
    return "CookieStoreProxyImpl($superString)";
  }
}


class _CookieStoreProxyCalls implements CookieStore {
  CookieStoreProxyImpl _proxyImpl;

  _CookieStoreProxyCalls(this._proxyImpl);
    dynamic get(String url,[Function responseFactory = null]) {
      var params = new CookieStoreGetParams();
      params.url = url;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kCookieStore_get_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic set(String url,String cookie,[Function responseFactory = null]) {
      var params = new CookieStoreSetParams();
      params.url = url;
      params.cookie = cookie;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kCookieStore_set_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class CookieStoreProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  CookieStore ptr;
  final String name = CookieStoreName;

  CookieStoreProxy(CookieStoreProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _CookieStoreProxyCalls(proxyImpl);

  CookieStoreProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new CookieStoreProxyImpl.fromEndpoint(endpoint) {
    ptr = new _CookieStoreProxyCalls(impl);
  }

  CookieStoreProxy.fromHandle(core.MojoHandle handle) :
      impl = new CookieStoreProxyImpl.fromHandle(handle) {
    ptr = new _CookieStoreProxyCalls(impl);
  }

  CookieStoreProxy.unbound() :
      impl = new CookieStoreProxyImpl.unbound() {
    ptr = new _CookieStoreProxyCalls(impl);
  }

  factory CookieStoreProxy.connectToService(
      bindings.ServiceConnector s, String url) {
    CookieStoreProxy p = new CookieStoreProxy.unbound();
    s.connectToService(url, p);
    return p;
  }

  static CookieStoreProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CookieStoreProxy"));
    return new CookieStoreProxy.fromEndpoint(endpoint);
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

  static const String name = CookieStoreName;


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
      case kCookieStore_get_name:
        var params = CookieStoreGetParams.deserialize(
            message.payload);
        var response = _impl.get(params.url,_CookieStoreGetResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kCookieStore_get_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kCookieStore_get_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kCookieStore_set_name:
        var params = CookieStoreSetParams.deserialize(
            message.payload);
        var response = _impl.set(params.url,params.cookie,_CookieStoreSetResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kCookieStore_set_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kCookieStore_set_name,
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
}


