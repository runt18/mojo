// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library vsync_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;



class VSyncProviderAwaitVSyncParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  VSyncProviderAwaitVSyncParams() : super(kVersions.last.size);

  static VSyncProviderAwaitVSyncParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static VSyncProviderAwaitVSyncParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    VSyncProviderAwaitVSyncParams result = new VSyncProviderAwaitVSyncParams();

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
    return "VSyncProviderAwaitVSyncParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class VSyncProviderAwaitVSyncResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int timeStamp = 0;

  VSyncProviderAwaitVSyncResponseParams() : super(kVersions.last.size);

  static VSyncProviderAwaitVSyncResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static VSyncProviderAwaitVSyncResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    VSyncProviderAwaitVSyncResponseParams result = new VSyncProviderAwaitVSyncResponseParams();

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
      
      result.timeStamp = decoder0.decodeInt64(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInt64(timeStamp, 8);
  }

  String toString() {
    return "VSyncProviderAwaitVSyncResponseParams("
           "timeStamp: $timeStamp" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["timeStamp"] = timeStamp;
    return map;
  }
}

const int kVSyncProvider_awaitVSync_name = 0;
const String VSyncProviderName = "vsync::VSyncProvider";

abstract class VSyncProvider {
  dynamic awaitVSync([Function responseFactory = null]);

}


class VSyncProviderProxyImpl extends bindings.Proxy {
  VSyncProviderProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  VSyncProviderProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  VSyncProviderProxyImpl.unbound() : super.unbound();

  static VSyncProviderProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For VSyncProviderProxyImpl"));
    return new VSyncProviderProxyImpl.fromEndpoint(endpoint);
  }

  String get name => VSyncProviderName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case kVSyncProvider_awaitVSync_name:
        var r = VSyncProviderAwaitVSyncResponseParams.deserialize(
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
    return "VSyncProviderProxyImpl($superString)";
  }
}


class _VSyncProviderProxyCalls implements VSyncProvider {
  VSyncProviderProxyImpl _proxyImpl;

  _VSyncProviderProxyCalls(this._proxyImpl);
    dynamic awaitVSync([Function responseFactory = null]) {
      var params = new VSyncProviderAwaitVSyncParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kVSyncProvider_awaitVSync_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class VSyncProviderProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  VSyncProvider ptr;
  final String name = VSyncProviderName;

  VSyncProviderProxy(VSyncProviderProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _VSyncProviderProxyCalls(proxyImpl);

  VSyncProviderProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new VSyncProviderProxyImpl.fromEndpoint(endpoint) {
    ptr = new _VSyncProviderProxyCalls(impl);
  }

  VSyncProviderProxy.fromHandle(core.MojoHandle handle) :
      impl = new VSyncProviderProxyImpl.fromHandle(handle) {
    ptr = new _VSyncProviderProxyCalls(impl);
  }

  VSyncProviderProxy.unbound() :
      impl = new VSyncProviderProxyImpl.unbound() {
    ptr = new _VSyncProviderProxyCalls(impl);
  }

  factory VSyncProviderProxy.connectToService(
      bindings.ServiceConnector s, String url) {
    VSyncProviderProxy p = new VSyncProviderProxy.unbound();
    s.connectToService(url, p);
    return p;
  }

  static VSyncProviderProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For VSyncProviderProxy"));
    return new VSyncProviderProxy.fromEndpoint(endpoint);
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
    return "VSyncProviderProxy($impl)";
  }
}


class VSyncProviderStub extends bindings.Stub {
  VSyncProvider _impl = null;

  VSyncProviderStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  VSyncProviderStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  VSyncProviderStub.unbound() : super.unbound();

  static VSyncProviderStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For VSyncProviderStub"));
    return new VSyncProviderStub.fromEndpoint(endpoint);
  }

  static const String name = VSyncProviderName;


  VSyncProviderAwaitVSyncResponseParams _VSyncProviderAwaitVSyncResponseParamsFactory(int timeStamp) {
    var mojo_factory_result = new VSyncProviderAwaitVSyncResponseParams();
    mojo_factory_result.timeStamp = timeStamp;
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
      case kVSyncProvider_awaitVSync_name:
        var params = VSyncProviderAwaitVSyncParams.deserialize(
            message.payload);
        var response = _impl.awaitVSync(_VSyncProviderAwaitVSyncResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kVSyncProvider_awaitVSync_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kVSyncProvider_awaitVSync_name,
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

  VSyncProvider get impl => _impl;
  set impl(VSyncProvider d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "VSyncProviderStub($superString)";
  }

  int get version => 0;
}


