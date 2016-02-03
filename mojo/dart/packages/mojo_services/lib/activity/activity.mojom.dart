// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library activity_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;

class SystemUiVisibility extends bindings.MojoEnum {
  static const SystemUiVisibility standard = const SystemUiVisibility._(0);
  static const SystemUiVisibility fullscreen = const SystemUiVisibility._(1);
  static const SystemUiVisibility immersive = const SystemUiVisibility._(2);

  const SystemUiVisibility._(int v) : super(v);

  static const Map<String, SystemUiVisibility> valuesMap = const {
    "standard": standard,
    "fullscreen": fullscreen,
    "immersive": immersive,
  };
  static const List<SystemUiVisibility> values = const [
    standard,
    fullscreen,
    immersive,
  ];

  static SystemUiVisibility valueOf(String name) => valuesMap[name];

  factory SystemUiVisibility(int v) {
    switch (v) {
      case 0:
        return standard;
      case 1:
        return fullscreen;
      case 2:
        return immersive;
      default:
        return null;
    }
  }

  static SystemUiVisibility decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    SystemUiVisibility result = new SystemUiVisibility(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum SystemUiVisibility.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case standard:
        return 'SystemUiVisibility.standard';
      case fullscreen:
        return 'SystemUiVisibility.fullscreen';
      case immersive:
        return 'SystemUiVisibility.immersive';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}



class ScreenOrientation extends bindings.MojoEnum {
  static const ScreenOrientation unspecified = const ScreenOrientation._(0);
  static const ScreenOrientation landscape = const ScreenOrientation._(1);
  static const ScreenOrientation portrait = const ScreenOrientation._(2);
  static const ScreenOrientation nosensor = const ScreenOrientation._(3);

  const ScreenOrientation._(int v) : super(v);

  static const Map<String, ScreenOrientation> valuesMap = const {
    "unspecified": unspecified,
    "landscape": landscape,
    "portrait": portrait,
    "nosensor": nosensor,
  };
  static const List<ScreenOrientation> values = const [
    unspecified,
    landscape,
    portrait,
    nosensor,
  ];

  static ScreenOrientation valueOf(String name) => valuesMap[name];

  factory ScreenOrientation(int v) {
    switch (v) {
      case 0:
        return unspecified;
      case 1:
        return landscape;
      case 2:
        return portrait;
      case 3:
        return nosensor;
      default:
        return null;
    }
  }

  static ScreenOrientation decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    ScreenOrientation result = new ScreenOrientation(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum ScreenOrientation.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case unspecified:
        return 'ScreenOrientation.unspecified';
      case landscape:
        return 'ScreenOrientation.landscape';
      case portrait:
        return 'ScreenOrientation.portrait';
      case nosensor:
        return 'ScreenOrientation.nosensor';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}



class HapticFeedbackType extends bindings.MojoEnum {
  static const HapticFeedbackType longPress = const HapticFeedbackType._(0);
  static const HapticFeedbackType virtualKey = const HapticFeedbackType._(1);
  static const HapticFeedbackType keyboardTap = const HapticFeedbackType._(2);
  static const HapticFeedbackType clockTick = const HapticFeedbackType._(3);

  const HapticFeedbackType._(int v) : super(v);

  static const Map<String, HapticFeedbackType> valuesMap = const {
    "longPress": longPress,
    "virtualKey": virtualKey,
    "keyboardTap": keyboardTap,
    "clockTick": clockTick,
  };
  static const List<HapticFeedbackType> values = const [
    longPress,
    virtualKey,
    keyboardTap,
    clockTick,
  ];

  static HapticFeedbackType valueOf(String name) => valuesMap[name];

  factory HapticFeedbackType(int v) {
    switch (v) {
      case 0:
        return longPress;
      case 1:
        return virtualKey;
      case 2:
        return keyboardTap;
      case 3:
        return clockTick;
      default:
        return null;
    }
  }

