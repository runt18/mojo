// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library compositor_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/geometry.mojom.dart' as geometry_mojom;
import 'package:mojo_services/mojo/context_provider.mojom.dart' as context_provider_mojom;
import 'package:mojo_services/mojo/gfx/composition/scene_token.mojom.dart' as scene_token_mojom;
import 'package:mojo_services/mojo/gfx/composition/scenes.mojom.dart' as scenes_mojom;
import 'package:mojo_services/mojo/gfx/composition/renderers.mojom.dart' as renderers_mojom;
const int kLabelMaxLength = 32;



class _CompositorCreateSceneParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  Object scene = null;
  String label = null;

  _CompositorCreateSceneParams() : super(kVersions.last.size);

  static _CompositorCreateSceneParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CompositorCreateSceneParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CompositorCreateSceneParams result = new _CompositorCreateSceneParams();

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
      
      result.scene = decoder0.decodeInterfaceRequest(8, false, scenes_mojom.SceneStub.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.label = decoder0.decodeString(16, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInterfaceRequest(scene, 8, false);
    
    encoder0.encodeString(label, 16, true);
  }

  String toString() {
    return "_CompositorCreateSceneParams("
           "scene: $scene" ", "
           "label: $label" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




class CompositorCreateSceneResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  scene_token_mojom.SceneToken sceneToken = null;

  CompositorCreateSceneResponseParams() : super(kVersions.last.size);

  static CompositorCreateSceneResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static CompositorCreateSceneResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    CompositorCreateSceneResponseParams result = new CompositorCreateSceneResponseParams();

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
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(sceneToken, 8, false);
  }

  String toString() {
    return "CompositorCreateSceneResponseParams("
           "sceneToken: $sceneToken" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["sceneToken"] = sceneToken;
    return map;
  }
}




class _CompositorCreateRendererParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  Object contextProvider = null;
  Object renderer = null;
  String label = null;

  _CompositorCreateRendererParams() : super(kVersions.last.size);

  static _CompositorCreateRendererParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CompositorCreateRendererParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CompositorCreateRendererParams result = new _CompositorCreateRendererParams();

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
      
      result.contextProvider = decoder0.decodeServiceInterface(8, false, context_provider_mojom.ContextProviderProxy.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.renderer = decoder0.decodeInterfaceRequest(16, false, renderers_mojom.RendererStub.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.label = decoder0.decodeString(24, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInterface(contextProvider, 8, false);
    
    encoder0.encodeInterfaceRequest(renderer, 16, false);
    
    encoder0.encodeString(label, 24, true);
  }

  String toString() {
    return "_CompositorCreateRendererParams("
           "contextProvider: $contextProvider" ", "
           "renderer: $renderer" ", "
           "label: $label" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




const int _Compositor_createSceneName = 0;
const int _Compositor_createRendererName = 1;



class _CompositorServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class Compositor {
  static const String serviceName = "mojo::gfx::composition::Compositor";
  dynamic createScene(Object scene,String label,[Function responseFactory = null]);
  void createRenderer(Object contextProvider, Object renderer, String label);
}


class _CompositorProxyImpl extends bindings.Proxy {
  _CompositorProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _CompositorProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _CompositorProxyImpl.unbound() : super.unbound();

  static _CompositorProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _CompositorProxyImpl"));
    return new _CompositorProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _CompositorServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _Compositor_createSceneName:
        var r = CompositorCreateSceneResponseParams.deserialize(
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
    return "_CompositorProxyImpl($superString)";
  }
}


class _CompositorProxyCalls implements Compositor {
  _CompositorProxyImpl _proxyImpl;

  _CompositorProxyCalls(this._proxyImpl);
    dynamic createScene(Object scene,String label,[Function responseFactory = null]) {
      var params = new _CompositorCreateSceneParams();
      params.scene = scene;
      params.label = label;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _Compositor_createSceneName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    void createRenderer(Object contextProvider, Object renderer, String label) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _CompositorCreateRendererParams();
      params.contextProvider = contextProvider;
      params.renderer = renderer;
      params.label = label;
      _proxyImpl.sendMessage(params, _Compositor_createRendererName);
    }
}


class CompositorProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  Compositor ptr;

  CompositorProxy(_CompositorProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _CompositorProxyCalls(proxyImpl);

  CompositorProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _CompositorProxyImpl.fromEndpoint(endpoint) {
    ptr = new _CompositorProxyCalls(impl);
  }

  CompositorProxy.fromHandle(core.MojoHandle handle) :
      impl = new _CompositorProxyImpl.fromHandle(handle) {
    ptr = new _CompositorProxyCalls(impl);
  }

  CompositorProxy.unbound() :
      impl = new _CompositorProxyImpl.unbound() {
    ptr = new _CompositorProxyCalls(impl);
  }

  factory CompositorProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    CompositorProxy p = new CompositorProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static CompositorProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CompositorProxy"));
    return new CompositorProxy.fromEndpoint(endpoint);
  }

  String get serviceName => Compositor.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "CompositorProxy($impl)";
  }
}


class CompositorStub extends bindings.Stub {
  Compositor _impl = null;

  CompositorStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  CompositorStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  CompositorStub.unbound() : super.unbound();

  static CompositorStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CompositorStub"));
    return new CompositorStub.fromEndpoint(endpoint);
  }


  CompositorCreateSceneResponseParams _CompositorCreateSceneResponseParamsFactory(scene_token_mojom.SceneToken sceneToken) {
    var mojo_factory_result = new CompositorCreateSceneResponseParams();
    mojo_factory_result.sceneToken = sceneToken;
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
      case _Compositor_createSceneName:
        var params = _CompositorCreateSceneParams.deserialize(
            message.payload);
        var response = _impl.createScene(params.scene,params.label,_CompositorCreateSceneResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _Compositor_createSceneName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _Compositor_createSceneName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _Compositor_createRendererName:
        var params = _CompositorCreateRendererParams.deserialize(
            message.payload);
        _impl.createRenderer(params.contextProvider, params.renderer, params.label);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  Compositor get impl => _impl;
  set impl(Compositor d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "CompositorStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _CompositorServiceDescription();
}



