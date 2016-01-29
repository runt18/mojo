// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library scheduling_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class FrameInfo extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(40, 0)
  ];
  int frameTime = 0;
  int frameInterval = 0;
  int frameDeadline = 0;
  int presentationTime = 0;

  FrameInfo() : super(kVersions.last.size);

  static FrameInfo deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FrameInfo decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FrameInfo result = new FrameInfo();

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
      
      result.frameTime = decoder0.decodeInt64(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.frameInterval = decoder0.decodeUint64(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.frameDeadline = decoder0.decodeInt64(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.presentationTime = decoder0.decodeInt64(32);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInt64(frameTime, 8);
    
    encoder0.encodeUint64(frameInterval, 16);
    
    encoder0.encodeInt64(frameDeadline, 24);
    
    encoder0.encodeInt64(presentationTime, 32);
  }

  String toString() {
    return "FrameInfo("
           "frameTime: $frameTime" ", "
           "frameInterval: $frameInterval" ", "
           "frameDeadline: $frameDeadline" ", "
           "presentationTime: $presentationTime" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["frameTime"] = frameTime;
    map["frameInterval"] = frameInterval;
    map["frameDeadline"] = frameDeadline;
    map["presentationTime"] = presentationTime;
    return map;
  }
}




class _SceneSchedulerScheduleFrameParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _SceneSchedulerScheduleFrameParams() : super(kVersions.last.size);

  static _SceneSchedulerScheduleFrameParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SceneSchedulerScheduleFrameParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SceneSchedulerScheduleFrameParams result = new _SceneSchedulerScheduleFrameParams();

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
    return "_SceneSchedulerScheduleFrameParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}




class SceneSchedulerScheduleFrameResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  FrameInfo frameInfo = null;

  SceneSchedulerScheduleFrameResponseParams() : super(kVersions.last.size);

  static SceneSchedulerScheduleFrameResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SceneSchedulerScheduleFrameResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SceneSchedulerScheduleFrameResponseParams result = new SceneSchedulerScheduleFrameResponseParams();

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
      result.frameInfo = FrameInfo.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(frameInfo, 8, false);
  }

  String toString() {
    return "SceneSchedulerScheduleFrameResponseParams("
           "frameInfo: $frameInfo" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["frameInfo"] = frameInfo;
    return map;
  }
}




const int _SceneScheduler_scheduleFrameName = 0;



class _SceneSchedulerServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class SceneScheduler {
  static const String serviceName = null;
  dynamic scheduleFrame([Function responseFactory = null]);
}


class _SceneSchedulerProxyImpl extends bindings.Proxy {
  _SceneSchedulerProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _SceneSchedulerProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _SceneSchedulerProxyImpl.unbound() : super.unbound();

  static _SceneSchedulerProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _SceneSchedulerProxyImpl"));
    return new _SceneSchedulerProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _SceneSchedulerServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _SceneScheduler_scheduleFrameName:
        var r = SceneSchedulerScheduleFrameResponseParams.deserialize(
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
    return "_SceneSchedulerProxyImpl($superString)";
  }
}


class _SceneSchedulerProxyCalls implements SceneScheduler {
  _SceneSchedulerProxyImpl _proxyImpl;

  _SceneSchedulerProxyCalls(this._proxyImpl);
    dynamic scheduleFrame([Function responseFactory = null]) {
      var params = new _SceneSchedulerScheduleFrameParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _SceneScheduler_scheduleFrameName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class SceneSchedulerProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  SceneScheduler ptr;

  SceneSchedulerProxy(_SceneSchedulerProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _SceneSchedulerProxyCalls(proxyImpl);

  SceneSchedulerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _SceneSchedulerProxyImpl.fromEndpoint(endpoint) {
    ptr = new _SceneSchedulerProxyCalls(impl);
  }

  SceneSchedulerProxy.fromHandle(core.MojoHandle handle) :
      impl = new _SceneSchedulerProxyImpl.fromHandle(handle) {
    ptr = new _SceneSchedulerProxyCalls(impl);
  }

  SceneSchedulerProxy.unbound() :
      impl = new _SceneSchedulerProxyImpl.unbound() {
    ptr = new _SceneSchedulerProxyCalls(impl);
  }

  factory SceneSchedulerProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    SceneSchedulerProxy p = new SceneSchedulerProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static SceneSchedulerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SceneSchedulerProxy"));
    return new SceneSchedulerProxy.fromEndpoint(endpoint);
  }

  String get serviceName => SceneScheduler.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "SceneSchedulerProxy($impl)";
  }
}


class SceneSchedulerStub extends bindings.Stub {
  SceneScheduler _impl = null;

  SceneSchedulerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  SceneSchedulerStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  SceneSchedulerStub.unbound() : super.unbound();

  static SceneSchedulerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SceneSchedulerStub"));
    return new SceneSchedulerStub.fromEndpoint(endpoint);
  }


  SceneSchedulerScheduleFrameResponseParams _SceneSchedulerScheduleFrameResponseParamsFactory(FrameInfo frameInfo) {
    var mojo_factory_result = new SceneSchedulerScheduleFrameResponseParams();
    mojo_factory_result.frameInfo = frameInfo;
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
      case _SceneScheduler_scheduleFrameName:
        var params = _SceneSchedulerScheduleFrameParams.deserialize(
            message.payload);
        var response = _impl.scheduleFrame(_SceneSchedulerScheduleFrameResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _SceneScheduler_scheduleFrameName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _SceneScheduler_scheduleFrameName,
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

  SceneScheduler get impl => _impl;
  set impl(SceneScheduler d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "SceneSchedulerStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _SceneSchedulerServiceDescription();
}



