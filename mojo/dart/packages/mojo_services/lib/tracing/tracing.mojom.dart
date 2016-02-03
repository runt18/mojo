// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library tracing_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class _TraceProviderStartTracingParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String categories = null;
  Object recorder = null;

  _TraceProviderStartTracingParams() : super(kVersions.last.size);

  static _TraceProviderStartTracingParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _TraceProviderStartTracingParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _TraceProviderStartTracingParams result = new _TraceProviderStartTracingParams();

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
      
      result.categories = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.recorder = decoder0.decodeServiceInterface(16, false, TraceRecorderProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(categories, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "categories of struct _TraceProviderStartTracingParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterface(recorder, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "recorder of struct _TraceProviderStartTracingParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_TraceProviderStartTracingParams("
           "categories: $categories" ", "
           "recorder: $recorder" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




class _TraceProviderStopTracingParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _TraceProviderStopTracingParams() : super(kVersions.last.size);

  static _TraceProviderStopTracingParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _TraceProviderStopTracingParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _TraceProviderStopTracingParams result = new _TraceProviderStopTracingParams();

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
    return "_TraceProviderStopTracingParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}




class _TraceRecorderRecordParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String json = null;

  _TraceRecorderRecordParams() : super(kVersions.last.size);

  static _TraceRecorderRecordParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _TraceRecorderRecordParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _TraceRecorderRecordParams result = new _TraceRecorderRecordParams();

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
      
      result.json = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(json, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "json of struct _TraceRecorderRecordParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_TraceRecorderRecordParams("
           "json: $json" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["json"] = json;
    return map;
  }
}




class _TraceCollectorStartParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  core.MojoDataPipeProducer stream = null;
  String categories = null;

  _TraceCollectorStartParams() : super(kVersions.last.size);

  static _TraceCollectorStartParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _TraceCollectorStartParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _TraceCollectorStartParams result = new _TraceCollectorStartParams();

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
      
      result.stream = decoder0.decodeProducerHandle(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.categories = decoder0.decodeString(16, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeProducerHandle(stream, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "stream of struct _TraceCollectorStartParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(categories, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "categories of struct _TraceCollectorStartParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_TraceCollectorStartParams("
           "stream: $stream" ", "
           "categories: $categories" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




class _TraceCollectorStopAndFlushParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _TraceCollectorStopAndFlushParams() : super(kVersions.last.size);

  static _TraceCollectorStopAndFlushParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _TraceCollectorStopAndFlushParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _TraceCollectorStopAndFlushParams result = new _TraceCollectorStopAndFlushParams();

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
    return "_TraceCollectorStopAndFlushParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}




const int _TraceProvider_startTracingName = 0;
const int _TraceProvider_stopTracingName = 1;



class _TraceProviderServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class TraceProvider {
  static const String serviceName = "tracing::TraceProvider";
  void startTracing(String categories, Object recorder);
  void stopTracing();
}


class _TraceProviderProxyImpl extends bindings.Proxy {
  _TraceProviderProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _TraceProviderProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _TraceProviderProxyImpl.unbound() : super.unbound();

  static _TraceProviderProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _TraceProviderProxyImpl"));
    return new _TraceProviderProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _TraceProviderServiceDescription();

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
    return "_TraceProviderProxyImpl($superString)";
  }
}


class _TraceProviderProxyCalls implements TraceProvider {
  _TraceProviderProxyImpl _proxyImpl;

  _TraceProviderProxyCalls(this._proxyImpl);
    void startTracing(String categories, Object recorder) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _TraceProviderStartTracingParams();
      params.categories = categories;
      params.recorder = recorder;
      _proxyImpl.sendMessage(params, _TraceProvider_startTracingName);
    }
    void stopTracing() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _TraceProviderStopTracingParams();
      _proxyImpl.sendMessage(params, _TraceProvider_stopTracingName);
    }
}


class TraceProviderProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  TraceProvider ptr;

  TraceProviderProxy(_TraceProviderProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _TraceProviderProxyCalls(proxyImpl);

  TraceProviderProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _TraceProviderProxyImpl.fromEndpoint(endpoint) {
    ptr = new _TraceProviderProxyCalls(impl);
  }

  TraceProviderProxy.fromHandle(core.MojoHandle handle) :
      impl = new _TraceProviderProxyImpl.fromHandle(handle) {
    ptr = new _TraceProviderProxyCalls(impl);
  }

  TraceProviderProxy.unbound() :
      impl = new _TraceProviderProxyImpl.unbound() {
    ptr = new _TraceProviderProxyCalls(impl);
  }

  factory TraceProviderProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    TraceProviderProxy p = new TraceProviderProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static TraceProviderProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TraceProviderProxy"));
    return new TraceProviderProxy.fromEndpoint(endpoint);
  }

  String get serviceName => TraceProvider.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "TraceProviderProxy($impl)";
  }
}


class TraceProviderStub extends bindings.Stub {
  TraceProvider _impl = null;

  TraceProviderStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  TraceProviderStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  TraceProviderStub.unbound() : super.unbound();

  static TraceProviderStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TraceProviderStub"));
    return new TraceProviderStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _TraceProvider_startTracingName:
        var params = _TraceProviderStartTracingParams.deserialize(
            message.payload);
        _impl.startTracing(params.categories, params.recorder);
        break;
      case _TraceProvider_stopTracingName:
        var params = _TraceProviderStopTracingParams.deserialize(
            message.payload);
        _impl.stopTracing();
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  TraceProvider get impl => _impl;
  set impl(TraceProvider d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "TraceProviderStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _TraceProviderServiceDescription();
}

const int _TraceRecorder_recordName = 0;



class _TraceRecorderServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class TraceRecorder {
  static const String serviceName = null;
  void record(String json);
}


class _TraceRecorderProxyImpl extends bindings.Proxy {
  _TraceRecorderProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _TraceRecorderProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _TraceRecorderProxyImpl.unbound() : super.unbound();

  static _TraceRecorderProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _TraceRecorderProxyImpl"));
    return new _TraceRecorderProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _TraceRecorderServiceDescription();

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
    return "_TraceRecorderProxyImpl($superString)";
  }
}


class _TraceRecorderProxyCalls implements TraceRecorder {
  _TraceRecorderProxyImpl _proxyImpl;

  _TraceRecorderProxyCalls(this._proxyImpl);
    void record(String json) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _TraceRecorderRecordParams();
      params.json = json;
      _proxyImpl.sendMessage(params, _TraceRecorder_recordName);
    }
}


class TraceRecorderProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  TraceRecorder ptr;

  TraceRecorderProxy(_TraceRecorderProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _TraceRecorderProxyCalls(proxyImpl);

  TraceRecorderProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _TraceRecorderProxyImpl.fromEndpoint(endpoint) {
    ptr = new _TraceRecorderProxyCalls(impl);
  }

  TraceRecorderProxy.fromHandle(core.MojoHandle handle) :
      impl = new _TraceRecorderProxyImpl.fromHandle(handle) {
    ptr = new _TraceRecorderProxyCalls(impl);
  }

  TraceRecorderProxy.unbound() :
      impl = new _TraceRecorderProxyImpl.unbound() {
    ptr = new _TraceRecorderProxyCalls(impl);
  }

  factory TraceRecorderProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    TraceRecorderProxy p = new TraceRecorderProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static TraceRecorderProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TraceRecorderProxy"));
    return new TraceRecorderProxy.fromEndpoint(endpoint);
  }

  String get serviceName => TraceRecorder.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "TraceRecorderProxy($impl)";
  }
}


class TraceRecorderStub extends bindings.Stub {
  TraceRecorder _impl = null;

  TraceRecorderStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  TraceRecorderStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  TraceRecorderStub.unbound() : super.unbound();

  static TraceRecorderStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TraceRecorderStub"));
    return new TraceRecorderStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _TraceRecorder_recordName:
        var params = _TraceRecorderRecordParams.deserialize(
            message.payload);
        _impl.record(params.json);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  TraceRecorder get impl => _impl;
  set impl(TraceRecorder d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "TraceRecorderStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _TraceRecorderServiceDescription();
}

const int _TraceCollector_startName = 0;
const int _TraceCollector_stopAndFlushName = 1;



class _TraceCollectorServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class TraceCollector {
  static const String serviceName = "tracing::TraceCollector";
  void start(core.MojoDataPipeProducer stream, String categories);
  void stopAndFlush();
}


class _TraceCollectorProxyImpl extends bindings.Proxy {
  _TraceCollectorProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _TraceCollectorProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _TraceCollectorProxyImpl.unbound() : super.unbound();

  static _TraceCollectorProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _TraceCollectorProxyImpl"));
    return new _TraceCollectorProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _TraceCollectorServiceDescription();

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
    return "_TraceCollectorProxyImpl($superString)";
  }
}


class _TraceCollectorProxyCalls implements TraceCollector {
  _TraceCollectorProxyImpl _proxyImpl;

  _TraceCollectorProxyCalls(this._proxyImpl);
    void start(core.MojoDataPipeProducer stream, String categories) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _TraceCollectorStartParams();
      params.stream = stream;
      params.categories = categories;
      _proxyImpl.sendMessage(params, _TraceCollector_startName);
    }
    void stopAndFlush() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _TraceCollectorStopAndFlushParams();
      _proxyImpl.sendMessage(params, _TraceCollector_stopAndFlushName);
    }
}


class TraceCollectorProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  TraceCollector ptr;

  TraceCollectorProxy(_TraceCollectorProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _TraceCollectorProxyCalls(proxyImpl);

  TraceCollectorProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _TraceCollectorProxyImpl.fromEndpoint(endpoint) {
    ptr = new _TraceCollectorProxyCalls(impl);
  }

  TraceCollectorProxy.fromHandle(core.MojoHandle handle) :
      impl = new _TraceCollectorProxyImpl.fromHandle(handle) {
    ptr = new _TraceCollectorProxyCalls(impl);
  }

  TraceCollectorProxy.unbound() :
      impl = new _TraceCollectorProxyImpl.unbound() {
    ptr = new _TraceCollectorProxyCalls(impl);
  }

  factory TraceCollectorProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    TraceCollectorProxy p = new TraceCollectorProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static TraceCollectorProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TraceCollectorProxy"));
    return new TraceCollectorProxy.fromEndpoint(endpoint);
  }

  String get serviceName => TraceCollector.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "TraceCollectorProxy($impl)";
  }
}


class TraceCollectorStub extends bindings.Stub {
  TraceCollector _impl = null;

  TraceCollectorStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  TraceCollectorStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  TraceCollectorStub.unbound() : super.unbound();

  static TraceCollectorStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TraceCollectorStub"));
    return new TraceCollectorStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _TraceCollector_startName:
        var params = _TraceCollectorStartParams.deserialize(
            message.payload);
        _impl.start(params.stream, params.categories);
        break;
      case _TraceCollector_stopAndFlushName:
        var params = _TraceCollectorStopAndFlushParams.deserialize(
            message.payload);
        _impl.stopAndFlush();
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  TraceCollector get impl => _impl;
  set impl(TraceCollector d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "TraceCollectorStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _TraceCollectorServiceDescription();
}



