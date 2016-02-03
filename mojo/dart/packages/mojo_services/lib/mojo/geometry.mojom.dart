// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library geometry_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;




class Point extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int x = 0;
  int y = 0;

  Point() : super(kVersions.last.size);

  static Point deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Point decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Point result = new Point();

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
      
      result.x = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.y = decoder0.decodeInt32(12);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(x, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "x of struct Point: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(y, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "y of struct Point: $e";
      rethrow;
    }
  }

  String toString() {
    return "Point("
           "x: $x" ", "
           "y: $y" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["x"] = x;
    map["y"] = y;
    return map;
  }
}




class PointF extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  double x = 0.0;
  double y = 0.0;

  PointF() : super(kVersions.last.size);

  static PointF deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static PointF decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    PointF result = new PointF();

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
      
      result.x = decoder0.decodeFloat(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.y = decoder0.decodeFloat(12);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeFloat(x, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "x of struct PointF: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(y, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "y of struct PointF: $e";
      rethrow;
    }
  }

  String toString() {
    return "PointF("
           "x: $x" ", "
           "y: $y" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["x"] = x;
    map["y"] = y;
    return map;
  }
}




class Size extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int width = 0;
  int height = 0;

  Size() : super(kVersions.last.size);

  static Size deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Size decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Size result = new Size();

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
      
      result.width = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.height = decoder0.decodeInt32(12);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(width, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "width of struct Size: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(height, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "height of struct Size: $e";
      rethrow;
    }
  }

  String toString() {
    return "Size("
           "width: $width" ", "
           "height: $height" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["width"] = width;
    map["height"] = height;
    return map;
  }
}




class Rect extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int x = 0;
  int y = 0;
  int width = 0;
  int height = 0;

  Rect() : super(kVersions.last.size);

  static Rect deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Rect decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Rect result = new Rect();

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
      
      result.x = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.y = decoder0.decodeInt32(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.width = decoder0.decodeInt32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.height = decoder0.decodeInt32(20);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(x, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "x of struct Rect: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(y, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "y of struct Rect: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(width, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "width of struct Rect: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(height, 20);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "height of struct Rect: $e";
      rethrow;
    }
  }

  String toString() {
    return "Rect("
           "x: $x" ", "
           "y: $y" ", "
           "width: $width" ", "
           "height: $height" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["x"] = x;
    map["y"] = y;
    map["width"] = width;
    map["height"] = height;
    return map;
  }
}




