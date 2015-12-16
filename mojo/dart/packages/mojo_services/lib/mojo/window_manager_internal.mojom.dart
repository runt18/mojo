// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library window_manager_internal_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo_services/mojo/geometry.mojom.dart' as geometry_mojom;
import 'package:mojo_services/mojo/input_events.mojom.dart' as input_events_mojom;



class _WindowManagerInternalCreateWindowManagerForViewManagerClientParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int connectionId = 0;
  core.MojoMessagePipeEndpoint windowManagerPipe = null;

  _WindowManagerInternalCreateWindowManagerForViewManagerClientParams() : super(kVersions.last.size);

  static _WindowManagerInternalCreateWindowManagerForViewManagerClientParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _WindowManagerInternalCreateWindowManagerForViewManagerClientParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _WindowManagerInternalCreateWindowManagerForViewManagerClientParams result = new _WindowManagerInternalCreateWindowManagerForViewManagerClientParams();

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
      
      result.connectionId = decoder0.decodeUint16(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.windowManagerPipe = decoder0.decodeMessagePipeHandle(12, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint16(connectionId, 8);
    
    encoder0.encodeMessagePipeHandle(windowManagerPipe, 12, false);
  }

  String toString() {
    return "_WindowManagerInternalCreateWindowManagerForViewManagerClientParams("
           "connectionId: $connectionId" ", "
           "windowManagerPipe: $windowManagerPipe" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _WindowManagerInternalSetViewManagerClientParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  core.MojoMessagePipeEndpoint viewManagerClientRequest = null;

  _WindowManagerInternalSetViewManagerClientParams() : super(kVersions.last.size);

  static _WindowManagerInternalSetViewManagerClientParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _WindowManagerInternalSetViewManagerClientParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _WindowManagerInternalSetViewManagerClientParams result = new _WindowManagerInternalSetViewManagerClientParams();

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
      
      result.viewManagerClientRequest = decoder0.decodeMessagePipeHandle(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeMessagePipeHandle(viewManagerClientRequest, 8, false);
  }

  String toString() {
    return "_WindowManagerInternalSetViewManagerClientParams("
           "viewManagerClientRequest: $viewManagerClientRequest" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _WindowManagerInternalClientDispatchInputEventToViewParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int viewId = 0;
  input_events_mojom.Event event = null;

  _WindowManagerInternalClientDispatchInputEventToViewParams() : super(kVersions.last.size);

  static _WindowManagerInternalClientDispatchInputEventToViewParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _WindowManagerInternalClientDispatchInputEventToViewParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _WindowManagerInternalClientDispatchInputEventToViewParams result = new _WindowManagerInternalClientDispatchInputEventToViewParams();

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
      
      result.viewId = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.event = input_events_mojom.Event.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(viewId, 8);
    
    encoder0.encodeStruct(event, 16, false);
  }

  String toString() {
    return "_WindowManagerInternalClientDispatchInputEventToViewParams("
           "viewId: $viewId" ", "
           "event: $event" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["viewId"] = viewId;
    map["event"] = event;
    return map;
  }
}


class _WindowManagerInternalClientSetViewportSizeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  geometry_mojom.Size size = null;

  _WindowManagerInternalClientSetViewportSizeParams() : super(kVersions.last.size);

  static _WindowManagerInternalClientSetViewportSizeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _WindowManagerInternalClientSetViewportSizeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _WindowManagerInternalClientSetViewportSizeParams result = new _WindowManagerInternalClientSetViewportSizeParams();

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
      result.size = geometry_mojom.Size.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(size, 8, false);
  }

  String toString() {
    return "_WindowManagerInternalClientSetViewportSizeParams("
           "size: $size" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["size"] = size;
    return map;
  }
}


class _WindowManagerInternalClientCloneAndAnimateParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int viewId = 0;

  _WindowManagerInternalClientCloneAndAnimateParams() : super(kVersions.last.size);

  static _WindowManagerInternalClientCloneAndAnimateParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _WindowManagerInternalClientCloneAndAnimateParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _WindowManagerInternalClientCloneAndAnimateParams result = new _WindowManagerInternalClientCloneAndAnimateParams();

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
      
      result.viewId = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(viewId, 8);
  }

  String toString() {
    return "_WindowManagerInternalClientCloneAndAnimateParams("
           "viewId: $viewId" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["viewId"] = viewId;
    return map;
  }
}

