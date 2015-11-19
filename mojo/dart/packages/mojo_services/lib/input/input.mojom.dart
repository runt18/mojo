// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library input_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;



class InputClientOnBackButtonParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  InputClientOnBackButtonParams() : super(kVersions.last.size);

  static InputClientOnBackButtonParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static InputClientOnBackButtonParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    InputClientOnBackButtonParams result = new InputClientOnBackButtonParams();

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
    return "InputClientOnBackButtonParams("")";
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


class InputServiceSetClientParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object client = null;

  InputServiceSetClientParams() : super(kVersions.last.size);

  static InputServiceSetClientParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static InputServiceSetClientParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    InputServiceSetClientParams result = new InputServiceSetClientParams();

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
    return "InputServiceSetClientParams("
           "client: $client" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int kInputClient_onBackButton_name = 0;

const String InputClientName =
      'input::InputClient';

abstract class InputClient {
  dynamic onBackButton([Function responseFactory = null]);

}


class InputClientProxyImpl extends bindings.Proxy {
  InputClientProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  InputClientProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  InputClientProxyImpl.unbound() : super.unbound();

  static InputClientProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For InputClientProxyImpl"));
    return new InputClientProxyImpl.fromEndpoint(endpoint);
  }

  String get name => InputClientName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case kInputClient_onBackButton_name:
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
    return "InputClientProxyImpl($superString)";
  }
}


class _InputClientProxyCalls implements InputClient {
  InputClientProxyImpl _proxyImpl;

  _InputClientProxyCalls(this._proxyImpl);
    dynamic onBackButton([Function responseFactory = null]) {
      var params = new InputClientOnBackButtonParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kInputClient_onBackButton_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class InputClientProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  InputClient ptr;
  final String name = InputClientName;

  InputClientProxy(InputClientProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _InputClientProxyCalls(proxyImpl);

  InputClientProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new InputClientProxyImpl.fromEndpoint(endpoint) {
    ptr = new _InputClientProxyCalls(impl);
  }

  InputClientProxy.fromHandle(core.MojoHandle handle) :
      impl = new InputClientProxyImpl.fromHandle(handle) {
    ptr = new _InputClientProxyCalls(impl);
  }

  InputClientProxy.unbound() :
      impl = new InputClientProxyImpl.unbound() {
    ptr = new _InputClientProxyCalls(impl);
  }

  factory InputClientProxy.connectToService(
      bindings.ServiceConnector s, String url) {
    InputClientProxy p = new InputClientProxy.unbound();
    s.connectToService(url, p);
    return p;
  }

  static InputClientProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For InputClientProxy"));
    return new InputClientProxy.fromEndpoint(endpoint);
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

  static const String name = InputClientName;


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
      case kInputClient_onBackButton_name:
        var params = InputClientOnBackButtonParams.deserialize(
            message.payload);
        var response = _impl.onBackButton(_InputClientOnBackButtonResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kInputClient_onBackButton_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kInputClient_onBackButton_name,
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
}

const int kInputService_setClient_name = 0;

const String InputServiceName =
      'input::InputService';

abstract class InputService {
  void setClient(Object client);

}


class InputServiceProxyImpl extends bindings.Proxy {
  InputServiceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  InputServiceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  InputServiceProxyImpl.unbound() : super.unbound();

  static InputServiceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For InputServiceProxyImpl"));
    return new InputServiceProxyImpl.fromEndpoint(endpoint);
  }

  String get name => InputServiceName;

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
    return "InputServiceProxyImpl($superString)";
  }
}


class _InputServiceProxyCalls implements InputService {
  InputServiceProxyImpl _proxyImpl;

  _InputServiceProxyCalls(this._proxyImpl);
    void setClient(Object client) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new InputServiceSetClientParams();
      params.client = client;
      _proxyImpl.sendMessage(params, kInputService_setClient_name);
    }
  
}


class InputServiceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  InputService ptr;
  final String name = InputServiceName;

  InputServiceProxy(InputServiceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _InputServiceProxyCalls(proxyImpl);

  InputServiceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new InputServiceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _InputServiceProxyCalls(impl);
  }

  InputServiceProxy.fromHandle(core.MojoHandle handle) :
      impl = new InputServiceProxyImpl.fromHandle(handle) {
    ptr = new _InputServiceProxyCalls(impl);
  }

  InputServiceProxy.unbound() :
      impl = new InputServiceProxyImpl.unbound() {
    ptr = new _InputServiceProxyCalls(impl);
  }

  factory InputServiceProxy.connectToService(
      bindings.ServiceConnector s, String url) {
    InputServiceProxy p = new InputServiceProxy.unbound();
    s.connectToService(url, p);
    return p;
  }

  static InputServiceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For InputServiceProxy"));
    return new InputServiceProxy.fromEndpoint(endpoint);
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

  static const String name = InputServiceName;



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case kInputService_setClient_name:
        var params = InputServiceSetClientParams.deserialize(
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
}


