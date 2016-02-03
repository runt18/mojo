// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library device_info_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class _DeviceInfoGetDeviceTypeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _DeviceInfoGetDeviceTypeParams() : super(kVersions.last.size);

  static _DeviceInfoGetDeviceTypeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _DeviceInfoGetDeviceTypeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _DeviceInfoGetDeviceTypeParams result = new _DeviceInfoGetDeviceTypeParams();

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
    return "_DeviceInfoGetDeviceTypeParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}




class DeviceInfoGetDeviceTypeResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  DeviceInfoDeviceType deviceType = null;

  DeviceInfoGetDeviceTypeResponseParams() : super(kVersions.last.size);

  static DeviceInfoGetDeviceTypeResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static DeviceInfoGetDeviceTypeResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    DeviceInfoGetDeviceTypeResponseParams result = new DeviceInfoGetDeviceTypeResponseParams();

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
      
        result.deviceType = DeviceInfoDeviceType.decode(decoder0, 8);
        if (result.deviceType == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable DeviceInfoDeviceType.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(deviceType, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "deviceType of struct DeviceInfoGetDeviceTypeResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "DeviceInfoGetDeviceTypeResponseParams("
           "deviceType: $deviceType" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["deviceType"] = deviceType;
    return map;
  }
}




const int _DeviceInfo_getDeviceTypeName = 0;
  
class DeviceInfoDeviceType extends bindings.MojoEnum {
  static const DeviceInfoDeviceType unknown = const DeviceInfoDeviceType._(0);
  static const DeviceInfoDeviceType headless = const DeviceInfoDeviceType._(1);
  static const DeviceInfoDeviceType watch = const DeviceInfoDeviceType._(2);
  static const DeviceInfoDeviceType phone = const DeviceInfoDeviceType._(3);
  static const DeviceInfoDeviceType tablet = const DeviceInfoDeviceType._(4);
  static const DeviceInfoDeviceType desktop = const DeviceInfoDeviceType._(5);
  static const DeviceInfoDeviceType tv = const DeviceInfoDeviceType._(6);

  const DeviceInfoDeviceType._(int v) : super(v);

  static const Map<String, DeviceInfoDeviceType> valuesMap = const {
    "unknown": unknown,
    "headless": headless,
    "watch": watch,
    "phone": phone,
    "tablet": tablet,
    "desktop": desktop,
    "tv": tv,
  };
  static const List<DeviceInfoDeviceType> values = const [
    unknown,
    headless,
    watch,
    phone,
    tablet,
    desktop,
    tv,
  ];

  static DeviceInfoDeviceType valueOf(String name) => valuesMap[name];

  factory DeviceInfoDeviceType(int v) {
    switch (v) {
      case 0:
        return unknown;
      case 1:
        return headless;
      case 2:
        return watch;
      case 3:
        return phone;
      case 4:
        return tablet;
      case 5:
        return desktop;
      case 6:
        return tv;
      default:
        return null;
    }
  }

  static DeviceInfoDeviceType decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    DeviceInfoDeviceType result = new DeviceInfoDeviceType(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum DeviceInfoDeviceType.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case unknown:
        return 'DeviceInfoDeviceType.unknown';
      case headless:
        return 'DeviceInfoDeviceType.headless';
      case watch:
        return 'DeviceInfoDeviceType.watch';
      case phone:
        return 'DeviceInfoDeviceType.phone';
      case tablet:
        return 'DeviceInfoDeviceType.tablet';
      case desktop:
        return 'DeviceInfoDeviceType.desktop';
      case tv:
        return 'DeviceInfoDeviceType.tv';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}





class _DeviceInfoServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class DeviceInfo {
  static const String serviceName = "mojo::DeviceInfo";
  dynamic getDeviceType([Function responseFactory = null]);
}


class _DeviceInfoProxyImpl extends bindings.Proxy {
  _DeviceInfoProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _DeviceInfoProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _DeviceInfoProxyImpl.unbound() : super.unbound();

  static _DeviceInfoProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _DeviceInfoProxyImpl"));
    return new _DeviceInfoProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _DeviceInfoServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _DeviceInfo_getDeviceTypeName:
        var r = DeviceInfoGetDeviceTypeResponseParams.deserialize(
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
    return "_DeviceInfoProxyImpl($superString)";
  }
}


class _DeviceInfoProxyCalls implements DeviceInfo {
  _DeviceInfoProxyImpl _proxyImpl;

  _DeviceInfoProxyCalls(this._proxyImpl);
    dynamic getDeviceType([Function responseFactory = null]) {
      var params = new _DeviceInfoGetDeviceTypeParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _DeviceInfo_getDeviceTypeName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class DeviceInfoProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  DeviceInfo ptr;

  DeviceInfoProxy(_DeviceInfoProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _DeviceInfoProxyCalls(proxyImpl);

  DeviceInfoProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _DeviceInfoProxyImpl.fromEndpoint(endpoint) {
    ptr = new _DeviceInfoProxyCalls(impl);
  }

  DeviceInfoProxy.fromHandle(core.MojoHandle handle) :
      impl = new _DeviceInfoProxyImpl.fromHandle(handle) {
    ptr = new _DeviceInfoProxyCalls(impl);
  }

  DeviceInfoProxy.unbound() :
      impl = new _DeviceInfoProxyImpl.unbound() {
    ptr = new _DeviceInfoProxyCalls(impl);
  }

  factory DeviceInfoProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    DeviceInfoProxy p = new DeviceInfoProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static DeviceInfoProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For DeviceInfoProxy"));
    return new DeviceInfoProxy.fromEndpoint(endpoint);
  }

  String get serviceName => DeviceInfo.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "DeviceInfoProxy($impl)";
  }
}


class DeviceInfoStub extends bindings.Stub {
  DeviceInfo _impl = null;

  DeviceInfoStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  DeviceInfoStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  DeviceInfoStub.unbound() : super.unbound();

  static DeviceInfoStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For DeviceInfoStub"));
    return new DeviceInfoStub.fromEndpoint(endpoint);
  }


  DeviceInfoGetDeviceTypeResponseParams _DeviceInfoGetDeviceTypeResponseParamsFactory(DeviceInfoDeviceType deviceType) {
    var mojo_factory_result = new DeviceInfoGetDeviceTypeResponseParams();
    mojo_factory_result.deviceType = deviceType;
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
      case _DeviceInfo_getDeviceTypeName:
        var params = _DeviceInfoGetDeviceTypeParams.deserialize(
            message.payload);
        var response = _impl.getDeviceType(_DeviceInfoGetDeviceTypeResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _DeviceInfo_getDeviceTypeName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _DeviceInfo_getDeviceTypeName,
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

  DeviceInfo get impl => _impl;
  set impl(DeviceInfo d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "DeviceInfoStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _DeviceInfoServiceDescription();
}



