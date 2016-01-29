// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library resources_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/geometry.mojom.dart' as geometry_mojom;
import 'package:mojo_services/mojo/gfx/composition/scene_token.mojom.dart' as scene_token_mojom;



class SceneResource extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  scene_token_mojom.SceneToken sceneToken = null;

  SceneResource() : super(kVersions.last.size);

  static SceneResource deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SceneResource decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SceneResource result = new SceneResource();

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
    return "SceneResource("
           "sceneToken: $sceneToken" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["sceneToken"] = sceneToken;
    return map;
  }
}




class MailboxTextureResource extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(40, 0)
  ];
  List<int> mailboxName = null;
  int syncPoint = 0;
  geometry_mojom.Size size = null;
  Object callback = null;

  MailboxTextureResource() : super(kVersions.last.size);

  static MailboxTextureResource deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MailboxTextureResource decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MailboxTextureResource result = new MailboxTextureResource();

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
      
      result.mailboxName = decoder0.decodeUint8Array(8, bindings.kNothingNullable, 64);
    }
    if (mainDataHeader.version >= 0) {
      
      result.syncPoint = decoder0.decodeUint32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, false);
      result.size = geometry_mojom.Size.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.callback = decoder0.decodeServiceInterface(32, false, MailboxTextureCallbackProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint8Array(mailboxName, 8, bindings.kNothingNullable, 64);
    
    encoder0.encodeUint32(syncPoint, 16);
    
    encoder0.encodeStruct(size, 24, false);
    
    encoder0.encodeInterface(callback, 32, false);
  }

  String toString() {
    return "MailboxTextureResource("
           "mailboxName: $mailboxName" ", "
           "syncPoint: $syncPoint" ", "
           "size: $size" ", "
           "callback: $callback" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




class _MailboxTextureCallbackOnMailboxTextureReleasedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _MailboxTextureCallbackOnMailboxTextureReleasedParams() : super(kVersions.last.size);

  static _MailboxTextureCallbackOnMailboxTextureReleasedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MailboxTextureCallbackOnMailboxTextureReleasedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MailboxTextureCallbackOnMailboxTextureReleasedParams result = new _MailboxTextureCallbackOnMailboxTextureReleasedParams();

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
    return "_MailboxTextureCallbackOnMailboxTextureReleasedParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}





enum ResourceTag {
  scene,
  mailboxTexture,
  unknown
}

class Resource extends bindings.Union {
  static final _tag_to_int = const {
    ResourceTag.scene: 0,
    ResourceTag.mailboxTexture: 1,
  };

  static final _int_to_tag = const {
    0: ResourceTag.scene,
    1: ResourceTag.mailboxTexture,
  };

  var _data;
  ResourceTag _tag = ResourceTag.unknown;

  ResourceTag get tag => _tag;
  SceneResource get scene {
    if (_tag != ResourceTag.scene) {
      throw new bindings.UnsetUnionTagError(_tag, ResourceTag.scene);
    }
    return _data;
  }

  set scene(SceneResource value) {
    _tag = ResourceTag.scene;
    _data = value;
  }
  MailboxTextureResource get mailboxTexture {
    if (_tag != ResourceTag.mailboxTexture) {
      throw new bindings.UnsetUnionTagError(_tag, ResourceTag.mailboxTexture);
    }
    return _data;
  }

  set mailboxTexture(MailboxTextureResource value) {
    _tag = ResourceTag.mailboxTexture;
    _data = value;
  }

  static Resource decode(bindings.Decoder decoder0, int offset) {
    int size = decoder0.decodeUint32(offset);
    if (size == 0) {
      return null;
    }
    Resource result = new Resource();

    // TODO(azani): Handle unknown union member.
    ResourceTag tag = _int_to_tag[decoder0.decodeUint32(offset + 4)];
    switch (tag) {
      case ResourceTag.scene:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        result.scene = SceneResource.decode(decoder1);
        break;
      case ResourceTag.mailboxTexture:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        result.mailboxTexture = MailboxTextureResource.decode(decoder1);
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $tag");
    }

    return result;
  }

  void encode(bindings.Encoder encoder0, int offset) {
    // TODO(azani): Error when trying to encode an unknown member.
    encoder0.encodeUint32(16, offset);
    encoder0.encodeUint32(_tag_to_int[_tag], offset + 4);
    switch (_tag) {
      case ResourceTag.scene:
        
        encoder0.encodeStruct(scene, offset + 8, false);
        break;
      case ResourceTag.mailboxTexture:
        
        encoder0.encodeStruct(mailboxTexture, offset + 8, false);
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $_tag");
    }
  }

  String toString() {
    String result = "Resource(";
    switch (_tag) {
      case ResourceTag.scene:
        result += "scene";
        break;
      case ResourceTag.mailboxTexture:
        result += "mailboxTexture";
        break;
      default:
        result += "unknown";
    }
    result += ": $_data)";
    return result;
  }
}



const int _MailboxTextureCallback_onMailboxTextureReleasedName = 0;



class _MailboxTextureCallbackServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class MailboxTextureCallback {
  static const String serviceName = null;
  void onMailboxTextureReleased();
}


class _MailboxTextureCallbackProxyImpl extends bindings.Proxy {
  _MailboxTextureCallbackProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _MailboxTextureCallbackProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _MailboxTextureCallbackProxyImpl.unbound() : super.unbound();

  static _MailboxTextureCallbackProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _MailboxTextureCallbackProxyImpl"));
    return new _MailboxTextureCallbackProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _MailboxTextureCallbackServiceDescription();

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
    return "_MailboxTextureCallbackProxyImpl($superString)";
  }
}


