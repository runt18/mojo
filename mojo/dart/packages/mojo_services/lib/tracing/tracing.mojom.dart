// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library tracing_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;



class TraceProviderStartTracingParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String categories = null;
  Object recorder = null;

  TraceProviderStartTracingParams() : super(kVersions.last.size);

  static TraceProviderStartTracingParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TraceProviderStartTracingParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TraceProviderStartTracingParams result = new TraceProviderStartTracingParams();

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
    
    encoder0.encodeString(categories, 8, false);
    
    encoder0.encodeInterface(recorder, 16, false);
  }

  String toString() {
    return "TraceProviderStartTracingParams("
           "categories: $categories" ", "
           "recorder: $recorder" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class TraceProviderStopTracingParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  TraceProviderStopTracingParams() : super(kVersions.last.size);

  static TraceProviderStopTracingParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TraceProviderStopTracingParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TraceProviderStopTracingParams result = new TraceProviderStopTracingParams();

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
    return "TraceProviderStopTracingParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class TraceRecorderRecordParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String json = null;

  TraceRecorderRecordParams() : super(kVersions.last.size);

  static TraceRecorderRecordParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TraceRecorderRecordParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TraceRecorderRecordParams result = new TraceRecorderRecordParams();

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
    
    encoder0.encodeString(json, 8, false);
  }

  String toString() {
    return "TraceRecorderRecordParams("
           "json: $json" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["json"] = json;
    return map;
  }
}


class TraceCollectorStartParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  core.MojoDataPipeProducer stream = null;
  String categories = null;

  TraceCollectorStartParams() : super(kVersions.last.size);

  static TraceCollectorStartParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TraceCollectorStartParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TraceCollectorStartParams result = new TraceCollectorStartParams();

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
    
    encoder0.encodeProducerHandle(stream, 8, false);
    
    encoder0.encodeString(categories, 16, false);
  }

  String toString() {
    return "TraceCollectorStartParams("
           "stream: $stream" ", "
           "categories: $categories" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class TraceCollectorStopAndFlushParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  TraceCollectorStopAndFlushParams() : super(kVersions.last.size);

  static TraceCollectorStopAndFlushParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TraceCollectorStopAndFlushParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TraceCollectorStopAndFlushParams result = new TraceCollectorStopAndFlushParams();

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
    return "TraceCollectorStopAndFlushParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

const int kTraceProvider_startTracing_name = 0;
const int kTraceProvider_stopTracing_name = 1;
const String TraceProviderName = "tracing::TraceProvider";

abstract class TraceProvider {
  void startTracing(String categories, Object recorder);
  void stopTracing();

}


class TraceProviderProxyImpl extends bindings.Proxy {
  TraceProviderProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  TraceProviderProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  TraceProviderProxyImpl.unbound() : super.unbound();

  static TraceProviderProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TraceProviderProxyImpl"));
    return new TraceProviderProxyImpl.fromEndpoint(endpoint);
  }

  String get name => TraceProviderName;

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
    return "TraceProviderProxyImpl($superString)";
  }
}


class _TraceProviderProxyCalls implements TraceProvider {
  TraceProviderProxyImpl _proxyImpl;

  _TraceProviderProxyCalls(this._proxyImpl);
    void startTracing(String categories, Object recorder) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new TraceProviderStartTracingParams();
      params.categories = categories;
      params.recorder = recorder;
      _proxyImpl.sendMessage(params, kTraceProvider_startTracing_name);
    }
  
    void stopTracing() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new TraceProviderStopTracingParams();
      _proxyImpl.sendMessage(params, kTraceProvider_stopTracing_name);
    }
  
}


class TraceProviderProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  TraceProvider ptr;
  final String name = TraceProviderName;

  TraceProviderProxy(TraceProviderProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _TraceProviderProxyCalls(proxyImpl);

  TraceProviderProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new TraceProviderProxyImpl.fromEndpoint(endpoint) {
    ptr = new _TraceProviderProxyCalls(impl);
  }

  TraceProviderProxy.fromHandle(core.MojoHandle handle) :
      impl = new TraceProviderProxyImpl.fromHandle(handle) {
    ptr = new _TraceProviderProxyCalls(impl);
  }

  TraceProviderProxy.unbound() :
      impl = new TraceProviderProxyImpl.unbound() {
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

  static const String name = TraceProviderName;



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case kTraceProvider_startTracing_name:
        var params = TraceProviderStartTracingParams.deserialize(
            message.payload);
        _impl.startTracing(params.categories, params.recorder);
        break;
      case kTraceProvider_stopTracing_name:
        var params = TraceProviderStopTracingParams.deserialize(
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
}

const int kTraceRecorder_record_name = 0;
const String TraceRecorderName = null;

abstract class TraceRecorder {
  void record(String json);

}


class TraceRecorderProxyImpl extends bindings.Proxy {
  TraceRecorderProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  TraceRecorderProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  TraceRecorderProxyImpl.unbound() : super.unbound();

  static TraceRecorderProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TraceRecorderProxyImpl"));
    return new TraceRecorderProxyImpl.fromEndpoint(endpoint);
  }

  String get name => TraceRecorderName;

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
    return "TraceRecorderProxyImpl($superString)";
  }
}


class _TraceRecorderProxyCalls implements TraceRecorder {
  TraceRecorderProxyImpl _proxyImpl;

  _TraceRecorderProxyCalls(this._proxyImpl);
    void record(String json) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new TraceRecorderRecordParams();
      params.json = json;
      _proxyImpl.sendMessage(params, kTraceRecorder_record_name);
    }
  
}


class TraceRecorderProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  TraceRecorder ptr;
  final String name = TraceRecorderName;

  TraceRecorderProxy(TraceRecorderProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _TraceRecorderProxyCalls(proxyImpl);

  TraceRecorderProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new TraceRecorderProxyImpl.fromEndpoint(endpoint) {
    ptr = new _TraceRecorderProxyCalls(impl);
  }

  TraceRecorderProxy.fromHandle(core.MojoHandle handle) :
      impl = new TraceRecorderProxyImpl.fromHandle(handle) {
    ptr = new _TraceRecorderProxyCalls(impl);
  }

  TraceRecorderProxy.unbound() :
      impl = new TraceRecorderProxyImpl.unbound() {
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

  static const String name = TraceRecorderName;



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case kTraceRecorder_record_name:
        var params = TraceRecorderRecordParams.deserialize(
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
}

const int kTraceCollector_start_name = 0;
const int kTraceCollector_stopAndFlush_name = 1;
const String TraceCollectorName = "tracing::TraceCollector";

abstract class TraceCollector {
  void start(core.MojoDataPipeProducer stream, String categories);
  void stopAndFlush();

}


class TraceCollectorProxyImpl extends bindings.Proxy {
  TraceCollectorProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  TraceCollectorProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  TraceCollectorProxyImpl.unbound() : super.unbound();

  static TraceCollectorProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TraceCollectorProxyImpl"));
    return new TraceCollectorProxyImpl.fromEndpoint(endpoint);
  }

  String get name => TraceCollectorName;

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
    return "TraceCollectorProxyImpl($superString)";
  }
}


class _TraceCollectorProxyCalls implements TraceCollector {
  TraceCollectorProxyImpl _proxyImpl;

  _TraceCollectorProxyCalls(this._proxyImpl);
    void start(core.MojoDataPipeProducer stream, String categories) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new TraceCollectorStartParams();
      params.stream = stream;
      params.categories = categories;
      _proxyImpl.sendMessage(params, kTraceCollector_start_name);
    }
  
    void stopAndFlush() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new TraceCollectorStopAndFlushParams();
      _proxyImpl.sendMessage(params, kTraceCollector_stopAndFlush_name);
    }
  
}


class TraceCollectorProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  TraceCollector ptr;
  final String name = TraceCollectorName;

  TraceCollectorProxy(TraceCollectorProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _TraceCollectorProxyCalls(proxyImpl);

  TraceCollectorProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new TraceCollectorProxyImpl.fromEndpoint(endpoint) {
    ptr = new _TraceCollectorProxyCalls(impl);
  }

  TraceCollectorProxy.fromHandle(core.MojoHandle handle) :
      impl = new TraceCollectorProxyImpl.fromHandle(handle) {
    ptr = new _TraceCollectorProxyCalls(impl);
  }

  TraceCollectorProxy.unbound() :
      impl = new TraceCollectorProxyImpl.unbound() {
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

  static const String name = TraceCollectorName;



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case kTraceCollector_start_name:
        var params = TraceCollectorStartParams.deserialize(
            message.payload);
        _impl.start(params.stream, params.categories);
        break;
      case kTraceCollector_stopAndFlush_name:
        var params = TraceCollectorStopAndFlushParams.deserialize(
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
}


