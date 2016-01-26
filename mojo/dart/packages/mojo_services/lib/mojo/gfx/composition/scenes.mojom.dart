// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library scenes_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo_services/mojo/gfx/composition/nodes.mojom.dart' as nodes_mojom;
import 'package:mojo_services/mojo/gfx/composition/resources.mojom.dart' as resources_mojom;
import 'package:mojo_services/mojo/gfx/composition/scene_token.mojom.dart' as scene_token_mojom;
import 'package:mojo_services/mojo/gfx/composition/scheduling.mojom.dart' as scheduling_mojom;
const int kSceneRootNodeId = 0;
const int kSceneVersionNone = 0;



class SceneUpdate extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  bool clearResources = false;
  bool clearNodes = false;
  Map<int, resources_mojom.Resource> resources = null;
  Map<int, nodes_mojom.Node> nodes = null;

  SceneUpdate() : super(kVersions.last.size);

  static SceneUpdate deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SceneUpdate decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SceneUpdate result = new SceneUpdate();

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
      
      result.clearResources = decoder0.decodeBool(8, 0);
    }
    if (mainDataHeader.version >= 0) {
      
      result.clearNodes = decoder0.decodeBool(8, 1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      if (decoder1 == null) {
        result.resources = null;
      } else {
        decoder1.decodeDataHeaderForMap();
        List<int> keys0;
        List<resources_mojom.Resource> values0;
        {
          
          keys0 = decoder1.decodeUint32Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForUnionArray(keys0.length);
            values0 = new List<resources_mojom.Resource>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
                values0[i2] = resources_mojom.Resource.decode(decoder2, bindings.ArrayDataHeader.kHeaderSize + bindings.kUnionSize * i2);
            }
          }
        }
        result.resources = new Map<int, resources_mojom.Resource>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, true);
      if (decoder1 == null) {
        result.nodes = null;
      } else {
        decoder1.decodeDataHeaderForMap();
        List<int> keys0;
        List<nodes_mojom.Node> values0;
        {
          
          keys0 = decoder1.decodeUint32Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(keys0.length);
            values0 = new List<nodes_mojom.Node>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, true);
              values0[i2] = nodes_mojom.Node.decode(decoder3);
            }
          }
        }
        result.nodes = new Map<int, nodes_mojom.Node>.fromIterables(
            keys0, values0);
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeBool(clearResources, 8, 0);
    
    encoder0.encodeBool(clearNodes, 8, 1);
    
    if (resources == null) {
      encoder0.encodeNullPointer(16, true);
    } else {
      var encoder1 = encoder0.encoderForMap(16);
      int size0 = resources.length;
      var keys0 = resources.keys.toList();
      var values0 = resources.values.toList();
      
      encoder1.encodeUint32Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      
      {
        var encoder2 = encoder1.encodeUnionArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
        for (int i1 = 0; i1 < values0.length; ++i1) {
          
          encoder2.encodeUnion(values0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kUnionSize * i1, true);
        }
      }
    }
    
    if (nodes == null) {
      encoder0.encodeNullPointer(24, true);
    } else {
      var encoder1 = encoder0.encoderForMap(24);
      int size0 = nodes.length;
      var keys0 = nodes.keys.toList();
      var values0 = nodes.values.toList();
      
      encoder1.encodeUint32Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      
      {
        var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
        for (int i1 = 0; i1 < values0.length; ++i1) {
          
          encoder2.encodeStruct(values0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, true);
        }
      }
    }
  }

  String toString() {
    return "SceneUpdate("
           "clearResources: $clearResources" ", "
           "clearNodes: $clearNodes" ", "
           "resources: $resources" ", "
           "nodes: $nodes" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class SceneMetadata extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int version = 0;
  int presentationTime = 0;

  SceneMetadata() : super(kVersions.last.size);

  static SceneMetadata deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SceneMetadata decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SceneMetadata result = new SceneMetadata();

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
      
      result.version = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.presentationTime = decoder0.decodeInt64(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(version, 8);
    
    encoder0.encodeInt64(presentationTime, 16);
  }

  String toString() {
    return "SceneMetadata("
           "version: $version" ", "
           "presentationTime: $presentationTime" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["version"] = version;
    map["presentationTime"] = presentationTime;
    return map;
  }
}


