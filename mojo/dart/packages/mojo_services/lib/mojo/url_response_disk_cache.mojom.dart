// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library url_response_disk_cache_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/url_response.mojom.dart' as url_response_mojom;



class UrlResponseDiskCacheGetParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String url = null;

  UrlResponseDiskCacheGetParams() : super(kVersions.last.size);

  static UrlResponseDiskCacheGetParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UrlResponseDiskCacheGetParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UrlResponseDiskCacheGetParams result = new UrlResponseDiskCacheGetParams();

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
    return "UrlResponseDiskCacheGetParams("
           "url: $url" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["url"] = url;
    return map;
  }
}


class UrlResponseDiskCacheGetResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  url_response_mojom.UrlResponse response = null;
  List<int> filePath = null;
  List<int> cacheDirPath = null;

  UrlResponseDiskCacheGetResponseParams() : super(kVersions.last.size);

  static UrlResponseDiskCacheGetResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UrlResponseDiskCacheGetResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UrlResponseDiskCacheGetResponseParams result = new UrlResponseDiskCacheGetResponseParams();

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
      result.response = url_response_mojom.UrlResponse.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.filePath = decoder0.decodeUint8Array(16, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 0) {
      
      result.cacheDirPath = decoder0.decodeUint8Array(24, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(response, 8, true);
    
    encoder0.encodeUint8Array(filePath, 16, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    
    encoder0.encodeUint8Array(cacheDirPath, 24, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
  }

  String toString() {
    return "UrlResponseDiskCacheGetResponseParams("
           "response: $response" ", "
           "filePath: $filePath" ", "
           "cacheDirPath: $cacheDirPath" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class UrlResponseDiskCacheValidateParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String url = null;

  UrlResponseDiskCacheValidateParams() : super(kVersions.last.size);

  static UrlResponseDiskCacheValidateParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UrlResponseDiskCacheValidateParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UrlResponseDiskCacheValidateParams result = new UrlResponseDiskCacheValidateParams();

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
    return "UrlResponseDiskCacheValidateParams("
           "url: $url" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["url"] = url;
    return map;
  }
}


class UrlResponseDiskCacheUpdateParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  url_response_mojom.UrlResponse response = null;

  UrlResponseDiskCacheUpdateParams() : super(kVersions.last.size);

  static UrlResponseDiskCacheUpdateParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UrlResponseDiskCacheUpdateParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UrlResponseDiskCacheUpdateParams result = new UrlResponseDiskCacheUpdateParams();

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
    
    encoder0.encodeStruct(response, 8, false);
  }

  String toString() {
    return "UrlResponseDiskCacheUpdateParams("
           "response: $response" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class UrlResponseDiskCacheUpdateAndGetParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  url_response_mojom.UrlResponse response = null;

  UrlResponseDiskCacheUpdateAndGetParams() : super(kVersions.last.size);

  static UrlResponseDiskCacheUpdateAndGetParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UrlResponseDiskCacheUpdateAndGetParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UrlResponseDiskCacheUpdateAndGetParams result = new UrlResponseDiskCacheUpdateAndGetParams();

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
    
    encoder0.encodeStruct(response, 8, false);
  }

  String toString() {
    return "UrlResponseDiskCacheUpdateAndGetParams("
           "response: $response" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class UrlResponseDiskCacheUpdateAndGetResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  List<int> filePath = null;
  List<int> cacheDirPath = null;

  UrlResponseDiskCacheUpdateAndGetResponseParams() : super(kVersions.last.size);

  static UrlResponseDiskCacheUpdateAndGetResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UrlResponseDiskCacheUpdateAndGetResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UrlResponseDiskCacheUpdateAndGetResponseParams result = new UrlResponseDiskCacheUpdateAndGetResponseParams();

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
      
      result.filePath = decoder0.decodeUint8Array(8, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 0) {
      
      result.cacheDirPath = decoder0.decodeUint8Array(16, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint8Array(filePath, 8, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    
    encoder0.encodeUint8Array(cacheDirPath, 16, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
  }

  String toString() {
    return "UrlResponseDiskCacheUpdateAndGetResponseParams("
           "filePath: $filePath" ", "
           "cacheDirPath: $cacheDirPath" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["filePath"] = filePath;
    map["cacheDirPath"] = cacheDirPath;
    return map;
  }
}


class UrlResponseDiskCacheUpdateAndGetExtractedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  url_response_mojom.UrlResponse response = null;

  UrlResponseDiskCacheUpdateAndGetExtractedParams() : super(kVersions.last.size);

  static UrlResponseDiskCacheUpdateAndGetExtractedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UrlResponseDiskCacheUpdateAndGetExtractedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UrlResponseDiskCacheUpdateAndGetExtractedParams result = new UrlResponseDiskCacheUpdateAndGetExtractedParams();

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
    
    encoder0.encodeStruct(response, 8, false);
  }

  String toString() {
    return "UrlResponseDiskCacheUpdateAndGetExtractedParams("
           "response: $response" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class UrlResponseDiskCacheUpdateAndGetExtractedResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  List<int> extractedDirPath = null;
  List<int> cacheDirPath = null;

  UrlResponseDiskCacheUpdateAndGetExtractedResponseParams() : super(kVersions.last.size);

  static UrlResponseDiskCacheUpdateAndGetExtractedResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UrlResponseDiskCacheUpdateAndGetExtractedResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UrlResponseDiskCacheUpdateAndGetExtractedResponseParams result = new UrlResponseDiskCacheUpdateAndGetExtractedResponseParams();

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
      
      result.extractedDirPath = decoder0.decodeUint8Array(8, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 0) {
      
      result.cacheDirPath = decoder0.decodeUint8Array(16, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint8Array(extractedDirPath, 8, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    
    encoder0.encodeUint8Array(cacheDirPath, 16, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
  }

  String toString() {
    return "UrlResponseDiskCacheUpdateAndGetExtractedResponseParams("
           "extractedDirPath: $extractedDirPath" ", "
           "cacheDirPath: $cacheDirPath" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["extractedDirPath"] = extractedDirPath;
    map["cacheDirPath"] = cacheDirPath;
    return map;
  }
}

const int kUrlResponseDiskCache_get_name = 0;
const int kUrlResponseDiskCache_validate_name = 1;
const int kUrlResponseDiskCache_update_name = 2;
const int kUrlResponseDiskCache_updateAndGet_name = 3;
const int kUrlResponseDiskCache_updateAndGetExtracted_name = 4;
const String UrlResponseDiskCacheName = "mojo::URLResponseDiskCache";

abstract class UrlResponseDiskCache {
  dynamic get(String url,[Function responseFactory = null]);
  void validate(String url);
  void update(url_response_mojom.UrlResponse response);
  dynamic updateAndGet(url_response_mojom.UrlResponse response,[Function responseFactory = null]);
  dynamic updateAndGetExtracted(url_response_mojom.UrlResponse response,[Function responseFactory = null]);

}


class UrlResponseDiskCacheProxyImpl extends bindings.Proxy {
  UrlResponseDiskCacheProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  UrlResponseDiskCacheProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  UrlResponseDiskCacheProxyImpl.unbound() : super.unbound();

  static UrlResponseDiskCacheProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For UrlResponseDiskCacheProxyImpl"));
    return new UrlResponseDiskCacheProxyImpl.fromEndpoint(endpoint);
  }

  String get name => UrlResponseDiskCacheName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case kUrlResponseDiskCache_get_name:
        var r = UrlResponseDiskCacheGetResponseParams.deserialize(
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
      case kUrlResponseDiskCache_updateAndGet_name:
        var r = UrlResponseDiskCacheUpdateAndGetResponseParams.deserialize(
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
      case kUrlResponseDiskCache_updateAndGetExtracted_name:
        var r = UrlResponseDiskCacheUpdateAndGetExtractedResponseParams.deserialize(
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
    return "UrlResponseDiskCacheProxyImpl($superString)";
  }
}


class _UrlResponseDiskCacheProxyCalls implements UrlResponseDiskCache {
  UrlResponseDiskCacheProxyImpl _proxyImpl;

  _UrlResponseDiskCacheProxyCalls(this._proxyImpl);
    dynamic get(String url,[Function responseFactory = null]) {
      var params = new UrlResponseDiskCacheGetParams();
      params.url = url;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kUrlResponseDiskCache_get_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    void validate(String url) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new UrlResponseDiskCacheValidateParams();
      params.url = url;
      _proxyImpl.sendMessage(params, kUrlResponseDiskCache_validate_name);
    }
  
    void update(url_response_mojom.UrlResponse response) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new UrlResponseDiskCacheUpdateParams();
      params.response = response;
      _proxyImpl.sendMessage(params, kUrlResponseDiskCache_update_name);
    }
  
    dynamic updateAndGet(url_response_mojom.UrlResponse response,[Function responseFactory = null]) {
      var params = new UrlResponseDiskCacheUpdateAndGetParams();
      params.response = response;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kUrlResponseDiskCache_updateAndGet_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic updateAndGetExtracted(url_response_mojom.UrlResponse response,[Function responseFactory = null]) {
      var params = new UrlResponseDiskCacheUpdateAndGetExtractedParams();
      params.response = response;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kUrlResponseDiskCache_updateAndGetExtracted_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class UrlResponseDiskCacheProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  UrlResponseDiskCache ptr;
  final String name = UrlResponseDiskCacheName;

  UrlResponseDiskCacheProxy(UrlResponseDiskCacheProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _UrlResponseDiskCacheProxyCalls(proxyImpl);

  UrlResponseDiskCacheProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new UrlResponseDiskCacheProxyImpl.fromEndpoint(endpoint) {
    ptr = new _UrlResponseDiskCacheProxyCalls(impl);
  }

  UrlResponseDiskCacheProxy.fromHandle(core.MojoHandle handle) :
      impl = new UrlResponseDiskCacheProxyImpl.fromHandle(handle) {
    ptr = new _UrlResponseDiskCacheProxyCalls(impl);
  }

  UrlResponseDiskCacheProxy.unbound() :
      impl = new UrlResponseDiskCacheProxyImpl.unbound() {
    ptr = new _UrlResponseDiskCacheProxyCalls(impl);
  }

  factory UrlResponseDiskCacheProxy.connectToService(
      bindings.ServiceConnector s, String url) {
    UrlResponseDiskCacheProxy p = new UrlResponseDiskCacheProxy.unbound();
    s.connectToService(url, p);
    return p;
  }

  static UrlResponseDiskCacheProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For UrlResponseDiskCacheProxy"));
    return new UrlResponseDiskCacheProxy.fromEndpoint(endpoint);
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
    return "UrlResponseDiskCacheProxy($impl)";
  }
}


class UrlResponseDiskCacheStub extends bindings.Stub {
  UrlResponseDiskCache _impl = null;

  UrlResponseDiskCacheStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  UrlResponseDiskCacheStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  UrlResponseDiskCacheStub.unbound() : super.unbound();

  static UrlResponseDiskCacheStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For UrlResponseDiskCacheStub"));
    return new UrlResponseDiskCacheStub.fromEndpoint(endpoint);
  }

  static const String name = UrlResponseDiskCacheName;


  UrlResponseDiskCacheGetResponseParams _UrlResponseDiskCacheGetResponseParamsFactory(url_response_mojom.UrlResponse response, List<int> filePath, List<int> cacheDirPath) {
    var mojo_factory_result = new UrlResponseDiskCacheGetResponseParams();
    mojo_factory_result.response = response;
    mojo_factory_result.filePath = filePath;
    mojo_factory_result.cacheDirPath = cacheDirPath;
    return mojo_factory_result;
  }
  UrlResponseDiskCacheUpdateAndGetResponseParams _UrlResponseDiskCacheUpdateAndGetResponseParamsFactory(List<int> filePath, List<int> cacheDirPath) {
    var mojo_factory_result = new UrlResponseDiskCacheUpdateAndGetResponseParams();
    mojo_factory_result.filePath = filePath;
    mojo_factory_result.cacheDirPath = cacheDirPath;
    return mojo_factory_result;
  }
  UrlResponseDiskCacheUpdateAndGetExtractedResponseParams _UrlResponseDiskCacheUpdateAndGetExtractedResponseParamsFactory(List<int> extractedDirPath, List<int> cacheDirPath) {
    var mojo_factory_result = new UrlResponseDiskCacheUpdateAndGetExtractedResponseParams();
    mojo_factory_result.extractedDirPath = extractedDirPath;
    mojo_factory_result.cacheDirPath = cacheDirPath;
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
      case kUrlResponseDiskCache_get_name:
        var params = UrlResponseDiskCacheGetParams.deserialize(
            message.payload);
        var response = _impl.get(params.url,_UrlResponseDiskCacheGetResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kUrlResponseDiskCache_get_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kUrlResponseDiskCache_get_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kUrlResponseDiskCache_validate_name:
        var params = UrlResponseDiskCacheValidateParams.deserialize(
            message.payload);
        _impl.validate(params.url);
        break;
      case kUrlResponseDiskCache_update_name:
        var params = UrlResponseDiskCacheUpdateParams.deserialize(
            message.payload);
        _impl.update(params.response);
        break;
      case kUrlResponseDiskCache_updateAndGet_name:
        var params = UrlResponseDiskCacheUpdateAndGetParams.deserialize(
            message.payload);
        var response = _impl.updateAndGet(params.response,_UrlResponseDiskCacheUpdateAndGetResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kUrlResponseDiskCache_updateAndGet_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kUrlResponseDiskCache_updateAndGet_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kUrlResponseDiskCache_updateAndGetExtracted_name:
        var params = UrlResponseDiskCacheUpdateAndGetExtractedParams.deserialize(
            message.payload);
        var response = _impl.updateAndGetExtracted(params.response,_UrlResponseDiskCacheUpdateAndGetExtractedResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kUrlResponseDiskCache_updateAndGetExtracted_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kUrlResponseDiskCache_updateAndGetExtracted_name,
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

  UrlResponseDiskCache get impl => _impl;
  set impl(UrlResponseDiskCache d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "UrlResponseDiskCacheStub($superString)";
  }

  int get version => 0;
}


