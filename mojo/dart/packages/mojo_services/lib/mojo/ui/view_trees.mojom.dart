// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library view_trees_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/service_provider.mojom.dart' as service_provider_mojom;
import 'package:mojo_services/mojo/ui/layouts.mojom.dart' as layouts_mojom;
import 'package:mojo_services/mojo/ui/views.mojom.dart' as views_mojom;



class ViewTreeToken extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int value = 0;

  ViewTreeToken() : super(kVersions.last.size);

  static ViewTreeToken deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewTreeToken decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewTreeToken result = new ViewTreeToken();

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
      
      result.value = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(value, 8);
  }

  String toString() {
    return "ViewTreeToken("
           "value: $value" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["value"] = value;
    return map;
  }
}


class _ViewTreeOnLayoutParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _ViewTreeOnLayoutParams() : super(kVersions.last.size);

  static _ViewTreeOnLayoutParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewTreeOnLayoutParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewTreeOnLayoutParams result = new _ViewTreeOnLayoutParams();

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
    return "_ViewTreeOnLayoutParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class ViewTreeOnLayoutResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  ViewTreeOnLayoutResponseParams() : super(kVersions.last.size);

  static ViewTreeOnLayoutResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewTreeOnLayoutResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewTreeOnLayoutResponseParams result = new ViewTreeOnLayoutResponseParams();

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
    return "ViewTreeOnLayoutResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _ViewTreeOnRootUnavailableParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int rootKey = 0;

  _ViewTreeOnRootUnavailableParams() : super(kVersions.last.size);

  static _ViewTreeOnRootUnavailableParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewTreeOnRootUnavailableParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewTreeOnRootUnavailableParams result = new _ViewTreeOnRootUnavailableParams();

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
      
      result.rootKey = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(rootKey, 8);
  }

  String toString() {
    return "_ViewTreeOnRootUnavailableParams("
           "rootKey: $rootKey" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["rootKey"] = rootKey;
    return map;
  }
}


class ViewTreeOnRootUnavailableResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  ViewTreeOnRootUnavailableResponseParams() : super(kVersions.last.size);

  static ViewTreeOnRootUnavailableResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewTreeOnRootUnavailableResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewTreeOnRootUnavailableResponseParams result = new ViewTreeOnRootUnavailableResponseParams();

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
    return "ViewTreeOnRootUnavailableResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _ViewTreeHostGetServiceProviderParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object serviceProvider = null;

  _ViewTreeHostGetServiceProviderParams() : super(kVersions.last.size);

  static _ViewTreeHostGetServiceProviderParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewTreeHostGetServiceProviderParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewTreeHostGetServiceProviderParams result = new _ViewTreeHostGetServiceProviderParams();

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
      
      result.serviceProvider = decoder0.decodeInterfaceRequest(8, false, service_provider_mojom.ServiceProviderStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInterfaceRequest(serviceProvider, 8, false);
  }

  String toString() {
    return "_ViewTreeHostGetServiceProviderParams("
           "serviceProvider: $serviceProvider" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _ViewTreeHostRequestLayoutParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _ViewTreeHostRequestLayoutParams() : super(kVersions.last.size);

  static _ViewTreeHostRequestLayoutParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewTreeHostRequestLayoutParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewTreeHostRequestLayoutParams result = new _ViewTreeHostRequestLayoutParams();

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
    return "_ViewTreeHostRequestLayoutParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _ViewTreeHostSetRootParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int rootKey = 0;
  views_mojom.ViewToken rootViewToken = null;

  _ViewTreeHostSetRootParams() : super(kVersions.last.size);

  static _ViewTreeHostSetRootParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewTreeHostSetRootParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewTreeHostSetRootParams result = new _ViewTreeHostSetRootParams();

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
      
      result.rootKey = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.rootViewToken = views_mojom.ViewToken.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(rootKey, 8);
    
    encoder0.encodeStruct(rootViewToken, 16, false);
  }

  String toString() {
    return "_ViewTreeHostSetRootParams("
           "rootKey: $rootKey" ", "
           "rootViewToken: $rootViewToken" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["rootKey"] = rootKey;
    map["rootViewToken"] = rootViewToken;
    return map;
  }
}


class _ViewTreeHostResetRootParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _ViewTreeHostResetRootParams() : super(kVersions.last.size);

  static _ViewTreeHostResetRootParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewTreeHostResetRootParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewTreeHostResetRootParams result = new _ViewTreeHostResetRootParams();

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
    return "_ViewTreeHostResetRootParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _ViewTreeHostLayoutRootParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  layouts_mojom.ViewLayoutParams rootLayoutParams = null;

  _ViewTreeHostLayoutRootParams() : super(kVersions.last.size);

  static _ViewTreeHostLayoutRootParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewTreeHostLayoutRootParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewTreeHostLayoutRootParams result = new _ViewTreeHostLayoutRootParams();

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
      result.rootLayoutParams = layouts_mojom.ViewLayoutParams.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(rootLayoutParams, 8, false);
  }

  String toString() {
    return "_ViewTreeHostLayoutRootParams("
           "rootLayoutParams: $rootLayoutParams" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["rootLayoutParams"] = rootLayoutParams;
    return map;
  }
}


class ViewTreeHostLayoutRootResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  layouts_mojom.ViewLayoutInfo info = null;

  ViewTreeHostLayoutRootResponseParams() : super(kVersions.last.size);

  static ViewTreeHostLayoutRootResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewTreeHostLayoutRootResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewTreeHostLayoutRootResponseParams result = new ViewTreeHostLayoutRootResponseParams();

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
      result.info = layouts_mojom.ViewLayoutInfo.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(info, 8, true);
  }

  String toString() {
    return "ViewTreeHostLayoutRootResponseParams("
           "info: $info" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["info"] = info;
    return map;
  }
}

const int _ViewTree_onLayoutName = 0;
const int _ViewTree_onRootUnavailableName = 1;

abstract class ViewTree {
  static const String serviceName = null;
  dynamic onLayout([Function responseFactory = null]);
  dynamic onRootUnavailable(int rootKey,[Function responseFactory = null]);
}


class _ViewTreeProxyImpl extends bindings.Proxy {
  _ViewTreeProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ViewTreeProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _ViewTreeProxyImpl.unbound() : super.unbound();

  static _ViewTreeProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _ViewTreeProxyImpl"));
    return new _ViewTreeProxyImpl.fromEndpoint(endpoint);
  }

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _ViewTree_onLayoutName:
        var r = ViewTreeOnLayoutResponseParams.deserialize(
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
      case _ViewTree_onRootUnavailableName:
        var r = ViewTreeOnRootUnavailableResponseParams.deserialize(
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
    return "_ViewTreeProxyImpl($superString)";
  }
}


class _ViewTreeProxyCalls implements ViewTree {
  _ViewTreeProxyImpl _proxyImpl;

  _ViewTreeProxyCalls(this._proxyImpl);
    dynamic onLayout([Function responseFactory = null]) {
      var params = new _ViewTreeOnLayoutParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _ViewTree_onLayoutName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic onRootUnavailable(int rootKey,[Function responseFactory = null]) {
      var params = new _ViewTreeOnRootUnavailableParams();
      params.rootKey = rootKey;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _ViewTree_onRootUnavailableName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class ViewTreeProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  ViewTree ptr;

  ViewTreeProxy(_ViewTreeProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ViewTreeProxyCalls(proxyImpl);

  ViewTreeProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _ViewTreeProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ViewTreeProxyCalls(impl);
  }

  ViewTreeProxy.fromHandle(core.MojoHandle handle) :
      impl = new _ViewTreeProxyImpl.fromHandle(handle) {
    ptr = new _ViewTreeProxyCalls(impl);
  }

  ViewTreeProxy.unbound() :
      impl = new _ViewTreeProxyImpl.unbound() {
    ptr = new _ViewTreeProxyCalls(impl);
  }

  factory ViewTreeProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ViewTreeProxy p = new ViewTreeProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static ViewTreeProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewTreeProxy"));
    return new ViewTreeProxy.fromEndpoint(endpoint);
  }

  String get serviceName => ViewTree.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "ViewTreeProxy($impl)";
  }
}


class ViewTreeStub extends bindings.Stub {
  ViewTree _impl = null;

  ViewTreeStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  ViewTreeStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  ViewTreeStub.unbound() : super.unbound();