class _SceneSetListenerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object listener = null;

  _SceneSetListenerParams() : super(kVersions.last.size);

  static _SceneSetListenerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SceneSetListenerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SceneSetListenerParams result = new _SceneSetListenerParams();

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
      
      result.listener = decoder0.decodeServiceInterface(8, true, SceneListenerProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInterface(listener, 8, true);
  }

  String toString() {
    return "_SceneSetListenerParams("
           "listener: $listener" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _SceneUpdateParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  SceneUpdate update = null;

  _SceneUpdateParams() : super(kVersions.last.size);

  static _SceneUpdateParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SceneUpdateParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SceneUpdateParams result = new _SceneUpdateParams();

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
      result.update = SceneUpdate.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(update, 8, false);
  }

  String toString() {
    return "_SceneUpdateParams("
           "update: $update" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _ScenePublishParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  SceneMetadata metadata = null;

  _ScenePublishParams() : super(kVersions.last.size);

  static _ScenePublishParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ScenePublishParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ScenePublishParams result = new _ScenePublishParams();

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
      result.metadata = SceneMetadata.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(metadata, 8, true);
  }

  String toString() {
    return "_ScenePublishParams("
           "metadata: $metadata" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["metadata"] = metadata;
    return map;
  }
}


class _SceneGetSchedulerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object scheduler = null;

  _SceneGetSchedulerParams() : super(kVersions.last.size);

  static _SceneGetSchedulerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SceneGetSchedulerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SceneGetSchedulerParams result = new _SceneGetSchedulerParams();

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
      
      result.scheduler = decoder0.decodeInterfaceRequest(8, false, scheduling_mojom.SceneSchedulerStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInterfaceRequest(scheduler, 8, false);
  }

  String toString() {
    return "_SceneGetSchedulerParams("
           "scheduler: $scheduler" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _SceneListenerOnResourceUnavailableParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int resourceId = 0;

  _SceneListenerOnResourceUnavailableParams() : super(kVersions.last.size);

  static _SceneListenerOnResourceUnavailableParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SceneListenerOnResourceUnavailableParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SceneListenerOnResourceUnavailableParams result = new _SceneListenerOnResourceUnavailableParams();

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
      
      result.resourceId = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(resourceId, 8);
  }

  String toString() {
    return "_SceneListenerOnResourceUnavailableParams("
           "resourceId: $resourceId" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["resourceId"] = resourceId;
    return map;
  }
}


class SceneListenerOnResourceUnavailableResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  SceneListenerOnResourceUnavailableResponseParams() : super(kVersions.last.size);

  static SceneListenerOnResourceUnavailableResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SceneListenerOnResourceUnavailableResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SceneListenerOnResourceUnavailableResponseParams result = new SceneListenerOnResourceUnavailableResponseParams();

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
    return "SceneListenerOnResourceUnavailableResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

const int _Scene_setListenerName = 0;
const int _Scene_updateName = 1;
const int _Scene_publishName = 2;
const int _Scene_getSchedulerName = 3;

abstract class Scene {
  static const String serviceName = null;
  void setListener(Object listener);
  void update(SceneUpdate update);
  void publish(SceneMetadata metadata);
  void getScheduler(Object scheduler);
}


class _SceneProxyImpl extends bindings.Proxy {
  _SceneProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _SceneProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _SceneProxyImpl.unbound() : super.unbound();

  static _SceneProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _SceneProxyImpl"));
    return new _SceneProxyImpl.fromEndpoint(endpoint);
  }

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
    return "_SceneProxyImpl($superString)";
  }
}


class _SceneProxyCalls implements Scene {
  _SceneProxyImpl _proxyImpl;

  _SceneProxyCalls(this._proxyImpl);
    void setListener(Object listener) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _SceneSetListenerParams();
      params.listener = listener;
      _proxyImpl.sendMessage(params, _Scene_setListenerName);
    }
    void update(SceneUpdate update) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _SceneUpdateParams();
      params.update = update;
      _proxyImpl.sendMessage(params, _Scene_updateName);
    }
    void publish(SceneMetadata metadata) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ScenePublishParams();
      params.metadata = metadata;
      _proxyImpl.sendMessage(params, _Scene_publishName);
    }
    void getScheduler(Object scheduler) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _SceneGetSchedulerParams();
      params.scheduler = scheduler;
      _proxyImpl.sendMessage(params, _Scene_getSchedulerName);
    }
}


class SceneProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  Scene ptr;

  SceneProxy(_SceneProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _SceneProxyCalls(proxyImpl);

  SceneProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _SceneProxyImpl.fromEndpoint(endpoint) {
    ptr = new _SceneProxyCalls(impl);
  }

  SceneProxy.fromHandle(core.MojoHandle handle) :
      impl = new _SceneProxyImpl.fromHandle(handle) {
    ptr = new _SceneProxyCalls(impl);
  }

  SceneProxy.unbound() :
      impl = new _SceneProxyImpl.unbound() {
    ptr = new _SceneProxyCalls(impl);
  }

  factory SceneProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    SceneProxy p = new SceneProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static SceneProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SceneProxy"));
    return new SceneProxy.fromEndpoint(endpoint);
  }

  String get serviceName => Scene.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "SceneProxy($impl)";
  }
}


