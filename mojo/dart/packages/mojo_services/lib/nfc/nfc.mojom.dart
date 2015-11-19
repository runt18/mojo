// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library nfc_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;



class NfcData extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<int> data = null;

  NfcData() : super(kVersions.last.size);

  static NfcData deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NfcData decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NfcData result = new NfcData();

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
      
      result.data = decoder0.decodeUint8Array(8, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint8Array(data, 8, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
  }

  String toString() {
    return "NfcData("
           "data: $data" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["data"] = data;
    return map;
  }
}


class NfcTransmissionCancelParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  NfcTransmissionCancelParams() : super(kVersions.last.size);

  static NfcTransmissionCancelParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NfcTransmissionCancelParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NfcTransmissionCancelParams result = new NfcTransmissionCancelParams();

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
    return "NfcTransmissionCancelParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class NfcReceiverOnReceivedNfcDataParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  NfcData nfcData = null;

  NfcReceiverOnReceivedNfcDataParams() : super(kVersions.last.size);

  static NfcReceiverOnReceivedNfcDataParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NfcReceiverOnReceivedNfcDataParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NfcReceiverOnReceivedNfcDataParams result = new NfcReceiverOnReceivedNfcDataParams();

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
      result.nfcData = NfcData.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(nfcData, 8, false);
  }

  String toString() {
    return "NfcReceiverOnReceivedNfcDataParams("
           "nfcData: $nfcData" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["nfcData"] = nfcData;
    return map;
  }
}


class NfcTransmitOnNextConnectionParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  NfcData nfcData = null;
  Object transmission = null;

  NfcTransmitOnNextConnectionParams() : super(kVersions.last.size);

  static NfcTransmitOnNextConnectionParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NfcTransmitOnNextConnectionParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NfcTransmitOnNextConnectionParams result = new NfcTransmitOnNextConnectionParams();

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
      result.nfcData = NfcData.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.transmission = decoder0.decodeInterfaceRequest(16, true, NfcTransmissionStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(nfcData, 8, false);
    
    encoder0.encodeInterfaceRequest(transmission, 16, true);
  }

  String toString() {
    return "NfcTransmitOnNextConnectionParams("
           "nfcData: $nfcData" ", "
           "transmission: $transmission" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class NfcTransmitOnNextConnectionResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool success = false;

  NfcTransmitOnNextConnectionResponseParams() : super(kVersions.last.size);

  static NfcTransmitOnNextConnectionResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NfcTransmitOnNextConnectionResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NfcTransmitOnNextConnectionResponseParams result = new NfcTransmitOnNextConnectionResponseParams();

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
      
      result.success = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeBool(success, 8, 0);
  }

  String toString() {
    return "NfcTransmitOnNextConnectionResponseParams("
           "success: $success" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["success"] = success;
    return map;
  }
}


class NfcRegisterParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  NfcRegisterParams() : super(kVersions.last.size);

  static NfcRegisterParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NfcRegisterParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NfcRegisterParams result = new NfcRegisterParams();

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
    return "NfcRegisterParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class NfcUnregisterParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  NfcUnregisterParams() : super(kVersions.last.size);

  static NfcUnregisterParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NfcUnregisterParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NfcUnregisterParams result = new NfcUnregisterParams();

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
    return "NfcUnregisterParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

const int kNfcTransmission_cancel_name = 0;

const String NfcTransmissionName =
      'nfc::NfcTransmission';

abstract class NfcTransmission {
  void cancel();

}


class NfcTransmissionProxyImpl extends bindings.Proxy {
  NfcTransmissionProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  NfcTransmissionProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  NfcTransmissionProxyImpl.unbound() : super.unbound();

  static NfcTransmissionProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NfcTransmissionProxyImpl"));
    return new NfcTransmissionProxyImpl.fromEndpoint(endpoint);
  }

  String get name => NfcTransmissionName;

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
    return "NfcTransmissionProxyImpl($superString)";
  }
}


class _NfcTransmissionProxyCalls implements NfcTransmission {
  NfcTransmissionProxyImpl _proxyImpl;

  _NfcTransmissionProxyCalls(this._proxyImpl);
    void cancel() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new NfcTransmissionCancelParams();
      _proxyImpl.sendMessage(params, kNfcTransmission_cancel_name);
    }
  
}


class NfcTransmissionProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  NfcTransmission ptr;
  final String name = NfcTransmissionName;

  NfcTransmissionProxy(NfcTransmissionProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _NfcTransmissionProxyCalls(proxyImpl);

  NfcTransmissionProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new NfcTransmissionProxyImpl.fromEndpoint(endpoint) {
    ptr = new _NfcTransmissionProxyCalls(impl);
  }

  NfcTransmissionProxy.fromHandle(core.MojoHandle handle) :
      impl = new NfcTransmissionProxyImpl.fromHandle(handle) {
    ptr = new _NfcTransmissionProxyCalls(impl);
  }

  NfcTransmissionProxy.unbound() :
      impl = new NfcTransmissionProxyImpl.unbound() {
    ptr = new _NfcTransmissionProxyCalls(impl);
  }

  factory NfcTransmissionProxy.connectToService(
      bindings.ServiceConnector s, String url) {
    NfcTransmissionProxy p = new NfcTransmissionProxy.unbound();
    s.connectToService(url, p);
    return p;
  }

  static NfcTransmissionProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NfcTransmissionProxy"));
    return new NfcTransmissionProxy.fromEndpoint(endpoint);
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
    return "NfcTransmissionProxy($impl)";
  }
}


class NfcTransmissionStub extends bindings.Stub {
  NfcTransmission _impl = null;

  NfcTransmissionStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  NfcTransmissionStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  NfcTransmissionStub.unbound() : super.unbound();

  static NfcTransmissionStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NfcTransmissionStub"));
    return new NfcTransmissionStub.fromEndpoint(endpoint);
  }

  static const String name = NfcTransmissionName;



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case kNfcTransmission_cancel_name:
        var params = NfcTransmissionCancelParams.deserialize(
            message.payload);
        _impl.cancel();
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  NfcTransmission get impl => _impl;
  set impl(NfcTransmission d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "NfcTransmissionStub($superString)";
  }

  int get version => 0;
}

const int kNfcReceiver_onReceivedNfcData_name = 0;

const String NfcReceiverName =
      'nfc::NfcReceiver';

abstract class NfcReceiver {
  void onReceivedNfcData(NfcData nfcData);

}


class NfcReceiverProxyImpl extends bindings.Proxy {
  NfcReceiverProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  NfcReceiverProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  NfcReceiverProxyImpl.unbound() : super.unbound();

  static NfcReceiverProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NfcReceiverProxyImpl"));
    return new NfcReceiverProxyImpl.fromEndpoint(endpoint);
  }

  String get name => NfcReceiverName;

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
    return "NfcReceiverProxyImpl($superString)";
  }
}


class _NfcReceiverProxyCalls implements NfcReceiver {
  NfcReceiverProxyImpl _proxyImpl;

  _NfcReceiverProxyCalls(this._proxyImpl);
    void onReceivedNfcData(NfcData nfcData) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new NfcReceiverOnReceivedNfcDataParams();
      params.nfcData = nfcData;
      _proxyImpl.sendMessage(params, kNfcReceiver_onReceivedNfcData_name);
    }
  
}


class NfcReceiverProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  NfcReceiver ptr;
  final String name = NfcReceiverName;

  NfcReceiverProxy(NfcReceiverProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _NfcReceiverProxyCalls(proxyImpl);

  NfcReceiverProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new NfcReceiverProxyImpl.fromEndpoint(endpoint) {
    ptr = new _NfcReceiverProxyCalls(impl);
  }

  NfcReceiverProxy.fromHandle(core.MojoHandle handle) :
      impl = new NfcReceiverProxyImpl.fromHandle(handle) {
    ptr = new _NfcReceiverProxyCalls(impl);
  }

  NfcReceiverProxy.unbound() :
      impl = new NfcReceiverProxyImpl.unbound() {
    ptr = new _NfcReceiverProxyCalls(impl);
  }

  factory NfcReceiverProxy.connectToService(
      bindings.ServiceConnector s, String url) {
    NfcReceiverProxy p = new NfcReceiverProxy.unbound();
    s.connectToService(url, p);
    return p;
  }

  static NfcReceiverProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NfcReceiverProxy"));
    return new NfcReceiverProxy.fromEndpoint(endpoint);
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
    return "NfcReceiverProxy($impl)";
  }
}


class NfcReceiverStub extends bindings.Stub {
  NfcReceiver _impl = null;

  NfcReceiverStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  NfcReceiverStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  NfcReceiverStub.unbound() : super.unbound();

