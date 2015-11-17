// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library device_info_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;



class DeviceInfoGetDeviceTypeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  DeviceInfoGetDeviceTypeParams() : super(kVersions.last.size);

  static DeviceInfoGetDeviceTypeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static DeviceInfoGetDeviceTypeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    DeviceInfoGetDeviceTypeParams result = new DeviceInfoGetDeviceTypeParams();

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
    return "DeviceInfoGetDeviceTypeParams("")";
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
    
    encoder0.encodeEnum(deviceType, 8);
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

const int kDeviceInfo_getDeviceType_name = 0;

const String DeviceInfoName =
      'mojo::DeviceInfo';
  class DeviceInfoDeviceType extends bindings.MojoEnum {
  static const UNKNOWN = const DeviceInfoDeviceType._(0);
  static const HEADLESS = const DeviceInfoDeviceType._(1);
  static const WATCH = const DeviceInfoDeviceType._(2);
  static const PHONE = const DeviceInfoDeviceType._(3);
  static const TABLET = const DeviceInfoDeviceType._(4);
  static const DESKTOP = const DeviceInfoDeviceType._(5);
  static const TV = const DeviceInfoDeviceType._(6);

  const DeviceInfoDeviceType._(int v) : super(v);

  static const Map<String, DeviceInfoDeviceType> valuesMap = const {
    "UNKNOWN": UNKNOWN,
    "HEADLESS": HEADLESS,
    "WATCH": WATCH,
    "PHONE": PHONE,
    "TABLET": TABLET,
    "DESKTOP": DESKTOP,
    "TV": TV,
  };
  static const List<DeviceInfoDeviceType> values = const [
    UNKNOWN,
    HEADLESS,
    WATCH,
    PHONE,
    TABLET,
    DESKTOP,
    TV,
  ];

  static DeviceInfoDeviceType valueOf(String name) => valuesMap[name];

  factory DeviceInfoDeviceType(int v) {
    switch (v) {
      case 0:
        return UNKNOWN;
      case 1:
        return HEADLESS;
      case 2:
        return WATCH;
      case 3:
        return PHONE;
      case 4:
        return TABLET;
      case 5:
        return DESKTOP;
      case 6:
        return TV;
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
      case UNKNOWN:
        return 'DeviceInfoDeviceType.UNKNOWN';
      case HEADLESS:
        return 'DeviceInfoDeviceType.HEADLESS';
      case WATCH:
        return 'DeviceInfoDeviceType.WATCH';
      case PHONE:
        return 'DeviceInfoDeviceType.PHONE';
      case TABLET:
        return 'DeviceInfoDeviceType.TABLET';
      case DESKTOP:
        return 'DeviceInfoDeviceType.DESKTOP';
      case TV:
        return 'DeviceInfoDeviceType.TV';
    }
  }

  int toJson() => value;
}

abstract class DeviceInfo {
  dynamic getDeviceType([Function responseFactory = null]);

}


class DeviceInfoProxyImpl extends bindings.Proxy {
  DeviceInfoProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  DeviceInfoProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  DeviceInfoProxyImpl.unbound() : super.unbound();

  static DeviceInfoProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For DeviceInfoProxyImpl"));
    return new DeviceInfoProxyImpl.fromEndpoint(endpoint);
  }

  String get name => DeviceInfoName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case kDeviceInfo_getDeviceType_name:
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
    return "DeviceInfoProxyImpl($superString)";
  }
}


class _DeviceInfoProxyCalls implements DeviceInfo {
  DeviceInfoProxyImpl _proxyImpl;

  _DeviceInfoProxyCalls(this._proxyImpl);
    dynamic getDeviceType([Function responseFactory = null]) {
      var params = new DeviceInfoGetDeviceTypeParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kDeviceInfo_getDeviceType_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class DeviceInfoProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  DeviceInfo ptr;
  final String name = DeviceInfoName;

  DeviceInfoProxy(DeviceInfoProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _DeviceInfoProxyCalls(proxyImpl);

  DeviceInfoProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new DeviceInfoProxyImpl.fromEndpoint(endpoint) {
    ptr = new _DeviceInfoProxyCalls(impl);
  }

  DeviceInfoProxy.fromHandle(core.MojoHandle handle) :
      impl = new DeviceInfoProxyImpl.fromHandle(handle) {
    ptr = new _DeviceInfoProxyCalls(impl);
  }

  DeviceInfoProxy.unbound() :
      impl = new DeviceInfoProxyImpl.unbound() {
    ptr = new _DeviceInfoProxyCalls(impl);
  }

  factory DeviceInfoProxy.connectToService(
      bindings.ServiceConnector s, String url) {
    DeviceInfoProxy p = new DeviceInfoProxy.unbound();
    s.connectToService(url, p);
    return p;
  }

  static DeviceInfoProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For DeviceInfoProxy"));
    return new DeviceInfoProxy.fromEndpoint(endpoint);
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

  static const String name = DeviceInfoName;


  DeviceInfoGetDeviceTypeResponseParams _DeviceInfoGetDeviceTypeResponseParamsFactory(DeviceInfoDeviceType deviceType) {
    var result = new DeviceInfoGetDeviceTypeResponseParams();
    result.deviceType = deviceType;
    return result;
  }

  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case kDeviceInfo_getDeviceType_name:
        var params = DeviceInfoGetDeviceTypeParams.deserialize(
            message.payload);
        var response = _impl.getDeviceType(_DeviceInfoGetDeviceTypeResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kDeviceInfo_getDeviceType_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kDeviceInfo_getDeviceType_name,
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
}


