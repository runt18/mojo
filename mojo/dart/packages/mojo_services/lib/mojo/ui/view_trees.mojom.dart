// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library view_trees_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo_services/mojo/ui/layouts.mojom.dart' as layouts_mojom;
import 'package:mojo_services/mojo/ui/views.mojom.dart' as views_mojom;



class ViewTreeOnLayoutParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  ViewTreeOnLayoutParams() : super(kVersions.last.size);

  static ViewTreeOnLayoutParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewTreeOnLayoutParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewTreeOnLayoutParams result = new ViewTreeOnLayoutParams();

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
    return "ViewTreeOnLayoutParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class ViewTreeOnLayoutResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  ViewTreeOnLayoutResponseParams() : super(kVersions.last.size);

  static ViewTreeOnLayoutResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewTreeOnLayoutResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewTreeOnLayoutResponseParams result = new ViewTreeOnLayoutResponseParams();

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
    return "ViewTreeOnLayoutResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class ViewTreeOnRootUnavailableParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int rootKey = 0;

  ViewTreeOnRootUnavailableParams() : super(kVersions.last.size);

  static ViewTreeOnRootUnavailableParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewTreeOnRootUnavailableParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewTreeOnRootUnavailableParams result = new ViewTreeOnRootUnavailableParams();

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
      
      result.rootKey = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(rootKey, 8);
  }

  String toString() {
    return "ViewTreeOnRootUnavailableParams("
           "rootKey: $rootKey" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["rootKey"] = rootKey;
    return map;
  }
}


class ViewTreeOnRootUnavailableResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  ViewTreeOnRootUnavailableResponseParams() : super(kVersions.last.size);

  static ViewTreeOnRootUnavailableResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewTreeOnRootUnavailableResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewTreeOnRootUnavailableResponseParams result = new ViewTreeOnRootUnavailableResponseParams();

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
    return "ViewTreeOnRootUnavailableResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class ViewTreeHostRequestLayoutParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  ViewTreeHostRequestLayoutParams() : super(kVersions.last.size);

  static ViewTreeHostRequestLayoutParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewTreeHostRequestLayoutParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewTreeHostRequestLayoutParams result = new ViewTreeHostRequestLayoutParams();

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
    return "ViewTreeHostRequestLayoutParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class ViewTreeHostSetRootParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int rootKey = 0;
  views_mojom.ViewToken rootViewToken = null;

  ViewTreeHostSetRootParams() : super(kVersions.last.size);

  static ViewTreeHostSetRootParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewTreeHostSetRootParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewTreeHostSetRootParams result = new ViewTreeHostSetRootParams();

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
      
      result.rootKey = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.rootViewToken = views_mojom.ViewToken.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(rootKey, 8);
    
    encoder0.encodeStruct(rootViewToken, 16, false);
  }

  String toString() {
    return "ViewTreeHostSetRootParams("
           "rootKey: $rootKey" ", "
           "rootViewToken: $rootViewToken" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["rootKey"] = rootKey;
    map["rootViewToken"] = rootViewToken;
    return map;
  }
}


class ViewTreeHostResetRootParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  ViewTreeHostResetRootParams() : super(kVersions.last.size);

  static ViewTreeHostResetRootParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewTreeHostResetRootParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewTreeHostResetRootParams result = new ViewTreeHostResetRootParams();

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
    return "ViewTreeHostResetRootParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class ViewTreeHostLayoutRootParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  layouts_mojom.ViewLayoutParams rootLayoutParams = null;

  ViewTreeHostLayoutRootParams() : super(kVersions.last.size);

  static ViewTreeHostLayoutRootParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewTreeHostLayoutRootParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewTreeHostLayoutRootParams result = new ViewTreeHostLayoutRootParams();

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
      result.rootLayoutParams = layouts_mojom.ViewLayoutParams.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(rootLayoutParams, 8, false);
  }

  String toString() {
    return "ViewTreeHostLayoutRootParams("
           "rootLayoutParams: $rootLayoutParams" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["rootLayoutParams"] = rootLayoutParams;
    return map;
  }
}


class ViewTreeHostLayoutRootResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  layouts_mojom.ViewLayoutInfo info = null;

  ViewTreeHostLayoutRootResponseParams() : super(kVersions.last.size);

  static ViewTreeHostLayoutRootResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewTreeHostLayoutRootResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewTreeHostLayoutRootResponseParams result = new ViewTreeHostLayoutRootResponseParams();

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
      
      var decoder1 = decoder0.decodePointer(8, true);
      result.info = layouts_mojom.ViewLayoutInfo.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(info, 8, true);
  }

  String toString() {
    return "ViewTreeHostLayoutRootResponseParams("
           "info: $info" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["info"] = info;
    return map;
  }
}

