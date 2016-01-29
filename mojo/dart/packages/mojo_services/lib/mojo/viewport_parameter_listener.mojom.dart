// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library viewport_parameter_listener_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class _ViewportParameterListenerOnVSyncParametersUpdatedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int timebase = 0;
  int interval = 0;

  _ViewportParameterListenerOnVSyncParametersUpdatedParams() : super(kVersions.last.size);

  static _ViewportParameterListenerOnVSyncParametersUpdatedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewportParameterListenerOnVSyncParametersUpdatedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewportParameterListenerOnVSyncParametersUpdatedParams result = new _ViewportParameterListenerOnVSyncParametersUpdatedParams();

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
      
      result.timebase = decoder0.decodeInt64(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.interval = decoder0.decodeInt64(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInt64(timebase, 8);
    
    encoder0.encodeInt64(interval, 16);
  }

  String toString() {
    return "_ViewportParameterListenerOnVSyncParametersUpdatedParams("
           "timebase: $timebase" ", "
           "interval: $interval" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["timebase"] = timebase;
    map["interval"] = interval;
    return map;
  }
}




const int _ViewportParameterListener_onVSyncParametersUpdatedName = 0;



class _ViewportParameterListenerServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class ViewportParameterListener {
  static const String serviceName = null;
  void onVSyncParametersUpdated(int timebase, int interval);
}


class _ViewportParameterListenerProxyImpl extends bindings.Proxy {
  _ViewportParameterListenerProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ViewportParameterListenerProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _ViewportParameterListenerProxyImpl.unbound() : super.unbound();

  static _ViewportParameterListenerProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _ViewportParameterListenerProxyImpl"));
    return new _ViewportParameterListenerProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _ViewportParameterListenerServiceDescription();

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
    return "_ViewportParameterListenerProxyImpl($superString)";
  }
}


class _ViewportParameterListenerProxyCalls implements ViewportParameterListener {
  _ViewportParameterListenerProxyImpl _proxyImpl;

  _ViewportParameterListenerProxyCalls(this._proxyImpl);
    void onVSyncParametersUpdated(int timebase, int interval) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ViewportParameterListenerOnVSyncParametersUpdatedParams();
      params.timebase = timebase;
      params.interval = interval;
      _proxyImpl.sendMessage(params, _ViewportParameterListener_onVSyncParametersUpdatedName);
    }
}


class ViewportParameterListenerProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  ViewportParameterListener ptr;

  ViewportParameterListenerProxy(_ViewportParameterListenerProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ViewportParameterListenerProxyCalls(proxyImpl);

  ViewportParameterListenerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _ViewportParameterListenerProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ViewportParameterListenerProxyCalls(impl);
  }

  ViewportParameterListenerProxy.fromHandle(core.MojoHandle handle) :
      impl = new _ViewportParameterListenerProxyImpl.fromHandle(handle) {
    ptr = new _ViewportParameterListenerProxyCalls(impl);
  }

  ViewportParameterListenerProxy.unbound() :
      impl = new _ViewportParameterListenerProxyImpl.unbound() {
    ptr = new _ViewportParameterListenerProxyCalls(impl);
  }

  factory ViewportParameterListenerProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ViewportParameterListenerProxy p = new ViewportParameterListenerProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static ViewportParameterListenerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewportParameterListenerProxy"));
    return new ViewportParameterListenerProxy.fromEndpoint(endpoint);
  }

  String get serviceName => ViewportParameterListener.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "ViewportParameterListenerProxy($impl)";
  }
}


class ViewportParameterListenerStub extends bindings.Stub {
  ViewportParameterListener _impl = null;

  ViewportParameterListenerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  ViewportParameterListenerStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  ViewportParameterListenerStub.unbound() : super.unbound();

  static ViewportParameterListenerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewportParameterListenerStub"));
    return new ViewportParameterListenerStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _ViewportParameterListener_onVSyncParametersUpdatedName:
        var params = _ViewportParameterListenerOnVSyncParametersUpdatedParams.deserialize(
            message.payload);
        _impl.onVSyncParametersUpdated(params.timebase, params.interval);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  ViewportParameterListener get impl => _impl;
  set impl(ViewportParameterListener d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "ViewportParameterListenerStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _ViewportParameterListenerServiceDescription();
}



