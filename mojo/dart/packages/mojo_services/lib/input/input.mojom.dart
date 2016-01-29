// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library input_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class _InputClientOnBackButtonParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _InputClientOnBackButtonParams() : super(kVersions.last.size);

  static _InputClientOnBackButtonParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _InputClientOnBackButtonParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _InputClientOnBackButtonParams result = new _InputClientOnBackButtonParams();

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
    return "_InputClientOnBackButtonParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}




class InputClientOnBackButtonResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  InputClientOnBackButtonResponseParams() : super(kVersions.last.size);

  static InputClientOnBackButtonResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static InputClientOnBackButtonResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    InputClientOnBackButtonResponseParams result = new InputClientOnBackButtonResponseParams();

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
    return "InputClientOnBackButtonResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}




class _InputServiceSetClientParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object client = null;

  _InputServiceSetClientParams() : super(kVersions.last.size);

  static _InputServiceSetClientParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _InputServiceSetClientParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _InputServiceSetClientParams result = new _InputServiceSetClientParams();

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
      
      result.client = decoder0.decodeServiceInterface(8, false, InputClientProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInterface(client, 8, false);
  }

  String toString() {
    return "_InputServiceSetClientParams("
           "client: $client" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




const int _InputClient_onBackButtonName = 0;



class _InputClientServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class InputClient {
  static const String serviceName = null;
  dynamic onBackButton([Function responseFactory = null]);
}


class _InputClientProxyImpl extends bindings.Proxy {
  _InputClientProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _InputClientProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _InputClientProxyImpl.unbound() : super.unbound();

  static _InputClientProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _InputClientProxyImpl"));
    return new _InputClientProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _InputClientServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _InputClient_onBackButtonName:
        var r = InputClientOnBackButtonResponseParams.deserialize(
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
    return "_InputClientProxyImpl($superString)";
  }
}


class _InputClientProxyCalls implements InputClient {
  _InputClientProxyImpl _proxyImpl;

  _InputClientProxyCalls(this._proxyImpl);
    dynamic onBackButton([Function responseFactory = null]) {
      var params = new _InputClientOnBackButtonParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _InputClient_onBackButtonName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class InputClientProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  InputClient ptr;

  InputClientProxy(_InputClientProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _InputClientProxyCalls(proxyImpl);

  InputClientProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _InputClientProxyImpl.fromEndpoint(endpoint) {
    ptr = new _InputClientProxyCalls(impl);
  }

  InputClientProxy.fromHandle(core.MojoHandle handle) :
      impl = new _InputClientProxyImpl.fromHandle(handle) {
    ptr = new _InputClientProxyCalls(impl);
  }

  InputClientProxy.unbound() :
      impl = new _InputClientProxyImpl.unbound() {
    ptr = new _InputClientProxyCalls(impl);
  }

  factory InputClientProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    InputClientProxy p = new InputClientProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static InputClientProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For InputClientProxy"));
    return new InputClientProxy.fromEndpoint(endpoint);
  }

  String get serviceName => InputClient.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "InputClientProxy($impl)";
  }
}


class InputClientStub extends bindings.Stub {
  InputClient _impl = null;

  InputClientStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  InputClientStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  InputClientStub.unbound() : super.unbound();

  static InputClientStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For InputClientStub"));
    return new InputClientStub.fromEndpoint(endpoint);
  }


  InputClientOnBackButtonResponseParams _InputClientOnBackButtonResponseParamsFactory() {
    var mojo_factory_result = new InputClientOnBackButtonResponseParams();
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
      case _InputClient_onBackButtonName:
        var params = _InputClientOnBackButtonParams.deserialize(
            message.payload);
        var response = _impl.onBackButton(_InputClientOnBackButtonResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _InputClient_onBackButtonName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _InputClient_onBackButtonName,
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

  InputClient get impl => _impl;
  set impl(InputClient d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "InputClientStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _InputClientServiceDescription();
}

const int _InputService_setClientName = 0;



class _InputServiceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class InputService {
  static const String serviceName = "input::InputService";
  void setClient(Object client);
}


class _InputServiceProxyImpl extends bindings.Proxy {
  _InputServiceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _InputServiceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _InputServiceProxyImpl.unbound() : super.unbound();

  static _InputServiceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _InputServiceProxyImpl"));
    return new _InputServiceProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _InputServiceServiceDescription();

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
    return "_InputServiceProxyImpl($superString)";
  }
}


class _InputServiceProxyCalls implements InputService {
  _InputServiceProxyImpl _proxyImpl;

  _InputServiceProxyCalls(this._proxyImpl);
    void setClient(Object client) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _InputServiceSetClientParams();
      params.client = client;
      _proxyImpl.sendMessage(params, _InputService_setClientName);
    }
}


class InputServiceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  InputService ptr;

  InputServiceProxy(_InputServiceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _InputServiceProxyCalls(proxyImpl);

  InputServiceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _InputServiceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _InputServiceProxyCalls(impl);
  }

  InputServiceProxy.fromHandle(core.MojoHandle handle) :
      impl = new _InputServiceProxyImpl.fromHandle(handle) {
    ptr = new _InputServiceProxyCalls(impl);
  }

  InputServiceProxy.unbound() :
      impl = new _InputServiceProxyImpl.unbound() {
    ptr = new _InputServiceProxyCalls(impl);
  }

  factory InputServiceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    InputServiceProxy p = new InputServiceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static InputServiceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For InputServiceProxy"));
    return new InputServiceProxy.fromEndpoint(endpoint);
  }

  String get serviceName => InputService.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "InputServiceProxy($impl)";
  }
}


class InputServiceStub extends bindings.Stub {
  InputService _impl = null;

  InputServiceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  InputServiceStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  InputServiceStub.unbound() : super.unbound();

  static InputServiceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For InputServiceStub"));
    return new InputServiceStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _InputService_setClientName:
        var params = _InputServiceSetClientParams.deserialize(
            message.payload);
        _impl.setClient(params.client);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  InputService get impl => _impl;
  set impl(InputService d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "InputServiceStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _InputServiceServiceDescription();
}



