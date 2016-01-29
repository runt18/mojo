// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library hit_tests_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/geometry.mojom.dart' as geometry_mojom;
import 'package:mojo_services/mojo/gfx/composition/scene_token.mojom.dart' as scene_token_mojom;
const int kHitIdNone = 0;



class Hit extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(40, 0)
  ];
  scene_token_mojom.SceneToken sceneToken = null;
  int sceneVersion = 0;
  int nodeId = 0;
  int hitId = 0;
  geometry_mojom.Point intersection = null;

  Hit() : super(kVersions.last.size);

  static Hit deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Hit decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Hit result = new Hit();

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
      
      result.nodeId = decoder0.decodeUint32(20);
    }
    if (mainDataHeader.version >= 0) {
      
      result.hitId = decoder0.decodeUint32(24);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(32, false);
      result.intersection = geometry_mojom.Point.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(sceneToken, 8, false);
    
    encoder0.encodeUint32(sceneVersion, 16);
    
    encoder0.encodeUint32(nodeId, 20);
    
    encoder0.encodeUint32(hitId, 24);
    
    encoder0.encodeStruct(intersection, 32, false);
  }

  String toString() {
    return "Hit("
           "sceneToken: $sceneToken" ", "
           "sceneVersion: $sceneVersion" ", "
           "nodeId: $nodeId" ", "
           "hitId: $hitId" ", "
           "intersection: $intersection" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["sceneToken"] = sceneToken;
    map["sceneVersion"] = sceneVersion;
    map["nodeId"] = nodeId;
    map["hitId"] = hitId;
    map["intersection"] = intersection;
    return map;
  }
}




class HitTestResult extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<Hit> hits = null;

  HitTestResult() : super(kVersions.last.size);

  static HitTestResult deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static HitTestResult decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    HitTestResult result = new HitTestResult();

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
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.hits = new List<Hit>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.hits[i1] = Hit.decode(decoder2);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    if (hits == null) {
      encoder0.encodeNullPointer(8, false);
    } else {
      var encoder1 = encoder0.encodePointerArray(hits.length, 8, bindings.kUnspecifiedArrayLength);
      for (int i0 = 0; i0 < hits.length; ++i0) {
        
        encoder1.encodeStruct(hits[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
      }
    }
  }

  String toString() {
    return "HitTestResult("
           "hits: $hits" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["hits"] = hits;
    return map;
  }
}




class _HitTesterHitTestParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  geometry_mojom.Point point = null;

  _HitTesterHitTestParams() : super(kVersions.last.size);

  static _HitTesterHitTestParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _HitTesterHitTestParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _HitTesterHitTestParams result = new _HitTesterHitTestParams();

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
      result.point = geometry_mojom.Point.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(point, 8, false);
  }

  String toString() {
    return "_HitTesterHitTestParams("
           "point: $point" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["point"] = point;
    return map;
  }
}




class HitTesterHitTestResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  HitTestResult result = null;

  HitTesterHitTestResponseParams() : super(kVersions.last.size);

  static HitTesterHitTestResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static HitTesterHitTestResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    HitTesterHitTestResponseParams result = new HitTesterHitTestResponseParams();

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
      result.result = HitTestResult.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(result, 8, false);
  }

  String toString() {
    return "HitTesterHitTestResponseParams("
           "result: $result" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["result"] = result;
    return map;
  }
}




const int _HitTester_hitTestName = 0;



class _HitTesterServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class HitTester {
  static const String serviceName = null;
  dynamic hitTest(geometry_mojom.Point point,[Function responseFactory = null]);
}


class _HitTesterProxyImpl extends bindings.Proxy {
  _HitTesterProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _HitTesterProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _HitTesterProxyImpl.unbound() : super.unbound();

  static _HitTesterProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _HitTesterProxyImpl"));
    return new _HitTesterProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _HitTesterServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _HitTester_hitTestName:
        var r = HitTesterHitTestResponseParams.deserialize(
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
    return "_HitTesterProxyImpl($superString)";
  }
}


class _HitTesterProxyCalls implements HitTester {
  _HitTesterProxyImpl _proxyImpl;

  _HitTesterProxyCalls(this._proxyImpl);
    dynamic hitTest(geometry_mojom.Point point,[Function responseFactory = null]) {
      var params = new _HitTesterHitTestParams();
      params.point = point;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _HitTester_hitTestName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class HitTesterProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  HitTester ptr;

  HitTesterProxy(_HitTesterProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _HitTesterProxyCalls(proxyImpl);

  HitTesterProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _HitTesterProxyImpl.fromEndpoint(endpoint) {
    ptr = new _HitTesterProxyCalls(impl);
  }

  HitTesterProxy.fromHandle(core.MojoHandle handle) :
      impl = new _HitTesterProxyImpl.fromHandle(handle) {
    ptr = new _HitTesterProxyCalls(impl);
  }

  HitTesterProxy.unbound() :
      impl = new _HitTesterProxyImpl.unbound() {
    ptr = new _HitTesterProxyCalls(impl);
  }

  factory HitTesterProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    HitTesterProxy p = new HitTesterProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static HitTesterProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HitTesterProxy"));
    return new HitTesterProxy.fromEndpoint(endpoint);
  }

  String get serviceName => HitTester.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "HitTesterProxy($impl)";
  }
}


class HitTesterStub extends bindings.Stub {
  HitTester _impl = null;

  HitTesterStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  HitTesterStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  HitTesterStub.unbound() : super.unbound();

  static HitTesterStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HitTesterStub"));
    return new HitTesterStub.fromEndpoint(endpoint);
  }


  HitTesterHitTestResponseParams _HitTesterHitTestResponseParamsFactory(HitTestResult result) {
    var mojo_factory_result = new HitTesterHitTestResponseParams();
    mojo_factory_result.result = result;
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
      case _HitTester_hitTestName:
        var params = _HitTesterHitTestParams.deserialize(
            message.payload);
        var response = _impl.hitTest(params.point,_HitTesterHitTestResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _HitTester_hitTestName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _HitTester_hitTestName,
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

  HitTester get impl => _impl;
  set impl(HitTester d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "HitTesterStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _HitTesterServiceDescription();
}



