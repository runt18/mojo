// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library sensors_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
class SensorType extends bindings.MojoEnum {
  static const ACCELEROMETER = const SensorType._(0);
  static const AMBIENT_TEMPERATURE = const SensorType._(1);
  static const GAME_ROTATION_VECTOR = const SensorType._(2);
  static const GEOMAGNETIC_ROTATION_VECTOR = const SensorType._(3);
  static const GRAVITY = const SensorType._(4);
  static const GYROSCOPE = const SensorType._(5);
  static const GYROSCOPE_UNCALIBRATED = const SensorType._(6);
  static const HEART_RATE = const SensorType._(7);
  static const LIGHT = const SensorType._(8);
  static const LINEAR_ACCELERATION = const SensorType._(9);
  static const MAGNETIC_FIELD = const SensorType._(10);
  static const MAGNETIC_FIELD_UNCALIBRATED = const SensorType._(11);
  static const PRESSURE = const SensorType._(12);
  static const PROXIMITY = const SensorType._(13);
  static const RELATIVE_HUMIDITY = const SensorType._(14);
  static const ROTATION_VECTOR = const SensorType._(15);
  static const SIGNIFICANT_MOTION = const SensorType._(16);
  static const STEP_COUNTER = const SensorType._(17);
  static const STEP_DETECTOR = const SensorType._(18);

  const SensorType._(int v) : super(v);

  static const Map<String, SensorType> valuesMap = const {
    "ACCELEROMETER": ACCELEROMETER,
    "AMBIENT_TEMPERATURE": AMBIENT_TEMPERATURE,
    "GAME_ROTATION_VECTOR": GAME_ROTATION_VECTOR,
    "GEOMAGNETIC_ROTATION_VECTOR": GEOMAGNETIC_ROTATION_VECTOR,
    "GRAVITY": GRAVITY,
    "GYROSCOPE": GYROSCOPE,
    "GYROSCOPE_UNCALIBRATED": GYROSCOPE_UNCALIBRATED,
    "HEART_RATE": HEART_RATE,
    "LIGHT": LIGHT,
    "LINEAR_ACCELERATION": LINEAR_ACCELERATION,
    "MAGNETIC_FIELD": MAGNETIC_FIELD,
    "MAGNETIC_FIELD_UNCALIBRATED": MAGNETIC_FIELD_UNCALIBRATED,
    "PRESSURE": PRESSURE,
    "PROXIMITY": PROXIMITY,
    "RELATIVE_HUMIDITY": RELATIVE_HUMIDITY,
    "ROTATION_VECTOR": ROTATION_VECTOR,
    "SIGNIFICANT_MOTION": SIGNIFICANT_MOTION,
    "STEP_COUNTER": STEP_COUNTER,
    "STEP_DETECTOR": STEP_DETECTOR,
  };
  static const List<SensorType> values = const [
    ACCELEROMETER,
    AMBIENT_TEMPERATURE,
    GAME_ROTATION_VECTOR,
    GEOMAGNETIC_ROTATION_VECTOR,
    GRAVITY,
    GYROSCOPE,
    GYROSCOPE_UNCALIBRATED,
    HEART_RATE,
    LIGHT,
    LINEAR_ACCELERATION,
    MAGNETIC_FIELD,
    MAGNETIC_FIELD_UNCALIBRATED,
    PRESSURE,
    PROXIMITY,
    RELATIVE_HUMIDITY,
    ROTATION_VECTOR,
    SIGNIFICANT_MOTION,
    STEP_COUNTER,
    STEP_DETECTOR,
  ];

  static SensorType valueOf(String name) => valuesMap[name];

  factory SensorType(int v) {
    switch (v) {
      case 0:
        return ACCELEROMETER;
      case 1:
        return AMBIENT_TEMPERATURE;
      case 2:
        return GAME_ROTATION_VECTOR;
      case 3:
        return GEOMAGNETIC_ROTATION_VECTOR;
      case 4:
        return GRAVITY;
      case 5:
        return GYROSCOPE;
      case 6:
        return GYROSCOPE_UNCALIBRATED;
      case 7:
        return HEART_RATE;
      case 8:
        return LIGHT;
      case 9:
        return LINEAR_ACCELERATION;
      case 10:
        return MAGNETIC_FIELD;
      case 11:
        return MAGNETIC_FIELD_UNCALIBRATED;
      case 12:
        return PRESSURE;
      case 13:
        return PROXIMITY;
      case 14:
        return RELATIVE_HUMIDITY;
      case 15:
        return ROTATION_VECTOR;
      case 16:
        return SIGNIFICANT_MOTION;
      case 17:
        return STEP_COUNTER;
      case 18:
        return STEP_DETECTOR;
      default:
        return null;
    }
  }

