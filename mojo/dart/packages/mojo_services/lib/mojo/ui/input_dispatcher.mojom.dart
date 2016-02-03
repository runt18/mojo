// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library input_dispatcher_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/input_events.mojom.dart' as input_events_mojom;



class _InputDispatcherDispatchEventParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  input_events_mojom.Event event = null;

  _InputDispatcherDispatchEventParams() : super(kVersions.last.size);

  static _InputDispatcherDispatchEventParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _InputDispatcherDispatchEventParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _InputDispatcherDispatchEventParams result = new _InputDispatcherDispatchEventParams();

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
      result.event = input_events_mojom.Event.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(event, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "event of struct _InputDispatcherDispatchEventParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_InputDispatcherDispatchEventParams("
           "event: $event" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["event"] = event;
    return map;
  }
}




const int _InputDispatcher_dispatchEventName = 0;



class _InputDispatcherServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class InputDispatcher {
  static const String serviceName = "mojo::ui::InputDispatcher";
  void dispatchEvent(input_events_mojom.Event event);
}


class _InputDispatcherProxyImpl extends bindings.Proxy {
  _InputDispatcherProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _InputDispatcherProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _InputDispatcherProxyImpl.unbound() : super.unbound();

  static _InputDispatcherProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _InputDispatcherProxyImpl"));
    return new _InputDispatcherProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _InputDispatcherServiceDescription();

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
    return "_InputDispatcherProxyImpl($superString)";
  }
}


class _InputDispatcherProxyCalls implements InputDispatcher {
  _InputDispatcherProxyImpl _proxyImpl;

  _InputDispatcherProxyCalls(this._proxyImpl);
    void dispatchEvent(input_events_mojom.Event event) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _InputDispatcherDispatchEventParams();
      params.event = event;
      _proxyImpl.sendMessage(params, _InputDispatcher_dispatchEventName);
    }
}


class InputDispatcherProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  InputDispatcher ptr;

  InputDispatcherProxy(_InputDispatcherProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _InputDispatcherProxyCalls(proxyImpl);

  InputDispatcherProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _InputDispatcherProxyImpl.fromEndpoint(endpoint) {
    ptr = new _InputDispatcherProxyCalls(impl);
  }

  InputDispatcherProxy.fromHandle(core.MojoHandle handle) :
      impl = new _InputDispatcherProxyImpl.fromHandle(handle) {
    ptr = new _InputDispatcherProxyCalls(impl);
  }

  InputDispatcherProxy.unbound() :
      impl = new _InputDispatcherProxyImpl.unbound() {
    ptr = new _InputDispatcherProxyCalls(impl);
  }

  factory InputDispatcherProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    InputDispatcherProxy p = new InputDispatcherProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static InputDispatcherProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For InputDispatcherProxy"));
    return new InputDispatcherProxy.fromEndpoint(endpoint);
  }

  String get serviceName => InputDispatcher.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "InputDispatcherProxy($impl)";
  }
}


class InputDispatcherStub extends bindings.Stub {
  InputDispatcher _impl = null;

  InputDispatcherStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  InputDispatcherStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  InputDispatcherStub.unbound() : super.unbound();

  static InputDispatcherStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For InputDispatcherStub"));
    return new InputDispatcherStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _InputDispatcher_dispatchEventName:
        var params = _InputDispatcherDispatchEventParams.deserialize(
            message.payload);
        _impl.dispatchEvent(params.event);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  InputDispatcher get impl => _impl;
  set impl(InputDispatcher d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "InputDispatcherStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _InputDispatcherServiceDescription();
}



