// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library input_events_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;

import 'package:mojo_services/mojo/geometry.mojom.dart' as geometry_mojom;
import 'package:mojo_services/mojo/input_event_constants.mojom.dart' as input_event_constants_mojom;
import 'package:mojo_services/mojo/input_key_codes.mojom.dart' as input_key_codes_mojom;



class KeyData extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  int keyCode = 0;
  bool isChar = false;
  int character = 0;
  input_key_codes_mojom.KeyboardCode windowsKeyCode = null;
  int nativeKeyCode = 0;
  int text = 0;
  int unmodifiedText = 0;

  KeyData() : super(kVersions.last.size);

  static KeyData deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static KeyData decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    KeyData result = new KeyData();

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
      
      result.keyCode = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.isChar = decoder0.decodeBool(12, 0);
    }
    if (mainDataHeader.version >= 0) {
      
      result.character = decoder0.decodeUint16(14);
    }
    if (mainDataHeader.version >= 0) {
      
        result.windowsKeyCode = input_key_codes_mojom.KeyboardCode.decode(decoder0, 16);
        if (result.windowsKeyCode == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable input_key_codes_mojom.KeyboardCode.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.nativeKeyCode = decoder0.decodeInt32(20);
    }
    if (mainDataHeader.version >= 0) {
      
      result.text = decoder0.decodeUint16(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.unmodifiedText = decoder0.decodeUint16(26);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(keyCode, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "keyCode of struct KeyData: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(isChar, 12, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "isChar of struct KeyData: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint16(character, 14);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "character of struct KeyData: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(windowsKeyCode, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "windowsKeyCode of struct KeyData: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(nativeKeyCode, 20);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "nativeKeyCode of struct KeyData: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint16(text, 24);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "text of struct KeyData: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint16(unmodifiedText, 26);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "unmodifiedText of struct KeyData: $e";
      rethrow;
    }
  }

  String toString() {
    return "KeyData("
           "keyCode: $keyCode" ", "
           "isChar: $isChar" ", "
           "character: $character" ", "
           "windowsKeyCode: $windowsKeyCode" ", "
           "nativeKeyCode: $nativeKeyCode" ", "
           "text: $text" ", "
           "unmodifiedText: $unmodifiedText" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["keyCode"] = keyCode;
    map["isChar"] = isChar;
    map["character"] = character;
    map["windowsKeyCode"] = windowsKeyCode;
    map["nativeKeyCode"] = nativeKeyCode;
    map["text"] = text;
    map["unmodifiedText"] = unmodifiedText;
    return map;
  }
}




class PointerData extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(56, 0)
  ];
  int pointerId = 0;
  input_event_constants_mojom.PointerKind kind = null;
  double x = 0.0;
  double y = 0.0;
  double screenX = 0.0;
  double screenY = 0.0;
  double pressure = 0.0;
  double radiusMajor = 0.0;
  double radiusMinor = 0.0;
  double orientation = 0.0;
  double horizontalWheel = 0.0;
  double verticalWheel = 0.0;

  PointerData() : super(kVersions.last.size);

  static PointerData deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static PointerData decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    PointerData result = new PointerData();

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
      
      result.pointerId = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 0) {
      
        result.kind = input_event_constants_mojom.PointerKind.decode(decoder0, 12);
        if (result.kind == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable input_event_constants_mojom.PointerKind.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.x = decoder0.decodeFloat(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.y = decoder0.decodeFloat(20);
    }
    if (mainDataHeader.version >= 0) {
      
      result.screenX = decoder0.decodeFloat(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.screenY = decoder0.decodeFloat(28);
    }
    if (mainDataHeader.version >= 0) {
      
      result.pressure = decoder0.decodeFloat(32);
    }
    if (mainDataHeader.version >= 0) {
      
      result.radiusMajor = decoder0.decodeFloat(36);
    }
    if (mainDataHeader.version >= 0) {
      
      result.radiusMinor = decoder0.decodeFloat(40);
    }
    if (mainDataHeader.version >= 0) {
      
      result.orientation = decoder0.decodeFloat(44);
    }
    if (mainDataHeader.version >= 0) {
      
      result.horizontalWheel = decoder0.decodeFloat(48);
    }
    if (mainDataHeader.version >= 0) {
      
      result.verticalWheel = decoder0.decodeFloat(52);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(pointerId, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "pointerId of struct PointerData: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(kind, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "kind of struct PointerData: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(x, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "x of struct PointerData: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(y, 20);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "y of struct PointerData: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(screenX, 24);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "screenX of struct PointerData: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(screenY, 28);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "screenY of struct PointerData: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(pressure, 32);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "pressure of struct PointerData: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(radiusMajor, 36);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "radiusMajor of struct PointerData: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(radiusMinor, 40);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "radiusMinor of struct PointerData: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(orientation, 44);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "orientation of struct PointerData: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(horizontalWheel, 48);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "horizontalWheel of struct PointerData: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(verticalWheel, 52);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "verticalWheel of struct PointerData: $e";
      rethrow;
    }
  }

  String toString() {
    return "PointerData("
           "pointerId: $pointerId" ", "
           "kind: $kind" ", "
           "x: $x" ", "
           "y: $y" ", "
           "screenX: $screenX" ", "
           "screenY: $screenY" ", "
           "pressure: $pressure" ", "
           "radiusMajor: $radiusMajor" ", "
           "radiusMinor: $radiusMinor" ", "
           "orientation: $orientation" ", "
           "horizontalWheel: $horizontalWheel" ", "
           "verticalWheel: $verticalWheel" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["pointerId"] = pointerId;
    map["kind"] = kind;
    map["x"] = x;
    map["y"] = y;
    map["screenX"] = screenX;
    map["screenY"] = screenY;
    map["pressure"] = pressure;
    map["radiusMajor"] = radiusMajor;
    map["radiusMinor"] = radiusMinor;
    map["orientation"] = orientation;
    map["horizontalWheel"] = horizontalWheel;
    map["verticalWheel"] = verticalWheel;
    return map;
  }
}




class Event extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(40, 0)
  ];
  input_event_constants_mojom.EventType action = null;
  input_event_constants_mojom.EventFlags flags = null;
  int timeStamp = 0;
  KeyData keyData = null;
  PointerData pointerData = null;

  Event() : super(kVersions.last.size);

  static Event deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Event decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Event result = new Event();

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
      
        result.action = input_event_constants_mojom.EventType.decode(decoder0, 8);
        if (result.action == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable input_event_constants_mojom.EventType.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
        result.flags = input_event_constants_mojom.EventFlags.decode(decoder0, 12);
        if (result.flags == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable input_event_constants_mojom.EventFlags.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.timeStamp = decoder0.decodeInt64(16);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, true);
      result.keyData = KeyData.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(32, true);
      result.pointerData = PointerData.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(action, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "action of struct Event: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(flags, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "flags of struct Event: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(timeStamp, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "timeStamp of struct Event: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(keyData, 24, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "keyData of struct Event: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(pointerData, 32, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "pointerData of struct Event: $e";
      rethrow;
    }
  }

  String toString() {
    return "Event("
           "action: $action" ", "
           "flags: $flags" ", "
           "timeStamp: $timeStamp" ", "
           "keyData: $keyData" ", "
           "pointerData: $pointerData" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["action"] = action;
    map["flags"] = flags;
    map["timeStamp"] = timeStamp;
    map["keyData"] = keyData;
    map["pointerData"] = pointerData;
    return map;
  }
}