  static SensorType decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    SensorType result = new SensorType(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum SensorType.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case ACCELEROMETER:
        return 'SensorType.ACCELEROMETER';
      case AMBIENT_TEMPERATURE:
        return 'SensorType.AMBIENT_TEMPERATURE';
      case GAME_ROTATION_VECTOR:
        return 'SensorType.GAME_ROTATION_VECTOR';
      case GEOMAGNETIC_ROTATION_VECTOR:
        return 'SensorType.GEOMAGNETIC_ROTATION_VECTOR';
      case GRAVITY:
        return 'SensorType.GRAVITY';
      case GYROSCOPE:
        return 'SensorType.GYROSCOPE';
      case GYROSCOPE_UNCALIBRATED:
        return 'SensorType.GYROSCOPE_UNCALIBRATED';
      case HEART_RATE:
        return 'SensorType.HEART_RATE';
      case LIGHT:
        return 'SensorType.LIGHT';
      case LINEAR_ACCELERATION:
        return 'SensorType.LINEAR_ACCELERATION';
      case MAGNETIC_FIELD:
        return 'SensorType.MAGNETIC_FIELD';
      case MAGNETIC_FIELD_UNCALIBRATED:
        return 'SensorType.MAGNETIC_FIELD_UNCALIBRATED';
      case PRESSURE:
        return 'SensorType.PRESSURE';
      case PROXIMITY:
        return 'SensorType.PROXIMITY';
      case RELATIVE_HUMIDITY:
        return 'SensorType.RELATIVE_HUMIDITY';
      case ROTATION_VECTOR:
        return 'SensorType.ROTATION_VECTOR';
      case SIGNIFICANT_MOTION:
        return 'SensorType.SIGNIFICANT_MOTION';
      case STEP_COUNTER:
        return 'SensorType.STEP_COUNTER';
      case STEP_DETECTOR:
        return 'SensorType.STEP_DETECTOR';
    }
  }

  int toJson() => value;
}



class SensorData extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  int accuracy = 0;
  int timeStamp = 0;
  List<double> values = null;

  SensorData() : super(kVersions.last.size);

  static SensorData deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SensorData decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SensorData result = new SensorData();

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
      
      result.accuracy = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.timeStamp = decoder0.decodeInt64(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.values = decoder0.decodeFloatArray(24, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInt32(accuracy, 8);
    
    encoder0.encodeInt64(timeStamp, 16);
    
    encoder0.encodeFloatArray(values, 24, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
  }

  String toString() {
    return "SensorData("
           "accuracy: $accuracy" ", "
           "timeStamp: $timeStamp" ", "
           "values: $values" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["accuracy"] = accuracy;
    map["timeStamp"] = timeStamp;
    map["values"] = values;
    return map;
  }
}


class SensorListenerOnAccuracyChangedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int accuracy = 0;

  SensorListenerOnAccuracyChangedParams() : super(kVersions.last.size);

  static SensorListenerOnAccuracyChangedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SensorListenerOnAccuracyChangedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SensorListenerOnAccuracyChangedParams result = new SensorListenerOnAccuracyChangedParams();

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
      
      result.accuracy = decoder0.decodeInt32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInt32(accuracy, 8);
  }

  String toString() {
    return "SensorListenerOnAccuracyChangedParams("
           "accuracy: $accuracy" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["accuracy"] = accuracy;
    return map;
  }
}


class SensorListenerOnSensorChangedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  SensorData data = null;

  SensorListenerOnSensorChangedParams() : super(kVersions.last.size);

  static SensorListenerOnSensorChangedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SensorListenerOnSensorChangedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SensorListenerOnSensorChangedParams result = new SensorListenerOnSensorChangedParams();

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
      result.data = SensorData.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(data, 8, false);
  }

  String toString() {
    return "SensorListenerOnSensorChangedParams("
           "data: $data" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["data"] = data;
    return map;
  }
}


class SensorServiceAddListenerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  SensorType type = null;
  Object listener = null;

  SensorServiceAddListenerParams() : super(kVersions.last.size);

  static SensorServiceAddListenerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SensorServiceAddListenerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SensorServiceAddListenerParams result = new SensorServiceAddListenerParams();

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
      
        result.type = SensorType.decode(decoder0, 8);
        if (result.type == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable SensorType.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.listener = decoder0.decodeServiceInterface(12, false, SensorListenerProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(type, 8);
    
    encoder0.encodeInterface(listener, 12, false);
  }

  String toString() {
    return "SensorServiceAddListenerParams("
           "type: $type" ", "
           "listener: $listener" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int kSensorListener_onAccuracyChanged_name = 0;
const int kSensorListener_onSensorChanged_name = 1;

const String SensorListenerName =
      'sensors::SensorListener';

abstract class SensorListener {
  void onAccuracyChanged(int accuracy);
  void onSensorChanged(SensorData data);

}


class SensorListenerProxyImpl extends bindings.Proxy {
  SensorListenerProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  SensorListenerProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  SensorListenerProxyImpl.unbound() : super.unbound();

  static SensorListenerProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SensorListenerProxyImpl"));
    return new SensorListenerProxyImpl.fromEndpoint(endpoint);
  }

  String get name => SensorListenerName;

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
    return "SensorListenerProxyImpl($superString)";
  }
}


class _SensorListenerProxyCalls implements SensorListener {
  SensorListenerProxyImpl _proxyImpl;

