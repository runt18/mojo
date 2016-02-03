// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library rect_mojom;

import 'dart:async';
import 'dart:collection';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;




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

mojom_types.MojomStruct _rectRect() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'Rect'
      ..fullIdentifier = 'mojo.test.Rect')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'X')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int32),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Y')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int32),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Width')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int32),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Height')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int32),];
}



Map<String, mojom_types.UserDefinedType> _initDescriptions() {
  var map = new HashMap<String, mojom_types.UserDefinedType>();
  map["rect_Rect__"] =
    new mojom_types.UserDefinedType()
      ..structType = _rectRect();
  return map;
}

var _mojomDesc;
Map<String, mojom_types.UserDefinedType> getAllMojomTypeDefinitions() {
  if (_mojomDesc == null) {
    _mojomDesc = _initDescriptions();
  }
  return _mojomDesc;
}

