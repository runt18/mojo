// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library views_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/service_provider.mojom.dart' as service_provider_mojom;
import 'package:mojo_services/mojo/ui/layouts.mojom.dart' as layouts_mojom;



class ViewToken extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int value = 0;

  ViewToken() : super(kVersions.last.size);

  static ViewToken deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewToken decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewToken result = new ViewToken();

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
      
      result.value = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(value, 8);
  }

  String toString() {
    return "ViewToken("
           "value: $value" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["value"] = value;
    return map;
  }
}


class ViewOnLayoutParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  layouts_mojom.ViewLayoutParams layoutParams = null;
  List<int> childrenNeedingLayout = null;

  ViewOnLayoutParams() : super(kVersions.last.size);

  static ViewOnLayoutParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewOnLayoutParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewOnLayoutParams result = new ViewOnLayoutParams();

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
      result.layoutParams = layouts_mojom.ViewLayoutParams.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.childrenNeedingLayout = decoder0.decodeUint32Array(16, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(layoutParams, 8, false);
    
    encoder0.encodeUint32Array(childrenNeedingLayout, 16, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
  }

  String toString() {
    return "ViewOnLayoutParams("
           "layoutParams: $layoutParams" ", "
           "childrenNeedingLayout: $childrenNeedingLayout" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["layoutParams"] = layoutParams;
    map["childrenNeedingLayout"] = childrenNeedingLayout;
    return map;
  }
}


class ViewOnLayoutResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  layouts_mojom.ViewLayoutInfo info = null;

  ViewOnLayoutResponseParams() : super(kVersions.last.size);

  static ViewOnLayoutResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewOnLayoutResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewOnLayoutResponseParams result = new ViewOnLayoutResponseParams();

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
      result.info = layouts_mojom.ViewLayoutInfo.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(info, 8, false);
  }

  String toString() {
    return "ViewOnLayoutResponseParams("
           "info: $info" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["info"] = info;
    return map;
  }
}


class ViewOnChildUnavailableParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int childKey = 0;

  ViewOnChildUnavailableParams() : super(kVersions.last.size);

  static ViewOnChildUnavailableParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewOnChildUnavailableParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewOnChildUnavailableParams result = new ViewOnChildUnavailableParams();

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
      
      result.childKey = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(childKey, 8);
  }

  String toString() {
    return "ViewOnChildUnavailableParams("
           "childKey: $childKey" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["childKey"] = childKey;
    return map;
  }
}


class ViewOnChildUnavailableResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  ViewOnChildUnavailableResponseParams() : super(kVersions.last.size);

  static ViewOnChildUnavailableResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewOnChildUnavailableResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewOnChildUnavailableResponseParams result = new ViewOnChildUnavailableResponseParams();

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
    return "ViewOnChildUnavailableResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class ViewHostGetServiceProviderParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object serviceProvider = null;

  ViewHostGetServiceProviderParams() : super(kVersions.last.size);

  static ViewHostGetServiceProviderParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewHostGetServiceProviderParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewHostGetServiceProviderParams result = new ViewHostGetServiceProviderParams();

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
      
      result.serviceProvider = decoder0.decodeInterfaceRequest(8, false, service_provider_mojom.ServiceProviderStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInterfaceRequest(serviceProvider, 8, false);
  }

  String toString() {
    return "ViewHostGetServiceProviderParams("
           "serviceProvider: $serviceProvider" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class ViewHostRequestLayoutParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  ViewHostRequestLayoutParams() : super(kVersions.last.size);

  static ViewHostRequestLayoutParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewHostRequestLayoutParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewHostRequestLayoutParams result = new ViewHostRequestLayoutParams();

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
    return "ViewHostRequestLayoutParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class ViewHostAddChildParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int childKey = 0;
  ViewToken childViewToken = null;

  ViewHostAddChildParams() : super(kVersions.last.size);

  static ViewHostAddChildParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewHostAddChildParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewHostAddChildParams result = new ViewHostAddChildParams();

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
      
      result.childKey = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.childViewToken = ViewToken.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(childKey, 8);
    
    encoder0.encodeStruct(childViewToken, 16, false);
  }

  String toString() {
    return "ViewHostAddChildParams("
           "childKey: $childKey" ", "
           "childViewToken: $childViewToken" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["childKey"] = childKey;
    map["childViewToken"] = childViewToken;
    return map;
  }
}


class ViewHostRemoveChildParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int childKey = 0;

  ViewHostRemoveChildParams() : super(kVersions.last.size);

  static ViewHostRemoveChildParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewHostRemoveChildParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewHostRemoveChildParams result = new ViewHostRemoveChildParams();

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
      
      result.childKey = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(childKey, 8);
  }

  String toString() {
    return "ViewHostRemoveChildParams("
           "childKey: $childKey" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["childKey"] = childKey;
    return map;
  }
}


class ViewHostLayoutChildParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int childKey = 0;
  layouts_mojom.ViewLayoutParams childLayoutParams = null;

  ViewHostLayoutChildParams() : super(kVersions.last.size);

  static ViewHostLayoutChildParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewHostLayoutChildParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewHostLayoutChildParams result = new ViewHostLayoutChildParams();

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
      
      result.childKey = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.childLayoutParams = layouts_mojom.ViewLayoutParams.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(childKey, 8);
    
    encoder0.encodeStruct(childLayoutParams, 16, false);
  }

  String toString() {
    return "ViewHostLayoutChildParams("
           "childKey: $childKey" ", "
           "childLayoutParams: $childLayoutParams" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["childKey"] = childKey;
    map["childLayoutParams"] = childLayoutParams;
    return map;
  }
}


class ViewHostLayoutChildResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  layouts_mojom.ViewLayoutInfo info = null;

  ViewHostLayoutChildResponseParams() : super(kVersions.last.size);

  static ViewHostLayoutChildResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewHostLayoutChildResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewHostLayoutChildResponseParams result = new ViewHostLayoutChildResponseParams();

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
    return "ViewHostLayoutChildResponseParams("
           "info: $info" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["info"] = info;
    return map;
  }
}

const int kView_onLayout_name = 0;
const int kView_onChildUnavailable_name = 1;

const String ViewName =
      'mojo::ui::View';

abstract class View {
  dynamic onLayout(layouts_mojom.ViewLayoutParams layoutParams,List<int> childrenNeedingLayout,[Function responseFactory = null]);
  dynamic onChildUnavailable(int childKey,[Function responseFactory = null]);

}


class ViewProxyImpl extends bindings.Proxy {
  ViewProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  ViewProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  ViewProxyImpl.unbound() : super.unbound();

  static ViewProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewProxyImpl"));
    return new ViewProxyImpl.fromEndpoint(endpoint);
  }

  String get name => ViewName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case kView_onLayout_name:
        var r = ViewOnLayoutResponseParams.deserialize(
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
      case kView_onChildUnavailable_name:
        var r = ViewOnChildUnavailableResponseParams.deserialize(
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
    return "ViewProxyImpl($superString)";
  }
}


class _ViewProxyCalls implements View {
  ViewProxyImpl _proxyImpl;

  _ViewProxyCalls(this._proxyImpl);
    dynamic onLayout(layouts_mojom.ViewLayoutParams layoutParams,List<int> childrenNeedingLayout,[Function responseFactory = null]) {
      var params = new ViewOnLayoutParams();
      params.layoutParams = layoutParams;
      params.childrenNeedingLayout = childrenNeedingLayout;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kView_onLayout_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic onChildUnavailable(int childKey,[Function responseFactory = null]) {
      var params = new ViewOnChildUnavailableParams();
      params.childKey = childKey;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kView_onChildUnavailable_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class ViewProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  View ptr;
  final String name = ViewName;

  ViewProxy(ViewProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ViewProxyCalls(proxyImpl);

  ViewProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new ViewProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ViewProxyCalls(impl);
  }

  ViewProxy.fromHandle(core.MojoHandle handle) :
      impl = new ViewProxyImpl.fromHandle(handle) {
    ptr = new _ViewProxyCalls(impl);
  }

  ViewProxy.unbound() :
      impl = new ViewProxyImpl.unbound() {
    ptr = new _ViewProxyCalls(impl);
  }

  factory ViewProxy.connectToService(
      bindings.ServiceConnector s, String url) {
    ViewProxy p = new ViewProxy.unbound();
    s.connectToService(url, p);
    return p;
  }

  static ViewProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewProxy"));
    return new ViewProxy.fromEndpoint(endpoint);
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
    return "ViewProxy($impl)";
  }
}


class ViewStub extends bindings.Stub {
  View _impl = null;

  ViewStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  ViewStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  ViewStub.unbound() : super.unbound();

  static ViewStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewStub"));
    return new ViewStub.fromEndpoint(endpoint);
  }

  static const String name = ViewName;