class _MailboxTextureCallbackProxyCalls implements MailboxTextureCallback {
  _MailboxTextureCallbackProxyImpl _proxyImpl;

  _MailboxTextureCallbackProxyCalls(this._proxyImpl);
    void onMailboxTextureReleased() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _MailboxTextureCallbackOnMailboxTextureReleasedParams();
      _proxyImpl.sendMessage(params, _MailboxTextureCallback_onMailboxTextureReleasedName);
    }
}


class MailboxTextureCallbackProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  MailboxTextureCallback ptr;

  MailboxTextureCallbackProxy(_MailboxTextureCallbackProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _MailboxTextureCallbackProxyCalls(proxyImpl);

  MailboxTextureCallbackProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _MailboxTextureCallbackProxyImpl.fromEndpoint(endpoint) {
    ptr = new _MailboxTextureCallbackProxyCalls(impl);
  }

  MailboxTextureCallbackProxy.fromHandle(core.MojoHandle handle) :
      impl = new _MailboxTextureCallbackProxyImpl.fromHandle(handle) {
    ptr = new _MailboxTextureCallbackProxyCalls(impl);
  }

  MailboxTextureCallbackProxy.unbound() :
      impl = new _MailboxTextureCallbackProxyImpl.unbound() {
    ptr = new _MailboxTextureCallbackProxyCalls(impl);
  }

  factory MailboxTextureCallbackProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    MailboxTextureCallbackProxy p = new MailboxTextureCallbackProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static MailboxTextureCallbackProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MailboxTextureCallbackProxy"));
    return new MailboxTextureCallbackProxy.fromEndpoint(endpoint);
  }

  String get serviceName => MailboxTextureCallback.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "MailboxTextureCallbackProxy($impl)";
  }
}


class MailboxTextureCallbackStub extends bindings.Stub {
  MailboxTextureCallback _impl = null;

  MailboxTextureCallbackStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  MailboxTextureCallbackStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  MailboxTextureCallbackStub.unbound() : super.unbound();

  static MailboxTextureCallbackStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MailboxTextureCallbackStub"));
    return new MailboxTextureCallbackStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _MailboxTextureCallback_onMailboxTextureReleasedName:
        var params = _MailboxTextureCallbackOnMailboxTextureReleasedParams.deserialize(
            message.payload);
        _impl.onMailboxTextureReleased();
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  MailboxTextureCallback get impl => _impl;
  set impl(MailboxTextureCallback d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "MailboxTextureCallbackStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _MailboxTextureCallbackServiceDescription();
}