  static HapticFeedbackType decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    HapticFeedbackType result = new HapticFeedbackType(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum HapticFeedbackType.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case longPress:
        return 'HapticFeedbackType.longPress';
      case virtualKey:
        return 'HapticFeedbackType.virtualKey';
      case keyboardTap:
        return 'HapticFeedbackType.keyboardTap';
      case clockTick:
        return 'HapticFeedbackType.clockTick';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}



class AuralFeedbackType extends bindings.MojoEnum {
  static const AuralFeedbackType click = const AuralFeedbackType._(0);
  static const AuralFeedbackType navigationLeft = const AuralFeedbackType._(1);
  static const AuralFeedbackType navigationUp = const AuralFeedbackType._(2);
  static const AuralFeedbackType navigationRight = const AuralFeedbackType._(3);
  static const AuralFeedbackType navigationDown = const AuralFeedbackType._(4);

  const AuralFeedbackType._(int v) : super(v);

  static const Map<String, AuralFeedbackType> valuesMap = const {
    "click": click,
    "navigationLeft": navigationLeft,
    "navigationUp": navigationUp,
    "navigationRight": navigationRight,
    "navigationDown": navigationDown,
  };
  static const List<AuralFeedbackType> values = const [
    click,
    navigationLeft,
    navigationUp,
    navigationRight,
    navigationDown,
  ];

  static AuralFeedbackType valueOf(String name) => valuesMap[name];

  factory AuralFeedbackType(int v) {
    switch (v) {
      case 0:
        return click;
      case 1:
        return navigationLeft;
      case 2:
        return navigationUp;
      case 3:
        return navigationRight;
      case 4:
        return navigationDown;
      default:
        return null;
    }
  }

  static AuralFeedbackType decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    AuralFeedbackType result = new AuralFeedbackType(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum AuralFeedbackType.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case click:
        return 'AuralFeedbackType.click';
      case navigationLeft:
        return 'AuralFeedbackType.navigationLeft';
      case navigationUp:
        return 'AuralFeedbackType.navigationUp';
      case navigationRight:
        return 'AuralFeedbackType.navigationRight';
      case navigationDown:
        return 'AuralFeedbackType.navigationDown';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}





class StringExtra extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String name = null;
  String value = null;

  StringExtra() : super(kVersions.last.size);

  static StringExtra deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static StringExtra decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    StringExtra result = new StringExtra();

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
      
      result.name = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.value = decoder0.decodeString(16, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(name, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "name of struct StringExtra: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(value, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "value of struct StringExtra: $e";
      rethrow;
    }
  }

  String toString() {
    return "StringExtra("
           "name: $name" ", "
           "value: $value" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["name"] = name;
    map["value"] = value;
    return map;
  }
}




class ComponentName extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String packageName = null;
  String className = null;

  ComponentName() : super(kVersions.last.size);

  static ComponentName deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ComponentName decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ComponentName result = new ComponentName();

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
      
      result.packageName = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.className = decoder0.decodeString(16, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(packageName, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "packageName of struct ComponentName: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(className, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "className of struct ComponentName: $e";
      rethrow;
    }
  }

  String toString() {
    return "ComponentName("
           "packageName: $packageName" ", "
           "className: $className" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["packageName"] = packageName;
    map["className"] = className;
    return map;
  }
}




class Intent extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(56, 0)
  ];
  String action = null;
  String url = null;
  int flags = 0;
  ComponentName component = null;
  List<StringExtra> stringExtras = null;
  String type = null;

  Intent() : super(kVersions.last.size);

  static Intent deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Intent decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Intent result = new Intent();

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
      