  ViewOnLayoutResponseParams _ViewOnLayoutResponseParamsFactory(layouts_mojom.ViewLayoutInfo info) {
    var mojo_factory_result = new ViewOnLayoutResponseParams();
    mojo_factory_result.info = info;
    return mojo_factory_result;
  }
  ViewOnChildUnavailableResponseParams _ViewOnChildUnavailableResponseParamsFactory() {
    var mojo_factory_result = new ViewOnChildUnavailableResponseParams();
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
      case kView_onLayout_name:
        var params = ViewOnLayoutParams.deserialize(
            message.payload);
        var response = _impl.onLayout(params.layoutParams,params.childrenNeedingLayout,_ViewOnLayoutResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kView_onLayout_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kView_onLayout_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kView_onChildUnavailable_name:
        var params = ViewOnChildUnavailableParams.deserialize(
            message.payload);
        var response = _impl.onChildUnavailable(params.childKey,_ViewOnChildUnavailableResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kView_onChildUnavailable_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kView_onChildUnavailable_name,
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

  View get impl => _impl;
  set impl(View d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "ViewStub($superString)";
  }

  int get version => 0;
}

const int kViewHost_getServiceProvider_name = 0;
const int kViewHost_requestLayout_name = 1;
const int kViewHost_addChild_name = 2;
const int kViewHost_removeChild_name = 3;
const int kViewHost_layoutChild_name = 4;

const String ViewHostName =
      'mojo::ui::ViewHost';

abstract class ViewHost {
  void getServiceProvider(Object serviceProvider);
  void requestLayout();
  void addChild(int childKey, ViewToken childViewToken);
  void removeChild(int childKey);
  dynamic layoutChild(int childKey,layouts_mojom.ViewLayoutParams childLayoutParams,[Function responseFactory = null]);

}


class ViewHostProxyImpl extends bindings.Proxy {
  ViewHostProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  ViewHostProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  ViewHostProxyImpl.unbound() : super.unbound();

  static ViewHostProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewHostProxyImpl"));
    return new ViewHostProxyImpl.fromEndpoint(endpoint);
  }

  String get name => ViewHostName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case kViewHost_layoutChild_name:
        var r = ViewHostLayoutChildResponseParams.deserialize(
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
    return "ViewHostProxyImpl($superString)";
  }
}


class _ViewHostProxyCalls implements ViewHost {
  ViewHostProxyImpl _proxyImpl;

  _ViewHostProxyCalls(this._proxyImpl);
    void getServiceProvider(Object serviceProvider) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new ViewHostGetServiceProviderParams();
      params.serviceProvider = serviceProvider;
      _proxyImpl.sendMessage(params, kViewHost_getServiceProvider_name);
    }
  
    void requestLayout() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new ViewHostRequestLayoutParams();
      _proxyImpl.sendMessage(params, kViewHost_requestLayout_name);
    }
  
    void addChild(int childKey, ViewToken childViewToken) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new ViewHostAddChildParams();
      params.childKey = childKey;
      params.childViewToken = childViewToken;
      _proxyImpl.sendMessage(params, kViewHost_addChild_name);
    }
  
    void removeChild(int childKey) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new ViewHostRemoveChildParams();
      params.childKey = childKey;
      _proxyImpl.sendMessage(params, kViewHost_removeChild_name);
    }
  
    dynamic layoutChild(int childKey,layouts_mojom.ViewLayoutParams childLayoutParams,[Function responseFactory = null]) {
      var params = new ViewHostLayoutChildParams();
      params.childKey = childKey;
      params.childLayoutParams = childLayoutParams;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kViewHost_layoutChild_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class ViewHostProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  ViewHost ptr;
  final String name = ViewHostName;

  ViewHostProxy(ViewHostProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ViewHostProxyCalls(proxyImpl);

  ViewHostProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new ViewHostProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ViewHostProxyCalls(impl);
  }

  ViewHostProxy.fromHandle(core.MojoHandle handle) :
      impl = new ViewHostProxyImpl.fromHandle(handle) {
    ptr = new _ViewHostProxyCalls(impl);
  }

  ViewHostProxy.unbound() :
      impl = new ViewHostProxyImpl.unbound() {
    ptr = new _ViewHostProxyCalls(impl);
  }

  factory ViewHostProxy.connectToService(
      bindings.ServiceConnector s, String url) {
    ViewHostProxy p = new ViewHostProxy.unbound();
    s.connectToService(url, p);
    return p;
  }

  static ViewHostProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewHostProxy"));
    return new ViewHostProxy.fromEndpoint(endpoint);
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
    return "ViewHostProxy($impl)";
  }
}


class ViewHostStub extends bindings.Stub {
  ViewHost _impl = null;

  ViewHostStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  ViewHostStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  ViewHostStub.unbound() : super.unbound();

  static ViewHostStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewHostStub"));
    return new ViewHostStub.fromEndpoint(endpoint);
  }

  static const String name = ViewHostName;


  ViewHostLayoutChildResponseParams _ViewHostLayoutChildResponseParamsFactory(layouts_mojom.ViewLayoutInfo info) {
    var mojo_factory_result = new ViewHostLayoutChildResponseParams();
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
      case kViewHost_getServiceProvider_name:
        var params = ViewHostGetServiceProviderParams.deserialize(
            message.payload);
        _impl.getServiceProvider(params.serviceProvider);
        break;
      case kViewHost_requestLayout_name:
        var params = ViewHostRequestLayoutParams.deserialize(
            message.payload);
        _impl.requestLayout();
        break;
      case kViewHost_addChild_name:
        var params = ViewHostAddChildParams.deserialize(
            message.payload);
        _impl.addChild(params.childKey, params.childViewToken);
        break;
      case kViewHost_removeChild_name:
        var params = ViewHostRemoveChildParams.deserialize(
            message.payload);
        _impl.removeChild(params.childKey);
        break;
      case kViewHost_layoutChild_name:
        var params = ViewHostLayoutChildParams.deserialize(
            message.payload);
        var response = _impl.layoutChild(params.childKey,params.childLayoutParams,_ViewHostLayoutChildResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kViewHost_layoutChild_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kViewHost_layoutChild_name,
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

  ViewHost get impl => _impl;
  set impl(ViewHost d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "ViewHostStub($superString)";
  }

  int get version => 0;
}


