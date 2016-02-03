// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library navigation_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo/mojo/url_request.mojom.dart' as url_request_mojom;

class Target extends bindings.MojoEnum {
  static const Target default_ = const Target._(0);
  static const Target sourceNode = const Target._(1);
  static const Target newNode = const Target._(2);

  const Target._(int v) : super(v);

  static const Map<String, Target> valuesMap = const {
    "default_": default_,
    "sourceNode": sourceNode,
    "newNode": newNode,
  };
  static const List<Target> values = const [
    default_,
    sourceNode,
    newNode,
  ];

  static Target valueOf(String name) => valuesMap[name];

  factory Target(int v) {
    switch (v) {
      case 0:
        return default_;
      case 1:
        return sourceNode;
      case 2:
        return newNode;
      default:
        return null;
    }
  }

  static Target decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    Target result = new Target(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum Target.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case default_:
        return 'Target.default_';
      case sourceNode:
        return 'Target.sourceNode';
      case newNode:
        return 'Target.newNode';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}





class _NavigatorHostRequestNavigateParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  Target target = null;
  url_request_mojom.UrlRequest request = null;

  _NavigatorHostRequestNavigateParams() : super(kVersions.last.size);

  static _NavigatorHostRequestNavigateParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _NavigatorHostRequestNavigateParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _NavigatorHostRequestNavigateParams result = new _NavigatorHostRequestNavigateParams();

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
      
        result.target = Target.decode(decoder0, 8);
        if (result.target == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable Target.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.request = url_request_mojom.UrlRequest.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(target, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "target of struct _NavigatorHostRequestNavigateParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(request, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "request of struct _NavigatorHostRequestNavigateParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_NavigatorHostRequestNavigateParams("
           "target: $target" ", "
           "request: $request" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




class _NavigatorHostRequestNavigateHistoryParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int delta = 0;

  _NavigatorHostRequestNavigateHistoryParams() : super(kVersions.last.size);

  static _NavigatorHostRequestNavigateHistoryParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _NavigatorHostRequestNavigateHistoryParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _NavigatorHostRequestNavigateHistoryParams result = new _NavigatorHostRequestNavigateHistoryParams();

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
      
      result.delta = decoder0.decodeInt32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(delta, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "delta of struct _NavigatorHostRequestNavigateHistoryParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_NavigatorHostRequestNavigateHistoryParams("
           "delta: $delta" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["delta"] = delta;
    return map;
  }
}




class _NavigatorHostDidNavigateLocallyParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String url = null;

  _NavigatorHostDidNavigateLocallyParams() : super(kVersions.last.size);

  static _NavigatorHostDidNavigateLocallyParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _NavigatorHostDidNavigateLocallyParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _NavigatorHostDidNavigateLocallyParams result = new _NavigatorHostDidNavigateLocallyParams();

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
    try {
      encoder0.encodeString(url, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "url of struct _NavigatorHostDidNavigateLocallyParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_NavigatorHostDidNavigateLocallyParams("
           "url: $url" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["url"] = url;
    return map;
  }
}




const int _NavigatorHost_requestNavigateName = 0;
const int _NavigatorHost_requestNavigateHistoryName = 1;
const int _NavigatorHost_didNavigateLocallyName = 2;



class _NavigatorHostServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class NavigatorHost {
  static const String serviceName = "mojo::NavigatorHost";
  void requestNavigate(Target target, url_request_mojom.UrlRequest request);
  void requestNavigateHistory(int delta);
  void didNavigateLocally(String url);
}


class _NavigatorHostProxyImpl extends bindings.Proxy {
  _NavigatorHostProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _NavigatorHostProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _NavigatorHostProxyImpl.unbound() : super.unbound();

  static _NavigatorHostProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _NavigatorHostProxyImpl"));
    return new _NavigatorHostProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _NavigatorHostServiceDescription();

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
    return "_NavigatorHostProxyImpl($superString)";
  }
}


class _NavigatorHostProxyCalls implements NavigatorHost {
  _NavigatorHostProxyImpl _proxyImpl;

  _NavigatorHostProxyCalls(this._proxyImpl);
    void requestNavigate(Target target, url_request_mojom.UrlRequest request) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _NavigatorHostRequestNavigateParams();
      params.target = target;
      params.request = request;
      _proxyImpl.sendMessage(params, _NavigatorHost_requestNavigateName);
    }
    void requestNavigateHistory(int delta) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _NavigatorHostRequestNavigateHistoryParams();
      params.delta = delta;
      _proxyImpl.sendMessage(params, _NavigatorHost_requestNavigateHistoryName);
    }
    void didNavigateLocally(String url) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _NavigatorHostDidNavigateLocallyParams();
      params.url = url;
      _proxyImpl.sendMessage(params, _NavigatorHost_didNavigateLocallyName);
    }
}


class NavigatorHostProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  NavigatorHost ptr;

  NavigatorHostProxy(_NavigatorHostProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _NavigatorHostProxyCalls(proxyImpl);

  NavigatorHostProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _NavigatorHostProxyImpl.fromEndpoint(endpoint) {
    ptr = new _NavigatorHostProxyCalls(impl);
  }

  NavigatorHostProxy.fromHandle(core.MojoHandle handle) :
      impl = new _NavigatorHostProxyImpl.fromHandle(handle) {
    ptr = new _NavigatorHostProxyCalls(impl);
  }

  NavigatorHostProxy.unbound() :
      impl = new _NavigatorHostProxyImpl.unbound() {
    ptr = new _NavigatorHostProxyCalls(impl);
  }

  factory NavigatorHostProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    NavigatorHostProxy p = new NavigatorHostProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static NavigatorHostProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NavigatorHostProxy"));
    return new NavigatorHostProxy.fromEndpoint(endpoint);
  }

  String get serviceName => NavigatorHost.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "NavigatorHostProxy($impl)";
  }
}


class NavigatorHostStub extends bindings.Stub {
  NavigatorHost _impl = null;

  NavigatorHostStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  NavigatorHostStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  NavigatorHostStub.unbound() : super.unbound();

  static NavigatorHostStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NavigatorHostStub"));
    return new NavigatorHostStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _NavigatorHost_requestNavigateName:
        var params = _NavigatorHostRequestNavigateParams.deserialize(
            message.payload);
        _impl.requestNavigate(params.target, params.request);
        break;
      case _NavigatorHost_requestNavigateHistoryName:
        var params = _NavigatorHostRequestNavigateHistoryParams.deserialize(
            message.payload);
        _impl.requestNavigateHistory(params.delta);
        break;
      case _NavigatorHost_didNavigateLocallyName:
        var params = _NavigatorHostDidNavigateLocallyParams.deserialize(
            message.payload);
        _impl.didNavigateLocally(params.url);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  NavigatorHost get impl => _impl;
  set impl(NavigatorHost d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "NavigatorHostStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _NavigatorHostServiceDescription();
}