  static NfcReceiverStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NfcReceiverStub"));
    return new NfcReceiverStub.fromEndpoint(endpoint);
  }

  static const String name = NfcReceiverName;



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case kNfcReceiver_onReceivedNfcData_name:
        var params = NfcReceiverOnReceivedNfcDataParams.deserialize(
            message.payload);
        _impl.onReceivedNfcData(params.nfcData);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  NfcReceiver get impl => _impl;
  set impl(NfcReceiver d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "NfcReceiverStub($superString)";
  }

  int get version => 0;
}

const int kNfc_transmitOnNextConnection_name = 0;
const int kNfc_register_name = 1;
const int kNfc_unregister_name = 2;

const String NfcName =
      'nfc::Nfc';

abstract class Nfc {
  dynamic transmitOnNextConnection(NfcData nfcData,Object transmission,[Function responseFactory = null]);
  void register();
  void unregister();

}


class NfcProxyImpl extends bindings.Proxy {
  NfcProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  NfcProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  NfcProxyImpl.unbound() : super.unbound();

  static NfcProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NfcProxyImpl"));
    return new NfcProxyImpl.fromEndpoint(endpoint);
  }

  String get name => NfcName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case kNfc_transmitOnNextConnection_name:
        var r = NfcTransmitOnNextConnectionResponseParams.deserialize(
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
    return "NfcProxyImpl($superString)";
  }
}


class _NfcProxyCalls implements Nfc {
  NfcProxyImpl _proxyImpl;

  _NfcProxyCalls(this._proxyImpl);
    dynamic transmitOnNextConnection(NfcData nfcData,Object transmission,[Function responseFactory = null]) {
      var params = new NfcTransmitOnNextConnectionParams();
      params.nfcData = nfcData;
      params.transmission = transmission;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kNfc_transmitOnNextConnection_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    void register() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new NfcRegisterParams();
      _proxyImpl.sendMessage(params, kNfc_register_name);
    }
  
    void unregister() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new NfcUnregisterParams();
      _proxyImpl.sendMessage(params, kNfc_unregister_name);
    }
  
}


class NfcProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  Nfc ptr;
  final String name = NfcName;

  NfcProxy(NfcProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _NfcProxyCalls(proxyImpl);

  NfcProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new NfcProxyImpl.fromEndpoint(endpoint) {
    ptr = new _NfcProxyCalls(impl);
  }

  NfcProxy.fromHandle(core.MojoHandle handle) :
      impl = new NfcProxyImpl.fromHandle(handle) {
    ptr = new _NfcProxyCalls(impl);
  }

  NfcProxy.unbound() :
      impl = new NfcProxyImpl.unbound() {
    ptr = new _NfcProxyCalls(impl);
  }

  factory NfcProxy.connectToService(
      bindings.ServiceConnector s, String url) {
    NfcProxy p = new NfcProxy.unbound();
    s.connectToService(url, p);
    return p;
  }

  static NfcProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NfcProxy"));
    return new NfcProxy.fromEndpoint(endpoint);
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
    return "NfcProxy($impl)";
  }
}


class NfcStub extends bindings.Stub {
  Nfc _impl = null;

  NfcStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  NfcStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  NfcStub.unbound() : super.unbound();

  static NfcStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NfcStub"));
    return new NfcStub.fromEndpoint(endpoint);
  }

  static const String name = NfcName;


  NfcTransmitOnNextConnectionResponseParams _NfcTransmitOnNextConnectionResponseParamsFactory(bool success) {
    var mojo_factory_result = new NfcTransmitOnNextConnectionResponseParams();
    mojo_factory_result.success = success;
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
      case kNfc_transmitOnNextConnection_name:
        var params = NfcTransmitOnNextConnectionParams.deserialize(
            message.payload);
        var response = _impl.transmitOnNextConnection(params.nfcData,params.transmission,_NfcTransmitOnNextConnectionResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kNfc_transmitOnNextConnection_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kNfc_transmitOnNextConnection_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kNfc_register_name:
        var params = NfcRegisterParams.deserialize(
            message.payload);
        _impl.register();
        break;
      case kNfc_unregister_name:
        var params = NfcUnregisterParams.deserialize(
            message.payload);
        _impl.unregister();
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  Nfc get impl => _impl;
  set impl(Nfc d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "NfcStub($superString)";
  }

  int get version => 0;
}


