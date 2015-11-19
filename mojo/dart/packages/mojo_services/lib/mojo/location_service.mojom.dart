// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library location_service_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo_services/mojo/location.mojom.dart' as location_mojom;



class LocationServiceGetNextLocationParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  LocationServiceUpdatePriority priority = null;

  LocationServiceGetNextLocationParams() : super(kVersions.last.size);

  static LocationServiceGetNextLocationParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static LocationServiceGetNextLocationParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    LocationServiceGetNextLocationParams result = new LocationServiceGetNextLocationParams();

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
      
        result.priority = LocationServiceUpdatePriority.decode(decoder0, 8);
        if (result.priority == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable LocationServiceUpdatePriority.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(priority, 8);
  }

  String toString() {
    return "LocationServiceGetNextLocationParams("
           "priority: $priority" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["priority"] = priority;
    return map;
  }
}


class LocationServiceGetNextLocationResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  location_mojom.Location location = null;

  LocationServiceGetNextLocationResponseParams() : super(kVersions.last.size);

  static LocationServiceGetNextLocationResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static LocationServiceGetNextLocationResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    LocationServiceGetNextLocationResponseParams result = new LocationServiceGetNextLocationResponseParams();

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
      result.location = location_mojom.Location.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(location, 8, true);
  }

  String toString() {
    return "LocationServiceGetNextLocationResponseParams("
           "location: $location" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["location"] = location;
    return map;
  }
}

const int kLocationService_getNextLocation_name = 0;

const String LocationServiceName =
      'mojo::LocationService';
  class LocationServiceUpdatePriority extends bindings.MojoEnum {
  static const PRIORITY_BALANCED_POWER_ACCURACY = const LocationServiceUpdatePriority._(0);
  static const PRIORITY_HIGH_ACCURACY = const LocationServiceUpdatePriority._(1);
  static const PRIORITY_LOW_POWER = const LocationServiceUpdatePriority._(2);
  static const PRIORITY_NO_POWER = const LocationServiceUpdatePriority._(3);

  const LocationServiceUpdatePriority._(int v) : super(v);

  static const Map<String, LocationServiceUpdatePriority> valuesMap = const {
    "PRIORITY_BALANCED_POWER_ACCURACY": PRIORITY_BALANCED_POWER_ACCURACY,
    "PRIORITY_HIGH_ACCURACY": PRIORITY_HIGH_ACCURACY,
    "PRIORITY_LOW_POWER": PRIORITY_LOW_POWER,
    "PRIORITY_NO_POWER": PRIORITY_NO_POWER,
  };
  static const List<LocationServiceUpdatePriority> values = const [
    PRIORITY_BALANCED_POWER_ACCURACY,
    PRIORITY_HIGH_ACCURACY,
    PRIORITY_LOW_POWER,
    PRIORITY_NO_POWER,
  ];

  static LocationServiceUpdatePriority valueOf(String name) => valuesMap[name];

  factory LocationServiceUpdatePriority(int v) {
    switch (v) {
      case 0:
        return PRIORITY_BALANCED_POWER_ACCURACY;
      case 1:
        return PRIORITY_HIGH_ACCURACY;
      case 2:
        return PRIORITY_LOW_POWER;
      case 3:
        return PRIORITY_NO_POWER;
      default:
        return null;
    }
  }

  static LocationServiceUpdatePriority decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    LocationServiceUpdatePriority result = new LocationServiceUpdatePriority(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum LocationServiceUpdatePriority.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case PRIORITY_BALANCED_POWER_ACCURACY:
        return 'LocationServiceUpdatePriority.PRIORITY_BALANCED_POWER_ACCURACY';
      case PRIORITY_HIGH_ACCURACY:
        return 'LocationServiceUpdatePriority.PRIORITY_HIGH_ACCURACY';
      case PRIORITY_LOW_POWER:
        return 'LocationServiceUpdatePriority.PRIORITY_LOW_POWER';
      case PRIORITY_NO_POWER:
        return 'LocationServiceUpdatePriority.PRIORITY_NO_POWER';
    }
  }

  int toJson() => value;
}

abstract class LocationService {
  dynamic getNextLocation(LocationServiceUpdatePriority priority,[Function responseFactory = null]);

}


class LocationServiceProxyImpl extends bindings.Proxy {
  LocationServiceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  LocationServiceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  LocationServiceProxyImpl.unbound() : super.unbound();

  static LocationServiceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For LocationServiceProxyImpl"));
    return new LocationServiceProxyImpl.fromEndpoint(endpoint);
  }

  String get name => LocationServiceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case kLocationService_getNextLocation_name:
        var r = LocationServiceGetNextLocationResponseParams.deserialize(
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
    return "LocationServiceProxyImpl($superString)";
  }
}


class _LocationServiceProxyCalls implements LocationService {
  LocationServiceProxyImpl _proxyImpl;

  _LocationServiceProxyCalls(this._proxyImpl);
    dynamic getNextLocation(LocationServiceUpdatePriority priority,[Function responseFactory = null]) {
      var params = new LocationServiceGetNextLocationParams();
      params.priority = priority;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kLocationService_getNextLocation_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class LocationServiceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  LocationService ptr;
  final String name = LocationServiceName;

  LocationServiceProxy(LocationServiceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _LocationServiceProxyCalls(proxyImpl);

  LocationServiceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new LocationServiceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _LocationServiceProxyCalls(impl);
  }

  LocationServiceProxy.fromHandle(core.MojoHandle handle) :
      impl = new LocationServiceProxyImpl.fromHandle(handle) {
    ptr = new _LocationServiceProxyCalls(impl);
  }

  LocationServiceProxy.unbound() :
      impl = new LocationServiceProxyImpl.unbound() {
    ptr = new _LocationServiceProxyCalls(impl);
  }

  factory LocationServiceProxy.connectToService(
      bindings.ServiceConnector s, String url) {
    LocationServiceProxy p = new LocationServiceProxy.unbound();
    s.connectToService(url, p);
    return p;
  }

  static LocationServiceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For LocationServiceProxy"));
    return new LocationServiceProxy.fromEndpoint(endpoint);
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
    return "LocationServiceProxy($impl)";
  }
}


class LocationServiceStub extends bindings.Stub {
  LocationService _impl = null;

  LocationServiceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  LocationServiceStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  LocationServiceStub.unbound() : super.unbound();

  static LocationServiceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For LocationServiceStub"));
    return new LocationServiceStub.fromEndpoint(endpoint);
  }

  static const String name = LocationServiceName;


  LocationServiceGetNextLocationResponseParams _LocationServiceGetNextLocationResponseParamsFactory(location_mojom.Location location) {
    var mojo_factory_result = new LocationServiceGetNextLocationResponseParams();
    mojo_factory_result.location = location;
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
      case kLocationService_getNextLocation_name:
        var params = LocationServiceGetNextLocationParams.deserialize(
            message.payload);
        var response = _impl.getNextLocation(params.priority,_LocationServiceGetNextLocationResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kLocationService_getNextLocation_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kLocationService_getNextLocation_name,
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

  LocationService get impl => _impl;
  set impl(LocationService d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "LocationServiceStub($superString)";
  }

  int get version => 0;
}