  static ViewTreeStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewTreeStub"));
    return new ViewTreeStub.fromEndpoint(endpoint);
  }


  ViewTreeOnLayoutResponseParams _ViewTreeOnLayoutResponseParamsFactory() {
    var mojo_factory_result = new ViewTreeOnLayoutResponseParams();
    return mojo_factory_result;
  }
  ViewTreeOnRootUnavailableResponseParams _ViewTreeOnRootUnavailableResponseParamsFactory() {
    var mojo_factory_result = new ViewTreeOnRootUnavailableResponseParams();
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
      case _ViewTree_onLayoutName:
        var params = _ViewTreeOnLayoutParams.deserialize(
            message.payload);
        var response = _impl.onLayout(_ViewTreeOnLayoutResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _ViewTree_onLayoutName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _ViewTree_onLayoutName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _ViewTree_onRootUnavailableName:
        var params = _ViewTreeOnRootUnavailableParams.deserialize(
            message.payload);
        var response = _impl.onRootUnavailable(params.rootKey,_ViewTreeOnRootUnavailableResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _ViewTree_onRootUnavailableName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _ViewTree_onRootUnavailableName,
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

  ViewTree get impl => _impl;
  set impl(ViewTree d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "ViewTreeStub($superString)";
  }

  int get version => 0;
}

const int _ViewTreeHost_getServiceProviderName = 0;
const int _ViewTreeHost_requestLayoutName = 1;
const int _ViewTreeHost_setRootName = 2;
const int _ViewTreeHost_resetRootName = 3;
const int _ViewTreeHost_layoutRootName = 4;

abstract class ViewTreeHost {
  static const String serviceName = null;
  void getServiceProvider(Object serviceProvider);
  void requestLayout();
  void setRoot(int rootKey, views_mojom.ViewToken rootViewToken);
  void resetRoot();
  dynamic layoutRoot(layouts_mojom.ViewLayoutParams rootLayoutParams,[Function responseFactory = null]);
}


class _ViewTreeHostProxyImpl extends bindings.Proxy {
  _ViewTreeHostProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ViewTreeHostProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _ViewTreeHostProxyImpl.unbound() : super.unbound();

  static _ViewTreeHostProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _ViewTreeHostProxyImpl"));
    return new _ViewTreeHostProxyImpl.fromEndpoint(endpoint);
  }

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _ViewTreeHost_layoutRootName:
        var r = ViewTreeHostLayoutRootResponseParams.deserialize(
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
    return "_ViewTreeHostProxyImpl($superString)";
  }
}


class _ViewTreeHostProxyCalls implements ViewTreeHost {
  _ViewTreeHostProxyImpl _proxyImpl;

  _ViewTreeHostProxyCalls(this._proxyImpl);
    void getServiceProvider(Object serviceProvider) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ViewTreeHostGetServiceProviderParams();
      params.serviceProvider = serviceProvider;
      _proxyImpl.sendMessage(params, _ViewTreeHost_getServiceProviderName);
    }
    void requestLayout() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ViewTreeHostRequestLayoutParams();
      _proxyImpl.sendMessage(params, _ViewTreeHost_requestLayoutName);
    }
    void setRoot(int rootKey, views_mojom.ViewToken rootViewToken) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ViewTreeHostSetRootParams();
      params.rootKey = rootKey;
      params.rootViewToken = rootViewToken;
      _proxyImpl.sendMessage(params, _ViewTreeHost_setRootName);
    }
    void resetRoot() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ViewTreeHostResetRootParams();
      _proxyImpl.sendMessage(params, _ViewTreeHost_resetRootName);
    }
    dynamic layoutRoot(layouts_mojom.ViewLayoutParams rootLayoutParams,[Function responseFactory = null]) {
      var params = new _ViewTreeHostLayoutRootParams();
      params.rootLayoutParams = rootLayoutParams;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _ViewTreeHost_layoutRootName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class ViewTreeHostProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  ViewTreeHost ptr;

  ViewTreeHostProxy(_ViewTreeHostProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ViewTreeHostProxyCalls(proxyImpl);

  ViewTreeHostProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _ViewTreeHostProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ViewTreeHostProxyCalls(impl);
  }

  ViewTreeHostProxy.fromHandle(core.MojoHandle handle) :
      impl = new _ViewTreeHostProxyImpl.fromHandle(handle) {
    ptr = new _ViewTreeHostProxyCalls(impl);
  }

  ViewTreeHostProxy.unbound() :
      impl = new _ViewTreeHostProxyImpl.unbound() {
    ptr = new _ViewTreeHostProxyCalls(impl);
  }

  factory ViewTreeHostProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ViewTreeHostProxy p = new ViewTreeHostProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static ViewTreeHostProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewTreeHostProxy"));
    return new ViewTreeHostProxy.fromEndpoint(endpoint);
  }

  String get serviceName => ViewTreeHost.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "ViewTreeHostProxy($impl)";
  }
}


class ViewTreeHostStub extends bindings.Stub {
  ViewTreeHost _impl = null;

  ViewTreeHostStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  ViewTreeHostStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  ViewTreeHostStub.unbound() : super.unbound();

  static ViewTreeHostStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewTreeHostStub"));
    return new ViewTreeHostStub.fromEndpoint(endpoint);
  }


  ViewTreeHostLayoutRootResponseParams _ViewTreeHostLayoutRootResponseParamsFactory(layouts_mojom.ViewLayoutInfo info) {
    var mojo_factory_result = new ViewTreeHostLayoutRootResponseParams();
    mojo_factory_result.info = info;
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
      case _ViewTreeHost_getServiceProviderName:
        var params = _ViewTreeHostGetServiceProviderParams.deserialize(
            message.payload);
        _impl.getServiceProvider(params.serviceProvider);
        break;
      case _ViewTreeHost_requestLayoutName:
        var params = _ViewTreeHostRequestLayoutParams.deserialize(
            message.payload);
        _impl.requestLayout();
        break;
      case _ViewTreeHost_setRootName:
        var params = _ViewTreeHostSetRootParams.deserialize(
            message.payload);
        _impl.setRoot(params.rootKey, params.rootViewToken);
        break;
      case _ViewTreeHost_resetRootName:
        var params = _ViewTreeHostResetRootParams.deserialize(
            message.payload);
        _impl.resetRoot();
        break;
      case _ViewTreeHost_layoutRootName:
        var params = _ViewTreeHostLayoutRootParams.deserialize(
            message.payload);
        var response = _impl.layoutRoot(params.rootLayoutParams,_ViewTreeHostLayoutRootResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _ViewTreeHost_layoutRootName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _ViewTreeHost_layoutRootName,
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

  ViewTreeHost get impl => _impl;
  set impl(ViewTreeHost d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "ViewTreeHostStub($superString)";
  }

  int get version => 0;
}


