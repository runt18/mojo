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


class _NfcTransmissionCancelParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _NfcTransmissionCancelParams() : super(kVersions.last.size);

  static _NfcTransmissionCancelParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _NfcTransmissionCancelParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _NfcTransmissionCancelParams result = new _NfcTransmissionCancelParams();

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
    return "_NfcTransmissionCancelParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _NfcReceiverOnReceivedNfcDataParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  NfcData nfcData = null;

  _NfcReceiverOnReceivedNfcDataParams() : super(kVersions.last.size);

  static _NfcReceiverOnReceivedNfcDataParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _NfcReceiverOnReceivedNfcDataParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _NfcReceiverOnReceivedNfcDataParams result = new _NfcReceiverOnReceivedNfcDataParams();

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
    return "_NfcReceiverOnReceivedNfcDataParams("
           "nfcData: $nfcData" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["nfcData"] = nfcData;
    return map;
  }
}


class _NfcTransmitOnNextConnectionParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  NfcData nfcData = null;
  Object transmission = null;

  _NfcTransmitOnNextConnectionParams() : super(kVersions.last.size);

  static _NfcTransmitOnNextConnectionParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _NfcTransmitOnNextConnectionParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _NfcTransmitOnNextConnectionParams result = new _NfcTransmitOnNextConnectionParams();

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
    return "_NfcTransmitOnNextConnectionParams("
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


class _NfcRegisterParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _NfcRegisterParams() : super(kVersions.last.size);

  static _NfcRegisterParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _NfcRegisterParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _NfcRegisterParams result = new _NfcRegisterParams();

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
    return "_NfcRegisterParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _NfcUnregisterParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _NfcUnregisterParams() : super(kVersions.last.size);

  static _NfcUnregisterParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _NfcUnregisterParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _NfcUnregisterParams result = new _NfcUnregisterParams();

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
    return "_NfcUnregisterParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

const int _NfcTransmission_cancelName = 0;

abstract class NfcTransmission {
  static const String serviceName = null;
  void cancel();
}


class _NfcTransmissionProxyImpl extends bindings.Proxy {
  _NfcTransmissionProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _NfcTransmissionProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _NfcTransmissionProxyImpl.unbound() : super.unbound();

  static _NfcTransmissionProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _NfcTransmissionProxyImpl"));
    return new _NfcTransmissionProxyImpl.fromEndpoint(endpoint);
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
    return "_NfcTransmissionProxyImpl($superString)";
  }
}


class _NfcTransmissionProxyCalls implements NfcTransmission {
  _NfcTransmissionProxyImpl _proxyImpl;

  _NfcTransmissionProxyCalls(this._proxyImpl);
    void cancel() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _NfcTransmissionCancelParams();
      _proxyImpl.sendMessage(params, _NfcTransmission_cancelName);
    }
}


class NfcTransmissionProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  NfcTransmission ptr;

  NfcTransmissionProxy(_NfcTransmissionProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _NfcTransmissionProxyCalls(proxyImpl);

  NfcTransmissionProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _NfcTransmissionProxyImpl.fromEndpoint(endpoint) {
    ptr = new _NfcTransmissionProxyCalls(impl);
  }

  NfcTransmissionProxy.fromHandle(core.MojoHandle handle) :
      impl = new _NfcTransmissionProxyImpl.fromHandle(handle) {
    ptr = new _NfcTransmissionProxyCalls(impl);
  }

  NfcTransmissionProxy.unbound() :
      impl = new _NfcTransmissionProxyImpl.unbound() {
    ptr = new _NfcTransmissionProxyCalls(impl);
  }

  factory NfcTransmissionProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    NfcTransmissionProxy p = new NfcTransmissionProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static NfcTransmissionProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NfcTransmissionProxy"));
    return new NfcTransmissionProxy.fromEndpoint(endpoint);
  }

  String get serviceName => NfcTransmission.serviceName;

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



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _NfcTransmission_cancelName:
        var params = _NfcTransmissionCancelParams.deserialize(
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

const int _NfcReceiver_onReceivedNfcDataName = 0;

abstract class NfcReceiver {
  static const String serviceName = "nfc::NfcReceiver";
  void onReceivedNfcData(NfcData nfcData);
}


class _NfcReceiverProxyImpl extends bindings.Proxy {
  _NfcReceiverProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _NfcReceiverProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _NfcReceiverProxyImpl.unbound() : super.unbound();

  static _NfcReceiverProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _NfcReceiverProxyImpl"));
    return new _NfcReceiverProxyImpl.fromEndpoint(endpoint);
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
    return "_NfcReceiverProxyImpl($superString)";
  }
}


