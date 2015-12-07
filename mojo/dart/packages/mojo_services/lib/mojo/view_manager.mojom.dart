// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library view_manager_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo_services/mojo/geometry.mojom.dart' as geometry_mojom;
import 'package:mojo_services/mojo/input_events.mojom.dart' as input_events_mojom;
import 'package:mojo/mojo/service_provider.mojom.dart' as service_provider_mojom;
import 'package:mojo_services/mojo/native_viewport.mojom.dart' as native_viewport_mojom;
import 'package:mojo_services/mojo/surface_id.mojom.dart' as surface_id_mojom;
import 'package:mojo_services/mojo/view_manager_constants.mojom.dart' as view_manager_constants_mojom;
class ErrorCode extends bindings.MojoEnum {
  static const NONE = const ErrorCode._(0);
  static const VALUE_IN_USE = const ErrorCode._(1);
  static const ILLEGAL_ARGUMENT = const ErrorCode._(2);

  const ErrorCode._(int v) : super(v);

  static const Map<String, ErrorCode> valuesMap = const {
    "NONE": NONE,
    "VALUE_IN_USE": VALUE_IN_USE,
    "ILLEGAL_ARGUMENT": ILLEGAL_ARGUMENT,
  };
  static const List<ErrorCode> values = const [
    NONE,
    VALUE_IN_USE,
    ILLEGAL_ARGUMENT,
  ];

  static ErrorCode valueOf(String name) => valuesMap[name];

  factory ErrorCode(int v) {
    switch (v) {
      case 0:
        return NONE;
      case 1:
        return VALUE_IN_USE;
      case 2:
        return ILLEGAL_ARGUMENT;
      default:
        return null;
    }
  }

  static ErrorCode decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    ErrorCode result = new ErrorCode(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum ErrorCode.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case NONE:
        return 'ErrorCode.NONE';
      case VALUE_IN_USE:
        return 'ErrorCode.VALUE_IN_USE';
      case ILLEGAL_ARGUMENT:
        return 'ErrorCode.ILLEGAL_ARGUMENT';
    }
  }

  int toJson() => value;
}



class ViewData extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(48, 0)
  ];
  int parentId = 0;
  int viewId = 0;
  geometry_mojom.Rect bounds = null;
  Map<String, List<int>> properties = null;
  bool visible = false;
  bool drawn = false;
  native_viewport_mojom.ViewportMetrics viewportMetrics = null;

  ViewData() : super(kVersions.last.size);

  static ViewData deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewData decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewData result = new ViewData();

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
      
      result.parentId = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.viewId = decoder0.decodeUint32(12);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.bounds = geometry_mojom.Rect.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<List<int>> values0;
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
            keys0 = new List<String>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              keys0[i2] = decoder2.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
            }
          }
        }
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(keys0.length);
            values0 = new List<List<int>>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              values0[i2] = decoder2.decodeUint8Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
            }
          }
        }
        result.properties = new Map<String, List<int>>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      result.visible = decoder0.decodeBool(32, 0);
    }
    if (mainDataHeader.version >= 0) {
      
      result.drawn = decoder0.decodeBool(32, 1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(40, false);
      result.viewportMetrics = native_viewport_mojom.ViewportMetrics.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(parentId, 8);
    
    encoder0.encodeUint32(viewId, 12);
    
    encoder0.encodeStruct(bounds, 16, false);
    
    if (properties == null) {
      encoder0.encodeNullPointer(24, false);
    } else {
      var encoder1 = encoder0.encoderForMap(24);
      int size0 = properties.length;
      var keys0 = properties.keys.toList();
      var values0 = properties.values.toList();
      
      {
        var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
        for (int i1 = 0; i1 < keys0.length; ++i1) {
          
          encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
      
      {
        var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
        for (int i1 = 0; i1 < values0.length; ++i1) {
          
          encoder2.encodeUint8Array(values0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
      }
    }
    
    encoder0.encodeBool(visible, 32, 0);
    
    encoder0.encodeBool(drawn, 32, 1);
    
    encoder0.encodeStruct(viewportMetrics, 40, false);
  }

  String toString() {
    return "ViewData("
           "parentId: $parentId" ", "
           "viewId: $viewId" ", "
           "bounds: $bounds" ", "
           "properties: $properties" ", "
           "visible: $visible" ", "
           "drawn: $drawn" ", "
           "viewportMetrics: $viewportMetrics" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["parentId"] = parentId;
    map["viewId"] = viewId;
    map["bounds"] = bounds;
    map["properties"] = properties;
    map["visible"] = visible;
    map["drawn"] = drawn;
    map["viewportMetrics"] = viewportMetrics;
    return map;
  }
}


class ViewManagerServiceCreateViewParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int viewId = 0;

  ViewManagerServiceCreateViewParams() : super(kVersions.last.size);

  static ViewManagerServiceCreateViewParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerServiceCreateViewParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerServiceCreateViewParams result = new ViewManagerServiceCreateViewParams();

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
    return "ViewManagerServiceCreateViewParams("
           "viewId: $viewId" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["viewId"] = viewId;
    return map;
  }
}


class ViewManagerServiceCreateViewResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  ErrorCode errorCode = null;

  ViewManagerServiceCreateViewResponseParams() : super(kVersions.last.size);

  static ViewManagerServiceCreateViewResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerServiceCreateViewResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerServiceCreateViewResponseParams result = new ViewManagerServiceCreateViewResponseParams();

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
      
        result.errorCode = ErrorCode.decode(decoder0, 8);
        if (result.errorCode == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable ErrorCode.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(errorCode, 8);
  }

  String toString() {
    return "ViewManagerServiceCreateViewResponseParams("
           "errorCode: $errorCode" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["errorCode"] = errorCode;
    return map;
  }
}


class ViewManagerServiceDeleteViewParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int viewId = 0;

  ViewManagerServiceDeleteViewParams() : super(kVersions.last.size);

  static ViewManagerServiceDeleteViewParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerServiceDeleteViewParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerServiceDeleteViewParams result = new ViewManagerServiceDeleteViewParams();

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
    return "ViewManagerServiceDeleteViewParams("
           "viewId: $viewId" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["viewId"] = viewId;
    return map;
  }
}


class ViewManagerServiceDeleteViewResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool success = false;

  ViewManagerServiceDeleteViewResponseParams() : super(kVersions.last.size);

  static ViewManagerServiceDeleteViewResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerServiceDeleteViewResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerServiceDeleteViewResponseParams result = new ViewManagerServiceDeleteViewResponseParams();

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
      
      result.success = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeBool(success, 8, 0);
  }

  String toString() {
    return "ViewManagerServiceDeleteViewResponseParams("
           "success: $success" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["success"] = success;
    return map;
  }
}


class ViewManagerServiceSetViewBoundsParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int viewId = 0;
  geometry_mojom.Rect bounds = null;

  ViewManagerServiceSetViewBoundsParams() : super(kVersions.last.size);

  static ViewManagerServiceSetViewBoundsParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerServiceSetViewBoundsParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerServiceSetViewBoundsParams result = new ViewManagerServiceSetViewBoundsParams();

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
      result.bounds = geometry_mojom.Rect.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(viewId, 8);
    
    encoder0.encodeStruct(bounds, 16, false);
  }

  String toString() {
    return "ViewManagerServiceSetViewBoundsParams("
           "viewId: $viewId" ", "
           "bounds: $bounds" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["viewId"] = viewId;
    map["bounds"] = bounds;
    return map;
  }
}


class ViewManagerServiceSetViewBoundsResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool success = false;

  ViewManagerServiceSetViewBoundsResponseParams() : super(kVersions.last.size);

  static ViewManagerServiceSetViewBoundsResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerServiceSetViewBoundsResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerServiceSetViewBoundsResponseParams result = new ViewManagerServiceSetViewBoundsResponseParams();

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
      
      result.success = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeBool(success, 8, 0);
  }

  String toString() {
    return "ViewManagerServiceSetViewBoundsResponseParams("
           "success: $success" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["success"] = success;
    return map;
  }
}


class ViewManagerServiceSetViewVisibilityParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int viewId = 0;
  bool visible = false;

  ViewManagerServiceSetViewVisibilityParams() : super(kVersions.last.size);

  static ViewManagerServiceSetViewVisibilityParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerServiceSetViewVisibilityParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerServiceSetViewVisibilityParams result = new ViewManagerServiceSetViewVisibilityParams();

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
      
      result.visible = decoder0.decodeBool(12, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(viewId, 8);
    
    encoder0.encodeBool(visible, 12, 0);
  }

  String toString() {
    return "ViewManagerServiceSetViewVisibilityParams("
           "viewId: $viewId" ", "
           "visible: $visible" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["viewId"] = viewId;
    map["visible"] = visible;
    return map;
  }
}


class ViewManagerServiceSetViewVisibilityResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool success = false;

  ViewManagerServiceSetViewVisibilityResponseParams() : super(kVersions.last.size);

  static ViewManagerServiceSetViewVisibilityResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerServiceSetViewVisibilityResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerServiceSetViewVisibilityResponseParams result = new ViewManagerServiceSetViewVisibilityResponseParams();

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
      
      result.success = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeBool(success, 8, 0);
  }

  String toString() {
    return "ViewManagerServiceSetViewVisibilityResponseParams("
           "success: $success" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["success"] = success;
    return map;
  }
}


class ViewManagerServiceSetViewPropertyParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  int viewId = 0;
  String name = null;
  List<int> value = null;

  ViewManagerServiceSetViewPropertyParams() : super(kVersions.last.size);

  static ViewManagerServiceSetViewPropertyParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerServiceSetViewPropertyParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerServiceSetViewPropertyParams result = new ViewManagerServiceSetViewPropertyParams();

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
      
      result.name = decoder0.decodeString(16, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.value = decoder0.decodeUint8Array(24, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(viewId, 8);
    
    encoder0.encodeString(name, 16, false);
    
    encoder0.encodeUint8Array(value, 24, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
  }

  String toString() {
    return "ViewManagerServiceSetViewPropertyParams("
           "viewId: $viewId" ", "
           "name: $name" ", "
           "value: $value" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["viewId"] = viewId;
    map["name"] = name;
    map["value"] = value;
    return map;
  }
}


class ViewManagerServiceSetViewPropertyResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool success = false;

  ViewManagerServiceSetViewPropertyResponseParams() : super(kVersions.last.size);

  static ViewManagerServiceSetViewPropertyResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerServiceSetViewPropertyResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerServiceSetViewPropertyResponseParams result = new ViewManagerServiceSetViewPropertyResponseParams();

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
      
      result.success = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeBool(success, 8, 0);
  }

  String toString() {
    return "ViewManagerServiceSetViewPropertyResponseParams("
           "success: $success" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["success"] = success;
    return map;
  }
}


class ViewManagerServiceAddViewParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int parent = 0;
  int child = 0;

  ViewManagerServiceAddViewParams() : super(kVersions.last.size);

  static ViewManagerServiceAddViewParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerServiceAddViewParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerServiceAddViewParams result = new ViewManagerServiceAddViewParams();

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
      
      result.parent = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.child = decoder0.decodeUint32(12);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(parent, 8);
    
    encoder0.encodeUint32(child, 12);
  }

  String toString() {
    return "ViewManagerServiceAddViewParams("
           "parent: $parent" ", "
           "child: $child" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["parent"] = parent;
    map["child"] = child;
    return map;
  }
}


class ViewManagerServiceAddViewResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool success = false;

  ViewManagerServiceAddViewResponseParams() : super(kVersions.last.size);

  static ViewManagerServiceAddViewResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerServiceAddViewResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerServiceAddViewResponseParams result = new ViewManagerServiceAddViewResponseParams();

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
      
      result.success = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeBool(success, 8, 0);
  }

  String toString() {
    return "ViewManagerServiceAddViewResponseParams("
           "success: $success" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["success"] = success;
    return map;
  }
}


class ViewManagerServiceRemoveViewFromParentParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int viewId = 0;

  ViewManagerServiceRemoveViewFromParentParams() : super(kVersions.last.size);

  static ViewManagerServiceRemoveViewFromParentParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerServiceRemoveViewFromParentParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerServiceRemoveViewFromParentParams result = new ViewManagerServiceRemoveViewFromParentParams();

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
    return "ViewManagerServiceRemoveViewFromParentParams("
           "viewId: $viewId" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["viewId"] = viewId;
    return map;
  }
}


class ViewManagerServiceRemoveViewFromParentResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool success = false;

  ViewManagerServiceRemoveViewFromParentResponseParams() : super(kVersions.last.size);

  static ViewManagerServiceRemoveViewFromParentResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerServiceRemoveViewFromParentResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerServiceRemoveViewFromParentResponseParams result = new ViewManagerServiceRemoveViewFromParentResponseParams();

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
      
      result.success = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeBool(success, 8, 0);
  }

  String toString() {
    return "ViewManagerServiceRemoveViewFromParentResponseParams("
           "success: $success" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["success"] = success;
    return map;
  }
}


class ViewManagerServiceReorderViewParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int viewId = 0;
  int relativeViewId = 0;
  view_manager_constants_mojom.OrderDirection direction = null;

  ViewManagerServiceReorderViewParams() : super(kVersions.last.size);

  static ViewManagerServiceReorderViewParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerServiceReorderViewParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerServiceReorderViewParams result = new ViewManagerServiceReorderViewParams();

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
      
      result.relativeViewId = decoder0.decodeUint32(12);
    }
    if (mainDataHeader.version >= 0) {
      
        result.direction = view_manager_constants_mojom.OrderDirection.decode(decoder0, 16);
        if (result.direction == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable view_manager_constants_mojom.OrderDirection.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(viewId, 8);
    
    encoder0.encodeUint32(relativeViewId, 12);
    
    encoder0.encodeEnum(direction, 16);
  }

  String toString() {
    return "ViewManagerServiceReorderViewParams("
           "viewId: $viewId" ", "
           "relativeViewId: $relativeViewId" ", "
           "direction: $direction" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["viewId"] = viewId;
    map["relativeViewId"] = relativeViewId;
    map["direction"] = direction;
    return map;
  }
}


class ViewManagerServiceReorderViewResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool success = false;

  ViewManagerServiceReorderViewResponseParams() : super(kVersions.last.size);

  static ViewManagerServiceReorderViewResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerServiceReorderViewResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerServiceReorderViewResponseParams result = new ViewManagerServiceReorderViewResponseParams();

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
      
      result.success = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeBool(success, 8, 0);
  }

  String toString() {
    return "ViewManagerServiceReorderViewResponseParams("
           "success: $success" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["success"] = success;
    return map;
  }
}


class ViewManagerServiceGetViewTreeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int viewId = 0;

  ViewManagerServiceGetViewTreeParams() : super(kVersions.last.size);

  static ViewManagerServiceGetViewTreeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerServiceGetViewTreeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerServiceGetViewTreeParams result = new ViewManagerServiceGetViewTreeParams();

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
    return "ViewManagerServiceGetViewTreeParams("
           "viewId: $viewId" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["viewId"] = viewId;
    return map;
  }
}


class ViewManagerServiceGetViewTreeResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<ViewData> views = null;

  ViewManagerServiceGetViewTreeResponseParams() : super(kVersions.last.size);

  static ViewManagerServiceGetViewTreeResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerServiceGetViewTreeResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerServiceGetViewTreeResponseParams result = new ViewManagerServiceGetViewTreeResponseParams();

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
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.views = new List<ViewData>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.views[i1] = ViewData.decode(decoder2);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    if (views == null) {
      encoder0.encodeNullPointer(8, false);
    } else {
      var encoder1 = encoder0.encodePointerArray(views.length, 8, bindings.kUnspecifiedArrayLength);
      for (int i0 = 0; i0 < views.length; ++i0) {
        
        encoder1.encodeStruct(views[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
      }
    }
  }

  String toString() {
    return "ViewManagerServiceGetViewTreeResponseParams("
           "views: $views" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["views"] = views;
    return map;
  }
}


class ViewManagerServiceSetViewSurfaceIdParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int viewId = 0;
  surface_id_mojom.SurfaceId surfaceId = null;

  ViewManagerServiceSetViewSurfaceIdParams() : super(kVersions.last.size);

  static ViewManagerServiceSetViewSurfaceIdParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerServiceSetViewSurfaceIdParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerServiceSetViewSurfaceIdParams result = new ViewManagerServiceSetViewSurfaceIdParams();

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
      result.surfaceId = surface_id_mojom.SurfaceId.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(viewId, 8);
    
    encoder0.encodeStruct(surfaceId, 16, false);
  }

  String toString() {
    return "ViewManagerServiceSetViewSurfaceIdParams("
           "viewId: $viewId" ", "
           "surfaceId: $surfaceId" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["viewId"] = viewId;
    map["surfaceId"] = surfaceId;
    return map;
  }
}


class ViewManagerServiceSetViewSurfaceIdResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool success = false;

  ViewManagerServiceSetViewSurfaceIdResponseParams() : super(kVersions.last.size);

  static ViewManagerServiceSetViewSurfaceIdResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerServiceSetViewSurfaceIdResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerServiceSetViewSurfaceIdResponseParams result = new ViewManagerServiceSetViewSurfaceIdResponseParams();

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
      
      result.success = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeBool(success, 8, 0);
  }

  String toString() {
    return "ViewManagerServiceSetViewSurfaceIdResponseParams("
           "success: $success" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["success"] = success;
    return map;
  }
}


class ViewManagerServiceEmbedUrlParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  String url = null;
  int viewId = 0;
  Object services = null;
  Object exposedServices = null;

  ViewManagerServiceEmbedUrlParams() : super(kVersions.last.size);

  static ViewManagerServiceEmbedUrlParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerServiceEmbedUrlParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerServiceEmbedUrlParams result = new ViewManagerServiceEmbedUrlParams();

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
      
      result.url = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.viewId = decoder0.decodeUint32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.services = decoder0.decodeInterfaceRequest(20, true, service_provider_mojom.ServiceProviderStub.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.exposedServices = decoder0.decodeServiceInterface(24, true, service_provider_mojom.ServiceProviderProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeString(url, 8, false);
    
    encoder0.encodeUint32(viewId, 16);
    
    encoder0.encodeInterfaceRequest(services, 20, true);
    
    encoder0.encodeInterface(exposedServices, 24, true);
  }

  String toString() {
    return "ViewManagerServiceEmbedUrlParams("
           "url: $url" ", "
           "viewId: $viewId" ", "
           "services: $services" ", "
           "exposedServices: $exposedServices" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class ViewManagerServiceEmbedUrlResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool success = false;

  ViewManagerServiceEmbedUrlResponseParams() : super(kVersions.last.size);

  static ViewManagerServiceEmbedUrlResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerServiceEmbedUrlResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerServiceEmbedUrlResponseParams result = new ViewManagerServiceEmbedUrlResponseParams();

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
      
      result.success = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeBool(success, 8, 0);
  }

  String toString() {
    return "ViewManagerServiceEmbedUrlResponseParams("
           "success: $success" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["success"] = success;
    return map;
  }
}


class ViewManagerServiceEmbedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int viewId = 0;
  Object client = null;

  ViewManagerServiceEmbedParams() : super(kVersions.last.size);

  static ViewManagerServiceEmbedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerServiceEmbedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerServiceEmbedParams result = new ViewManagerServiceEmbedParams();

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
      
      result.client = decoder0.decodeServiceInterface(12, false, ViewManagerClientProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(viewId, 8);
    
    encoder0.encodeInterface(client, 12, false);
  }

  String toString() {
    return "ViewManagerServiceEmbedParams("
           "viewId: $viewId" ", "
           "client: $client" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class ViewManagerServiceEmbedResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool success = false;

  ViewManagerServiceEmbedResponseParams() : super(kVersions.last.size);

  static ViewManagerServiceEmbedResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerServiceEmbedResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerServiceEmbedResponseParams result = new ViewManagerServiceEmbedResponseParams();

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
      
      result.success = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeBool(success, 8, 0);
  }

  String toString() {
    return "ViewManagerServiceEmbedResponseParams("
           "success: $success" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["success"] = success;
    return map;
  }
}


class ViewManagerServicePerformActionParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int viewId = 0;
  String action = null;

  ViewManagerServicePerformActionParams() : super(kVersions.last.size);

  static ViewManagerServicePerformActionParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerServicePerformActionParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerServicePerformActionParams result = new ViewManagerServicePerformActionParams();

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
      
      result.action = decoder0.decodeString(16, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(viewId, 8);
    
    encoder0.encodeString(action, 16, false);
  }

  String toString() {
    return "ViewManagerServicePerformActionParams("
           "viewId: $viewId" ", "
           "action: $action" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["viewId"] = viewId;
    map["action"] = action;
    return map;
  }
}


class ViewManagerServicePerformActionResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool success = false;

  ViewManagerServicePerformActionResponseParams() : super(kVersions.last.size);

  static ViewManagerServicePerformActionResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerServicePerformActionResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerServicePerformActionResponseParams result = new ViewManagerServicePerformActionResponseParams();

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
      
      result.success = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeBool(success, 8, 0);
  }

  String toString() {
    return "ViewManagerServicePerformActionResponseParams("
           "success: $success" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["success"] = success;
    return map;
  }
}


class ViewManagerClientOnEmbedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(56, 0)
  ];
  int connectionId = 0;
  Object services = null;
  String embedderUrl = null;
  ViewData root = null;
  Object viewManagerService = null;
  Object exposedServices = null;
  core.MojoMessagePipeEndpoint windowManagerPipe = null;

  ViewManagerClientOnEmbedParams() : super(kVersions.last.size);

  static ViewManagerClientOnEmbedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerClientOnEmbedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerClientOnEmbedParams result = new ViewManagerClientOnEmbedParams();

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
      
      result.services = decoder0.decodeInterfaceRequest(12, true, service_provider_mojom.ServiceProviderStub.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.embedderUrl = decoder0.decodeString(16, false);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, false);
      result.root = ViewData.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.viewManagerService = decoder0.decodeServiceInterface(32, true, ViewManagerServiceProxy.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.exposedServices = decoder0.decodeServiceInterface(40, true, service_provider_mojom.ServiceProviderProxy.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.windowManagerPipe = decoder0.decodeMessagePipeHandle(48, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint16(connectionId, 8);
    
    encoder0.encodeInterfaceRequest(services, 12, true);
    
    encoder0.encodeString(embedderUrl, 16, false);
    
    encoder0.encodeStruct(root, 24, false);
    
    encoder0.encodeInterface(viewManagerService, 32, true);
    
    encoder0.encodeInterface(exposedServices, 40, true);
    
    encoder0.encodeMessagePipeHandle(windowManagerPipe, 48, false);
  }

  String toString() {
    return "ViewManagerClientOnEmbedParams("
           "connectionId: $connectionId" ", "
           "services: $services" ", "
           "embedderUrl: $embedderUrl" ", "
           "root: $root" ", "
           "viewManagerService: $viewManagerService" ", "
           "exposedServices: $exposedServices" ", "
           "windowManagerPipe: $windowManagerPipe" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class ViewManagerClientOnEmbeddedAppDisconnectedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int view = 0;

  ViewManagerClientOnEmbeddedAppDisconnectedParams() : super(kVersions.last.size);

  static ViewManagerClientOnEmbeddedAppDisconnectedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerClientOnEmbeddedAppDisconnectedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerClientOnEmbeddedAppDisconnectedParams result = new ViewManagerClientOnEmbeddedAppDisconnectedParams();

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
      
      result.view = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(view, 8);
  }

  String toString() {
    return "ViewManagerClientOnEmbeddedAppDisconnectedParams("
           "view: $view" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["view"] = view;
    return map;
  }
}


class ViewManagerClientOnViewBoundsChangedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  int view = 0;
  geometry_mojom.Rect oldBounds = null;
  geometry_mojom.Rect newBounds = null;

  ViewManagerClientOnViewBoundsChangedParams() : super(kVersions.last.size);

  static ViewManagerClientOnViewBoundsChangedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerClientOnViewBoundsChangedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerClientOnViewBoundsChangedParams result = new ViewManagerClientOnViewBoundsChangedParams();

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
      
      result.view = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.oldBounds = geometry_mojom.Rect.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, false);
      result.newBounds = geometry_mojom.Rect.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(view, 8);
    
    encoder0.encodeStruct(oldBounds, 16, false);
    
    encoder0.encodeStruct(newBounds, 24, false);
  }

  String toString() {
    return "ViewManagerClientOnViewBoundsChangedParams("
           "view: $view" ", "
           "oldBounds: $oldBounds" ", "
           "newBounds: $newBounds" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["view"] = view;
    map["oldBounds"] = oldBounds;
    map["newBounds"] = newBounds;
    return map;
  }
}