  _SensorListenerProxyCalls(this._proxyImpl);
    void onAccuracyChanged(int accuracy) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new SensorListenerOnAccuracyChangedParams();
      params.accuracy = accuracy;
      _proxyImpl.sendMessage(params, kSensorListener_onAccuracyChanged_name);
    }
  
    void onSensorChanged(SensorData data) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new SensorListenerOnSensorChangedParams();
      params.data = data;
      _proxyImpl.sendMessage(params, kSensorListener_onSensorChanged_name);
    }
  
}


class SensorListenerProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  SensorListener ptr;
  final String name = SensorListenerName;

  SensorListenerProxy(SensorListenerProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _SensorListenerProxyCalls(proxyImpl);

  SensorListenerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new SensorListenerProxyImpl.fromEndpoint(endpoint) {
    ptr = new _SensorListenerProxyCalls(impl);
  }

  SensorListenerProxy.fromHandle(core.MojoHandle handle) :
      impl = new SensorListenerProxyImpl.fromHandle(handle) {
    ptr = new _SensorListenerProxyCalls(impl);
  }

  SensorListenerProxy.unbound() :
      impl = new SensorListenerProxyImpl.unbound() {
    ptr = new _SensorListenerProxyCalls(impl);
  }

  factory SensorListenerProxy.connectToService(
      bindings.ServiceConnector s, String url) {
    SensorListenerProxy p = new SensorListenerProxy.unbound();
    s.connectToService(url, p);
    return p;
  }

  static SensorListenerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SensorListenerProxy"));
    return new SensorListenerProxy.fromEndpoint(endpoint);
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
    return "SensorListenerProxy($impl)";
  }
}


class SensorListenerStub extends bindings.Stub {
  SensorListener _impl = null;

  SensorListenerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  SensorListenerStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  SensorListenerStub.unbound() : super.unbound();

  static SensorListenerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SensorListenerStub"));
    return new SensorListenerStub.fromEndpoint(endpoint);
  }

  static const String name = SensorListenerName;



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case kSensorListener_onAccuracyChanged_name:
        var params = SensorListenerOnAccuracyChangedParams.deserialize(
            message.payload);
        _impl.onAccuracyChanged(params.accuracy);
        break;
      case kSensorListener_onSensorChanged_name:
        var params = SensorListenerOnSensorChangedParams.deserialize(
            message.payload);
        _impl.onSensorChanged(params.data);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  SensorListener get impl => _impl;
  set impl(SensorListener d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "SensorListenerStub($superString)";
  }

  int get version => 0;
}

const int kSensorService_addListener_name = 0;

const String SensorServiceName =
      'sensors::SensorService';

abstract class SensorService {
  void addListener(SensorType type, Object listener);

}


class SensorServiceProxyImpl extends bindings.Proxy {
  SensorServiceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  SensorServiceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  SensorServiceProxyImpl.unbound() : super.unbound();

  static SensorServiceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SensorServiceProxyImpl"));
    return new SensorServiceProxyImpl.fromEndpoint(endpoint);
  }

  String get name => SensorServiceName;

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
    return "SensorServiceProxyImpl($superString)";
  }
}


class _SensorServiceProxyCalls implements SensorService {
  SensorServiceProxyImpl _proxyImpl;

  _SensorServiceProxyCalls(this._proxyImpl);
    void addListener(SensorType type, Object listener) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new SensorServiceAddListenerParams();
      params.type = type;
      params.listener = listener;
      _proxyImpl.sendMessage(params, kSensorService_addListener_name);
    }
  
}


class SensorServiceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  SensorService ptr;
  final String name = SensorServiceName;

  SensorServiceProxy(SensorServiceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _SensorServiceProxyCalls(proxyImpl);

  SensorServiceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new SensorServiceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _SensorServiceProxyCalls(impl);
  }

  SensorServiceProxy.fromHandle(core.MojoHandle handle) :
      impl = new SensorServiceProxyImpl.fromHandle(handle) {
    ptr = new _SensorServiceProxyCalls(impl);
  }

  SensorServiceProxy.unbound() :
      impl = new SensorServiceProxyImpl.unbound() {
    ptr = new _SensorServiceProxyCalls(impl);
  }

  factory SensorServiceProxy.connectToService(
      bindings.ServiceConnector s, String url) {
    SensorServiceProxy p = new SensorServiceProxy.unbound();
    s.connectToService(url, p);
    return p;
  }

  static SensorServiceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SensorServiceProxy"));
    return new SensorServiceProxy.fromEndpoint(endpoint);
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
    return "SensorServiceProxy($impl)";
  }
}


class SensorServiceStub extends bindings.Stub {
  SensorService _impl = null;

  SensorServiceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  SensorServiceStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  SensorServiceStub.unbound() : super.unbound();

  static SensorServiceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SensorServiceStub"));
    return new SensorServiceStub.fromEndpoint(endpoint);
  }

  static const String name = SensorServiceName;



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case kSensorService_addListener_name:
        var params = SensorServiceAddListenerParams.deserialize(
            message.payload);
        _impl.addListener(params.type, params.listener);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  SensorService get impl => _impl;
  set impl(SensorService d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "SensorServiceStub($superString)";
  }

  int get version => 0;
}