      result.action = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.url = decoder0.decodeString(16, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.flags = decoder0.decodeUint32(24);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(32, true);
      result.component = ComponentName.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(40, true);
      if (decoder1 == null) {
        result.stringExtras = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.stringExtras = new List<StringExtra>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.stringExtras[i1] = StringExtra.decode(decoder2);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      result.type = decoder0.decodeString(48, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(action, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "action of struct Intent: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(url, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "url of struct Intent: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(flags, 24);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "flags of struct Intent: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(component, 32, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "component of struct Intent: $e";
      rethrow;
    }
    try {
      if (stringExtras == null) {
        encoder0.encodeNullPointer(40, true);
      } else {
        var encoder1 = encoder0.encodePointerArray(stringExtras.length, 40, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < stringExtras.length; ++i0) {
          encoder1.encodeStruct(stringExtras[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "stringExtras of struct Intent: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(type, 48, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "type of struct Intent: $e";
      rethrow;
    }
  }

  String toString() {
    return "Intent("
           "action: $action" ", "
           "url: $url" ", "
           "flags: $flags" ", "
           "component: $component" ", "
           "stringExtras: $stringExtras" ", "
           "type: $type" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["action"] = action;
    map["url"] = url;
    map["flags"] = flags;
    map["component"] = component;
    map["stringExtras"] = stringExtras;
    map["type"] = type;
    return map;
  }
}




class TaskDescription extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String label = null;
  int primaryColor = 0;

  TaskDescription() : super(kVersions.last.size);

  static TaskDescription deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TaskDescription decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TaskDescription result = new TaskDescription();

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
      
      result.label = decoder0.decodeString(8, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.primaryColor = decoder0.decodeUint32(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(label, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "label of struct TaskDescription: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(primaryColor, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "primaryColor of struct TaskDescription: $e";
      rethrow;
    }
  }

  String toString() {
    return "TaskDescription("
           "label: $label" ", "
           "primaryColor: $primaryColor" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["label"] = label;
    map["primaryColor"] = primaryColor;
    return map;
  }
}




class _ActivityGetUserFeedbackParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object userFeedback = null;

  _ActivityGetUserFeedbackParams() : super(kVersions.last.size);

  static _ActivityGetUserFeedbackParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ActivityGetUserFeedbackParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ActivityGetUserFeedbackParams result = new _ActivityGetUserFeedbackParams();

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
      
      result.userFeedback = decoder0.decodeInterfaceRequest(8, false, UserFeedbackStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(userFeedback, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "userFeedback of struct _ActivityGetUserFeedbackParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ActivityGetUserFeedbackParams("
           "userFeedback: $userFeedback" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




class _ActivityStartActivityParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Intent intent = null;

  _ActivityStartActivityParams() : super(kVersions.last.size);

  static _ActivityStartActivityParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ActivityStartActivityParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ActivityStartActivityParams result = new _ActivityStartActivityParams();

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
      result.intent = Intent.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(intent, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "intent of struct _ActivityStartActivityParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ActivityStartActivityParams("
           "intent: $intent" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["intent"] = intent;
    return map;
  }
}




class _ActivityFinishCurrentActivityParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _ActivityFinishCurrentActivityParams() : super(kVersions.last.size);

  static _ActivityFinishCurrentActivityParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ActivityFinishCurrentActivityParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ActivityFinishCurrentActivityParams result = new _ActivityFinishCurrentActivityParams();

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
    return "_ActivityFinishCurrentActivityParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}




class _ActivitySetTaskDescriptionParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  TaskDescription description = null;

  _ActivitySetTaskDescriptionParams() : super(kVersions.last.size);

  static _ActivitySetTaskDescriptionParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ActivitySetTaskDescriptionParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ActivitySetTaskDescriptionParams result = new _ActivitySetTaskDescriptionParams();

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
      result.description = TaskDescription.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(description, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "description of struct _ActivitySetTaskDescriptionParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ActivitySetTaskDescriptionParams("
           "description: $description" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["description"] = description;
    return map;
  }
}




class _ActivitySetSystemUiVisibilityParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  SystemUiVisibility visibility = null;

  _ActivitySetSystemUiVisibilityParams() : super(kVersions.last.size);

  static _ActivitySetSystemUiVisibilityParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ActivitySetSystemUiVisibilityParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ActivitySetSystemUiVisibilityParams result = new _ActivitySetSystemUiVisibilityParams();

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
      
        result.visibility = SystemUiVisibility.decode(decoder0, 8);
        if (result.visibility == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable SystemUiVisibility.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(visibility, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "visibility of struct _ActivitySetSystemUiVisibilityParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ActivitySetSystemUiVisibilityParams("
           "visibility: $visibility" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["visibility"] = visibility;
    return map;
  }
}




class _ActivitySetRequestedOrientationParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  ScreenOrientation orientation = null;

  _ActivitySetRequestedOrientationParams() : super(kVersions.last.size);

  static _ActivitySetRequestedOrientationParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ActivitySetRequestedOrientationParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ActivitySetRequestedOrientationParams result = new _ActivitySetRequestedOrientationParams();

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
      
        result.orientation = ScreenOrientation.decode(decoder0, 8);
        if (result.orientation == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable ScreenOrientation.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(orientation, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "orientation of struct _ActivitySetRequestedOrientationParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ActivitySetRequestedOrientationParams("
           "orientation: $orientation" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["orientation"] = orientation;
    return map;
  }
}




class _PathServiceGetAppDataDirParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _PathServiceGetAppDataDirParams() : super(kVersions.last.size);

  static _PathServiceGetAppDataDirParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _PathServiceGetAppDataDirParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _PathServiceGetAppDataDirParams result = new _PathServiceGetAppDataDirParams();

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
    return "_PathServiceGetAppDataDirParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}




class PathServiceGetAppDataDirResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String path = null;

  PathServiceGetAppDataDirResponseParams() : super(kVersions.last.size);

  static PathServiceGetAppDataDirResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static PathServiceGetAppDataDirResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    PathServiceGetAppDataDirResponseParams result = new PathServiceGetAppDataDirResponseParams();

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
      
      result.path = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(path, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "path of struct PathServiceGetAppDataDirResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "PathServiceGetAppDataDirResponseParams("
           "path: $path" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["path"] = path;
    return map;
  }
}




class _PathServiceGetFilesDirParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _PathServiceGetFilesDirParams() : super(kVersions.last.size);

  static _PathServiceGetFilesDirParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _PathServiceGetFilesDirParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _PathServiceGetFilesDirParams result = new _PathServiceGetFilesDirParams();

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
    return "_PathServiceGetFilesDirParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}




class PathServiceGetFilesDirResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String path = null;

  PathServiceGetFilesDirResponseParams() : super(kVersions.last.size);

  static PathServiceGetFilesDirResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static PathServiceGetFilesDirResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    PathServiceGetFilesDirResponseParams result = new PathServiceGetFilesDirResponseParams();

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
      
      result.path = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(path, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "path of struct PathServiceGetFilesDirResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "PathServiceGetFilesDirResponseParams("
           "path: $path" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["path"] = path;
    return map;
  }
}




class _PathServiceGetCacheDirParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _PathServiceGetCacheDirParams() : super(kVersions.last.size);

  static _PathServiceGetCacheDirParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _PathServiceGetCacheDirParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _PathServiceGetCacheDirParams result = new _PathServiceGetCacheDirParams();

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
    return "_PathServiceGetCacheDirParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}




class PathServiceGetCacheDirResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String path = null;

  PathServiceGetCacheDirResponseParams() : super(kVersions.last.size);

  static PathServiceGetCacheDirResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static PathServiceGetCacheDirResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    PathServiceGetCacheDirResponseParams result = new PathServiceGetCacheDirResponseParams();

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
      
      result.path = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(path, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "path of struct PathServiceGetCacheDirResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "PathServiceGetCacheDirResponseParams("
           "path: $path" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["path"] = path;
    return map;
  }
}




class _UserFeedbackPerformHapticFeedbackParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  HapticFeedbackType type = null;

  _UserFeedbackPerformHapticFeedbackParams() : super(kVersions.last.size);

  static _UserFeedbackPerformHapticFeedbackParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _UserFeedbackPerformHapticFeedbackParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _UserFeedbackPerformHapticFeedbackParams result = new _UserFeedbackPerformHapticFeedbackParams();

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
      
        result.type = HapticFeedbackType.decode(decoder0, 8);
        if (result.type == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable HapticFeedbackType.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(type, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "type of struct _UserFeedbackPerformHapticFeedbackParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_UserFeedbackPerformHapticFeedbackParams("
           "type: $type" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["type"] = type;
    return map;
  }
}




class _UserFeedbackPerformAuralFeedbackParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  AuralFeedbackType type = null;

  _UserFeedbackPerformAuralFeedbackParams() : super(kVersions.last.size);

  static _UserFeedbackPerformAuralFeedbackParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _UserFeedbackPerformAuralFeedbackParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _UserFeedbackPerformAuralFeedbackParams result = new _UserFeedbackPerformAuralFeedbackParams();

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
      
        result.type = AuralFeedbackType.decode(decoder0, 8);
        if (result.type == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable AuralFeedbackType.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(type, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "type of struct _UserFeedbackPerformAuralFeedbackParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_UserFeedbackPerformAuralFeedbackParams("
           "type: $type" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["type"] = type;
    return map;
  }
}




const int _Activity_getUserFeedbackName = 0;
const int _Activity_startActivityName = 1;
const int _Activity_finishCurrentActivityName = 2;
const int _Activity_setTaskDescriptionName = 3;
const int _Activity_setSystemUiVisibilityName = 4;
const int _Activity_setRequestedOrientationName = 5;



class _ActivityServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class Activity {
  static const String serviceName = "activity::Activity";
  void getUserFeedback(Object userFeedback);
  void startActivity(Intent intent);
  void finishCurrentActivity();
  void setTaskDescription(TaskDescription description);
  void setSystemUiVisibility(SystemUiVisibility visibility);
  void setRequestedOrientation(ScreenOrientation orientation);
}


class _ActivityProxyImpl extends bindings.Proxy {
  _ActivityProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ActivityProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _ActivityProxyImpl.unbound() : super.unbound();

  static _ActivityProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _ActivityProxyImpl"));
    return new _ActivityProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _ActivityServiceDescription();

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
    return "_ActivityProxyImpl($superString)";
  }
}


class _ActivityProxyCalls implements Activity {
  _ActivityProxyImpl _proxyImpl;

  _ActivityProxyCalls(this._proxyImpl);
    void getUserFeedback(Object userFeedback) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ActivityGetUserFeedbackParams();
      params.userFeedback = userFeedback;
      _proxyImpl.sendMessage(params, _Activity_getUserFeedbackName);
    }
    void startActivity(Intent intent) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ActivityStartActivityParams();
      params.intent = intent;
      _proxyImpl.sendMessage(params, _Activity_startActivityName);
    }
    void finishCurrentActivity() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ActivityFinishCurrentActivityParams();
      _proxyImpl.sendMessage(params, _Activity_finishCurrentActivityName);
    }
    void setTaskDescription(TaskDescription description) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ActivitySetTaskDescriptionParams();
      params.description = description;
      _proxyImpl.sendMessage(params, _Activity_setTaskDescriptionName);
    }
    void setSystemUiVisibility(SystemUiVisibility visibility) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ActivitySetSystemUiVisibilityParams();
      params.visibility = visibility;
      _proxyImpl.sendMessage(params, _Activity_setSystemUiVisibilityName);
    }
    void setRequestedOrientation(ScreenOrientation orientation) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ActivitySetRequestedOrientationParams();
      params.orientation = orientation;
      _proxyImpl.sendMessage(params, _Activity_setRequestedOrientationName);
    }
}


class ActivityProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  Activity ptr;

  ActivityProxy(_ActivityProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ActivityProxyCalls(proxyImpl);

  ActivityProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _ActivityProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ActivityProxyCalls(impl);
  }

  ActivityProxy.fromHandle(core.MojoHandle handle) :
      impl = new _ActivityProxyImpl.fromHandle(handle) {
    ptr = new _ActivityProxyCalls(impl);
  }

  ActivityProxy.unbound() :
      impl = new _ActivityProxyImpl.unbound() {
    ptr = new _ActivityProxyCalls(impl);
  }

  factory ActivityProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ActivityProxy p = new ActivityProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static ActivityProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ActivityProxy"));
    return new ActivityProxy.fromEndpoint(endpoint);
  }

  String get serviceName => Activity.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "ActivityProxy($impl)";
  }
}


class ActivityStub extends bindings.Stub {
  Activity _impl = null;

  ActivityStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  ActivityStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  ActivityStub.unbound() : super.unbound();

  static ActivityStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ActivityStub"));
    return new ActivityStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _Activity_getUserFeedbackName:
        var params = _ActivityGetUserFeedbackParams.deserialize(
            message.payload);
        _impl.getUserFeedback(params.userFeedback);
        break;
      case _Activity_startActivityName:
        var params = _ActivityStartActivityParams.deserialize(
            message.payload);
        _impl.startActivity(params.intent);
        break;
      case _Activity_finishCurrentActivityName:
        var params = _ActivityFinishCurrentActivityParams.deserialize(
            message.payload);
        _impl.finishCurrentActivity();
        break;
      case _Activity_setTaskDescriptionName:
        var params = _ActivitySetTaskDescriptionParams.deserialize(
            message.payload);
        _impl.setTaskDescription(params.description);
        break;
      case _Activity_setSystemUiVisibilityName:
        var params = _ActivitySetSystemUiVisibilityParams.deserialize(
            message.payload);
        _impl.setSystemUiVisibility(params.visibility);
        break;
      case _Activity_setRequestedOrientationName:
        var params = _ActivitySetRequestedOrientationParams.deserialize(
            message.payload);
        _impl.setRequestedOrientation(params.orientation);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  Activity get impl => _impl;
  set impl(Activity d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "ActivityStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _ActivityServiceDescription();
}

const int _PathService_getAppDataDirName = 0;
const int _PathService_getFilesDirName = 1;
const int _PathService_getCacheDirName = 2;



class _PathServiceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class PathService {
  static const String serviceName = "activity::PathService";
  dynamic getAppDataDir([Function responseFactory = null]);
  dynamic getFilesDir([Function responseFactory = null]);
  dynamic getCacheDir([Function responseFactory = null]);
}


class _PathServiceProxyImpl extends bindings.Proxy {
  _PathServiceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _PathServiceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _PathServiceProxyImpl.unbound() : super.unbound();