const int _WindowManagerInternal_createWindowManagerForViewManagerClientName = 0;
const int _WindowManagerInternal_setViewManagerClientName = 1;

abstract class WindowManagerInternal {
  static const String serviceName = "mojo::WindowManagerInternal";
  void createWindowManagerForViewManagerClient(int connectionId, core.MojoMessagePipeEndpoint windowManagerPipe);
  void setViewManagerClient(core.MojoMessagePipeEndpoint viewManagerClientRequest);
}


class _WindowManagerInternalProxyImpl extends bindings.Proxy {
  _WindowManagerInternalProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _WindowManagerInternalProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _WindowManagerInternalProxyImpl.unbound() : super.unbound();

  static _WindowManagerInternalProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _WindowManagerInternalProxyImpl"));
    return new _WindowManagerInternalProxyImpl.fromEndpoint(endpoint);
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
    return "_WindowManagerInternalProxyImpl($superString)";
  }
}


class _WindowManagerInternalProxyCalls implements WindowManagerInternal {
  _WindowManagerInternalProxyImpl _proxyImpl;

  _WindowManagerInternalProxyCalls(this._proxyImpl);
    void createWindowManagerForViewManagerClient(int connectionId, core.MojoMessagePipeEndpoint windowManagerPipe) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _WindowManagerInternalCreateWindowManagerForViewManagerClientParams();
      params.connectionId = connectionId;
      params.windowManagerPipe = windowManagerPipe;
      _proxyImpl.sendMessage(params, _WindowManagerInternal_createWindowManagerForViewManagerClientName);
    }
    void setViewManagerClient(core.MojoMessagePipeEndpoint viewManagerClientRequest) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _WindowManagerInternalSetViewManagerClientParams();
      params.viewManagerClientRequest = viewManagerClientRequest;
      _proxyImpl.sendMessage(params, _WindowManagerInternal_setViewManagerClientName);
    }
}


class WindowManagerInternalProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  WindowManagerInternal ptr;

  WindowManagerInternalProxy(_WindowManagerInternalProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _WindowManagerInternalProxyCalls(proxyImpl);

  WindowManagerInternalProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _WindowManagerInternalProxyImpl.fromEndpoint(endpoint) {
    ptr = new _WindowManagerInternalProxyCalls(impl);
  }

  WindowManagerInternalProxy.fromHandle(core.MojoHandle handle) :
      impl = new _WindowManagerInternalProxyImpl.fromHandle(handle) {
    ptr = new _WindowManagerInternalProxyCalls(impl);
  }

  WindowManagerInternalProxy.unbound() :
      impl = new _WindowManagerInternalProxyImpl.unbound() {
    ptr = new _WindowManagerInternalProxyCalls(impl);
  }

  factory WindowManagerInternalProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    WindowManagerInternalProxy p = new WindowManagerInternalProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static WindowManagerInternalProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For WindowManagerInternalProxy"));
    return new WindowManagerInternalProxy.fromEndpoint(endpoint);
  }

  String get serviceName => WindowManagerInternal.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "WindowManagerInternalProxy($impl)";
  }
}


class WindowManagerInternalStub extends bindings.Stub {
  WindowManagerInternal _impl = null;

  WindowManagerInternalStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  WindowManagerInternalStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  WindowManagerInternalStub.unbound() : super.unbound();

  static WindowManagerInternalStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For WindowManagerInternalStub"));
    return new WindowManagerInternalStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _WindowManagerInternal_createWindowManagerForViewManagerClientName:
        var params = _WindowManagerInternalCreateWindowManagerForViewManagerClientParams.deserialize(
            message.payload);
        _impl.createWindowManagerForViewManagerClient(params.connectionId, params.windowManagerPipe);
        break;
      case _WindowManagerInternal_setViewManagerClientName:
        var params = _WindowManagerInternalSetViewManagerClientParams.deserialize(
            message.payload);
        _impl.setViewManagerClient(params.viewManagerClientRequest);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  WindowManagerInternal get impl => _impl;
  set impl(WindowManagerInternal d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "WindowManagerInternalStub($superString)";
  }

  int get version => 0;
}

const int _WindowManagerInternalClient_dispatchInputEventToViewName = 0;
const int _WindowManagerInternalClient_setViewportSizeName = 1;
const int _WindowManagerInternalClient_cloneAndAnimateName = 2;