class ViewManagerClientOnViewViewportMetricsChangedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  native_viewport_mojom.ViewportMetrics oldMetrics = null;
  native_viewport_mojom.ViewportMetrics newMetrics = null;

  ViewManagerClientOnViewViewportMetricsChangedParams() : super(kVersions.last.size);

  static ViewManagerClientOnViewViewportMetricsChangedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerClientOnViewViewportMetricsChangedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerClientOnViewViewportMetricsChangedParams result = new ViewManagerClientOnViewViewportMetricsChangedParams();

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
      result.oldMetrics = native_viewport_mojom.ViewportMetrics.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.newMetrics = native_viewport_mojom.ViewportMetrics.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(oldMetrics, 8, false);
    
    encoder0.encodeStruct(newMetrics, 16, false);
  }

  String toString() {
    return "ViewManagerClientOnViewViewportMetricsChangedParams("
           "oldMetrics: $oldMetrics" ", "
           "newMetrics: $newMetrics" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["oldMetrics"] = oldMetrics;
    map["newMetrics"] = newMetrics;
    return map;
  }
}


class ViewManagerClientOnViewHierarchyChangedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  int view = 0;
  int newParent = 0;
  int oldParent = 0;
  List<ViewData> views = null;

  ViewManagerClientOnViewHierarchyChangedParams() : super(kVersions.last.size);

  static ViewManagerClientOnViewHierarchyChangedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerClientOnViewHierarchyChangedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerClientOnViewHierarchyChangedParams result = new ViewManagerClientOnViewHierarchyChangedParams();

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
      
      result.view = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.newParent = decoder0.decodeUint32(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.oldParent = decoder0.decodeUint32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.views = new List<ViewData>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.views[i1] = ViewData.decode(decoder2);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(view, 8);
    
    encoder0.encodeUint32(newParent, 12);
    
    encoder0.encodeUint32(oldParent, 16);
    
    if (views == null) {
      encoder0.encodeNullPointer(24, false);
    } else {
      var encoder1 = encoder0.encodePointerArray(views.length, 24, bindings.kUnspecifiedArrayLength);
      for (int i0 = 0; i0 < views.length; ++i0) {
        
        encoder1.encodeStruct(views[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
      }
    }
  }

  String toString() {
    return "ViewManagerClientOnViewHierarchyChangedParams("
           "view: $view" ", "
           "newParent: $newParent" ", "
           "oldParent: $oldParent" ", "
           "views: $views" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["view"] = view;
    map["newParent"] = newParent;
    map["oldParent"] = oldParent;
    map["views"] = views;
    return map;
  }
}


class ViewManagerClientOnViewReorderedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int viewId = 0;
  int relativeViewId = 0;
  view_manager_constants_mojom.OrderDirection direction = null;

  ViewManagerClientOnViewReorderedParams() : super(kVersions.last.size);

  static ViewManagerClientOnViewReorderedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerClientOnViewReorderedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerClientOnViewReorderedParams result = new ViewManagerClientOnViewReorderedParams();

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
      
      result.relativeViewId = decoder0.decodeUint32(12);
    }
    if (mainDataHeader.version >= 0) {
      
        result.direction = view_manager_constants_mojom.OrderDirection.decode(decoder0, 16);
        if (result.direction == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable view_manager_constants_mojom.OrderDirection.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(viewId, 8);
    
    encoder0.encodeUint32(relativeViewId, 12);
    
    encoder0.encodeEnum(direction, 16);
  }

  String toString() {
    return "ViewManagerClientOnViewReorderedParams("
           "viewId: $viewId" ", "
           "relativeViewId: $relativeViewId" ", "
           "direction: $direction" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["viewId"] = viewId;
    map["relativeViewId"] = relativeViewId;
    map["direction"] = direction;
    return map;
  }
}


class ViewManagerClientOnViewDeletedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int view = 0;

  ViewManagerClientOnViewDeletedParams() : super(kVersions.last.size);

  static ViewManagerClientOnViewDeletedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerClientOnViewDeletedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerClientOnViewDeletedParams result = new ViewManagerClientOnViewDeletedParams();

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
      
      result.view = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(view, 8);
  }

  String toString() {
    return "ViewManagerClientOnViewDeletedParams("
           "view: $view" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["view"] = view;
    return map;
  }
}


class ViewManagerClientOnViewVisibilityChangedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int view = 0;
  bool visible = false;

  ViewManagerClientOnViewVisibilityChangedParams() : super(kVersions.last.size);

  static ViewManagerClientOnViewVisibilityChangedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerClientOnViewVisibilityChangedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerClientOnViewVisibilityChangedParams result = new ViewManagerClientOnViewVisibilityChangedParams();

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
      
      result.view = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.visible = decoder0.decodeBool(12, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(view, 8);
    
    encoder0.encodeBool(visible, 12, 0);
  }

  String toString() {
    return "ViewManagerClientOnViewVisibilityChangedParams("
           "view: $view" ", "
           "visible: $visible" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["view"] = view;
    map["visible"] = visible;
    return map;
  }
}


class ViewManagerClientOnViewDrawnStateChangedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int view = 0;
  bool drawn = false;

  ViewManagerClientOnViewDrawnStateChangedParams() : super(kVersions.last.size);

  static ViewManagerClientOnViewDrawnStateChangedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerClientOnViewDrawnStateChangedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerClientOnViewDrawnStateChangedParams result = new ViewManagerClientOnViewDrawnStateChangedParams();

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
      
      result.view = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.drawn = decoder0.decodeBool(12, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(view, 8);
    
    encoder0.encodeBool(drawn, 12, 0);
  }

  String toString() {
    return "ViewManagerClientOnViewDrawnStateChangedParams("
           "view: $view" ", "
           "drawn: $drawn" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["view"] = view;
    map["drawn"] = drawn;
    return map;
  }
}


class ViewManagerClientOnViewSharedPropertyChangedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  int view = 0;
  String name = null;
  List<int> newData = null;

  ViewManagerClientOnViewSharedPropertyChangedParams() : super(kVersions.last.size);

  static ViewManagerClientOnViewSharedPropertyChangedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerClientOnViewSharedPropertyChangedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerClientOnViewSharedPropertyChangedParams result = new ViewManagerClientOnViewSharedPropertyChangedParams();

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
      
      result.view = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.name = decoder0.decodeString(16, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.newData = decoder0.decodeUint8Array(24, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(view, 8);
    
    encoder0.encodeString(name, 16, false);
    
    encoder0.encodeUint8Array(newData, 24, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
  }

  String toString() {
    return "ViewManagerClientOnViewSharedPropertyChangedParams("
           "view: $view" ", "
           "name: $name" ", "
           "newData: $newData" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["view"] = view;
    map["name"] = name;
    map["newData"] = newData;
    return map;
  }
}


class ViewManagerClientOnViewInputEventParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int view = 0;
  input_events_mojom.Event event = null;

  ViewManagerClientOnViewInputEventParams() : super(kVersions.last.size);

  static ViewManagerClientOnViewInputEventParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerClientOnViewInputEventParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerClientOnViewInputEventParams result = new ViewManagerClientOnViewInputEventParams();

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
      
      result.view = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.event = input_events_mojom.Event.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(view, 8);
    
    encoder0.encodeStruct(event, 16, false);
  }

  String toString() {
    return "ViewManagerClientOnViewInputEventParams("
           "view: $view" ", "
           "event: $event" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["view"] = view;
    map["event"] = event;
    return map;
  }
}


class ViewManagerClientOnViewInputEventResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  ViewManagerClientOnViewInputEventResponseParams() : super(kVersions.last.size);

  static ViewManagerClientOnViewInputEventResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerClientOnViewInputEventResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerClientOnViewInputEventResponseParams result = new ViewManagerClientOnViewInputEventResponseParams();

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
    return "ViewManagerClientOnViewInputEventResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class ViewManagerClientOnPerformActionParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int viewId = 0;
  String action = null;

  ViewManagerClientOnPerformActionParams() : super(kVersions.last.size);

  static ViewManagerClientOnPerformActionParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerClientOnPerformActionParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerClientOnPerformActionParams result = new ViewManagerClientOnPerformActionParams();

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
      
      result.action = decoder0.decodeString(16, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(viewId, 8);
    
    encoder0.encodeString(action, 16, false);
  }

  String toString() {
    return "ViewManagerClientOnPerformActionParams("
           "viewId: $viewId" ", "
           "action: $action" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["viewId"] = viewId;
    map["action"] = action;
    return map;
  }
}


class ViewManagerClientOnPerformActionResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool success = false;

  ViewManagerClientOnPerformActionResponseParams() : super(kVersions.last.size);

  static ViewManagerClientOnPerformActionResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewManagerClientOnPerformActionResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewManagerClientOnPerformActionResponseParams result = new ViewManagerClientOnPerformActionResponseParams();

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
      
      result.success = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeBool(success, 8, 0);
  }

  String toString() {
    return "ViewManagerClientOnPerformActionResponseParams("
           "success: $success" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["success"] = success;
    return map;
  }
}

const int kViewManagerService_createView_name = 0;
const int kViewManagerService_deleteView_name = 1;
const int kViewManagerService_setViewBounds_name = 2;
const int kViewManagerService_setViewVisibility_name = 3;
const int kViewManagerService_setViewProperty_name = 4;
const int kViewManagerService_addView_name = 5;
const int kViewManagerService_removeViewFromParent_name = 6;
const int kViewManagerService_reorderView_name = 7;
const int kViewManagerService_getViewTree_name = 8;
const int kViewManagerService_setViewSurfaceId_name = 9;
const int kViewManagerService_embedUrl_name = 10;
const int kViewManagerService_embed_name = 11;
const int kViewManagerService_performAction_name = 12;
const String ViewManagerServiceName = "mojo::ViewManagerService";

abstract class ViewManagerService {
  dynamic createView(int viewId,[Function responseFactory = null]);
  dynamic deleteView(int viewId,[Function responseFactory = null]);
  dynamic setViewBounds(int viewId,geometry_mojom.Rect bounds,[Function responseFactory = null]);
  dynamic setViewVisibility(int viewId,bool visible,[Function responseFactory = null]);
  dynamic setViewProperty(int viewId,String name,List<int> value,[Function responseFactory = null]);
  dynamic addView(int parent,int child,[Function responseFactory = null]);
  dynamic removeViewFromParent(int viewId,[Function responseFactory = null]);
  dynamic reorderView(int viewId,int relativeViewId,view_manager_constants_mojom.OrderDirection direction,[Function responseFactory = null]);
  dynamic getViewTree(int viewId,[Function responseFactory = null]);
  dynamic setViewSurfaceId(int viewId,surface_id_mojom.SurfaceId surfaceId,[Function responseFactory = null]);
  dynamic embedUrl(String url,int viewId,Object services,Object exposedServices,[Function responseFactory = null]);
  dynamic embed(int viewId,Object client,[Function responseFactory = null]);
  dynamic performAction(int viewId,String action,[Function responseFactory = null]);

}


class ViewManagerServiceProxyImpl extends bindings.Proxy {
  ViewManagerServiceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  ViewManagerServiceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  ViewManagerServiceProxyImpl.unbound() : super.unbound();