const int kViewTree_onLayout_name = 0;
const int kViewTree_onRootUnavailable_name = 1;

const String ViewTreeName =
      'mojo::ui::ViewTree';

abstract class ViewTree {
  dynamic onLayout([Function responseFactory = null]);
  dynamic onRootUnavailable(int rootKey,[Function responseFactory = null]);

}


class ViewTreeProxyImpl extends bindings.Proxy {
  ViewTreeProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  ViewTreeProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  ViewTreeProxyImpl.unbound() : super.unbound();

  static ViewTreeProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewTreeProxyImpl"));
    return new ViewTreeProxyImpl.fromEndpoint(endpoint);
  }

  String get name => ViewTreeName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case kViewTree_onLayout_name:
        var r = ViewTreeOnLayoutResponseParams.deserialize(
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
      case kViewTree_onRootUnavailable_name:
        var r = ViewTreeOnRootUnavailableResponseParams.deserialize(
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
    return "ViewTreeProxyImpl($superString)";
  }
}


class _ViewTreeProxyCalls implements ViewTree {
  ViewTreeProxyImpl _proxyImpl;

  _ViewTreeProxyCalls(this._proxyImpl);
    dynamic onLayout([Function responseFactory = null]) {
      var params = new ViewTreeOnLayoutParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kViewTree_onLayout_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic onRootUnavailable(int rootKey,[Function responseFactory = null]) {
      var params = new ViewTreeOnRootUnavailableParams();
      params.rootKey = rootKey;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kViewTree_onRootUnavailable_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class ViewTreeProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  ViewTree ptr;
  final String name = ViewTreeName;

  ViewTreeProxy(ViewTreeProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ViewTreeProxyCalls(proxyImpl);

  ViewTreeProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new ViewTreeProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ViewTreeProxyCalls(impl);
  }

  ViewTreeProxy.fromHandle(core.MojoHandle handle) :
      impl = new ViewTreeProxyImpl.fromHandle(handle) {
    ptr = new _ViewTreeProxyCalls(impl);
  }

  ViewTreeProxy.unbound() :
      impl = new ViewTreeProxyImpl.unbound() {
    ptr = new _ViewTreeProxyCalls(impl);
  }

  factory ViewTreeProxy.connectToService(
      bindings.ServiceConnector s, String url) {
    ViewTreeProxy p = new ViewTreeProxy.unbound();
    s.connectToService(url, p);
    return p;
  }

  static ViewTreeProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewTreeProxy"));
    return new ViewTreeProxy.fromEndpoint(endpoint);
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
    return "ViewTreeProxy($impl)";
  }
}


class ViewTreeStub extends bindings.Stub {
  ViewTree _impl = null;

  ViewTreeStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  ViewTreeStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  ViewTreeStub.unbound() : super.unbound();

  static ViewTreeStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewTreeStub"));
    return new ViewTreeStub.fromEndpoint(endpoint);
  }

  static const String name = ViewTreeName;


  ViewTreeOnLayoutResponseParams _ViewTreeOnLayoutResponseParamsFactory() {
    var mojo_factory_result = new ViewTreeOnLayoutResponseParams();
    return mojo_factory_result;
  }
  ViewTreeOnRootUnavailableResponseParams _ViewTreeOnRootUnavailableResponseParamsFactory() {
    var mojo_factory_result = new ViewTreeOnRootUnavailableResponseParams();
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
      case kViewTree_onLayout_name:
        var params = ViewTreeOnLayoutParams.deserialize(
            message.payload);
        var response = _impl.onLayout(_ViewTreeOnLayoutResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kViewTree_onLayout_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kViewTree_onLayout_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kViewTree_onRootUnavailable_name:
        var params = ViewTreeOnRootUnavailableParams.deserialize(
            message.payload);
        var response = _impl.onRootUnavailable(params.rootKey,_ViewTreeOnRootUnavailableResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kViewTree_onRootUnavailable_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kViewTree_onRootUnavailable_name,
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

  ViewTree get impl => _impl;
  set impl(ViewTree d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "ViewTreeStub($superString)";
  }

  int get version => 0;
}

const int kViewTreeHost_requestLayout_name = 0;
const int kViewTreeHost_setRoot_name = 1;
const int kViewTreeHost_resetRoot_name = 2;
const int kViewTreeHost_layoutRoot_name = 3;

const String ViewTreeHostName =
      'mojo::ui::ViewTreeHost';

abstract class ViewTreeHost {
  void requestLayout();
  void setRoot(int rootKey, views_mojom.ViewToken rootViewToken);
  void resetRoot();
  dynamic layoutRoot(layouts_mojom.ViewLayoutParams rootLayoutParams,[Function responseFactory = null]);

}


class ViewTreeHostProxyImpl extends bindings.Proxy {
  ViewTreeHostProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  ViewTreeHostProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  ViewTreeHostProxyImpl.unbound() : super.unbound();

  static ViewTreeHostProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewTreeHostProxyImpl"));
    return new ViewTreeHostProxyImpl.fromEndpoint(endpoint);
  }

  String get name => ViewTreeHostName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case kViewTreeHost_layoutRoot_name:
        var r = ViewTreeHostLayoutRootResponseParams.deserialize(
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
    return "ViewTreeHostProxyImpl($superString)";
  }
}


class _ViewTreeHostProxyCalls implements ViewTreeHost {
  ViewTreeHostProxyImpl _proxyImpl;

  _ViewTreeHostProxyCalls(this._proxyImpl);
    void requestLayout() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new ViewTreeHostRequestLayoutParams();
      _proxyImpl.sendMessage(params, kViewTreeHost_requestLayout_name);
    }
  
    void setRoot(int rootKey, views_mojom.ViewToken rootViewToken) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new ViewTreeHostSetRootParams();
      params.rootKey = rootKey;
      params.rootViewToken = rootViewToken;
      _proxyImpl.sendMessage(params, kViewTreeHost_setRoot_name);
    }
  