  static _PathServiceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _PathServiceProxyImpl"));
    return new _PathServiceProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _PathServiceServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _PathService_getAppDataDirName:
        var r = PathServiceGetAppDataDirResponseParams.deserialize(
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
      case _PathService_getFilesDirName:
        var r = PathServiceGetFilesDirResponseParams.deserialize(
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
      case _PathService_getCacheDirName:
        var r = PathServiceGetCacheDirResponseParams.deserialize(
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
    return "_PathServiceProxyImpl($superString)";
  }
}


class _PathServiceProxyCalls implements PathService {
  _PathServiceProxyImpl _proxyImpl;

  _PathServiceProxyCalls(this._proxyImpl);
    dynamic getAppDataDir([Function responseFactory = null]) {
      var params = new _PathServiceGetAppDataDirParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _PathService_getAppDataDirName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic getFilesDir([Function responseFactory = null]) {
      var params = new _PathServiceGetFilesDirParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _PathService_getFilesDirName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic getCacheDir([Function responseFactory = null]) {
      var params = new _PathServiceGetCacheDirParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _PathService_getCacheDirName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class PathServiceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  PathService ptr;

  PathServiceProxy(_PathServiceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _PathServiceProxyCalls(proxyImpl);

  PathServiceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _PathServiceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _PathServiceProxyCalls(impl);
  }

  PathServiceProxy.fromHandle(core.MojoHandle handle) :
      impl = new _PathServiceProxyImpl.fromHandle(handle) {
    ptr = new _PathServiceProxyCalls(impl);
  }

  PathServiceProxy.unbound() :
      impl = new _PathServiceProxyImpl.unbound() {
    ptr = new _PathServiceProxyCalls(impl);
  }

  factory PathServiceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    PathServiceProxy p = new PathServiceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static PathServiceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For PathServiceProxy"));
    return new PathServiceProxy.fromEndpoint(endpoint);
  }

  String get serviceName => PathService.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "PathServiceProxy($impl)";
  }
}


class PathServiceStub extends bindings.Stub {
  PathService _impl = null;

  PathServiceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  PathServiceStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  PathServiceStub.unbound() : super.unbound();

  static PathServiceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For PathServiceStub"));
    return new PathServiceStub.fromEndpoint(endpoint);
  }


  PathServiceGetAppDataDirResponseParams _PathServiceGetAppDataDirResponseParamsFactory(String path) {
    var mojo_factory_result = new PathServiceGetAppDataDirResponseParams();
    mojo_factory_result.path = path;
    return mojo_factory_result;
  }
  PathServiceGetFilesDirResponseParams _PathServiceGetFilesDirResponseParamsFactory(String path) {
    var mojo_factory_result = new PathServiceGetFilesDirResponseParams();
    mojo_factory_result.path = path;
    return mojo_factory_result;
  }
  PathServiceGetCacheDirResponseParams _PathServiceGetCacheDirResponseParamsFactory(String path) {
    var mojo_factory_result = new PathServiceGetCacheDirResponseParams();
    mojo_factory_result.path = path;
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
      case _PathService_getAppDataDirName:
        var params = _PathServiceGetAppDataDirParams.deserialize(
            message.payload);
        var response = _impl.getAppDataDir(_PathServiceGetAppDataDirResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _PathService_getAppDataDirName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _PathService_getAppDataDirName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _PathService_getFilesDirName:
        var params = _PathServiceGetFilesDirParams.deserialize(
            message.payload);
        var response = _impl.getFilesDir(_PathServiceGetFilesDirResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _PathService_getFilesDirName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _PathService_getFilesDirName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _PathService_getCacheDirName:
        var params = _PathServiceGetCacheDirParams.deserialize(
            message.payload);
        var response = _impl.getCacheDir(_PathServiceGetCacheDirResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _PathService_getCacheDirName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _PathService_getCacheDirName,
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

  PathService get impl => _impl;
  set impl(PathService d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "PathServiceStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _PathServiceServiceDescription();
}

const int _UserFeedback_performHapticFeedbackName = 0;
const int _UserFeedback_performAuralFeedbackName = 1;



class _UserFeedbackServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class UserFeedback {
  static const String serviceName = null;
  void performHapticFeedback(HapticFeedbackType type);
  void performAuralFeedback(AuralFeedbackType type);
}


class _UserFeedbackProxyImpl extends bindings.Proxy {
  _UserFeedbackProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _UserFeedbackProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _UserFeedbackProxyImpl.unbound() : super.unbound();

  static _UserFeedbackProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _UserFeedbackProxyImpl"));
    return new _UserFeedbackProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _UserFeedbackServiceDescription();

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
    return "_UserFeedbackProxyImpl($superString)";
  }
}


class _UserFeedbackProxyCalls implements UserFeedback {
  _UserFeedbackProxyImpl _proxyImpl;

  _UserFeedbackProxyCalls(this._proxyImpl);
    void performHapticFeedback(HapticFeedbackType type) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _UserFeedbackPerformHapticFeedbackParams();
      params.type = type;
      _proxyImpl.sendMessage(params, _UserFeedback_performHapticFeedbackName);
    }
    void performAuralFeedback(AuralFeedbackType type) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _UserFeedbackPerformAuralFeedbackParams();
      params.type = type;
      _proxyImpl.sendMessage(params, _UserFeedback_performAuralFeedbackName);
    }
}


class UserFeedbackProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  UserFeedback ptr;

  UserFeedbackProxy(_UserFeedbackProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _UserFeedbackProxyCalls(proxyImpl);

  UserFeedbackProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _UserFeedbackProxyImpl.fromEndpoint(endpoint) {
    ptr = new _UserFeedbackProxyCalls(impl);
  }

  UserFeedbackProxy.fromHandle(core.MojoHandle handle) :
      impl = new _UserFeedbackProxyImpl.fromHandle(handle) {
    ptr = new _UserFeedbackProxyCalls(impl);
  }

  UserFeedbackProxy.unbound() :
      impl = new _UserFeedbackProxyImpl.unbound() {
    ptr = new _UserFeedbackProxyCalls(impl);
  }

  factory UserFeedbackProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    UserFeedbackProxy p = new UserFeedbackProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static UserFeedbackProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For UserFeedbackProxy"));
    return new UserFeedbackProxy.fromEndpoint(endpoint);
  }

  String get serviceName => UserFeedback.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "UserFeedbackProxy($impl)";
  }
}


class UserFeedbackStub extends bindings.Stub {
  UserFeedback _impl = null;

  UserFeedbackStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  UserFeedbackStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  UserFeedbackStub.unbound() : super.unbound();

  static UserFeedbackStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For UserFeedbackStub"));
    return new UserFeedbackStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _UserFeedback_performHapticFeedbackName:
        var params = _UserFeedbackPerformHapticFeedbackParams.deserialize(
            message.payload);
        _impl.performHapticFeedback(params.type);
        break;
      case _UserFeedback_performAuralFeedbackName:
        var params = _UserFeedbackPerformAuralFeedbackParams.deserialize(
            message.payload);
        _impl.performAuralFeedback(params.type);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  UserFeedback get impl => _impl;
  set impl(UserFeedback d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "UserFeedbackStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _UserFeedbackServiceDescription();
}