  static ViewManagerServiceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewManagerServiceProxyImpl"));
    return new ViewManagerServiceProxyImpl.fromEndpoint(endpoint);
  }

  String get name => ViewManagerServiceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case kViewManagerService_createView_name:
        var r = ViewManagerServiceCreateViewResponseParams.deserialize(
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
      case kViewManagerService_deleteView_name:
        var r = ViewManagerServiceDeleteViewResponseParams.deserialize(
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
      case kViewManagerService_setViewBounds_name:
        var r = ViewManagerServiceSetViewBoundsResponseParams.deserialize(
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
      case kViewManagerService_setViewVisibility_name:
        var r = ViewManagerServiceSetViewVisibilityResponseParams.deserialize(
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
      case kViewManagerService_setViewProperty_name:
        var r = ViewManagerServiceSetViewPropertyResponseParams.deserialize(
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
      case kViewManagerService_addView_name:
        var r = ViewManagerServiceAddViewResponseParams.deserialize(
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
      case kViewManagerService_removeViewFromParent_name:
        var r = ViewManagerServiceRemoveViewFromParentResponseParams.deserialize(
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
      case kViewManagerService_reorderView_name:
        var r = ViewManagerServiceReorderViewResponseParams.deserialize(
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
      case kViewManagerService_getViewTree_name:
        var r = ViewManagerServiceGetViewTreeResponseParams.deserialize(
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
      case kViewManagerService_setViewSurfaceId_name:
        var r = ViewManagerServiceSetViewSurfaceIdResponseParams.deserialize(
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
      case kViewManagerService_embedUrl_name:
        var r = ViewManagerServiceEmbedUrlResponseParams.deserialize(
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
      case kViewManagerService_embed_name:
        var r = ViewManagerServiceEmbedResponseParams.deserialize(
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
      case kViewManagerService_performAction_name:
        var r = ViewManagerServicePerformActionResponseParams.deserialize(
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
    return "ViewManagerServiceProxyImpl($superString)";
  }
}


class _ViewManagerServiceProxyCalls implements ViewManagerService {
  ViewManagerServiceProxyImpl _proxyImpl;

  _ViewManagerServiceProxyCalls(this._proxyImpl);
    dynamic createView(int viewId,[Function responseFactory = null]) {
      var params = new ViewManagerServiceCreateViewParams();
      params.viewId = viewId;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kViewManagerService_createView_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic deleteView(int viewId,[Function responseFactory = null]) {
      var params = new ViewManagerServiceDeleteViewParams();
      params.viewId = viewId;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kViewManagerService_deleteView_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic setViewBounds(int viewId,geometry_mojom.Rect bounds,[Function responseFactory = null]) {
      var params = new ViewManagerServiceSetViewBoundsParams();
      params.viewId = viewId;
      params.bounds = bounds;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kViewManagerService_setViewBounds_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic setViewVisibility(int viewId,bool visible,[Function responseFactory = null]) {
      var params = new ViewManagerServiceSetViewVisibilityParams();
      params.viewId = viewId;
      params.visible = visible;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kViewManagerService_setViewVisibility_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic setViewProperty(int viewId,String name,List<int> value,[Function responseFactory = null]) {
      var params = new ViewManagerServiceSetViewPropertyParams();
      params.viewId = viewId;
      params.name = name;
      params.value = value;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kViewManagerService_setViewProperty_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic addView(int parent,int child,[Function responseFactory = null]) {
      var params = new ViewManagerServiceAddViewParams();
      params.parent = parent;
      params.child = child;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kViewManagerService_addView_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic removeViewFromParent(int viewId,[Function responseFactory = null]) {
      var params = new ViewManagerServiceRemoveViewFromParentParams();
      params.viewId = viewId;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kViewManagerService_removeViewFromParent_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic reorderView(int viewId,int relativeViewId,view_manager_constants_mojom.OrderDirection direction,[Function responseFactory = null]) {
      var params = new ViewManagerServiceReorderViewParams();
      params.viewId = viewId;
      params.relativeViewId = relativeViewId;
      params.direction = direction;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kViewManagerService_reorderView_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic getViewTree(int viewId,[Function responseFactory = null]) {
      var params = new ViewManagerServiceGetViewTreeParams();
      params.viewId = viewId;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kViewManagerService_getViewTree_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic setViewSurfaceId(int viewId,surface_id_mojom.SurfaceId surfaceId,[Function responseFactory = null]) {
      var params = new ViewManagerServiceSetViewSurfaceIdParams();
      params.viewId = viewId;
      params.surfaceId = surfaceId;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kViewManagerService_setViewSurfaceId_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic embedUrl(String url,int viewId,Object services,Object exposedServices,[Function responseFactory = null]) {
      var params = new ViewManagerServiceEmbedUrlParams();
      params.url = url;
      params.viewId = viewId;
      params.services = services;
      params.exposedServices = exposedServices;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kViewManagerService_embedUrl_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic embed(int viewId,Object client,[Function responseFactory = null]) {
      var params = new ViewManagerServiceEmbedParams();
      params.viewId = viewId;
      params.client = client;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kViewManagerService_embed_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic performAction(int viewId,String action,[Function responseFactory = null]) {
      var params = new ViewManagerServicePerformActionParams();
      params.viewId = viewId;
      params.action = action;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kViewManagerService_performAction_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class ViewManagerServiceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  ViewManagerService ptr;
  final String name = ViewManagerServiceName;

  ViewManagerServiceProxy(ViewManagerServiceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ViewManagerServiceProxyCalls(proxyImpl);

  ViewManagerServiceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new ViewManagerServiceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ViewManagerServiceProxyCalls(impl);
  }

  ViewManagerServiceProxy.fromHandle(core.MojoHandle handle) :
      impl = new ViewManagerServiceProxyImpl.fromHandle(handle) {
    ptr = new _ViewManagerServiceProxyCalls(impl);
  }

  ViewManagerServiceProxy.unbound() :
      impl = new ViewManagerServiceProxyImpl.unbound() {
    ptr = new _ViewManagerServiceProxyCalls(impl);
  }

  factory ViewManagerServiceProxy.connectToService(
      bindings.ServiceConnector s, String url) {
    ViewManagerServiceProxy p = new ViewManagerServiceProxy.unbound();
    s.connectToService(url, p);
    return p;
  }

  static ViewManagerServiceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewManagerServiceProxy"));
    return new ViewManagerServiceProxy.fromEndpoint(endpoint);
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
    return "ViewManagerServiceProxy($impl)";
  }
}


class ViewManagerServiceStub extends bindings.Stub {
  ViewManagerService _impl = null;

  ViewManagerServiceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  ViewManagerServiceStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  ViewManagerServiceStub.unbound() : super.unbound();

  static ViewManagerServiceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewManagerServiceStub"));
    return new ViewManagerServiceStub.fromEndpoint(endpoint);
  }

  static const String name = ViewManagerServiceName;


  ViewManagerServiceCreateViewResponseParams _ViewManagerServiceCreateViewResponseParamsFactory(ErrorCode errorCode) {
    var mojo_factory_result = new ViewManagerServiceCreateViewResponseParams();
    mojo_factory_result.errorCode = errorCode;
    return mojo_factory_result;
  }
  ViewManagerServiceDeleteViewResponseParams _ViewManagerServiceDeleteViewResponseParamsFactory(bool success) {
    var mojo_factory_result = new ViewManagerServiceDeleteViewResponseParams();
    mojo_factory_result.success = success;
    return mojo_factory_result;
  }
  ViewManagerServiceSetViewBoundsResponseParams _ViewManagerServiceSetViewBoundsResponseParamsFactory(bool success) {
    var mojo_factory_result = new ViewManagerServiceSetViewBoundsResponseParams();
    mojo_factory_result.success = success;
    return mojo_factory_result;
  }
  ViewManagerServiceSetViewVisibilityResponseParams _ViewManagerServiceSetViewVisibilityResponseParamsFactory(bool success) {
    var mojo_factory_result = new ViewManagerServiceSetViewVisibilityResponseParams();
    mojo_factory_result.success = success;
    return mojo_factory_result;
  }
  ViewManagerServiceSetViewPropertyResponseParams _ViewManagerServiceSetViewPropertyResponseParamsFactory(bool success) {
    var mojo_factory_result = new ViewManagerServiceSetViewPropertyResponseParams();
    mojo_factory_result.success = success;
    return mojo_factory_result;
  }
  ViewManagerServiceAddViewResponseParams _ViewManagerServiceAddViewResponseParamsFactory(bool success) {
    var mojo_factory_result = new ViewManagerServiceAddViewResponseParams();
    mojo_factory_result.success = success;
    return mojo_factory_result;
  }
  ViewManagerServiceRemoveViewFromParentResponseParams _ViewManagerServiceRemoveViewFromParentResponseParamsFactory(bool success) {
    var mojo_factory_result = new ViewManagerServiceRemoveViewFromParentResponseParams();
    mojo_factory_result.success = success;
    return mojo_factory_result;
  }
  ViewManagerServiceReorderViewResponseParams _ViewManagerServiceReorderViewResponseParamsFactory(bool success) {
    var mojo_factory_result = new ViewManagerServiceReorderViewResponseParams();
    mojo_factory_result.success = success;
    return mojo_factory_result;
  }
  ViewManagerServiceGetViewTreeResponseParams _ViewManagerServiceGetViewTreeResponseParamsFactory(List<ViewData> views) {
    var mojo_factory_result = new ViewManagerServiceGetViewTreeResponseParams();
    mojo_factory_result.views = views;
    return mojo_factory_result;
  }
  ViewManagerServiceSetViewSurfaceIdResponseParams _ViewManagerServiceSetViewSurfaceIdResponseParamsFactory(bool success) {
    var mojo_factory_result = new ViewManagerServiceSetViewSurfaceIdResponseParams();
    mojo_factory_result.success = success;
    return mojo_factory_result;
  }
  ViewManagerServiceEmbedUrlResponseParams _ViewManagerServiceEmbedUrlResponseParamsFactory(bool success) {
    var mojo_factory_result = new ViewManagerServiceEmbedUrlResponseParams();
    mojo_factory_result.success = success;
    return mojo_factory_result;
  }
  ViewManagerServiceEmbedResponseParams _ViewManagerServiceEmbedResponseParamsFactory(bool success) {
    var mojo_factory_result = new ViewManagerServiceEmbedResponseParams();
    mojo_factory_result.success = success;
    return mojo_factory_result;
  }
  ViewManagerServicePerformActionResponseParams _ViewManagerServicePerformActionResponseParamsFactory(bool success) {
    var mojo_factory_result = new ViewManagerServicePerformActionResponseParams();
    mojo_factory_result.success = success;
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
      case kViewManagerService_createView_name:
        var params = ViewManagerServiceCreateViewParams.deserialize(
            message.payload);
        var response = _impl.createView(params.viewId,_ViewManagerServiceCreateViewResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kViewManagerService_createView_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kViewManagerService_createView_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kViewManagerService_deleteView_name:
        var params = ViewManagerServiceDeleteViewParams.deserialize(
            message.payload);
        var response = _impl.deleteView(params.viewId,_ViewManagerServiceDeleteViewResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kViewManagerService_deleteView_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kViewManagerService_deleteView_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kViewManagerService_setViewBounds_name:
        var params = ViewManagerServiceSetViewBoundsParams.deserialize(
            message.payload);
        var response = _impl.setViewBounds(params.viewId,params.bounds,_ViewManagerServiceSetViewBoundsResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kViewManagerService_setViewBounds_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kViewManagerService_setViewBounds_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kViewManagerService_setViewVisibility_name:
        var params = ViewManagerServiceSetViewVisibilityParams.deserialize(
            message.payload);
        var response = _impl.setViewVisibility(params.viewId,params.visible,_ViewManagerServiceSetViewVisibilityResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kViewManagerService_setViewVisibility_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kViewManagerService_setViewVisibility_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kViewManagerService_setViewProperty_name:
        var params = ViewManagerServiceSetViewPropertyParams.deserialize(
            message.payload);
        var response = _impl.setViewProperty(params.viewId,params.name,params.value,_ViewManagerServiceSetViewPropertyResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kViewManagerService_setViewProperty_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kViewManagerService_setViewProperty_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kViewManagerService_addView_name:
        var params = ViewManagerServiceAddViewParams.deserialize(
            message.payload);
        var response = _impl.addView(params.parent,params.child,_ViewManagerServiceAddViewResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kViewManagerService_addView_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kViewManagerService_addView_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kViewManagerService_removeViewFromParent_name:
        var params = ViewManagerServiceRemoveViewFromParentParams.deserialize(
            message.payload);
        var response = _impl.removeViewFromParent(params.viewId,_ViewManagerServiceRemoveViewFromParentResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kViewManagerService_removeViewFromParent_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kViewManagerService_removeViewFromParent_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kViewManagerService_reorderView_name:
        var params = ViewManagerServiceReorderViewParams.deserialize(
            message.payload);
        var response = _impl.reorderView(params.viewId,params.relativeViewId,params.direction,_ViewManagerServiceReorderViewResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kViewManagerService_reorderView_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kViewManagerService_reorderView_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kViewManagerService_getViewTree_name:
        var params = ViewManagerServiceGetViewTreeParams.deserialize(
            message.payload);
        var response = _impl.getViewTree(params.viewId,_ViewManagerServiceGetViewTreeResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kViewManagerService_getViewTree_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kViewManagerService_getViewTree_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kViewManagerService_setViewSurfaceId_name:
        var params = ViewManagerServiceSetViewSurfaceIdParams.deserialize(
            message.payload);
        var response = _impl.setViewSurfaceId(params.viewId,params.surfaceId,_ViewManagerServiceSetViewSurfaceIdResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kViewManagerService_setViewSurfaceId_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kViewManagerService_setViewSurfaceId_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kViewManagerService_embedUrl_name:
        var params = ViewManagerServiceEmbedUrlParams.deserialize(
            message.payload);
        var response = _impl.embedUrl(params.url,params.viewId,params.services,params.exposedServices,_ViewManagerServiceEmbedUrlResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kViewManagerService_embedUrl_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kViewManagerService_embedUrl_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kViewManagerService_embed_name:
        var params = ViewManagerServiceEmbedParams.deserialize(
            message.payload);
        var response = _impl.embed(params.viewId,params.client,_ViewManagerServiceEmbedResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kViewManagerService_embed_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kViewManagerService_embed_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kViewManagerService_performAction_name:
        var params = ViewManagerServicePerformActionParams.deserialize(
            message.payload);
        var response = _impl.performAction(params.viewId,params.action,_ViewManagerServicePerformActionResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kViewManagerService_performAction_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kViewManagerService_performAction_name,
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

  ViewManagerService get impl => _impl;
  set impl(ViewManagerService d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "ViewManagerServiceStub($superString)";
  }

  int get version => 0;
}

const int kViewManagerClient_onEmbed_name = 0;
const int kViewManagerClient_onEmbeddedAppDisconnected_name = 1;
const int kViewManagerClient_onViewBoundsChanged_name = 2;
const int kViewManagerClient_onViewViewportMetricsChanged_name = 3;
const int kViewManagerClient_onViewHierarchyChanged_name = 4;
const int kViewManagerClient_onViewReordered_name = 5;
const int kViewManagerClient_onViewDeleted_name = 6;
const int kViewManagerClient_onViewVisibilityChanged_name = 7;
const int kViewManagerClient_onViewDrawnStateChanged_name = 8;
const int kViewManagerClient_onViewSharedPropertyChanged_name = 9;
const int kViewManagerClient_onViewInputEvent_name = 10;
const int kViewManagerClient_onPerformAction_name = 11;
const String ViewManagerClientName = "mojo::ViewManagerClient";

abstract class ViewManagerClient {
  void onEmbed(int connectionId, String embedderUrl, ViewData root, Object viewManagerService, Object services, Object exposedServices, core.MojoMessagePipeEndpoint windowManagerPipe);
  void onEmbeddedAppDisconnected(int view);
  void onViewBoundsChanged(int view, geometry_mojom.Rect oldBounds, geometry_mojom.Rect newBounds);
  void onViewViewportMetricsChanged(native_viewport_mojom.ViewportMetrics oldMetrics, native_viewport_mojom.ViewportMetrics newMetrics);
  void onViewHierarchyChanged(int view, int newParent, int oldParent, List<ViewData> views);
  void onViewReordered(int viewId, int relativeViewId, view_manager_constants_mojom.OrderDirection direction);
  void onViewDeleted(int view);
  void onViewVisibilityChanged(int view, bool visible);
  void onViewDrawnStateChanged(int view, bool drawn);
  void onViewSharedPropertyChanged(int view, String name, List<int> newData);
  dynamic onViewInputEvent(int view,input_events_mojom.Event event,[Function responseFactory = null]);
  dynamic onPerformAction(int viewId,String action,[Function responseFactory = null]);

}


class ViewManagerClientProxyImpl extends bindings.Proxy {
  ViewManagerClientProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  ViewManagerClientProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  ViewManagerClientProxyImpl.unbound() : super.unbound();

  static ViewManagerClientProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewManagerClientProxyImpl"));
    return new ViewManagerClientProxyImpl.fromEndpoint(endpoint);
  }

  String get name => ViewManagerClientName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case kViewManagerClient_onViewInputEvent_name:
        var r = ViewManagerClientOnViewInputEventResponseParams.deserialize(
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
      case kViewManagerClient_onPerformAction_name:
        var r = ViewManagerClientOnPerformActionResponseParams.deserialize(
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
    return "ViewManagerClientProxyImpl($superString)";
  }
}


class _ViewManagerClientProxyCalls implements ViewManagerClient {
  ViewManagerClientProxyImpl _proxyImpl;

  _ViewManagerClientProxyCalls(this._proxyImpl);
    void onEmbed(int connectionId, String embedderUrl, ViewData root, Object viewManagerService, Object services, Object exposedServices, core.MojoMessagePipeEndpoint windowManagerPipe) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new ViewManagerClientOnEmbedParams();
      params.connectionId = connectionId;
      params.embedderUrl = embedderUrl;
      params.root = root;
      params.viewManagerService = viewManagerService;
      params.services = services;
      params.exposedServices = exposedServices;
      params.windowManagerPipe = windowManagerPipe;
      _proxyImpl.sendMessage(params, kViewManagerClient_onEmbed_name);
    }
  
    void onEmbeddedAppDisconnected(int view) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new ViewManagerClientOnEmbeddedAppDisconnectedParams();
      params.view = view;
      _proxyImpl.sendMessage(params, kViewManagerClient_onEmbeddedAppDisconnected_name);
    }
  
    void onViewBoundsChanged(int view, geometry_mojom.Rect oldBounds, geometry_mojom.Rect newBounds) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new ViewManagerClientOnViewBoundsChangedParams();
      params.view = view;
      params.oldBounds = oldBounds;
      params.newBounds = newBounds;
      _proxyImpl.sendMessage(params, kViewManagerClient_onViewBoundsChanged_name);
    }
  
    void onViewViewportMetricsChanged(native_viewport_mojom.ViewportMetrics oldMetrics, native_viewport_mojom.ViewportMetrics newMetrics) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new ViewManagerClientOnViewViewportMetricsChangedParams();
      params.oldMetrics = oldMetrics;
      params.newMetrics = newMetrics;
      _proxyImpl.sendMessage(params, kViewManagerClient_onViewViewportMetricsChanged_name);
    }
  
    void onViewHierarchyChanged(int view, int newParent, int oldParent, List<ViewData> views) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new ViewManagerClientOnViewHierarchyChangedParams();
      params.view = view;
      params.newParent = newParent;
      params.oldParent = oldParent;
      params.views = views;
      _proxyImpl.sendMessage(params, kViewManagerClient_onViewHierarchyChanged_name);
    }
  
    void onViewReordered(int viewId, int relativeViewId, view_manager_constants_mojom.OrderDirection direction) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new ViewManagerClientOnViewReorderedParams();
      params.viewId = viewId;
      params.relativeViewId = relativeViewId;
      params.direction = direction;
      _proxyImpl.sendMessage(params, kViewManagerClient_onViewReordered_name);
    }
  
    void onViewDeleted(int view) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new ViewManagerClientOnViewDeletedParams();
      params.view = view;
      _proxyImpl.sendMessage(params, kViewManagerClient_onViewDeleted_name);
    }
  
    void onViewVisibilityChanged(int view, bool visible) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new ViewManagerClientOnViewVisibilityChangedParams();
      params.view = view;
      params.visible = visible;
      _proxyImpl.sendMessage(params, kViewManagerClient_onViewVisibilityChanged_name);
    }
  
    void onViewDrawnStateChanged(int view, bool drawn) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new ViewManagerClientOnViewDrawnStateChangedParams();
      params.view = view;
      params.drawn = drawn;
      _proxyImpl.sendMessage(params, kViewManagerClient_onViewDrawnStateChanged_name);
    }
  
    void onViewSharedPropertyChanged(int view, String name, List<int> newData) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new ViewManagerClientOnViewSharedPropertyChangedParams();
      params.view = view;
      params.name = name;
      params.newData = newData;
      _proxyImpl.sendMessage(params, kViewManagerClient_onViewSharedPropertyChanged_name);
    }
  
    dynamic onViewInputEvent(int view,input_events_mojom.Event event,[Function responseFactory = null]) {
      var params = new ViewManagerClientOnViewInputEventParams();
      params.view = view;
      params.event = event;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kViewManagerClient_onViewInputEvent_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic onPerformAction(int viewId,String action,[Function responseFactory = null]) {
      var params = new ViewManagerClientOnPerformActionParams();
      params.viewId = viewId;
      params.action = action;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kViewManagerClient_onPerformAction_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class ViewManagerClientProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  ViewManagerClient ptr;
  final String name = ViewManagerClientName;

  ViewManagerClientProxy(ViewManagerClientProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ViewManagerClientProxyCalls(proxyImpl);

  ViewManagerClientProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new ViewManagerClientProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ViewManagerClientProxyCalls(impl);
  }

  ViewManagerClientProxy.fromHandle(core.MojoHandle handle) :
      impl = new ViewManagerClientProxyImpl.fromHandle(handle) {
    ptr = new _ViewManagerClientProxyCalls(impl);
  }

  ViewManagerClientProxy.unbound() :
      impl = new ViewManagerClientProxyImpl.unbound() {
    ptr = new _ViewManagerClientProxyCalls(impl);
  }

  factory ViewManagerClientProxy.connectToService(
      bindings.ServiceConnector s, String url) {
    ViewManagerClientProxy p = new ViewManagerClientProxy.unbound();
    s.connectToService(url, p);
    return p;
  }

  static ViewManagerClientProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewManagerClientProxy"));
    return new ViewManagerClientProxy.fromEndpoint(endpoint);
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
    return "ViewManagerClientProxy($impl)";
  }
}


class ViewManagerClientStub extends bindings.Stub {
  ViewManagerClient _impl = null;

  ViewManagerClientStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  ViewManagerClientStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  ViewManagerClientStub.unbound() : super.unbound();

  static ViewManagerClientStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewManagerClientStub"));
    return new ViewManagerClientStub.fromEndpoint(endpoint);
  }

  static const String name = ViewManagerClientName;


  ViewManagerClientOnViewInputEventResponseParams _ViewManagerClientOnViewInputEventResponseParamsFactory() {
    var mojo_factory_result = new ViewManagerClientOnViewInputEventResponseParams();
    return mojo_factory_result;
  }
  ViewManagerClientOnPerformActionResponseParams _ViewManagerClientOnPerformActionResponseParamsFactory(bool success) {
    var mojo_factory_result = new ViewManagerClientOnPerformActionResponseParams();
    mojo_factory_result.success = success;
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
      case kViewManagerClient_onEmbed_name:
        var params = ViewManagerClientOnEmbedParams.deserialize(
            message.payload);
        _impl.onEmbed(params.connectionId, params.embedderUrl, params.root, params.viewManagerService, params.services, params.exposedServices, params.windowManagerPipe);
        break;
      case kViewManagerClient_onEmbeddedAppDisconnected_name:
        var params = ViewManagerClientOnEmbeddedAppDisconnectedParams.deserialize(
            message.payload);
        _impl.onEmbeddedAppDisconnected(params.view);
        break;
      case kViewManagerClient_onViewBoundsChanged_name:
        var params = ViewManagerClientOnViewBoundsChangedParams.deserialize(
            message.payload);
        _impl.onViewBoundsChanged(params.view, params.oldBounds, params.newBounds);
        break;
      case kViewManagerClient_onViewViewportMetricsChanged_name:
        var params = ViewManagerClientOnViewViewportMetricsChangedParams.deserialize(
            message.payload);
        _impl.onViewViewportMetricsChanged(params.oldMetrics, params.newMetrics);
        break;
      case kViewManagerClient_onViewHierarchyChanged_name:
        var params = ViewManagerClientOnViewHierarchyChangedParams.deserialize(
            message.payload);
        _impl.onViewHierarchyChanged(params.view, params.newParent, params.oldParent, params.views);
        break;
      case kViewManagerClient_onViewReordered_name:
        var params = ViewManagerClientOnViewReorderedParams.deserialize(
            message.payload);
        _impl.onViewReordered(params.viewId, params.relativeViewId, params.direction);
        break;
      case kViewManagerClient_onViewDeleted_name:
        var params = ViewManagerClientOnViewDeletedParams.deserialize(
            message.payload);
        _impl.onViewDeleted(params.view);
        break;
      case kViewManagerClient_onViewVisibilityChanged_name:
        var params = ViewManagerClientOnViewVisibilityChangedParams.deserialize(
            message.payload);
        _impl.onViewVisibilityChanged(params.view, params.visible);
        break;
      case kViewManagerClient_onViewDrawnStateChanged_name:
        var params = ViewManagerClientOnViewDrawnStateChangedParams.deserialize(
            message.payload);
        _impl.onViewDrawnStateChanged(params.view, params.drawn);
        break;
      case kViewManagerClient_onViewSharedPropertyChanged_name:
        var params = ViewManagerClientOnViewSharedPropertyChangedParams.deserialize(
            message.payload);
        _impl.onViewSharedPropertyChanged(params.view, params.name, params.newData);
        break;
      case kViewManagerClient_onViewInputEvent_name:
        var params = ViewManagerClientOnViewInputEventParams.deserialize(
            message.payload);
        var response = _impl.onViewInputEvent(params.view,params.event,_ViewManagerClientOnViewInputEventResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kViewManagerClient_onViewInputEvent_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kViewManagerClient_onViewInputEvent_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kViewManagerClient_onPerformAction_name:
        var params = ViewManagerClientOnPerformActionParams.deserialize(
            message.payload);
        var response = _impl.onPerformAction(params.viewId,params.action,_ViewManagerClientOnPerformActionResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kViewManagerClient_onPerformAction_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kViewManagerClient_onPerformAction_name,
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

  ViewManagerClient get impl => _impl;
  set impl(ViewManagerClient d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "ViewManagerClientStub($superString)";
  }

  int get version => 0;
}