    void resetRoot() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new ViewTreeHostResetRootParams();
      _proxyImpl.sendMessage(params, kViewTreeHost_resetRoot_name);
    }
  
    dynamic layoutRoot(layouts_mojom.ViewLayoutParams rootLayoutParams,[Function responseFactory = null]) {
      var params = new ViewTreeHostLayoutRootParams();
      params.rootLayoutParams = rootLayoutParams;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kViewTreeHost_layoutRoot_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class ViewTreeHostProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  ViewTreeHost ptr;
  final String name = ViewTreeHostName;

  ViewTreeHostProxy(ViewTreeHostProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ViewTreeHostProxyCalls(proxyImpl);

  ViewTreeHostProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new ViewTreeHostProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ViewTreeHostProxyCalls(impl);
  }

  ViewTreeHostProxy.fromHandle(core.MojoHandle handle) :
      impl = new ViewTreeHostProxyImpl.fromHandle(handle) {
    ptr = new _ViewTreeHostProxyCalls(impl);
  }

  ViewTreeHostProxy.unbound() :
      impl = new ViewTreeHostProxyImpl.unbound() {
    ptr = new _ViewTreeHostProxyCalls(impl);
  }

  factory ViewTreeHostProxy.connectToService(
      bindings.ServiceConnector s, String url) {
    ViewTreeHostProxy p = new ViewTreeHostProxy.unbound();
    s.connectToService(url, p);
    return p;
  }

  static ViewTreeHostProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewTreeHostProxy"));
    return new ViewTreeHostProxy.fromEndpoint(endpoint);
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
    return "ViewTreeHostProxy($impl)";
  }
}


class ViewTreeHostStub extends bindings.Stub {
  ViewTreeHost _impl = null;

  ViewTreeHostStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  ViewTreeHostStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  ViewTreeHostStub.unbound() : super.unbound();

  static ViewTreeHostStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewTreeHostStub"));
    return new ViewTreeHostStub.fromEndpoint(endpoint);
  }

  static const String name = ViewTreeHostName;


  ViewTreeHostLayoutRootResponseParams _ViewTreeHostLayoutRootResponseParamsFactory(layouts_mojom.ViewLayoutInfo info) {
    var mojo_factory_result = new ViewTreeHostLayoutRootResponseParams();
    mojo_factory_result.info = info;
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
      case kViewTreeHost_requestLayout_name:
        var params = ViewTreeHostRequestLayoutParams.deserialize(
            message.payload);
        _impl.requestLayout();
        break;
      case kViewTreeHost_setRoot_name:
        var params = ViewTreeHostSetRootParams.deserialize(
            message.payload);
        _impl.setRoot(params.rootKey, params.rootViewToken);
        break;
      case kViewTreeHost_resetRoot_name:
        var params = ViewTreeHostResetRootParams.deserialize(
            message.payload);
        _impl.resetRoot();
        break;
      case kViewTreeHost_layoutRoot_name:
        var params = ViewTreeHostLayoutRootParams.deserialize(
            message.payload);
        var response = _impl.layoutRoot(params.rootLayoutParams,_ViewTreeHostLayoutRootResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kViewTreeHost_layoutRoot_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kViewTreeHost_layoutRoot_name,
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

  ViewTreeHost get impl => _impl;
  set impl(ViewTreeHost d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "ViewTreeHostStub($superString)";
  }

  int get version => 0;
}


