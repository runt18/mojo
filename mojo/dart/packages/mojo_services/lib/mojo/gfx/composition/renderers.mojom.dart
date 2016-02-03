// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library renderers_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/geometry.mojom.dart' as geometry_mojom;
import 'package:mojo_services/mojo/gfx/composition/hit_tests.mojom.dart' as hit_tests_mojom;
import 'package:mojo_services/mojo/gfx/composition/scene_token.mojom.dart' as scene_token_mojom;



class _RendererSetRootSceneParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  scene_token_mojom.SceneToken sceneToken = null;
  int sceneVersion = 0;
  geometry_mojom.Rect viewport = null;

  _RendererSetRootSceneParams() : super(kVersions.last.size);

  static _RendererSetRootSceneParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _RendererSetRootSceneParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _RendererSetRootSceneParams result = new _RendererSetRootSceneParams();

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
      result.sceneToken = scene_token_mojom.SceneToken.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.sceneVersion = decoder0.decodeUint32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, false);
      result.viewport = geometry_mojom.Rect.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(sceneToken, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "sceneToken of struct _RendererSetRootSceneParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(sceneVersion, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "sceneVersion of struct _RendererSetRootSceneParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(viewport, 24, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "viewport of struct _RendererSetRootSceneParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_RendererSetRootSceneParams("
           "sceneToken: $sceneToken" ", "
           "sceneVersion: $sceneVersion" ", "
           "viewport: $viewport" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["sceneToken"] = sceneToken;
    map["sceneVersion"] = sceneVersion;
    map["viewport"] = viewport;
    return map;
  }
}




class _RendererGetHitTesterParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object hitTester = null;

  _RendererGetHitTesterParams() : super(kVersions.last.size);

  static _RendererGetHitTesterParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _RendererGetHitTesterParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _RendererGetHitTesterParams result = new _RendererGetHitTesterParams();

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
      
      result.hitTester = decoder0.decodeInterfaceRequest(8, false, hit_tests_mojom.HitTesterStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(hitTester, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "hitTester of struct _RendererGetHitTesterParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_RendererGetHitTesterParams("
           "hitTester: $hitTester" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




const int _Renderer_setRootSceneName = 0;
const int _Renderer_getHitTesterName = 1;



class _RendererServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class Renderer {
  static const String serviceName = null;
  void setRootScene(scene_token_mojom.SceneToken sceneToken, int sceneVersion, geometry_mojom.Rect viewport);
  void getHitTester(Object hitTester);
}


class _RendererProxyImpl extends bindings.Proxy {
  _RendererProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _RendererProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _RendererProxyImpl.unbound() : super.unbound();

  static _RendererProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _RendererProxyImpl"));
    return new _RendererProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _RendererServiceDescription();

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
    return "_RendererProxyImpl($superString)";
  }
}


class _RendererProxyCalls implements Renderer {
  _RendererProxyImpl _proxyImpl;

  _RendererProxyCalls(this._proxyImpl);
    void setRootScene(scene_token_mojom.SceneToken sceneToken, int sceneVersion, geometry_mojom.Rect viewport) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _RendererSetRootSceneParams();
      params.sceneToken = sceneToken;
      params.sceneVersion = sceneVersion;
      params.viewport = viewport;
      _proxyImpl.sendMessage(params, _Renderer_setRootSceneName);
    }
    void getHitTester(Object hitTester) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _RendererGetHitTesterParams();
      params.hitTester = hitTester;
      _proxyImpl.sendMessage(params, _Renderer_getHitTesterName);
    }
}


class RendererProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  Renderer ptr;

  RendererProxy(_RendererProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _RendererProxyCalls(proxyImpl);

  RendererProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _RendererProxyImpl.fromEndpoint(endpoint) {
    ptr = new _RendererProxyCalls(impl);
  }

  RendererProxy.fromHandle(core.MojoHandle handle) :
      impl = new _RendererProxyImpl.fromHandle(handle) {
    ptr = new _RendererProxyCalls(impl);
  }

  RendererProxy.unbound() :
      impl = new _RendererProxyImpl.unbound() {
    ptr = new _RendererProxyCalls(impl);
  }

  factory RendererProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    RendererProxy p = new RendererProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static RendererProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For RendererProxy"));
    return new RendererProxy.fromEndpoint(endpoint);
  }

  String get serviceName => Renderer.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "RendererProxy($impl)";
  }
}


class RendererStub extends bindings.Stub {
  Renderer _impl = null;

  RendererStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  RendererStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  RendererStub.unbound() : super.unbound();

  static RendererStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For RendererStub"));
    return new RendererStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _Renderer_setRootSceneName:
        var params = _RendererSetRootSceneParams.deserialize(
            message.payload);
        _impl.setRootScene(params.sceneToken, params.sceneVersion, params.viewport);
        break;
      case _Renderer_getHitTesterName:
        var params = _RendererGetHitTesterParams.deserialize(
            message.payload);
        _impl.getHitTester(params.hitTester);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  Renderer get impl => _impl;
  set impl(Renderer d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "RendererStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _RendererServiceDescription();
}



