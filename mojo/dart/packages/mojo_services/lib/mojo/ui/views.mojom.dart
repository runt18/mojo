// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library views_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/service_provider.mojom.dart' as service_provider_mojom;
import 'package:mojo_services/mojo/gfx/composition/scenes.mojom.dart' as scenes_mojom;
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


class _ViewOnLayoutParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  layouts_mojom.ViewLayoutParams layoutParams = null;
  List<int> childrenNeedingLayout = null;

  _ViewOnLayoutParams() : super(kVersions.last.size);

  static _ViewOnLayoutParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewOnLayoutParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewOnLayoutParams result = new _ViewOnLayoutParams();

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
    return "_ViewOnLayoutParams("
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
  layouts_mojom.ViewLayoutResult result = null;

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
      result.result = layouts_mojom.ViewLayoutResult.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(result, 8, false);
  }

  String toString() {
    return "ViewOnLayoutResponseParams("
           "result: $result" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["result"] = result;
    return map;
  }
}


class _ViewOnChildUnavailableParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int childKey = 0;

  _ViewOnChildUnavailableParams() : super(kVersions.last.size);

  static _ViewOnChildUnavailableParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewOnChildUnavailableParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewOnChildUnavailableParams result = new _ViewOnChildUnavailableParams();

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
    return "_ViewOnChildUnavailableParams("
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


class _ViewHostGetServiceProviderParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object serviceProvider = null;

  _ViewHostGetServiceProviderParams() : super(kVersions.last.size);

  static _ViewHostGetServiceProviderParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewHostGetServiceProviderParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewHostGetServiceProviderParams result = new _ViewHostGetServiceProviderParams();

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
    return "_ViewHostGetServiceProviderParams("
           "serviceProvider: $serviceProvider" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _ViewHostCreateSceneParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object scene = null;

  _ViewHostCreateSceneParams() : super(kVersions.last.size);

  static _ViewHostCreateSceneParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewHostCreateSceneParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewHostCreateSceneParams result = new _ViewHostCreateSceneParams();

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
      
      result.scene = decoder0.decodeInterfaceRequest(8, false, scenes_mojom.SceneStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInterfaceRequest(scene, 8, false);
  }

  String toString() {
    return "_ViewHostCreateSceneParams("
           "scene: $scene" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _ViewHostRequestLayoutParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _ViewHostRequestLayoutParams() : super(kVersions.last.size);

  static _ViewHostRequestLayoutParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewHostRequestLayoutParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewHostRequestLayoutParams result = new _ViewHostRequestLayoutParams();

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
    return "_ViewHostRequestLayoutParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _ViewHostAddChildParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int childKey = 0;
  ViewToken childViewToken = null;

  _ViewHostAddChildParams() : super(kVersions.last.size);

  static _ViewHostAddChildParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewHostAddChildParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewHostAddChildParams result = new _ViewHostAddChildParams();

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
    return "_ViewHostAddChildParams("
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


class _ViewHostRemoveChildParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int childKey = 0;

  _ViewHostRemoveChildParams() : super(kVersions.last.size);

  static _ViewHostRemoveChildParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewHostRemoveChildParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewHostRemoveChildParams result = new _ViewHostRemoveChildParams();

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
    return "_ViewHostRemoveChildParams("
           "childKey: $childKey" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["childKey"] = childKey;
    return map;
  }
}


class _ViewHostLayoutChildParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int childKey = 0;
  layouts_mojom.ViewLayoutParams childLayoutParams = null;

  _ViewHostLayoutChildParams() : super(kVersions.last.size);

  static _ViewHostLayoutChildParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewHostLayoutChildParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewHostLayoutChildParams result = new _ViewHostLayoutChildParams();

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
    return "_ViewHostLayoutChildParams("
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

const int _View_onLayoutName = 0;
const int _View_onChildUnavailableName = 1;

abstract class View {
  static const String serviceName = null;
  dynamic onLayout(layouts_mojom.ViewLayoutParams layoutParams,List<int> childrenNeedingLayout,[Function responseFactory = null]);
  dynamic onChildUnavailable(int childKey,[Function responseFactory = null]);
}


class _ViewProxyImpl extends bindings.Proxy {
  _ViewProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ViewProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _ViewProxyImpl.unbound() : super.unbound();

  static _ViewProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _ViewProxyImpl"));
    return new _ViewProxyImpl.fromEndpoint(endpoint);
  }

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _View_onLayoutName:
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
      case _View_onChildUnavailableName:
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
    return "_ViewProxyImpl($superString)";
  }
}


class _ViewProxyCalls implements View {
  _ViewProxyImpl _proxyImpl;

