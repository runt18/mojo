// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library asset_bundle_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;



class _AssetBundleGetAsStreamParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String assetName = null;

  _AssetBundleGetAsStreamParams() : super(kVersions.last.size);

  static _AssetBundleGetAsStreamParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _AssetBundleGetAsStreamParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _AssetBundleGetAsStreamParams result = new _AssetBundleGetAsStreamParams();

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
      
      result.assetName = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeString(assetName, 8, false);
  }

  String toString() {
    return "_AssetBundleGetAsStreamParams("
           "assetName: $assetName" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["assetName"] = assetName;
    return map;
  }
}


class AssetBundleGetAsStreamResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  core.MojoDataPipeConsumer assetData = null;

  AssetBundleGetAsStreamResponseParams() : super(kVersions.last.size);

  static AssetBundleGetAsStreamResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static AssetBundleGetAsStreamResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    AssetBundleGetAsStreamResponseParams result = new AssetBundleGetAsStreamResponseParams();

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
      
      result.assetData = decoder0.decodeConsumerHandle(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeConsumerHandle(assetData, 8, false);
  }

  String toString() {
    return "AssetBundleGetAsStreamResponseParams("
           "assetData: $assetData" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _AssetUnpackerUnpackZipStreamParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  core.MojoDataPipeConsumer zippedAssets = null;
  Object assetBundle = null;

  _AssetUnpackerUnpackZipStreamParams() : super(kVersions.last.size);

  static _AssetUnpackerUnpackZipStreamParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _AssetUnpackerUnpackZipStreamParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _AssetUnpackerUnpackZipStreamParams result = new _AssetUnpackerUnpackZipStreamParams();

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
      
      result.zippedAssets = decoder0.decodeConsumerHandle(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.assetBundle = decoder0.decodeInterfaceRequest(12, false, AssetBundleStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeConsumerHandle(zippedAssets, 8, false);
    
    encoder0.encodeInterfaceRequest(assetBundle, 12, false);
  }

  String toString() {
    return "_AssetUnpackerUnpackZipStreamParams("
           "zippedAssets: $zippedAssets" ", "
           "assetBundle: $assetBundle" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int _AssetBundle_getAsStreamName = 0;

abstract class AssetBundle {
  static const String serviceName = "mojo::asset_bundle::AssetBundle";
  dynamic getAsStream(String assetName,[Function responseFactory = null]);
}


class _AssetBundleProxyImpl extends bindings.Proxy {
  _AssetBundleProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _AssetBundleProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _AssetBundleProxyImpl.unbound() : super.unbound();

  static _AssetBundleProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _AssetBundleProxyImpl"));
    return new _AssetBundleProxyImpl.fromEndpoint(endpoint);
  }

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _AssetBundle_getAsStreamName:
        var r = AssetBundleGetAsStreamResponseParams.deserialize(
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
    return "_AssetBundleProxyImpl($superString)";
  }
}


class _AssetBundleProxyCalls implements AssetBundle {
  _AssetBundleProxyImpl _proxyImpl;

  _AssetBundleProxyCalls(this._proxyImpl);
    dynamic getAsStream(String assetName,[Function responseFactory = null]) {
      var params = new _AssetBundleGetAsStreamParams();
      params.assetName = assetName;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _AssetBundle_getAsStreamName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class AssetBundleProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  AssetBundle ptr;

  AssetBundleProxy(_AssetBundleProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _AssetBundleProxyCalls(proxyImpl);

  AssetBundleProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _AssetBundleProxyImpl.fromEndpoint(endpoint) {
    ptr = new _AssetBundleProxyCalls(impl);
  }

  AssetBundleProxy.fromHandle(core.MojoHandle handle) :
      impl = new _AssetBundleProxyImpl.fromHandle(handle) {
    ptr = new _AssetBundleProxyCalls(impl);
  }

  AssetBundleProxy.unbound() :
      impl = new _AssetBundleProxyImpl.unbound() {
    ptr = new _AssetBundleProxyCalls(impl);
  }

  factory AssetBundleProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    AssetBundleProxy p = new AssetBundleProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static AssetBundleProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For AssetBundleProxy"));
    return new AssetBundleProxy.fromEndpoint(endpoint);
  }

  String get serviceName => AssetBundle.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "AssetBundleProxy($impl)";
  }
}


class AssetBundleStub extends bindings.Stub {
  AssetBundle _impl = null;

  AssetBundleStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  AssetBundleStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  AssetBundleStub.unbound() : super.unbound();

  static AssetBundleStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For AssetBundleStub"));
    return new AssetBundleStub.fromEndpoint(endpoint);
  }


  AssetBundleGetAsStreamResponseParams _AssetBundleGetAsStreamResponseParamsFactory(core.MojoDataPipeConsumer assetData) {
    var mojo_factory_result = new AssetBundleGetAsStreamResponseParams();
    mojo_factory_result.assetData = assetData;
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
      case _AssetBundle_getAsStreamName:
        var params = _AssetBundleGetAsStreamParams.deserialize(
            message.payload);
        var response = _impl.getAsStream(params.assetName,_AssetBundleGetAsStreamResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _AssetBundle_getAsStreamName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _AssetBundle_getAsStreamName,
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

  AssetBundle get impl => _impl;
  set impl(AssetBundle d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "AssetBundleStub($superString)";
  }

  int get version => 0;
}

const int _AssetUnpacker_unpackZipStreamName = 0;

abstract class AssetUnpacker {
  static const String serviceName = "mojo::asset_bundle::AssetUnpacker";
  void unpackZipStream(core.MojoDataPipeConsumer zippedAssets, Object assetBundle);
}


class _AssetUnpackerProxyImpl extends bindings.Proxy {
  _AssetUnpackerProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _AssetUnpackerProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _AssetUnpackerProxyImpl.unbound() : super.unbound();

  static _AssetUnpackerProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _AssetUnpackerProxyImpl"));
    return new _AssetUnpackerProxyImpl.fromEndpoint(endpoint);
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
    return "_AssetUnpackerProxyImpl($superString)";
  }
}


class _AssetUnpackerProxyCalls implements AssetUnpacker {
  _AssetUnpackerProxyImpl _proxyImpl;

  _AssetUnpackerProxyCalls(this._proxyImpl);
    void unpackZipStream(core.MojoDataPipeConsumer zippedAssets, Object assetBundle) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _AssetUnpackerUnpackZipStreamParams();
      params.zippedAssets = zippedAssets;
      params.assetBundle = assetBundle;
      _proxyImpl.sendMessage(params, _AssetUnpacker_unpackZipStreamName);
    }
}


class AssetUnpackerProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  AssetUnpacker ptr;

  AssetUnpackerProxy(_AssetUnpackerProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _AssetUnpackerProxyCalls(proxyImpl);

  AssetUnpackerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _AssetUnpackerProxyImpl.fromEndpoint(endpoint) {
    ptr = new _AssetUnpackerProxyCalls(impl);
  }

  AssetUnpackerProxy.fromHandle(core.MojoHandle handle) :
      impl = new _AssetUnpackerProxyImpl.fromHandle(handle) {
    ptr = new _AssetUnpackerProxyCalls(impl);
  }

  AssetUnpackerProxy.unbound() :
      impl = new _AssetUnpackerProxyImpl.unbound() {
    ptr = new _AssetUnpackerProxyCalls(impl);
  }

  factory AssetUnpackerProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    AssetUnpackerProxy p = new AssetUnpackerProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static AssetUnpackerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For AssetUnpackerProxy"));
    return new AssetUnpackerProxy.fromEndpoint(endpoint);
  }

  String get serviceName => AssetUnpacker.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "AssetUnpackerProxy($impl)";
  }
}


class AssetUnpackerStub extends bindings.Stub {
  AssetUnpacker _impl = null;

  AssetUnpackerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  AssetUnpackerStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  AssetUnpackerStub.unbound() : super.unbound();

  static AssetUnpackerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For AssetUnpackerStub"));
    return new AssetUnpackerStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _AssetUnpacker_unpackZipStreamName:
        var params = _AssetUnpackerUnpackZipStreamParams.deserialize(
            message.payload);
        _impl.unpackZipStream(params.zippedAssets, params.assetBundle);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  AssetUnpacker get impl => _impl;
  set impl(AssetUnpacker d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "AssetUnpackerStub($superString)";
  }

  int get version => 0;
}