class _NfcReceiverProxyCalls implements NfcReceiver {
  _NfcReceiverProxyImpl _proxyImpl;

  _NfcReceiverProxyCalls(this._proxyImpl);
    void onReceivedNfcData(NfcData nfcData) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _NfcReceiverOnReceivedNfcDataParams();
      params.nfcData = nfcData;
      _proxyImpl.sendMessage(params, _NfcReceiver_onReceivedNfcDataName);
    }
}


class NfcReceiverProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  NfcReceiver ptr;

  NfcReceiverProxy(_NfcReceiverProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _NfcReceiverProxyCalls(proxyImpl);

  NfcReceiverProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _NfcReceiverProxyImpl.fromEndpoint(endpoint) {
    ptr = new _NfcReceiverProxyCalls(impl);
  }

  NfcReceiverProxy.fromHandle(core.MojoHandle handle) :
      impl = new _NfcReceiverProxyImpl.fromHandle(handle) {
    ptr = new _NfcReceiverProxyCalls(impl);
  }

  NfcReceiverProxy.unbound() :
      impl = new _NfcReceiverProxyImpl.unbound() {
    ptr = new _NfcReceiverProxyCalls(impl);
  }

  factory NfcReceiverProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    NfcReceiverProxy p = new NfcReceiverProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static NfcReceiverProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NfcReceiverProxy"));
    return new NfcReceiverProxy.fromEndpoint(endpoint);
  }

  String get serviceName => NfcReceiver.serviceName;

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



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _NfcReceiver_onReceivedNfcDataName:
        var params = _NfcReceiverOnReceivedNfcDataParams.deserialize(
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

const int _Nfc_transmitOnNextConnectionName = 0;
const int _Nfc_registerName = 1;
const int _Nfc_unregisterName = 2;

abstract class Nfc {
  static const String serviceName = "nfc::Nfc";
  dynamic transmitOnNextConnection(NfcData nfcData,Object transmission,[Function responseFactory = null]);
  void register();
  void unregister();
}


class _NfcProxyImpl extends bindings.Proxy {
  _NfcProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _NfcProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _NfcProxyImpl.unbound() : super.unbound();

  static _NfcProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _NfcProxyImpl"));
    return new _NfcProxyImpl.fromEndpoint(endpoint);
  }

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _Nfc_transmitOnNextConnectionName:
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
    return "_NfcProxyImpl($superString)";
  }
}


class _NfcProxyCalls implements Nfc {
  _NfcProxyImpl _proxyImpl;

  _NfcProxyCalls(this._proxyImpl);
    dynamic transmitOnNextConnection(NfcData nfcData,Object transmission,[Function responseFactory = null]) {
      var params = new _NfcTransmitOnNextConnectionParams();
      params.nfcData = nfcData;
      params.transmission = transmission;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _Nfc_transmitOnNextConnectionName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    void register() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _NfcRegisterParams();
      _proxyImpl.sendMessage(params, _Nfc_registerName);
    }
    void unregister() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _NfcUnregisterParams();
      _proxyImpl.sendMessage(params, _Nfc_unregisterName);
    }
}


class NfcProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  Nfc ptr;

  NfcProxy(_NfcProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _NfcProxyCalls(proxyImpl);

  NfcProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _NfcProxyImpl.fromEndpoint(endpoint) {
    ptr = new _NfcProxyCalls(impl);
  }

  NfcProxy.fromHandle(core.MojoHandle handle) :
      impl = new _NfcProxyImpl.fromHandle(handle) {
    ptr = new _NfcProxyCalls(impl);
  }

  NfcProxy.unbound() :
      impl = new _NfcProxyImpl.unbound() {
    ptr = new _NfcProxyCalls(impl);
  }

  factory NfcProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    NfcProxy p = new NfcProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static NfcProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NfcProxy"));
    return new NfcProxy.fromEndpoint(endpoint);
  }

  String get serviceName => Nfc.serviceName;

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
      case _Nfc_transmitOnNextConnectionName:
        var params = _NfcTransmitOnNextConnectionParams.deserialize(
            message.payload);
        var response = _impl.transmitOnNextConnection(params.nfcData,params.transmission,_NfcTransmitOnNextConnectionResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _Nfc_transmitOnNextConnectionName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _Nfc_transmitOnNextConnectionName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _Nfc_registerName:
        var params = _NfcRegisterParams.deserialize(
            message.payload);
        _impl.register();
        break;
      case _Nfc_unregisterName:
        var params = _NfcUnregisterParams.deserialize(
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


