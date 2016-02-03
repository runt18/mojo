// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library content_handler_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo/mojo/application.mojom.dart' as application_mojom;
import 'package:mojo/mojo/url_response.mojom.dart' as url_response_mojom;



class _ContentHandlerStartApplicationParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  Object application = null;
  url_response_mojom.UrlResponse response = null;

  _ContentHandlerStartApplicationParams() : super(kVersions.last.size);

  static _ContentHandlerStartApplicationParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ContentHandlerStartApplicationParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ContentHandlerStartApplicationParams result = new _ContentHandlerStartApplicationParams();

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
      
      result.application = decoder0.decodeInterfaceRequest(8, false, application_mojom.ApplicationStub.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.response = url_response_mojom.UrlResponse.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(application, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "application of struct _ContentHandlerStartApplicationParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(response, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "response of struct _ContentHandlerStartApplicationParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ContentHandlerStartApplicationParams("
           "application: $application" ", "
           "response: $response" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




const int _ContentHandler_startApplicationName = 0;



class _ContentHandlerServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class ContentHandler {
  static const String serviceName = "mojo::ContentHandler";
  void startApplication(Object application, url_response_mojom.UrlResponse response);
}


class _ContentHandlerProxyImpl extends bindings.Proxy {
  _ContentHandlerProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ContentHandlerProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _ContentHandlerProxyImpl.unbound() : super.unbound();

  static _ContentHandlerProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _ContentHandlerProxyImpl"));
    return new _ContentHandlerProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _ContentHandlerServiceDescription();

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
    return "_ContentHandlerProxyImpl($superString)";
  }
}


class _ContentHandlerProxyCalls implements ContentHandler {
  _ContentHandlerProxyImpl _proxyImpl;

  _ContentHandlerProxyCalls(this._proxyImpl);
    void startApplication(Object application, url_response_mojom.UrlResponse response) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ContentHandlerStartApplicationParams();
      params.application = application;
      params.response = response;
      _proxyImpl.sendMessage(params, _ContentHandler_startApplicationName);
    }
}


class ContentHandlerProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  ContentHandler ptr;

  ContentHandlerProxy(_ContentHandlerProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ContentHandlerProxyCalls(proxyImpl);

  ContentHandlerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _ContentHandlerProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ContentHandlerProxyCalls(impl);
  }

  ContentHandlerProxy.fromHandle(core.MojoHandle handle) :
      impl = new _ContentHandlerProxyImpl.fromHandle(handle) {
    ptr = new _ContentHandlerProxyCalls(impl);
  }

  ContentHandlerProxy.unbound() :
      impl = new _ContentHandlerProxyImpl.unbound() {
    ptr = new _ContentHandlerProxyCalls(impl);
  }

  factory ContentHandlerProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ContentHandlerProxy p = new ContentHandlerProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static ContentHandlerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ContentHandlerProxy"));
    return new ContentHandlerProxy.fromEndpoint(endpoint);
  }

  String get serviceName => ContentHandler.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "ContentHandlerProxy($impl)";
  }
}


class ContentHandlerStub extends bindings.Stub {
  ContentHandler _impl = null;

  ContentHandlerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  ContentHandlerStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  ContentHandlerStub.unbound() : super.unbound();

  static ContentHandlerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ContentHandlerStub"));
    return new ContentHandlerStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _ContentHandler_startApplicationName:
        var params = _ContentHandlerStartApplicationParams.deserialize(
            message.payload);
        _impl.startApplication(params.application, params.response);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  ContentHandler get impl => _impl;
  set impl(ContentHandler d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "ContentHandlerStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _ContentHandlerServiceDescription();
}