  _ViewProxyCalls(this._proxyImpl);
    dynamic onLayout(layouts_mojom.ViewLayoutParams layoutParams,List<int> childrenNeedingLayout,[Function responseFactory = null]) {
      var params = new _ViewOnLayoutParams();
      params.layoutParams = layoutParams;
      params.childrenNeedingLayout = childrenNeedingLayout;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _View_onLayoutName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic onChildUnavailable(int childKey,[Function responseFactory = null]) {
      var params = new _ViewOnChildUnavailableParams();
      params.childKey = childKey;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _View_onChildUnavailableName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class ViewProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  View ptr;

  ViewProxy(_ViewProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ViewProxyCalls(proxyImpl);

  ViewProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _ViewProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ViewProxyCalls(impl);
  }

  ViewProxy.fromHandle(core.MojoHandle handle) :
      impl = new _ViewProxyImpl.fromHandle(handle) {
    ptr = new _ViewProxyCalls(impl);
  }

  ViewProxy.unbound() :
      impl = new _ViewProxyImpl.unbound() {
    ptr = new _ViewProxyCalls(impl);
  }

  factory ViewProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ViewProxy p = new ViewProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static ViewProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewProxy"));
    return new ViewProxy.fromEndpoint(endpoint);
  }

  String get serviceName => View.serviceName;

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


  ViewOnLayoutResponseParams _ViewOnLayoutResponseParamsFactory(layouts_mojom.ViewLayoutResult result) {
    var mojo_factory_result = new ViewOnLayoutResponseParams();
    mojo_factory_result.result = result;
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
      case _View_onLayoutName:
        var params = _ViewOnLayoutParams.deserialize(
            message.payload);
        var response = _impl.onLayout(params.layoutParams,params.childrenNeedingLayout,_ViewOnLayoutResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _View_onLayoutName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _View_onLayoutName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _View_onChildUnavailableName:
        var params = _ViewOnChildUnavailableParams.deserialize(
            message.payload);
        var response = _impl.onChildUnavailable(params.childKey,_ViewOnChildUnavailableResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _View_onChildUnavailableName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _View_onChildUnavailableName,
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

const int _ViewHost_getServiceProviderName = 0;
const int _ViewHost_createSceneName = 1;
const int _ViewHost_requestLayoutName = 2;
const int _ViewHost_addChildName = 3;
const int _ViewHost_removeChildName = 4;
const int _ViewHost_layoutChildName = 5;

abstract class ViewHost {
  static const String serviceName = null;
  void getServiceProvider(Object serviceProvider);
  void createScene(Object scene);
  void requestLayout();
  void addChild(int childKey, ViewToken childViewToken);
  void removeChild(int childKey);
  dynamic layoutChild(int childKey,layouts_mojom.ViewLayoutParams childLayoutParams,[Function responseFactory = null]);
}


class _ViewHostProxyImpl extends bindings.Proxy {
  _ViewHostProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ViewHostProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _ViewHostProxyImpl.unbound() : super.unbound();

  static _ViewHostProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _ViewHostProxyImpl"));
    return new _ViewHostProxyImpl.fromEndpoint(endpoint);
  }

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _ViewHost_layoutChildName:
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
    return "_ViewHostProxyImpl($superString)";
  }
}


class _ViewHostProxyCalls implements ViewHost {
  _ViewHostProxyImpl _proxyImpl;

  _ViewHostProxyCalls(this._proxyImpl);
    void getServiceProvider(Object serviceProvider) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ViewHostGetServiceProviderParams();
      params.serviceProvider = serviceProvider;
      _proxyImpl.sendMessage(params, _ViewHost_getServiceProviderName);
    }
    void createScene(Object scene) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ViewHostCreateSceneParams();
      params.scene = scene;
      _proxyImpl.sendMessage(params, _ViewHost_createSceneName);
    }
    void requestLayout() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ViewHostRequestLayoutParams();
      _proxyImpl.sendMessage(params, _ViewHost_requestLayoutName);
    }
    void addChild(int childKey, ViewToken childViewToken) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ViewHostAddChildParams();
      params.childKey = childKey;
      params.childViewToken = childViewToken;
      _proxyImpl.sendMessage(params, _ViewHost_addChildName);
    }
    void removeChild(int childKey) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ViewHostRemoveChildParams();
      params.childKey = childKey;
      _proxyImpl.sendMessage(params, _ViewHost_removeChildName);
    }
    dynamic layoutChild(int childKey,layouts_mojom.ViewLayoutParams childLayoutParams,[Function responseFactory = null]) {
      var params = new _ViewHostLayoutChildParams();
      params.childKey = childKey;
      params.childLayoutParams = childLayoutParams;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _ViewHost_layoutChildName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class ViewHostProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  ViewHost ptr;

  ViewHostProxy(_ViewHostProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ViewHostProxyCalls(proxyImpl);

  ViewHostProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _ViewHostProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ViewHostProxyCalls(impl);
  }

  ViewHostProxy.fromHandle(core.MojoHandle handle) :
      impl = new _ViewHostProxyImpl.fromHandle(handle) {
    ptr = new _ViewHostProxyCalls(impl);
  }

  ViewHostProxy.unbound() :
      impl = new _ViewHostProxyImpl.unbound() {
    ptr = new _ViewHostProxyCalls(impl);
  }

  factory ViewHostProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ViewHostProxy p = new ViewHostProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static ViewHostProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewHostProxy"));
    return new ViewHostProxy.fromEndpoint(endpoint);
  }

  String get serviceName => ViewHost.serviceName;

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
      case _ViewHost_getServiceProviderName:
        var params = _ViewHostGetServiceProviderParams.deserialize(
            message.payload);
        _impl.getServiceProvider(params.serviceProvider);
        break;
      case _ViewHost_createSceneName:
        var params = _ViewHostCreateSceneParams.deserialize(
            message.payload);
        _impl.createScene(params.scene);
        break;
      case _ViewHost_requestLayoutName:
        var params = _ViewHostRequestLayoutParams.deserialize(
            message.payload);
        _impl.requestLayout();
        break;
      case _ViewHost_addChildName:
        var params = _ViewHostAddChildParams.deserialize(
            message.payload);
        _impl.addChild(params.childKey, params.childViewToken);
        break;
      case _ViewHost_removeChildName:
        var params = _ViewHostRemoveChildParams.deserialize(
            message.payload);
        _impl.removeChild(params.childKey);
        break;
      case _ViewHost_layoutChildName:
        var params = _ViewHostLayoutChildParams.deserialize(
            message.payload);
        var response = _impl.layoutChild(params.childKey,params.childLayoutParams,_ViewHostLayoutChildResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _ViewHost_layoutChildName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _ViewHost_layoutChildName,
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


