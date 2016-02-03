// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library input_connection_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/input_events.mojom.dart' as input_events_mojom;



class _InputConnectionSetListenerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object listener = null;

  _InputConnectionSetListenerParams() : super(kVersions.last.size);

  static _InputConnectionSetListenerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _InputConnectionSetListenerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _InputConnectionSetListenerParams result = new _InputConnectionSetListenerParams();

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
      
      result.listener = decoder0.decodeServiceInterface(8, true, InputListenerProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(listener, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "listener of struct _InputConnectionSetListenerParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_InputConnectionSetListenerParams("
           "listener: $listener" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




class _InputListenerOnEventParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  input_events_mojom.Event event = null;

  _InputListenerOnEventParams() : super(kVersions.last.size);

  static _InputListenerOnEventParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _InputListenerOnEventParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _InputListenerOnEventParams result = new _InputListenerOnEventParams();

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
          "event of struct _InputListenerOnEventParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_InputListenerOnEventParams("
           "event: $event" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["event"] = event;
    return map;
  }
}




class InputListenerOnEventResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool consumed = false;

  InputListenerOnEventResponseParams() : super(kVersions.last.size);

  static InputListenerOnEventResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static InputListenerOnEventResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    InputListenerOnEventResponseParams result = new InputListenerOnEventResponseParams();

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
      
      result.consumed = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeBool(consumed, 8, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "consumed of struct InputListenerOnEventResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "InputListenerOnEventResponseParams("
           "consumed: $consumed" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["consumed"] = consumed;
    return map;
  }
}




const int _InputConnection_setListenerName = 0;



class _InputConnectionServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class InputConnection {
  static const String serviceName = "mojo::ui::InputConnection";
  void setListener(Object listener);
}


class _InputConnectionProxyImpl extends bindings.Proxy {
  _InputConnectionProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _InputConnectionProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _InputConnectionProxyImpl.unbound() : super.unbound();

  static _InputConnectionProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _InputConnectionProxyImpl"));
    return new _InputConnectionProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _InputConnectionServiceDescription();

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
    return "_InputConnectionProxyImpl($superString)";
  }
}


class _InputConnectionProxyCalls implements InputConnection {
  _InputConnectionProxyImpl _proxyImpl;

  _InputConnectionProxyCalls(this._proxyImpl);
    void setListener(Object listener) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _InputConnectionSetListenerParams();
      params.listener = listener;
      _proxyImpl.sendMessage(params, _InputConnection_setListenerName);
    }
}


class InputConnectionProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  InputConnection ptr;

  InputConnectionProxy(_InputConnectionProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _InputConnectionProxyCalls(proxyImpl);

  InputConnectionProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _InputConnectionProxyImpl.fromEndpoint(endpoint) {
    ptr = new _InputConnectionProxyCalls(impl);
  }

  InputConnectionProxy.fromHandle(core.MojoHandle handle) :
      impl = new _InputConnectionProxyImpl.fromHandle(handle) {
    ptr = new _InputConnectionProxyCalls(impl);
  }

  InputConnectionProxy.unbound() :
      impl = new _InputConnectionProxyImpl.unbound() {
    ptr = new _InputConnectionProxyCalls(impl);
  }

  factory InputConnectionProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    InputConnectionProxy p = new InputConnectionProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static InputConnectionProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For InputConnectionProxy"));
    return new InputConnectionProxy.fromEndpoint(endpoint);
  }

  String get serviceName => InputConnection.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "InputConnectionProxy($impl)";
  }
}


class InputConnectionStub extends bindings.Stub {
  InputConnection _impl = null;

  InputConnectionStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  InputConnectionStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  InputConnectionStub.unbound() : super.unbound();

  static InputConnectionStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For InputConnectionStub"));
    return new InputConnectionStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _InputConnection_setListenerName:
        var params = _InputConnectionSetListenerParams.deserialize(
            message.payload);
        _impl.setListener(params.listener);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  InputConnection get impl => _impl;
  set impl(InputConnection d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "InputConnectionStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _InputConnectionServiceDescription();
}

const int _InputListener_onEventName = 0;



class _InputListenerServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class InputListener {
  static const String serviceName = null;
  dynamic onEvent(input_events_mojom.Event event,[Function responseFactory = null]);
}


class _InputListenerProxyImpl extends bindings.Proxy {
  _InputListenerProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _InputListenerProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _InputListenerProxyImpl.unbound() : super.unbound();

  static _InputListenerProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _InputListenerProxyImpl"));
    return new _InputListenerProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _InputListenerServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _InputListener_onEventName:
        var r = InputListenerOnEventResponseParams.deserialize(
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
    return "_InputListenerProxyImpl($superString)";
  }
}


class _InputListenerProxyCalls implements InputListener {
  _InputListenerProxyImpl _proxyImpl;

  _InputListenerProxyCalls(this._proxyImpl);
    dynamic onEvent(input_events_mojom.Event event,[Function responseFactory = null]) {
      var params = new _InputListenerOnEventParams();
      params.event = event;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _InputListener_onEventName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class InputListenerProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  InputListener ptr;

  InputListenerProxy(_InputListenerProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _InputListenerProxyCalls(proxyImpl);

  InputListenerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _InputListenerProxyImpl.fromEndpoint(endpoint) {
    ptr = new _InputListenerProxyCalls(impl);
  }

  InputListenerProxy.fromHandle(core.MojoHandle handle) :
      impl = new _InputListenerProxyImpl.fromHandle(handle) {
    ptr = new _InputListenerProxyCalls(impl);
  }

  InputListenerProxy.unbound() :
      impl = new _InputListenerProxyImpl.unbound() {
    ptr = new _InputListenerProxyCalls(impl);
  }

  factory InputListenerProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    InputListenerProxy p = new InputListenerProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static InputListenerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For InputListenerProxy"));
    return new InputListenerProxy.fromEndpoint(endpoint);
  }

  String get serviceName => InputListener.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "InputListenerProxy($impl)";
  }
}


class InputListenerStub extends bindings.Stub {
  InputListener _impl = null;

  InputListenerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  InputListenerStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  InputListenerStub.unbound() : super.unbound();

  static InputListenerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For InputListenerStub"));
    return new InputListenerStub.fromEndpoint(endpoint);
  }


  InputListenerOnEventResponseParams _InputListenerOnEventResponseParamsFactory(bool consumed) {
    var mojo_factory_result = new InputListenerOnEventResponseParams();
    mojo_factory_result.consumed = consumed;
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
      case _InputListener_onEventName:
        var params = _InputListenerOnEventParams.deserialize(
            message.payload);
        var response = _impl.onEvent(params.event,_InputListenerOnEventResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _InputListener_onEventName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _InputListener_onEventName,
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

  InputListener get impl => _impl;
  set impl(InputListener d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "InputListenerStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _InputListenerServiceDescription();
}