class SceneStub extends bindings.Stub {
  Scene _impl = null;

  SceneStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  SceneStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  SceneStub.unbound() : super.unbound();

  static SceneStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SceneStub"));
    return new SceneStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _Scene_setListenerName:
        var params = _SceneSetListenerParams.deserialize(
            message.payload);
        _impl.setListener(params.listener);
        break;
      case _Scene_updateName:
        var params = _SceneUpdateParams.deserialize(
            message.payload);
        _impl.update(params.update);
        break;
      case _Scene_publishName:
        var params = _ScenePublishParams.deserialize(
            message.payload);
        _impl.publish(params.metadata);
        break;
      case _Scene_getSchedulerName:
        var params = _SceneGetSchedulerParams.deserialize(
            message.payload);
        _impl.getScheduler(params.scheduler);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  Scene get impl => _impl;
  set impl(Scene d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "SceneStub($superString)";
  }

  int get version => 0;
}

const int _SceneListener_onResourceUnavailableName = 0;

abstract class SceneListener {
  static const String serviceName = null;
  dynamic onResourceUnavailable(int resourceId,[Function responseFactory = null]);
}


class _SceneListenerProxyImpl extends bindings.Proxy {
  _SceneListenerProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _SceneListenerProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _SceneListenerProxyImpl.unbound() : super.unbound();

  static _SceneListenerProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _SceneListenerProxyImpl"));
    return new _SceneListenerProxyImpl.fromEndpoint(endpoint);
  }

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _SceneListener_onResourceUnavailableName:
        var r = SceneListenerOnResourceUnavailableResponseParams.deserialize(
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
    return "_SceneListenerProxyImpl($superString)";
  }
}


class _SceneListenerProxyCalls implements SceneListener {
  _SceneListenerProxyImpl _proxyImpl;

  _SceneListenerProxyCalls(this._proxyImpl);
    dynamic onResourceUnavailable(int resourceId,[Function responseFactory = null]) {
      var params = new _SceneListenerOnResourceUnavailableParams();
      params.resourceId = resourceId;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _SceneListener_onResourceUnavailableName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class SceneListenerProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  SceneListener ptr;

  SceneListenerProxy(_SceneListenerProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _SceneListenerProxyCalls(proxyImpl);

  SceneListenerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _SceneListenerProxyImpl.fromEndpoint(endpoint) {
    ptr = new _SceneListenerProxyCalls(impl);
  }

  SceneListenerProxy.fromHandle(core.MojoHandle handle) :
      impl = new _SceneListenerProxyImpl.fromHandle(handle) {
    ptr = new _SceneListenerProxyCalls(impl);
  }

  SceneListenerProxy.unbound() :
      impl = new _SceneListenerProxyImpl.unbound() {
    ptr = new _SceneListenerProxyCalls(impl);
  }

  factory SceneListenerProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    SceneListenerProxy p = new SceneListenerProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static SceneListenerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SceneListenerProxy"));
    return new SceneListenerProxy.fromEndpoint(endpoint);
  }

  String get serviceName => SceneListener.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "SceneListenerProxy($impl)";
  }
}


class SceneListenerStub extends bindings.Stub {
  SceneListener _impl = null;

  SceneListenerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  SceneListenerStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  SceneListenerStub.unbound() : super.unbound();

  static SceneListenerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SceneListenerStub"));
    return new SceneListenerStub.fromEndpoint(endpoint);
  }


  SceneListenerOnResourceUnavailableResponseParams _SceneListenerOnResourceUnavailableResponseParamsFactory() {
    var mojo_factory_result = new SceneListenerOnResourceUnavailableResponseParams();
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
      case _SceneListener_onResourceUnavailableName:
        var params = _SceneListenerOnResourceUnavailableParams.deserialize(
            message.payload);
        var response = _impl.onResourceUnavailable(params.resourceId,_SceneListenerOnResourceUnavailableResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _SceneListener_onResourceUnavailableName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _SceneListener_onResourceUnavailableName,
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

  SceneListener get impl => _impl;
  set impl(SceneListener d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "SceneListenerStub($superString)";
  }

  int get version => 0;
}


