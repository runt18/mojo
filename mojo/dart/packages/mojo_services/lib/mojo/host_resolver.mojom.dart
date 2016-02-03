// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library host_resolver_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo/mojo/network_error.mojom.dart' as network_error_mojom;
import 'package:mojo_services/mojo/net_address.mojom.dart' as net_address_mojom;



class _HostResolverGetHostAddressesParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String host = null;
  net_address_mojom.NetAddressFamily family = null;

  _HostResolverGetHostAddressesParams() : super(kVersions.last.size);

  static _HostResolverGetHostAddressesParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _HostResolverGetHostAddressesParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _HostResolverGetHostAddressesParams result = new _HostResolverGetHostAddressesParams();

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
      
      result.host = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
        result.family = net_address_mojom.NetAddressFamily.decode(decoder0, 16);
        if (result.family == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable net_address_mojom.NetAddressFamily.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(host, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "host of struct _HostResolverGetHostAddressesParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(family, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "family of struct _HostResolverGetHostAddressesParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_HostResolverGetHostAddressesParams("
           "host: $host" ", "
           "family: $family" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["host"] = host;
    map["family"] = family;
    return map;
  }
}




class HostResolverGetHostAddressesResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  network_error_mojom.NetworkError result = null;
  List<net_address_mojom.NetAddress> addresses = null;

  HostResolverGetHostAddressesResponseParams() : super(kVersions.last.size);

  static HostResolverGetHostAddressesResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static HostResolverGetHostAddressesResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    HostResolverGetHostAddressesResponseParams result = new HostResolverGetHostAddressesResponseParams();

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
      result.result = network_error_mojom.NetworkError.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      if (decoder1 == null) {
        result.addresses = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.addresses = new List<net_address_mojom.NetAddress>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.addresses[i1] = net_address_mojom.NetAddress.decode(decoder2);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(result, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "result of struct HostResolverGetHostAddressesResponseParams: $e";
      rethrow;
    }
    try {
      if (addresses == null) {
        encoder0.encodeNullPointer(16, true);
      } else {
        var encoder1 = encoder0.encodePointerArray(addresses.length, 16, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < addresses.length; ++i0) {
          encoder1.encodeStruct(addresses[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "addresses of struct HostResolverGetHostAddressesResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "HostResolverGetHostAddressesResponseParams("
           "result: $result" ", "
           "addresses: $addresses" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["result"] = result;
    map["addresses"] = addresses;
    return map;
  }
}




const int _HostResolver_getHostAddressesName = 0;



class _HostResolverServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class HostResolver {
  static const String serviceName = null;
  dynamic getHostAddresses(String host,net_address_mojom.NetAddressFamily family,[Function responseFactory = null]);
}


class _HostResolverProxyImpl extends bindings.Proxy {
  _HostResolverProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _HostResolverProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _HostResolverProxyImpl.unbound() : super.unbound();

  static _HostResolverProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _HostResolverProxyImpl"));
    return new _HostResolverProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _HostResolverServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _HostResolver_getHostAddressesName:
        var r = HostResolverGetHostAddressesResponseParams.deserialize(
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
    return "_HostResolverProxyImpl($superString)";
  }
}


class _HostResolverProxyCalls implements HostResolver {
  _HostResolverProxyImpl _proxyImpl;

  _HostResolverProxyCalls(this._proxyImpl);
    dynamic getHostAddresses(String host,net_address_mojom.NetAddressFamily family,[Function responseFactory = null]) {
      var params = new _HostResolverGetHostAddressesParams();
      params.host = host;
      params.family = family;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _HostResolver_getHostAddressesName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class HostResolverProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  HostResolver ptr;

  HostResolverProxy(_HostResolverProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _HostResolverProxyCalls(proxyImpl);

  HostResolverProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _HostResolverProxyImpl.fromEndpoint(endpoint) {
    ptr = new _HostResolverProxyCalls(impl);
  }

  HostResolverProxy.fromHandle(core.MojoHandle handle) :
      impl = new _HostResolverProxyImpl.fromHandle(handle) {
    ptr = new _HostResolverProxyCalls(impl);
  }

  HostResolverProxy.unbound() :
      impl = new _HostResolverProxyImpl.unbound() {
    ptr = new _HostResolverProxyCalls(impl);
  }

  factory HostResolverProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    HostResolverProxy p = new HostResolverProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static HostResolverProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HostResolverProxy"));
    return new HostResolverProxy.fromEndpoint(endpoint);
  }

  String get serviceName => HostResolver.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "HostResolverProxy($impl)";
  }
}


class HostResolverStub extends bindings.Stub {
  HostResolver _impl = null;

  HostResolverStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  HostResolverStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  HostResolverStub.unbound() : super.unbound();

  static HostResolverStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HostResolverStub"));
    return new HostResolverStub.fromEndpoint(endpoint);
  }


  HostResolverGetHostAddressesResponseParams _HostResolverGetHostAddressesResponseParamsFactory(network_error_mojom.NetworkError result, List<net_address_mojom.NetAddress> addresses) {
    var mojo_factory_result = new HostResolverGetHostAddressesResponseParams();
    mojo_factory_result.result = result;
    mojo_factory_result.addresses = addresses;
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
      case _HostResolver_getHostAddressesName:
        var params = _HostResolverGetHostAddressesParams.deserialize(
            message.payload);
        var response = _impl.getHostAddresses(params.host,params.family,_HostResolverGetHostAddressesResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _HostResolver_getHostAddressesName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _HostResolver_getHostAddressesName,
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

  HostResolver get impl => _impl;
  set impl(HostResolver d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "HostResolverStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _HostResolverServiceDescription();
}