class RectF extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  double x = 0.0;
  double y = 0.0;
  double width = 0.0;
  double height = 0.0;

  RectF() : super(kVersions.last.size);

  static RectF deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static RectF decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    RectF result = new RectF();

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
      
      result.x = decoder0.decodeFloat(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.y = decoder0.decodeFloat(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.width = decoder0.decodeFloat(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.height = decoder0.decodeFloat(20);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeFloat(x, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "x of struct RectF: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(y, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "y of struct RectF: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(width, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "width of struct RectF: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(height, 20);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "height of struct RectF: $e";
      rethrow;
    }
  }

  String toString() {
    return "RectF("
           "x: $x" ", "
           "y: $y" ", "
           "width: $width" ", "
           "height: $height" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["x"] = x;
    map["y"] = y;
    map["width"] = width;
    map["height"] = height;
    return map;
  }
}




class RRect extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(56, 0)
  ];
  int x = 0;
  int y = 0;
  int width = 0;
  int height = 0;
  int topLeftRadiusX = 0;
  int topLeftRadiusY = 0;
  int topRightRadiusX = 0;
  int topRightRadiusY = 0;
  int bottomLeftRadiusX = 0;
  int bottomLeftRadiusY = 0;
  int bottomRightRadiusX = 0;
  int bottomRightRadiusY = 0;

  RRect() : super(kVersions.last.size);

  static RRect deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static RRect decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    RRect result = new RRect();

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
      
      result.x = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.y = decoder0.decodeInt32(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.width = decoder0.decodeInt32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.height = decoder0.decodeInt32(20);
    }
    if (mainDataHeader.version >= 0) {
      
      result.topLeftRadiusX = decoder0.decodeInt32(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.topLeftRadiusY = decoder0.decodeInt32(28);
    }
    if (mainDataHeader.version >= 0) {
      
      result.topRightRadiusX = decoder0.decodeInt32(32);
    }
    if (mainDataHeader.version >= 0) {
      
      result.topRightRadiusY = decoder0.decodeInt32(36);
    }
    if (mainDataHeader.version >= 0) {
      
      result.bottomLeftRadiusX = decoder0.decodeInt32(40);
    }
    if (mainDataHeader.version >= 0) {
      
      result.bottomLeftRadiusY = decoder0.decodeInt32(44);
    }
    if (mainDataHeader.version >= 0) {
      
      result.bottomRightRadiusX = decoder0.decodeInt32(48);
    }
    if (mainDataHeader.version >= 0) {
      
      result.bottomRightRadiusY = decoder0.decodeInt32(52);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(x, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "x of struct RRect: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(y, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "y of struct RRect: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(width, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "width of struct RRect: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(height, 20);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "height of struct RRect: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(topLeftRadiusX, 24);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "topLeftRadiusX of struct RRect: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(topLeftRadiusY, 28);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "topLeftRadiusY of struct RRect: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(topRightRadiusX, 32);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "topRightRadiusX of struct RRect: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(topRightRadiusY, 36);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "topRightRadiusY of struct RRect: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(bottomLeftRadiusX, 40);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "bottomLeftRadiusX of struct RRect: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(bottomLeftRadiusY, 44);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "bottomLeftRadiusY of struct RRect: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(bottomRightRadiusX, 48);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "bottomRightRadiusX of struct RRect: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(bottomRightRadiusY, 52);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "bottomRightRadiusY of struct RRect: $e";
      rethrow;
    }
  }

  String toString() {
    return "RRect("
           "x: $x" ", "
           "y: $y" ", "
           "width: $width" ", "
           "height: $height" ", "
           "topLeftRadiusX: $topLeftRadiusX" ", "
           "topLeftRadiusY: $topLeftRadiusY" ", "
           "topRightRadiusX: $topRightRadiusX" ", "
           "topRightRadiusY: $topRightRadiusY" ", "
           "bottomLeftRadiusX: $bottomLeftRadiusX" ", "
           "bottomLeftRadiusY: $bottomLeftRadiusY" ", "
           "bottomRightRadiusX: $bottomRightRadiusX" ", "
           "bottomRightRadiusY: $bottomRightRadiusY" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["x"] = x;
    map["y"] = y;
    map["width"] = width;
    map["height"] = height;
    map["topLeftRadiusX"] = topLeftRadiusX;
    map["topLeftRadiusY"] = topLeftRadiusY;
    map["topRightRadiusX"] = topRightRadiusX;
    map["topRightRadiusY"] = topRightRadiusY;
    map["bottomLeftRadiusX"] = bottomLeftRadiusX;
    map["bottomLeftRadiusY"] = bottomLeftRadiusY;
    map["bottomRightRadiusX"] = bottomRightRadiusX;
    map["bottomRightRadiusY"] = bottomRightRadiusY;
    return map;
  }
}




class Transform extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<double> matrix = null;

  Transform() : super(kVersions.last.size);

  static Transform deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Transform decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Transform result = new Transform();

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
      
      result.matrix = decoder0.decodeFloatArray(8, bindings.kNothingNullable, 16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeFloatArray(matrix, 8, bindings.kNothingNullable, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "matrix of struct Transform: $e";
      rethrow;
    }
  }

  String toString() {
    return "Transform("
           "matrix: $matrix" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["matrix"] = matrix;
    return map;
  }
}