abstract class WindowManagerInternalClient {
  static const String serviceName = "mojo::WindowManagerInternalClient";
  void dispatchInputEventToView(int viewId, input_events_mojom.Event event);
  void setViewportSize(geometry_mojom.Size size);
  void cloneAndAnimate(int viewId);
}


class _WindowManagerInternalClientProxyImpl extends bindings.Proxy {
  _WindowManagerInternalClientProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _WindowManagerInternalClientProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _WindowManagerInternalClientProxyImpl.unbound() : super.unbound();

  static _WindowManagerInternalClientProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _WindowManagerInternalClientProxyImpl"));
    return new _WindowManagerInternalClientProxyImpl.fromEndpoint(endpoint);
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
    return "_WindowManagerInternalClientProxyImpl($superString)";
  }
}


class _WindowManagerInternalClientProxyCalls implements WindowManagerInternalClient {
  _WindowManagerInternalClientProxyImpl _proxyImpl;

  _WindowManagerInternalClientProxyCalls(this._proxyImpl);
    void dispatchInputEventToView(int viewId, input_events_mojom.Event event) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _WindowManagerInternalClientDispatchInputEventToViewParams();
      params.viewId = viewId;
      params.event = event;
      _proxyImpl.sendMessage(params, _WindowManagerInternalClient_dispatchInputEventToViewName);
    }
    void setViewportSize(geometry_mojom.Size size) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _WindowManagerInternalClientSetViewportSizeParams();
      params.size = size;
      _proxyImpl.sendMessage(params, _WindowManagerInternalClient_setViewportSizeName);
    }
    void cloneAndAnimate(int viewId) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _WindowManagerInternalClientCloneAndAnimateParams();
      params.viewId = viewId;
      _proxyImpl.sendMessage(params, _WindowManagerInternalClient_cloneAndAnimateName);
    }
}


class WindowManagerInternalClientProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  WindowManagerInternalClient ptr;

  WindowManagerInternalClientProxy(_WindowManagerInternalClientProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _WindowManagerInternalClientProxyCalls(proxyImpl);

  WindowManagerInternalClientProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _WindowManagerInternalClientProxyImpl.fromEndpoint(endpoint) {
    ptr = new _WindowManagerInternalClientProxyCalls(impl);
  }

  WindowManagerInternalClientProxy.fromHandle(core.MojoHandle handle) :
      impl = new _WindowManagerInternalClientProxyImpl.fromHandle(handle) {
    ptr = new _WindowManagerInternalClientProxyCalls(impl);
  }

  WindowManagerInternalClientProxy.unbound() :
      impl = new _WindowManagerInternalClientProxyImpl.unbound() {
    ptr = new _WindowManagerInternalClientProxyCalls(impl);
  }

  factory WindowManagerInternalClientProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    WindowManagerInternalClientProxy p = new WindowManagerInternalClientProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static WindowManagerInternalClientProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For WindowManagerInternalClientProxy"));
    return new WindowManagerInternalClientProxy.fromEndpoint(endpoint);
  }

  String get serviceName => WindowManagerInternalClient.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "WindowManagerInternalClientProxy($impl)";
  }
}


class WindowManagerInternalClientStub extends bindings.Stub {
  WindowManagerInternalClient _impl = null;

  WindowManagerInternalClientStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  WindowManagerInternalClientStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  WindowManagerInternalClientStub.unbound() : super.unbound();

  static WindowManagerInternalClientStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For WindowManagerInternalClientStub"));
    return new WindowManagerInternalClientStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _WindowManagerInternalClient_dispatchInputEventToViewName:
        var params = _WindowManagerInternalClientDispatchInputEventToViewParams.deserialize(
            message.payload);
        _impl.dispatchInputEventToView(params.viewId, params.event);
        break;
      case _WindowManagerInternalClient_setViewportSizeName:
        var params = _WindowManagerInternalClientSetViewportSizeParams.deserialize(
            message.payload);
        _impl.setViewportSize(params.size);
        break;
      case _WindowManagerInternalClient_cloneAndAnimateName:
        var params = _WindowManagerInternalClientCloneAndAnimateParams.deserialize(
            message.payload);
        _impl.cloneAndAnimate(params.viewId);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  WindowManagerInternalClient get impl => _impl;
  set impl(WindowManagerInternalClient d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "WindowManagerInternalClientStub($superString)";
  }

  int get version => 0;
}


