// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library animations_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo_services/mojo/geometry.mojom.dart' as geometry_mojom;

class AnimationTweenType extends bindings.MojoEnum {
  static const AnimationTweenType linear = const AnimationTweenType._(0);
  static const AnimationTweenType easeIn = const AnimationTweenType._(1);
  static const AnimationTweenType easeOut = const AnimationTweenType._(2);
  static const AnimationTweenType easeInOut = const AnimationTweenType._(3);

  const AnimationTweenType._(int v) : super(v);

  static const Map<String, AnimationTweenType> valuesMap = const {
    "linear": linear,
    "easeIn": easeIn,
    "easeOut": easeOut,
    "easeInOut": easeInOut,
  };
  static const List<AnimationTweenType> values = const [
    linear,
    easeIn,
    easeOut,
    easeInOut,
  ];

  static AnimationTweenType valueOf(String name) => valuesMap[name];

  factory AnimationTweenType(int v) {
    switch (v) {
      case 0:
        return linear;
      case 1:
        return easeIn;
      case 2:
        return easeOut;
      case 3:
        return easeInOut;
      default:
        return null;
    }
  }

  static AnimationTweenType decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    AnimationTweenType result = new AnimationTweenType(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum AnimationTweenType.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case linear:
        return 'AnimationTweenType.linear';
      case easeIn:
        return 'AnimationTweenType.easeIn';
      case easeOut:
        return 'AnimationTweenType.easeOut';
      case easeInOut:
        return 'AnimationTweenType.easeInOut';
    }
  }

  int toJson() => mojoEnumValue;
}

class AnimationProperty extends bindings.MojoEnum {
  static const AnimationProperty none = const AnimationProperty._(0);
  static const AnimationProperty opacity = const AnimationProperty._(1);
  static const AnimationProperty transform = const AnimationProperty._(2);

  const AnimationProperty._(int v) : super(v);

  static const Map<String, AnimationProperty> valuesMap = const {
    "none": none,
    "opacity": opacity,
    "transform": transform,
  };
  static const List<AnimationProperty> values = const [
    none,
    opacity,
    transform,
  ];

  static AnimationProperty valueOf(String name) => valuesMap[name];

  factory AnimationProperty(int v) {
    switch (v) {
      case 0:
        return none;
      case 1:
        return opacity;
      case 2:
        return transform;
      default:
        return null;
    }
  }

  static AnimationProperty decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    AnimationProperty result = new AnimationProperty(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum AnimationProperty.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case none:
        return 'AnimationProperty.none';
      case opacity:
        return 'AnimationProperty.opacity';
      case transform:
        return 'AnimationProperty.transform';
    }
  }

  int toJson() => mojoEnumValue;
}



class AnimationValue extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  double floatValue = 0.0;
  geometry_mojom.Transform transform = null;

  AnimationValue() : super(kVersions.last.size);

  static AnimationValue deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static AnimationValue decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    AnimationValue result = new AnimationValue();

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
      
      result.floatValue = decoder0.decodeFloat(8);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.transform = geometry_mojom.Transform.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeFloat(floatValue, 8);
    
    encoder0.encodeStruct(transform, 16, false);
  }

  String toString() {
    return "AnimationValue("
           "floatValue: $floatValue" ", "
           "transform: $transform" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["floatValue"] = floatValue;
    map["transform"] = transform;
    return map;
  }
}


class AnimationElement extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(40, 0)
  ];
  AnimationProperty property = null;
  AnimationTweenType tweenType = null;
  int duration = 0;
  AnimationValue startValue = null;
  AnimationValue targetValue = null;

  AnimationElement() : super(kVersions.last.size);

  static AnimationElement deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static AnimationElement decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    AnimationElement result = new AnimationElement();

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
      
        result.property = AnimationProperty.decode(decoder0, 8);
        if (result.property == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable AnimationProperty.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
        result.tweenType = AnimationTweenType.decode(decoder0, 12);
        if (result.tweenType == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable AnimationTweenType.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.duration = decoder0.decodeInt64(16);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, true);
      result.startValue = AnimationValue.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(32, true);
      result.targetValue = AnimationValue.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(property, 8);
    
    encoder0.encodeEnum(tweenType, 12);
    
    encoder0.encodeInt64(duration, 16);
    
    encoder0.encodeStruct(startValue, 24, true);
    
    encoder0.encodeStruct(targetValue, 32, true);
  }

  String toString() {
    return "AnimationElement("
           "property: $property" ", "
           "tweenType: $tweenType" ", "
           "duration: $duration" ", "
           "startValue: $startValue" ", "
           "targetValue: $targetValue" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["property"] = property;
    map["tweenType"] = tweenType;
    map["duration"] = duration;
    map["startValue"] = startValue;
    map["targetValue"] = targetValue;
    return map;
  }
}


class AnimationSequence extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int cycleCount = 0;
  List<AnimationElement> elements = null;

  AnimationSequence() : super(kVersions.last.size);

  static AnimationSequence deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static AnimationSequence decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    AnimationSequence result = new AnimationSequence();

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
      
      result.cycleCount = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.elements = new List<AnimationElement>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.elements[i1] = AnimationElement.decode(decoder2);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(cycleCount, 8);
    
    if (elements == null) {
      encoder0.encodeNullPointer(16, false);
    } else {
      var encoder1 = encoder0.encodePointerArray(elements.length, 16, bindings.kUnspecifiedArrayLength);
      for (int i0 = 0; i0 < elements.length; ++i0) {
        
        encoder1.encodeStruct(elements[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
      }
    }
  }

  String toString() {
    return "AnimationSequence("
           "cycleCount: $cycleCount" ", "
           "elements: $elements" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["cycleCount"] = cycleCount;
    map["elements"] = elements;
    return map;
  }
}


class AnimationGroup extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int viewId = 0;
  List<AnimationSequence> sequences = null;

  AnimationGroup() : super(kVersions.last.size);

  static AnimationGroup deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static AnimationGroup decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    AnimationGroup result = new AnimationGroup();

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
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.sequences = new List<AnimationSequence>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.sequences[i1] = AnimationSequence.decode(decoder2);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(viewId, 8);
    
    if (sequences == null) {
      encoder0.encodeNullPointer(16, false);
    } else {
      var encoder1 = encoder0.encodePointerArray(sequences.length, 16, bindings.kUnspecifiedArrayLength);
      for (int i0 = 0; i0 < sequences.length; ++i0) {
        
        encoder1.encodeStruct(sequences[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
      }
    }
  }

  String toString() {
    return "AnimationGroup("
           "viewId: $viewId" ", "
           "sequences: $sequences" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["viewId"] = viewId;
    map["sequences"] = sequences;
    return map;
  }
}


