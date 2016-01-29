// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library regression_tests_mojom;

import 'dart:async';
import 'dart:collection';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;

class EnumWithReference extends bindings.MojoEnum {
  static const EnumWithReference kStereoAndKeyboardMic = const EnumWithReference._(30);
  static const EnumWithReference kMax = const EnumWithReference._(30);

  const EnumWithReference._(int v) : super(v);

  static const Map<String, EnumWithReference> valuesMap = const {
    "kStereoAndKeyboardMic": kStereoAndKeyboardMic,
    "kMax": kMax,
  };
  static const List<EnumWithReference> values = const [
    kStereoAndKeyboardMic,
    kMax,
  ];

  static EnumWithReference valueOf(String name) => valuesMap[name];

  factory EnumWithReference(int v) {
    switch (v) {
      case 30:
        return kStereoAndKeyboardMic;
      case 30:
        return kMax;
      default:
        return null;
    }
  }

  static EnumWithReference decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    EnumWithReference result = new EnumWithReference(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum EnumWithReference.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case kStereoAndKeyboardMic:
        return 'EnumWithReference.kStereoAndKeyboardMic';
      case kMax:
        return 'EnumWithReference.kMax';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

mojom_types.MojomEnum _regressionTestsEnumWithReference() {
  return new mojom_types.MojomEnum()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'EnumWithReference'
      ..fullIdentifier = 'regression_tests.EnumWithReference')
    ..values = <mojom_types.EnumValue>[
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'KStereoAndKeyboardMic')
        ..enumTypeKey = 'regression_tests_EnumWithReference__'
        ..intValue = 30,
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'KMax')
        ..enumTypeKey = 'regression_tests_EnumWithReference__'
        ..intValue = 30,];
}

class EnumWithLowercase extends bindings.MojoEnum {
  static const EnumWithLowercase planarF16 = const EnumWithLowercase._(0);
  static const EnumWithLowercase planarF32 = const EnumWithLowercase._(1);

  const EnumWithLowercase._(int v) : super(v);

  static const Map<String, EnumWithLowercase> valuesMap = const {
    "planarF16": planarF16,
    "planarF32": planarF32,
  };
  static const List<EnumWithLowercase> values = const [
    planarF16,
    planarF32,
  ];

  static EnumWithLowercase valueOf(String name) => valuesMap[name];

  factory EnumWithLowercase(int v) {
    switch (v) {
      case 0:
        return planarF16;
      case 1:
        return planarF32;
      default:
        return null;
    }
  }

  static EnumWithLowercase decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    EnumWithLowercase result = new EnumWithLowercase(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum EnumWithLowercase.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case planarF16:
        return 'EnumWithLowercase.planarF16';
      case planarF32:
        return 'EnumWithLowercase.planarF32';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

mojom_types.MojomEnum _regressionTestsEnumWithLowercase() {
  return new mojom_types.MojomEnum()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'EnumWithLowercase'
      ..fullIdentifier = 'regression_tests.EnumWithLowercase')
    ..values = <mojom_types.EnumValue>[
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'PlanarF16')
        ..enumTypeKey = 'regression_tests_EnumWithLowercase__'
        ..intValue = 0,
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'PlanarF32')
        ..enumTypeKey = 'regression_tests_EnumWithLowercase__'
        ..intValue = 1,];
}

class EnumWithNumbers extends bindings.MojoEnum {
  static const EnumWithNumbers k21 = const EnumWithNumbers._(4);

  const EnumWithNumbers._(int v) : super(v);

  static const Map<String, EnumWithNumbers> valuesMap = const {
    "k21": k21,
  };
  static const List<EnumWithNumbers> values = const [
    k21,
  ];

  static EnumWithNumbers valueOf(String name) => valuesMap[name];

  factory EnumWithNumbers(int v) {
    switch (v) {
      case 4:
        return k21;
      default:
        return null;
    }
  }

  static EnumWithNumbers decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    EnumWithNumbers result = new EnumWithNumbers(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum EnumWithNumbers.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case k21:
        return 'EnumWithNumbers.k21';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

mojom_types.MojomEnum _regressionTestsEnumWithNumbers() {
  return new mojom_types.MojomEnum()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'EnumWithNumbers'
      ..fullIdentifier = 'regression_tests.EnumWithNumbers')
    ..values = <mojom_types.EnumValue>[
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'K21')
        ..enumTypeKey = 'regression_tests_EnumWithNumbers__'
        ..intValue = 4,];
}

class EnumWithK extends bindings.MojoEnum {
  static const EnumWithK k = const EnumWithK._(0);

  const EnumWithK._(int v) : super(v);

  static const Map<String, EnumWithK> valuesMap = const {
    "k": k,
  };
  static const List<EnumWithK> values = const [
    k,
  ];

  static EnumWithK valueOf(String name) => valuesMap[name];

  factory EnumWithK(int v) {
    switch (v) {
      case 0:
        return k;
      default:
        return null;
    }
  }

  static EnumWithK decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    EnumWithK result = new EnumWithK(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum EnumWithK.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case k:
        return 'EnumWithK.k';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

mojom_types.MojomEnum _regressionTestsEnumWithK() {
  return new mojom_types.MojomEnum()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'EnumWithK'
      ..fullIdentifier = 'regression_tests.EnumWithK')
    ..values = <mojom_types.EnumValue>[
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'K')
        ..enumTypeKey = 'regression_tests_EnumWithK__'
        ..intValue = 0,];
}

class EnumWithInternalAllCaps extends bindings.MojoEnum {
  static const EnumWithInternalAllCaps standard = const EnumWithInternalAllCaps._(0);
  static const EnumWithInternalAllCaps fullscreen = const EnumWithInternalAllCaps._(1);
  static const EnumWithInternalAllCaps immersive = const EnumWithInternalAllCaps._(2);

  const EnumWithInternalAllCaps._(int v) : super(v);

  static const Map<String, EnumWithInternalAllCaps> valuesMap = const {
    "standard": standard,
    "fullscreen": fullscreen,
    "immersive": immersive,
  };
  static const List<EnumWithInternalAllCaps> values = const [
    standard,
    fullscreen,
    immersive,
  ];

  static EnumWithInternalAllCaps valueOf(String name) => valuesMap[name];

  factory EnumWithInternalAllCaps(int v) {
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

  static EnumWithInternalAllCaps decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    EnumWithInternalAllCaps result = new EnumWithInternalAllCaps(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum EnumWithInternalAllCaps.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case standard:
        return 'EnumWithInternalAllCaps.standard';
      case fullscreen:
        return 'EnumWithInternalAllCaps.fullscreen';
      case immersive:
        return 'EnumWithInternalAllCaps.immersive';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

mojom_types.MojomEnum _regressionTestsEnumWithInternalAllCaps() {
  return new mojom_types.MojomEnum()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'EnumWithInternalAllCaps'
      ..fullIdentifier = 'regression_tests.EnumWithINTERNALAllCaps')
    ..values = <mojom_types.EnumValue>[
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Standard')
        ..enumTypeKey = 'regression_tests_EnumWithINTERNALAllCaps__'
        ..intValue = 0,
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Fullscreen')
        ..enumTypeKey = 'regression_tests_EnumWithINTERNALAllCaps__'
        ..intValue = 1,
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Immersive')
        ..enumTypeKey = 'regression_tests_EnumWithINTERNALAllCaps__'
        ..intValue = 2,];
}

class NormalEnum extends bindings.MojoEnum {
  static const NormalEnum first = const NormalEnum._(0);
  static const NormalEnum second = const NormalEnum._(1);

  const NormalEnum._(int v) : super(v);

  static const Map<String, NormalEnum> valuesMap = const {
    "first": first,
    "second": second,
  };
  static const List<NormalEnum> values = const [
    first,
    second,
  ];

  static NormalEnum valueOf(String name) => valuesMap[name];

  factory NormalEnum(int v) {
    switch (v) {
      case 0:
        return first;
      case 1:
        return second;
      default:
        return null;
    }
  }

  static NormalEnum decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    NormalEnum result = new NormalEnum(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum NormalEnum.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case first:
        return 'NormalEnum.first';
      case second:
        return 'NormalEnum.second';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

mojom_types.MojomEnum _regressionTestsNormalEnum() {
  return new mojom_types.MojomEnum()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'NormalEnum'
      ..fullIdentifier = 'regression_tests.NormalEnum')
    ..values = <mojom_types.EnumValue>[
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'First')
        ..enumTypeKey = 'regression_tests_NormalEnum__'
        ..intValue = 0,
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Second')
        ..enumTypeKey = 'regression_tests_NormalEnum__'
        ..intValue = 1,];
}

class CamelCaseTestEnum extends bindings.MojoEnum {
  static const CamelCaseTestEnum boolThing = const CamelCaseTestEnum._(0);
  static const CamelCaseTestEnum doubleThing = const CamelCaseTestEnum._(1);
  static const CamelCaseTestEnum floatThing = const CamelCaseTestEnum._(2);
  static const CamelCaseTestEnum int8Thing = const CamelCaseTestEnum._(3);
  static const CamelCaseTestEnum int16Thing = const CamelCaseTestEnum._(4);
  static const CamelCaseTestEnum int32Th1Ng = const CamelCaseTestEnum._(5);
  static const CamelCaseTestEnum int64Th1ng = const CamelCaseTestEnum._(6);
  static const CamelCaseTestEnum uint8TH1ng = const CamelCaseTestEnum._(7);
  static const CamelCaseTestEnum uint16tH1Ng = const CamelCaseTestEnum._(8);
  static const CamelCaseTestEnum uint32Th1ng = const CamelCaseTestEnum._(9);
  static const CamelCaseTestEnum uint64Th1Ng = const CamelCaseTestEnum._(10);

  const CamelCaseTestEnum._(int v) : super(v);

  static const Map<String, CamelCaseTestEnum> valuesMap = const {
    "boolThing": boolThing,
    "doubleThing": doubleThing,
    "floatThing": floatThing,
    "int8Thing": int8Thing,
    "int16Thing": int16Thing,
    "int32Th1Ng": int32Th1Ng,
    "int64Th1ng": int64Th1ng,
    "uint8TH1ng": uint8TH1ng,
    "uint16tH1Ng": uint16tH1Ng,
    "uint32Th1ng": uint32Th1ng,
    "uint64Th1Ng": uint64Th1Ng,
  };
  static const List<CamelCaseTestEnum> values = const [
    boolThing,
    doubleThing,
    floatThing,
    int8Thing,
    int16Thing,
    int32Th1Ng,
    int64Th1ng,
    uint8TH1ng,
    uint16tH1Ng,
    uint32Th1ng,
    uint64Th1Ng,
  ];

  static CamelCaseTestEnum valueOf(String name) => valuesMap[name];

  factory CamelCaseTestEnum(int v) {
    switch (v) {
      case 0:
        return boolThing;
      case 1:
        return doubleThing;
      case 2:
        return floatThing;
      case 3:
        return int8Thing;
      case 4:
        return int16Thing;
      case 5:
        return int32Th1Ng;
      case 6:
        return int64Th1ng;
      case 7:
        return uint8TH1ng;
      case 8:
        return uint16tH1Ng;
      case 9:
        return uint32Th1ng;
      case 10:
        return uint64Th1Ng;
      default:
        return null;
    }
  }

  static CamelCaseTestEnum decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    CamelCaseTestEnum result = new CamelCaseTestEnum(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum CamelCaseTestEnum.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case boolThing:
        return 'CamelCaseTestEnum.boolThing';
      case doubleThing:
        return 'CamelCaseTestEnum.doubleThing';
      case floatThing:
        return 'CamelCaseTestEnum.floatThing';
      case int8Thing:
        return 'CamelCaseTestEnum.int8Thing';
      case int16Thing:
        return 'CamelCaseTestEnum.int16Thing';
      case int32Th1Ng:
        return 'CamelCaseTestEnum.int32Th1Ng';
      case int64Th1ng:
        return 'CamelCaseTestEnum.int64Th1ng';
      case uint8TH1ng:
        return 'CamelCaseTestEnum.uint8TH1ng';
      case uint16tH1Ng:
        return 'CamelCaseTestEnum.uint16tH1Ng';
      case uint32Th1ng:
        return 'CamelCaseTestEnum.uint32Th1ng';
      case uint64Th1Ng:
        return 'CamelCaseTestEnum.uint64Th1Ng';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

mojom_types.MojomEnum _regressionTestsCamelCaseTestEnum() {
  return new mojom_types.MojomEnum()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'CamelCaseTestEnum'
      ..fullIdentifier = 'regression_tests.CamelCaseTestEnum')
    ..values = <mojom_types.EnumValue>[
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'BoolThing')
        ..enumTypeKey = 'regression_tests_CamelCaseTestEnum__'
        ..intValue = 0,
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'DoubleThing')
        ..enumTypeKey = 'regression_tests_CamelCaseTestEnum__'
        ..intValue = 1,
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'FloatThing')
        ..enumTypeKey = 'regression_tests_CamelCaseTestEnum__'
        ..intValue = 2,
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Int8Thing')
        ..enumTypeKey = 'regression_tests_CamelCaseTestEnum__'
        ..intValue = 3,
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Int16Thing')
        ..enumTypeKey = 'regression_tests_CamelCaseTestEnum__'
        ..intValue = 4,
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Int32Th1Ng')
        ..enumTypeKey = 'regression_tests_CamelCaseTestEnum__'
        ..intValue = 5,
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Int64Th1ng')
        ..enumTypeKey = 'regression_tests_CamelCaseTestEnum__'
        ..intValue = 6,
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Uint8TH1ng')
        ..enumTypeKey = 'regression_tests_CamelCaseTestEnum__'
        ..intValue = 7,
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Uint16tH1Ng')
        ..enumTypeKey = 'regression_tests_CamelCaseTestEnum__'
        ..intValue = 8,
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Uint32Th1ng')
        ..enumTypeKey = 'regression_tests_CamelCaseTestEnum__'
        ..intValue = 9,
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Uint64Th1Ng')
        ..enumTypeKey = 'regression_tests_CamelCaseTestEnum__'
        ..intValue = 10,];
}



class Edge extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Vertex v = null;

  Edge() : super(kVersions.last.size);

  static Edge deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Edge decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Edge result = new Edge();

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
      result.v = Vertex.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(v, 8, true);
  }

  String toString() {
    return "Edge("
           "v: $v" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["v"] = v;
    return map;
  }
}

mojom_types.MojomStruct _regressionTestsEdge() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'Edge'
      ..fullIdentifier = 'regression_tests.Edge')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'V')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..nullable = true
        
          ..identifier = 'regression_tests_Vertex__'
          ..typeKey = 'regression_tests_Vertex__'
        )),];
}


class Vertex extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  EmptyStruct e = null;

  Vertex() : super(kVersions.last.size);

  static Vertex deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Vertex decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Vertex result = new Vertex();

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
      result.e = EmptyStruct.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(e, 8, true);
  }

  String toString() {
    return "Vertex("
           "e: $e" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["e"] = e;
    return map;
  }
}

mojom_types.MojomStruct _regressionTestsVertex() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'Vertex'
      ..fullIdentifier = 'regression_tests.Vertex')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'E')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..nullable = true
        
          ..identifier = 'regression_tests_EmptyStruct__'
          ..typeKey = 'regression_tests_EmptyStruct__'
        )),];
}


class EmptyStruct extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  EmptyStruct() : super(kVersions.last.size);

  static EmptyStruct deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static EmptyStruct decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    EmptyStruct result = new EmptyStruct();

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
    return "EmptyStruct("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

mojom_types.MojomStruct _regressionTestsEmptyStruct() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'EmptyStruct'
      ..fullIdentifier = 'regression_tests.EmptyStruct')
    ..fields = <mojom_types.StructField>[];
}


class A extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  B b = null;

  A() : super(kVersions.last.size);

  static A deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static A decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    A result = new A();

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
      result.b = B.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(b, 8, true);
  }

  String toString() {
    return "A("
           "b: $b" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["b"] = b;
    return map;
  }
}

mojom_types.MojomStruct _regressionTestsA() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'A'
      ..fullIdentifier = 'regression_tests.A')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'B')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..nullable = true
        
          ..identifier = 'regression_tests_B__'
          ..typeKey = 'regression_tests_B__'
        )),];
}


class B extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  A a = null;

  B() : super(kVersions.last.size);

  static B deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static B decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    B result = new B();

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
      result.a = A.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(a, 8, true);
  }

  String toString() {
    return "B("
           "a: $a" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["a"] = a;
    return map;
  }
}

mojom_types.MojomStruct _regressionTestsB() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'B'
      ..fullIdentifier = 'regression_tests.B')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'A')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..nullable = true
        
          ..identifier = 'regression_tests_A__'
          ..typeKey = 'regression_tests_A__'
        )),];
}


class StructWithHandleCalledHandles extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  core.MojoHandle handles = null;

  StructWithHandleCalledHandles() : super(kVersions.last.size);

  static StructWithHandleCalledHandles deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static StructWithHandleCalledHandles decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    StructWithHandleCalledHandles result = new StructWithHandleCalledHandles();

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
      
      result.handles = decoder0.decodeHandle(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeHandle(handles, 8, false);
  }

  String toString() {
    return "StructWithHandleCalledHandles("
           "handles: $handles" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

mojom_types.MojomStruct _regressionTestsStructWithHandleCalledHandles() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'StructWithHandleCalledHandles'
      ..fullIdentifier = 'regression_tests.StructWithHandleCalledHandles')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Handles')
        ..type = (new mojom_types.Type()
          ..handleType = (new mojom_types.HandleType()
            ..kind = mojom_types.HandleTypeKind.unspecified)),];
}


class StructWithArrayOfHandlesCalledHandles extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<core.MojoHandle> handles = null;

  StructWithArrayOfHandlesCalledHandles() : super(kVersions.last.size);

  static StructWithArrayOfHandlesCalledHandles deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static StructWithArrayOfHandlesCalledHandles decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    StructWithArrayOfHandlesCalledHandles result = new StructWithArrayOfHandlesCalledHandles();

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
      
      result.handles = decoder0.decodeHandleArray(8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeHandleArray(handles, 8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
  }

  String toString() {
    return "StructWithArrayOfHandlesCalledHandles("
           "handles: $handles" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

mojom_types.MojomStruct _regressionTestsStructWithArrayOfHandlesCalledHandles() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'StructWithArrayOfHandlesCalledHandles'
      ..fullIdentifier = 'regression_tests.StructWithArrayOfHandlesCalledHandles')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Handles')
        ..type = (new mojom_types.Type()
          ..arrayType = (new mojom_types.ArrayType()
            ..elementType = (new mojom_types.Type()
                    ..handleType = (new mojom_types.HandleType()
                      ..kind = mojom_types.HandleTypeKind.unspecified)))),];
}


class StructWithInterfaceCalledHandles extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object handles = null;

  StructWithInterfaceCalledHandles() : super(kVersions.last.size);

  static StructWithInterfaceCalledHandles deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static StructWithInterfaceCalledHandles decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    StructWithInterfaceCalledHandles result = new StructWithInterfaceCalledHandles();

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
      
      result.handles = decoder0.decodeServiceInterface(8, false, TestInterfaceProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInterface(handles, 8, false);
  }

  String toString() {
    return "StructWithInterfaceCalledHandles("
           "handles: $handles" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

mojom_types.MojomStruct _regressionTestsStructWithInterfaceCalledHandles() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'StructWithInterfaceCalledHandles'
      ..fullIdentifier = 'regression_tests.StructWithInterfaceCalledHandles')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Handles')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..identifier = 'regression_tests_TestInterface__'
          ..typeKey = 'regression_tests_TestInterface__'
        )),];
}


class ContainsArrayOfEnum extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<NormalEnum> arrayOfEnums = null;

  ContainsArrayOfEnum() : super(kVersions.last.size);

  static ContainsArrayOfEnum deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ContainsArrayOfEnum decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ContainsArrayOfEnum result = new ContainsArrayOfEnum();

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
        var si1 = decoder1.decodeDataHeaderForEnumArray(bindings.kUnspecifiedArrayLength);
        result.arrayOfEnums = new List<NormalEnum>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
            result.arrayOfEnums[i1] = NormalEnum.decode(decoder1, bindings.ArrayDataHeader.kHeaderSize + bindings.kEnumSize * i1);
            if (result.arrayOfEnums[i1] == null) {
              throw new bindings.MojoCodecError(
                'Trying to decode null union for non-nullable NormalEnum.');
            }
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnumArray(arrayOfEnums, 8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
  }

  String toString() {
    return "ContainsArrayOfEnum("
           "arrayOfEnums: $arrayOfEnums" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["arrayOfEnums"] = arrayOfEnums;
    return map;
  }
}

mojom_types.MojomStruct _regressionTestsContainsArrayOfEnum() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'ContainsArrayOfEnum'
      ..fullIdentifier = 'regression_tests.ContainsArrayOfEnum')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'ArrayOfEnums')
        ..type = (new mojom_types.Type()
          ..arrayType = (new mojom_types.ArrayType()
            ..elementType = (new mojom_types.Type()
                    ..typeReference = (new mojom_types.TypeReference()
                    ..identifier = 'regression_tests_NormalEnum__'
                    ..typeKey = 'regression_tests_NormalEnum__'
                  )))),];
}


class _CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseParams() : super(kVersions.last.size);

  static _CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseParams result = new _CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseParams();

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
    return "_CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

mojom_types.MojomStruct _regressionTestsCheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseParams'
      ..fullIdentifier = 'regression_tests.CheckMethodWithEmptyResponse_WithoutParameterAndEmptyResponse_Params')
    ..fields = <mojom_types.StructField>[];
}


class CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseResponseParams() : super(kVersions.last.size);

  static CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseResponseParams result = new CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseResponseParams();

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
    return "CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

mojom_types.MojomStruct _regressionTestsCheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseResponseParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseResponseParams'
      ..fullIdentifier = 'regression_tests.CheckMethodWithEmptyResponse_WithoutParameterAndEmptyResponse_ResponseParams')
    ..fields = <mojom_types.StructField>[];
}


class _CheckMethodWithEmptyResponseWithParameterAndEmptyResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool b = false;

  _CheckMethodWithEmptyResponseWithParameterAndEmptyResponseParams() : super(kVersions.last.size);

  static _CheckMethodWithEmptyResponseWithParameterAndEmptyResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CheckMethodWithEmptyResponseWithParameterAndEmptyResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CheckMethodWithEmptyResponseWithParameterAndEmptyResponseParams result = new _CheckMethodWithEmptyResponseWithParameterAndEmptyResponseParams();

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
      
      result.b = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeBool(b, 8, 0);
  }

  String toString() {
    return "_CheckMethodWithEmptyResponseWithParameterAndEmptyResponseParams("
           "b: $b" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["b"] = b;
    return map;
  }
}

mojom_types.MojomStruct _regressionTestsCheckMethodWithEmptyResponseWithParameterAndEmptyResponseParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'CheckMethodWithEmptyResponseWithParameterAndEmptyResponseParams'
      ..fullIdentifier = 'regression_tests.CheckMethodWithEmptyResponse_WithParameterAndEmptyResponse_Params')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'B')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.bool),];
}


class CheckMethodWithEmptyResponseWithParameterAndEmptyResponseResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  CheckMethodWithEmptyResponseWithParameterAndEmptyResponseResponseParams() : super(kVersions.last.size);

  static CheckMethodWithEmptyResponseWithParameterAndEmptyResponseResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static CheckMethodWithEmptyResponseWithParameterAndEmptyResponseResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    CheckMethodWithEmptyResponseWithParameterAndEmptyResponseResponseParams result = new CheckMethodWithEmptyResponseWithParameterAndEmptyResponseResponseParams();

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
    return "CheckMethodWithEmptyResponseWithParameterAndEmptyResponseResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

mojom_types.MojomStruct _regressionTestsCheckMethodWithEmptyResponseWithParameterAndEmptyResponseResponseParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'CheckMethodWithEmptyResponseWithParameterAndEmptyResponseResponseParams'
      ..fullIdentifier = 'regression_tests.CheckMethodWithEmptyResponse_WithParameterAndEmptyResponse_ResponseParams')
    ..fields = <mojom_types.StructField>[];
}


class _CheckNameCollisionWithNameCollisionParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool message = false;
  bool response = false;

  _CheckNameCollisionWithNameCollisionParams() : super(kVersions.last.size);

  static _CheckNameCollisionWithNameCollisionParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CheckNameCollisionWithNameCollisionParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CheckNameCollisionWithNameCollisionParams result = new _CheckNameCollisionWithNameCollisionParams();

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
      
      result.message = decoder0.decodeBool(8, 0);
    }
    if (mainDataHeader.version >= 0) {
      
      result.response = decoder0.decodeBool(8, 1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeBool(message, 8, 0);
    
    encoder0.encodeBool(response, 8, 1);
  }

  String toString() {
    return "_CheckNameCollisionWithNameCollisionParams("
           "message: $message" ", "
           "response: $response" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["message"] = message;
    map["response"] = response;
    return map;
  }
}

mojom_types.MojomStruct _regressionTestsCheckNameCollisionWithNameCollisionParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'CheckNameCollisionWithNameCollisionParams'
      ..fullIdentifier = 'regression_tests.CheckNameCollision_WithNameCollision_Params')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Message')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.bool),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Response')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.bool),];
}


class CheckNameCollisionWithNameCollisionResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool message = false;
  bool response = false;

  CheckNameCollisionWithNameCollisionResponseParams() : super(kVersions.last.size);

  static CheckNameCollisionWithNameCollisionResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static CheckNameCollisionWithNameCollisionResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    CheckNameCollisionWithNameCollisionResponseParams result = new CheckNameCollisionWithNameCollisionResponseParams();

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
      
      result.message = decoder0.decodeBool(8, 0);
    }
    if (mainDataHeader.version >= 0) {
      
      result.response = decoder0.decodeBool(8, 1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeBool(message, 8, 0);
    
    encoder0.encodeBool(response, 8, 1);
  }

  String toString() {
    return "CheckNameCollisionWithNameCollisionResponseParams("
           "message: $message" ", "
           "response: $response" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["message"] = message;
    map["response"] = response;
    return map;
  }
}

mojom_types.MojomStruct _regressionTestsCheckNameCollisionWithNameCollisionResponseParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'CheckNameCollisionWithNameCollisionResponseParams'
      ..fullIdentifier = 'regression_tests.CheckNameCollision_WithNameCollision_ResponseParams')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Message')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.bool),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Response')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.bool),];
}


class _CheckEnumCapsSetEnumWithInternalAllCapsParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  EnumWithInternalAllCaps e = null;

  _CheckEnumCapsSetEnumWithInternalAllCapsParams() : super(kVersions.last.size);

  static _CheckEnumCapsSetEnumWithInternalAllCapsParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CheckEnumCapsSetEnumWithInternalAllCapsParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CheckEnumCapsSetEnumWithInternalAllCapsParams result = new _CheckEnumCapsSetEnumWithInternalAllCapsParams();

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
      
        result.e = EnumWithInternalAllCaps.decode(decoder0, 8);
        if (result.e == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable EnumWithInternalAllCaps.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(e, 8);
  }

  String toString() {
    return "_CheckEnumCapsSetEnumWithInternalAllCapsParams("
           "e: $e" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["e"] = e;
    return map;
  }
}

mojom_types.MojomStruct _regressionTestsCheckEnumCapsSetEnumWithInternalAllCapsParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'CheckEnumCapsSetEnumWithInternalAllCapsParams'
      ..fullIdentifier = 'regression_tests.CheckEnumCaps_SetEnumWithINTERNALAllCaps_Params')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'E')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..identifier = 'regression_tests_EnumWithINTERNALAllCaps__'
          ..typeKey = 'regression_tests_EnumWithINTERNALAllCaps__'
        )),];
}


class _TestInterfaceSomeMessageParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _TestInterfaceSomeMessageParams() : super(kVersions.last.size);

  static _TestInterfaceSomeMessageParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _TestInterfaceSomeMessageParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _TestInterfaceSomeMessageParams result = new _TestInterfaceSomeMessageParams();

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
    return "_TestInterfaceSomeMessageParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

mojom_types.MojomStruct _regressionTestsTestInterfaceSomeMessageParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'TestInterfaceSomeMessageParams'
      ..fullIdentifier = 'regression_tests.TestInterface_SomeMessage_Params')
    ..fields = <mojom_types.StructField>[];
}


class _Regression551GetParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<String> keyPrefixes = null;

  _Regression551GetParams() : super(kVersions.last.size);

  static _Regression551GetParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _Regression551GetParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _Regression551GetParams result = new _Regression551GetParams();

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
        result.keyPrefixes = new List<String>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.keyPrefixes[i1] = decoder1.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    if (keyPrefixes == null) {
      encoder0.encodeNullPointer(8, false);
    } else {
      var encoder1 = encoder0.encodePointerArray(keyPrefixes.length, 8, bindings.kUnspecifiedArrayLength);
      for (int i0 = 0; i0 < keyPrefixes.length; ++i0) {
        
        encoder1.encodeString(keyPrefixes[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
      }
    }
  }

  String toString() {
    return "_Regression551GetParams("
           "keyPrefixes: $keyPrefixes" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["keyPrefixes"] = keyPrefixes;
    return map;
  }
}

mojom_types.MojomStruct _regressionTestsRegression551GetParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'Regression551GetParams'
      ..fullIdentifier = 'regression_tests.Regression551_Get_Params')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'KeyPrefixes')
        ..type = (new mojom_types.Type()
          ..arrayType = (new mojom_types.ArrayType()
            ..elementType = (new mojom_types.Type()
                    ..stringType = (new mojom_types.StringType())))),];
}


class Regression551GetResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int result = 0;

  Regression551GetResponseParams() : super(kVersions.last.size);

  static Regression551GetResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Regression551GetResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Regression551GetResponseParams result = new Regression551GetResponseParams();

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
      
      result.result = decoder0.decodeInt32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInt32(result, 8);
  }

  String toString() {
    return "Regression551GetResponseParams("
           "result: $result" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["result"] = result;
    return map;
  }
}

mojom_types.MojomStruct _regressionTestsRegression551GetResponseParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'Regression551GetResponseParams'
      ..fullIdentifier = 'regression_tests.Regression551_Get_ResponseParams')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Result')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int32),];
}


class _ServiceNameServiceNameParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _ServiceNameServiceNameParams() : super(kVersions.last.size);

  static _ServiceNameServiceNameParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ServiceNameServiceNameParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ServiceNameServiceNameParams result = new _ServiceNameServiceNameParams();

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
    return "_ServiceNameServiceNameParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

mojom_types.MojomStruct _regressionTestsServiceNameServiceNameParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'ServiceNameServiceNameParams'
      ..fullIdentifier = 'regression_tests.ServiceName_serviceName_Params')
    ..fields = <mojom_types.StructField>[];
}


class ServiceNameServiceNameResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String serviceName_ = null;

  ServiceNameServiceNameResponseParams() : super(kVersions.last.size);

  static ServiceNameServiceNameResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ServiceNameServiceNameResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ServiceNameServiceNameResponseParams result = new ServiceNameServiceNameResponseParams();

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
      
      result.serviceName_ = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeString(serviceName_, 8, false);
  }

  String toString() {
    return "ServiceNameServiceNameResponseParams("
           "serviceName_: $serviceName_" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["serviceName_"] = serviceName_;
    return map;
  }
}

mojom_types.MojomStruct _regressionTestsServiceNameServiceNameResponseParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'ServiceNameServiceNameResponseParams'
      ..fullIdentifier = 'regression_tests.ServiceName_serviceName_ResponseParams')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'ServiceName')
        ..type = (new mojom_types.Type()
          ..stringType = (new mojom_types.StringType())),];
}


const int _CheckMethodWithEmptyResponse_withoutParameterAndEmptyResponseName = 0;
const int _CheckMethodWithEmptyResponse_withParameterAndEmptyResponseName = 1;

mojom_types.MojomInterface _regressionTestsCheckMethodWithEmptyResponse() {
  return new mojom_types.MojomInterface()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'CheckMethodWithEmptyResponse'
      ..fullIdentifier = 'regression_tests.CheckMethodWithEmptyResponse')
    ..interfaceName = 'CheckMethodWithEmptyResponse'
    ..methods = <int, mojom_types.MojomMethod>{
      _CheckMethodWithEmptyResponse_withoutParameterAndEmptyResponseName: new mojom_types.MojomMethod()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'WithoutParameterAndEmptyResponse')
        ..ordinal = _CheckMethodWithEmptyResponse_withoutParameterAndEmptyResponseName
        ..responseParams = _regressionTestsCheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseResponseParams()
        ..parameters = _regressionTestsCheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseParams(),
      _CheckMethodWithEmptyResponse_withParameterAndEmptyResponseName: new mojom_types.MojomMethod()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'WithParameterAndEmptyResponse')
        ..ordinal = _CheckMethodWithEmptyResponse_withParameterAndEmptyResponseName
        ..responseParams = _regressionTestsCheckMethodWithEmptyResponseWithParameterAndEmptyResponseResponseParams()
        ..parameters = _regressionTestsCheckMethodWithEmptyResponseWithParameterAndEmptyResponseParams(),
    };
}

class _CheckMethodWithEmptyResponseServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      _regressionTestsCheckMethodWithEmptyResponse();

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      getAllMojomTypeDefinitions()[typeKey];

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      getAllMojomTypeDefinitions();
}

abstract class CheckMethodWithEmptyResponse {
  static const String serviceName = null;
  dynamic withoutParameterAndEmptyResponse([Function responseFactory = null]);
  dynamic withParameterAndEmptyResponse(bool b,[Function responseFactory = null]);
}


class _CheckMethodWithEmptyResponseProxyImpl extends bindings.Proxy {
  _CheckMethodWithEmptyResponseProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _CheckMethodWithEmptyResponseProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _CheckMethodWithEmptyResponseProxyImpl.unbound() : super.unbound();

  static _CheckMethodWithEmptyResponseProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _CheckMethodWithEmptyResponseProxyImpl"));
    return new _CheckMethodWithEmptyResponseProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _CheckMethodWithEmptyResponseServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _CheckMethodWithEmptyResponse_withoutParameterAndEmptyResponseName:
        var r = CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseResponseParams.deserialize(
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
      case _CheckMethodWithEmptyResponse_withParameterAndEmptyResponseName:
        var r = CheckMethodWithEmptyResponseWithParameterAndEmptyResponseResponseParams.deserialize(
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
    return "_CheckMethodWithEmptyResponseProxyImpl($superString)";
  }
}


class _CheckMethodWithEmptyResponseProxyCalls implements CheckMethodWithEmptyResponse {
  _CheckMethodWithEmptyResponseProxyImpl _proxyImpl;

  _CheckMethodWithEmptyResponseProxyCalls(this._proxyImpl);
    dynamic withoutParameterAndEmptyResponse([Function responseFactory = null]) {
      var params = new _CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _CheckMethodWithEmptyResponse_withoutParameterAndEmptyResponseName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic withParameterAndEmptyResponse(bool b,[Function responseFactory = null]) {
      var params = new _CheckMethodWithEmptyResponseWithParameterAndEmptyResponseParams();
      params.b = b;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _CheckMethodWithEmptyResponse_withParameterAndEmptyResponseName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class CheckMethodWithEmptyResponseProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  CheckMethodWithEmptyResponse ptr;

  CheckMethodWithEmptyResponseProxy(_CheckMethodWithEmptyResponseProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _CheckMethodWithEmptyResponseProxyCalls(proxyImpl);

  CheckMethodWithEmptyResponseProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _CheckMethodWithEmptyResponseProxyImpl.fromEndpoint(endpoint) {
    ptr = new _CheckMethodWithEmptyResponseProxyCalls(impl);
  }

  CheckMethodWithEmptyResponseProxy.fromHandle(core.MojoHandle handle) :
      impl = new _CheckMethodWithEmptyResponseProxyImpl.fromHandle(handle) {
    ptr = new _CheckMethodWithEmptyResponseProxyCalls(impl);
  }

  CheckMethodWithEmptyResponseProxy.unbound() :
      impl = new _CheckMethodWithEmptyResponseProxyImpl.unbound() {
    ptr = new _CheckMethodWithEmptyResponseProxyCalls(impl);
  }

  factory CheckMethodWithEmptyResponseProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    CheckMethodWithEmptyResponseProxy p = new CheckMethodWithEmptyResponseProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static CheckMethodWithEmptyResponseProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CheckMethodWithEmptyResponseProxy"));
    return new CheckMethodWithEmptyResponseProxy.fromEndpoint(endpoint);
  }

  String get serviceName => CheckMethodWithEmptyResponse.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "CheckMethodWithEmptyResponseProxy($impl)";
  }
}


class CheckMethodWithEmptyResponseStub extends bindings.Stub {
  CheckMethodWithEmptyResponse _impl = null;

  CheckMethodWithEmptyResponseStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  CheckMethodWithEmptyResponseStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  CheckMethodWithEmptyResponseStub.unbound() : super.unbound();

  static CheckMethodWithEmptyResponseStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CheckMethodWithEmptyResponseStub"));
    return new CheckMethodWithEmptyResponseStub.fromEndpoint(endpoint);
  }


  CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseResponseParams _CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseResponseParamsFactory() {
    var mojo_factory_result = new CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseResponseParams();
    return mojo_factory_result;
  }
  CheckMethodWithEmptyResponseWithParameterAndEmptyResponseResponseParams _CheckMethodWithEmptyResponseWithParameterAndEmptyResponseResponseParamsFactory() {
    var mojo_factory_result = new CheckMethodWithEmptyResponseWithParameterAndEmptyResponseResponseParams();
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
      case _CheckMethodWithEmptyResponse_withoutParameterAndEmptyResponseName:
        var params = _CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseParams.deserialize(
            message.payload);
        var response = _impl.withoutParameterAndEmptyResponse(_CheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _CheckMethodWithEmptyResponse_withoutParameterAndEmptyResponseName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _CheckMethodWithEmptyResponse_withoutParameterAndEmptyResponseName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _CheckMethodWithEmptyResponse_withParameterAndEmptyResponseName:
        var params = _CheckMethodWithEmptyResponseWithParameterAndEmptyResponseParams.deserialize(
            message.payload);
        var response = _impl.withParameterAndEmptyResponse(params.b,_CheckMethodWithEmptyResponseWithParameterAndEmptyResponseResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _CheckMethodWithEmptyResponse_withParameterAndEmptyResponseName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _CheckMethodWithEmptyResponse_withParameterAndEmptyResponseName,
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

  CheckMethodWithEmptyResponse get impl => _impl;
  set impl(CheckMethodWithEmptyResponse d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "CheckMethodWithEmptyResponseStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _CheckMethodWithEmptyResponseServiceDescription();
}

const int _CheckNameCollision_withNameCollisionName = 0;

mojom_types.MojomInterface _regressionTestsCheckNameCollision() {
  return new mojom_types.MojomInterface()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'CheckNameCollision'
      ..fullIdentifier = 'regression_tests.CheckNameCollision')
    ..interfaceName = 'CheckNameCollision'
    ..methods = <int, mojom_types.MojomMethod>{
      _CheckNameCollision_withNameCollisionName: new mojom_types.MojomMethod()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'WithNameCollision')
        ..ordinal = _CheckNameCollision_withNameCollisionName
        ..responseParams = _regressionTestsCheckNameCollisionWithNameCollisionResponseParams()
        ..parameters = _regressionTestsCheckNameCollisionWithNameCollisionParams(),
    };
}

class _CheckNameCollisionServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      _regressionTestsCheckNameCollision();

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      getAllMojomTypeDefinitions()[typeKey];

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      getAllMojomTypeDefinitions();
}

abstract class CheckNameCollision {
  static const String serviceName = null;
  dynamic withNameCollision(bool message,bool response,[Function responseFactory = null]);
}


class _CheckNameCollisionProxyImpl extends bindings.Proxy {
  _CheckNameCollisionProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _CheckNameCollisionProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _CheckNameCollisionProxyImpl.unbound() : super.unbound();

  static _CheckNameCollisionProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _CheckNameCollisionProxyImpl"));
    return new _CheckNameCollisionProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _CheckNameCollisionServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _CheckNameCollision_withNameCollisionName:
        var r = CheckNameCollisionWithNameCollisionResponseParams.deserialize(
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
    return "_CheckNameCollisionProxyImpl($superString)";
  }
}


class _CheckNameCollisionProxyCalls implements CheckNameCollision {
  _CheckNameCollisionProxyImpl _proxyImpl;

  _CheckNameCollisionProxyCalls(this._proxyImpl);
    dynamic withNameCollision(bool message,bool response,[Function responseFactory = null]) {
      var params = new _CheckNameCollisionWithNameCollisionParams();
      params.message = message;
      params.response = response;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _CheckNameCollision_withNameCollisionName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class CheckNameCollisionProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  CheckNameCollision ptr;

  CheckNameCollisionProxy(_CheckNameCollisionProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _CheckNameCollisionProxyCalls(proxyImpl);

  CheckNameCollisionProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _CheckNameCollisionProxyImpl.fromEndpoint(endpoint) {
    ptr = new _CheckNameCollisionProxyCalls(impl);
  }

  CheckNameCollisionProxy.fromHandle(core.MojoHandle handle) :
      impl = new _CheckNameCollisionProxyImpl.fromHandle(handle) {
    ptr = new _CheckNameCollisionProxyCalls(impl);
  }

  CheckNameCollisionProxy.unbound() :
      impl = new _CheckNameCollisionProxyImpl.unbound() {
    ptr = new _CheckNameCollisionProxyCalls(impl);
  }

  factory CheckNameCollisionProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    CheckNameCollisionProxy p = new CheckNameCollisionProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static CheckNameCollisionProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CheckNameCollisionProxy"));
    return new CheckNameCollisionProxy.fromEndpoint(endpoint);
  }

  String get serviceName => CheckNameCollision.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "CheckNameCollisionProxy($impl)";
  }
}


class CheckNameCollisionStub extends bindings.Stub {
  CheckNameCollision _impl = null;

  CheckNameCollisionStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  CheckNameCollisionStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  CheckNameCollisionStub.unbound() : super.unbound();

  static CheckNameCollisionStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CheckNameCollisionStub"));
    return new CheckNameCollisionStub.fromEndpoint(endpoint);
  }


  CheckNameCollisionWithNameCollisionResponseParams _CheckNameCollisionWithNameCollisionResponseParamsFactory(bool message, bool response) {
    var mojo_factory_result = new CheckNameCollisionWithNameCollisionResponseParams();
    mojo_factory_result.message = message;
    mojo_factory_result.response = response;
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
      case _CheckNameCollision_withNameCollisionName:
        var params = _CheckNameCollisionWithNameCollisionParams.deserialize(
            message.payload);
        var response = _impl.withNameCollision(params.message,params.response,_CheckNameCollisionWithNameCollisionResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _CheckNameCollision_withNameCollisionName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _CheckNameCollision_withNameCollisionName,
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

  CheckNameCollision get impl => _impl;
  set impl(CheckNameCollision d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "CheckNameCollisionStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _CheckNameCollisionServiceDescription();
}

const int _CheckEnumCaps_setEnumWithInternalAllCapsName = 0;

mojom_types.MojomInterface _regressionTestsCheckEnumCaps() {
  return new mojom_types.MojomInterface()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'CheckEnumCaps'
      ..fullIdentifier = 'regression_tests.CheckEnumCaps')
    ..interfaceName = 'CheckEnumCaps'
    ..methods = <int, mojom_types.MojomMethod>{
      _CheckEnumCaps_setEnumWithInternalAllCapsName: new mojom_types.MojomMethod()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'SetEnumWithInternalAllCaps')
        ..ordinal = _CheckEnumCaps_setEnumWithInternalAllCapsName
        ..parameters = _regressionTestsCheckEnumCapsSetEnumWithInternalAllCapsParams(),
    };
}

class _CheckEnumCapsServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      _regressionTestsCheckEnumCaps();

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      getAllMojomTypeDefinitions()[typeKey];

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      getAllMojomTypeDefinitions();
}

abstract class CheckEnumCaps {
  static const String serviceName = null;
  void setEnumWithInternalAllCaps(EnumWithInternalAllCaps e);
}


class _CheckEnumCapsProxyImpl extends bindings.Proxy {
  _CheckEnumCapsProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _CheckEnumCapsProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _CheckEnumCapsProxyImpl.unbound() : super.unbound();

  static _CheckEnumCapsProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _CheckEnumCapsProxyImpl"));
    return new _CheckEnumCapsProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _CheckEnumCapsServiceDescription();

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
    return "_CheckEnumCapsProxyImpl($superString)";
  }
}


class _CheckEnumCapsProxyCalls implements CheckEnumCaps {
  _CheckEnumCapsProxyImpl _proxyImpl;

  _CheckEnumCapsProxyCalls(this._proxyImpl);
    void setEnumWithInternalAllCaps(EnumWithInternalAllCaps e) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _CheckEnumCapsSetEnumWithInternalAllCapsParams();
      params.e = e;
      _proxyImpl.sendMessage(params, _CheckEnumCaps_setEnumWithInternalAllCapsName);
    }
}


class CheckEnumCapsProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  CheckEnumCaps ptr;

  CheckEnumCapsProxy(_CheckEnumCapsProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _CheckEnumCapsProxyCalls(proxyImpl);

  CheckEnumCapsProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _CheckEnumCapsProxyImpl.fromEndpoint(endpoint) {
    ptr = new _CheckEnumCapsProxyCalls(impl);
  }

  CheckEnumCapsProxy.fromHandle(core.MojoHandle handle) :
      impl = new _CheckEnumCapsProxyImpl.fromHandle(handle) {
    ptr = new _CheckEnumCapsProxyCalls(impl);
  }

  CheckEnumCapsProxy.unbound() :
      impl = new _CheckEnumCapsProxyImpl.unbound() {
    ptr = new _CheckEnumCapsProxyCalls(impl);
  }

  factory CheckEnumCapsProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    CheckEnumCapsProxy p = new CheckEnumCapsProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static CheckEnumCapsProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CheckEnumCapsProxy"));
    return new CheckEnumCapsProxy.fromEndpoint(endpoint);
  }

  String get serviceName => CheckEnumCaps.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "CheckEnumCapsProxy($impl)";
  }
}


class CheckEnumCapsStub extends bindings.Stub {
  CheckEnumCaps _impl = null;

  CheckEnumCapsStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  CheckEnumCapsStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  CheckEnumCapsStub.unbound() : super.unbound();

  static CheckEnumCapsStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CheckEnumCapsStub"));
    return new CheckEnumCapsStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _CheckEnumCaps_setEnumWithInternalAllCapsName:
        var params = _CheckEnumCapsSetEnumWithInternalAllCapsParams.deserialize(
            message.payload);
        _impl.setEnumWithInternalAllCaps(params.e);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  CheckEnumCaps get impl => _impl;
  set impl(CheckEnumCaps d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "CheckEnumCapsStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _CheckEnumCapsServiceDescription();
}

const int _TestInterface_someMessageName = 0;

mojom_types.MojomInterface _regressionTestsTestInterface() {
  return new mojom_types.MojomInterface()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'TestInterface'
      ..fullIdentifier = 'regression_tests.TestInterface')
    ..interfaceName = 'TestInterface'
    ..methods = <int, mojom_types.MojomMethod>{
      _TestInterface_someMessageName: new mojom_types.MojomMethod()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'SomeMessage')
        ..ordinal = _TestInterface_someMessageName
        ..parameters = _regressionTestsTestInterfaceSomeMessageParams(),
    };
}

class _TestInterfaceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      _regressionTestsTestInterface();

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      getAllMojomTypeDefinitions()[typeKey];

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      getAllMojomTypeDefinitions();
}

abstract class TestInterface {
  static const String serviceName = null;
  void someMessage();
}


class _TestInterfaceProxyImpl extends bindings.Proxy {
  _TestInterfaceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _TestInterfaceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _TestInterfaceProxyImpl.unbound() : super.unbound();

  static _TestInterfaceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _TestInterfaceProxyImpl"));
    return new _TestInterfaceProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _TestInterfaceServiceDescription();

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
    return "_TestInterfaceProxyImpl($superString)";
  }
}


class _TestInterfaceProxyCalls implements TestInterface {
  _TestInterfaceProxyImpl _proxyImpl;

  _TestInterfaceProxyCalls(this._proxyImpl);
    void someMessage() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _TestInterfaceSomeMessageParams();
      _proxyImpl.sendMessage(params, _TestInterface_someMessageName);
    }
}


class TestInterfaceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  TestInterface ptr;

  TestInterfaceProxy(_TestInterfaceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _TestInterfaceProxyCalls(proxyImpl);

  TestInterfaceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _TestInterfaceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _TestInterfaceProxyCalls(impl);
  }

  TestInterfaceProxy.fromHandle(core.MojoHandle handle) :
      impl = new _TestInterfaceProxyImpl.fromHandle(handle) {
    ptr = new _TestInterfaceProxyCalls(impl);
  }

  TestInterfaceProxy.unbound() :
      impl = new _TestInterfaceProxyImpl.unbound() {
    ptr = new _TestInterfaceProxyCalls(impl);
  }

  factory TestInterfaceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    TestInterfaceProxy p = new TestInterfaceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static TestInterfaceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TestInterfaceProxy"));
    return new TestInterfaceProxy.fromEndpoint(endpoint);
  }

  String get serviceName => TestInterface.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "TestInterfaceProxy($impl)";
  }
}


class TestInterfaceStub extends bindings.Stub {
  TestInterface _impl = null;

  TestInterfaceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  TestInterfaceStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  TestInterfaceStub.unbound() : super.unbound();

  static TestInterfaceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TestInterfaceStub"));
    return new TestInterfaceStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _TestInterface_someMessageName:
        var params = _TestInterfaceSomeMessageParams.deserialize(
            message.payload);
        _impl.someMessage();
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  TestInterface get impl => _impl;
  set impl(TestInterface d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "TestInterfaceStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _TestInterfaceServiceDescription();
}

const int _Regression551_getName = 0;

mojom_types.MojomInterface _regressionTestsRegression551() {
  return new mojom_types.MojomInterface()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'Regression551'
      ..fullIdentifier = 'regression_tests.Regression551')
    ..interfaceName = 'Regression551'
    ..methods = <int, mojom_types.MojomMethod>{
      _Regression551_getName: new mojom_types.MojomMethod()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Get')
        ..ordinal = _Regression551_getName
        ..responseParams = _regressionTestsRegression551GetResponseParams()
        ..parameters = _regressionTestsRegression551GetParams(),
    };
}

class _Regression551ServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      _regressionTestsRegression551();

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      getAllMojomTypeDefinitions()[typeKey];

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      getAllMojomTypeDefinitions();
}

abstract class Regression551 {
  static const String serviceName = null;
  dynamic get(List<String> keyPrefixes,[Function responseFactory = null]);
}


class _Regression551ProxyImpl extends bindings.Proxy {
  _Regression551ProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _Regression551ProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _Regression551ProxyImpl.unbound() : super.unbound();

  static _Regression551ProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _Regression551ProxyImpl"));
    return new _Regression551ProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _Regression551ServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _Regression551_getName:
        var r = Regression551GetResponseParams.deserialize(
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
    return "_Regression551ProxyImpl($superString)";
  }
}


class _Regression551ProxyCalls implements Regression551 {
  _Regression551ProxyImpl _proxyImpl;

  _Regression551ProxyCalls(this._proxyImpl);
    dynamic get(List<String> keyPrefixes,[Function responseFactory = null]) {
      var params = new _Regression551GetParams();
      params.keyPrefixes = keyPrefixes;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _Regression551_getName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class Regression551Proxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  Regression551 ptr;

  Regression551Proxy(_Regression551ProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _Regression551ProxyCalls(proxyImpl);

  Regression551Proxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _Regression551ProxyImpl.fromEndpoint(endpoint) {
    ptr = new _Regression551ProxyCalls(impl);
  }

  Regression551Proxy.fromHandle(core.MojoHandle handle) :
      impl = new _Regression551ProxyImpl.fromHandle(handle) {
    ptr = new _Regression551ProxyCalls(impl);
  }

  Regression551Proxy.unbound() :
      impl = new _Regression551ProxyImpl.unbound() {
    ptr = new _Regression551ProxyCalls(impl);
  }

  factory Regression551Proxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    Regression551Proxy p = new Regression551Proxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static Regression551Proxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For Regression551Proxy"));
    return new Regression551Proxy.fromEndpoint(endpoint);
  }

  String get serviceName => Regression551.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "Regression551Proxy($impl)";
  }
}


class Regression551Stub extends bindings.Stub {
  Regression551 _impl = null;

  Regression551Stub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  Regression551Stub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  Regression551Stub.unbound() : super.unbound();

  static Regression551Stub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For Regression551Stub"));
    return new Regression551Stub.fromEndpoint(endpoint);
  }


  Regression551GetResponseParams _Regression551GetResponseParamsFactory(int result) {
    var mojo_factory_result = new Regression551GetResponseParams();
    mojo_factory_result.result = result;
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
      case _Regression551_getName:
        var params = _Regression551GetParams.deserialize(
            message.payload);
        var response = _impl.get(params.keyPrefixes,_Regression551GetResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _Regression551_getName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _Regression551_getName,
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

  Regression551 get impl => _impl;
  set impl(Regression551 d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "Regression551Stub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _Regression551ServiceDescription();
}

const int _ServiceName_serviceName_Name = 0;

mojom_types.MojomInterface _regressionTestsServiceName() {
  return new mojom_types.MojomInterface()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'ServiceName'
      ..fullIdentifier = 'regression_tests.ServiceName')
    ..interfaceName = 'ServiceName'
    ..methods = <int, mojom_types.MojomMethod>{
      _ServiceName_serviceName_Name: new mojom_types.MojomMethod()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'ServiceName')
        ..ordinal = _ServiceName_serviceName_Name
        ..responseParams = _regressionTestsServiceNameServiceNameResponseParams()
        ..parameters = _regressionTestsServiceNameServiceNameParams(),
    };
}

class _ServiceNameServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      _regressionTestsServiceName();

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      getAllMojomTypeDefinitions()[typeKey];

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      getAllMojomTypeDefinitions();
}

abstract class ServiceName {
  static const String serviceName = null;
  dynamic serviceName_([Function responseFactory = null]);
}


class _ServiceNameProxyImpl extends bindings.Proxy {
  _ServiceNameProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ServiceNameProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _ServiceNameProxyImpl.unbound() : super.unbound();

  static _ServiceNameProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _ServiceNameProxyImpl"));
    return new _ServiceNameProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _ServiceNameServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _ServiceName_serviceName_Name:
        var r = ServiceNameServiceNameResponseParams.deserialize(
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
    return "_ServiceNameProxyImpl($superString)";
  }
}


class _ServiceNameProxyCalls implements ServiceName {
  _ServiceNameProxyImpl _proxyImpl;

  _ServiceNameProxyCalls(this._proxyImpl);
    dynamic serviceName_([Function responseFactory = null]) {
      var params = new _ServiceNameServiceNameParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _ServiceName_serviceName_Name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class ServiceNameProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  ServiceName ptr;

  ServiceNameProxy(_ServiceNameProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ServiceNameProxyCalls(proxyImpl);

  ServiceNameProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _ServiceNameProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ServiceNameProxyCalls(impl);
  }

  ServiceNameProxy.fromHandle(core.MojoHandle handle) :
      impl = new _ServiceNameProxyImpl.fromHandle(handle) {
    ptr = new _ServiceNameProxyCalls(impl);
  }

  ServiceNameProxy.unbound() :
      impl = new _ServiceNameProxyImpl.unbound() {
    ptr = new _ServiceNameProxyCalls(impl);
  }

  factory ServiceNameProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ServiceNameProxy p = new ServiceNameProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static ServiceNameProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ServiceNameProxy"));
    return new ServiceNameProxy.fromEndpoint(endpoint);
  }

  String get serviceName => ServiceName.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "ServiceNameProxy($impl)";
  }
}


class ServiceNameStub extends bindings.Stub {
  ServiceName _impl = null;

  ServiceNameStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  ServiceNameStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  ServiceNameStub.unbound() : super.unbound();

  static ServiceNameStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ServiceNameStub"));
    return new ServiceNameStub.fromEndpoint(endpoint);
  }


  ServiceNameServiceNameResponseParams _ServiceNameServiceNameResponseParamsFactory(String serviceName_) {
    var mojo_factory_result = new ServiceNameServiceNameResponseParams();
    mojo_factory_result.serviceName_ = serviceName_;
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
      case _ServiceName_serviceName_Name:
        var params = _ServiceNameServiceNameParams.deserialize(
            message.payload);
        var response = _impl.serviceName_(_ServiceNameServiceNameResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _ServiceName_serviceName_Name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _ServiceName_serviceName_Name,
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

  ServiceName get impl => _impl;
  set impl(ServiceName d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "ServiceNameStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _ServiceNameServiceDescription();
}


Map<String, mojom_types.UserDefinedType> _initDescriptions() {
  var map = new HashMap<String, mojom_types.UserDefinedType>();
  map["regression_tests_EnumWithReference__"] =
    new mojom_types.UserDefinedType()
      ..enumType = _regressionTestsEnumWithReference();
  map["regression_tests_EnumWithLowercase__"] =
    new mojom_types.UserDefinedType()
      ..enumType = _regressionTestsEnumWithLowercase();
  map["regression_tests_EnumWithNumbers__"] =
    new mojom_types.UserDefinedType()
      ..enumType = _regressionTestsEnumWithNumbers();
  map["regression_tests_EnumWithK__"] =
    new mojom_types.UserDefinedType()
      ..enumType = _regressionTestsEnumWithK();
  map["regression_tests_EnumWithINTERNALAllCaps__"] =
    new mojom_types.UserDefinedType()
      ..enumType = _regressionTestsEnumWithInternalAllCaps();
  map["regression_tests_NormalEnum__"] =
    new mojom_types.UserDefinedType()
      ..enumType = _regressionTestsNormalEnum();
  map["regression_tests_CamelCaseTestEnum__"] =
    new mojom_types.UserDefinedType()
      ..enumType = _regressionTestsCamelCaseTestEnum();
  map["regression_tests_Edge__"] =
    new mojom_types.UserDefinedType()
      ..structType = _regressionTestsEdge();
  map["regression_tests_Vertex__"] =
    new mojom_types.UserDefinedType()
      ..structType = _regressionTestsVertex();
  map["regression_tests_EmptyStruct__"] =
    new mojom_types.UserDefinedType()
      ..structType = _regressionTestsEmptyStruct();
  map["regression_tests_A__"] =
    new mojom_types.UserDefinedType()
      ..structType = _regressionTestsA();
  map["regression_tests_B__"] =
    new mojom_types.UserDefinedType()
      ..structType = _regressionTestsB();
  map["regression_tests_StructWithHandleCalledHandles__"] =
    new mojom_types.UserDefinedType()
      ..structType = _regressionTestsStructWithHandleCalledHandles();
  map["regression_tests_StructWithArrayOfHandlesCalledHandles__"] =
    new mojom_types.UserDefinedType()
      ..structType = _regressionTestsStructWithArrayOfHandlesCalledHandles();
  map["regression_tests_StructWithInterfaceCalledHandles__"] =
    new mojom_types.UserDefinedType()
      ..structType = _regressionTestsStructWithInterfaceCalledHandles();
  map["regression_tests_ContainsArrayOfEnum__"] =
    new mojom_types.UserDefinedType()
      ..structType = _regressionTestsContainsArrayOfEnum();
  map["regression_tests_CheckMethodWithEmptyResponse_WithoutParameterAndEmptyResponse_Params__"] =
    new mojom_types.UserDefinedType()
      ..structType = _regressionTestsCheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseParams();
  map["regression_tests_CheckMethodWithEmptyResponse_WithoutParameterAndEmptyResponse_ResponseParams__"] =
    new mojom_types.UserDefinedType()
      ..structType = _regressionTestsCheckMethodWithEmptyResponseWithoutParameterAndEmptyResponseResponseParams();
  map["regression_tests_CheckMethodWithEmptyResponse_WithParameterAndEmptyResponse_Params__"] =
    new mojom_types.UserDefinedType()
      ..structType = _regressionTestsCheckMethodWithEmptyResponseWithParameterAndEmptyResponseParams();
  map["regression_tests_CheckMethodWithEmptyResponse_WithParameterAndEmptyResponse_ResponseParams__"] =
    new mojom_types.UserDefinedType()
      ..structType = _regressionTestsCheckMethodWithEmptyResponseWithParameterAndEmptyResponseResponseParams();
  map["regression_tests_CheckNameCollision_WithNameCollision_Params__"] =
    new mojom_types.UserDefinedType()
      ..structType = _regressionTestsCheckNameCollisionWithNameCollisionParams();
  map["regression_tests_CheckNameCollision_WithNameCollision_ResponseParams__"] =
    new mojom_types.UserDefinedType()
      ..structType = _regressionTestsCheckNameCollisionWithNameCollisionResponseParams();
  map["regression_tests_CheckEnumCaps_SetEnumWithINTERNALAllCaps_Params__"] =
    new mojom_types.UserDefinedType()
      ..structType = _regressionTestsCheckEnumCapsSetEnumWithInternalAllCapsParams();
  map["regression_tests_TestInterface_SomeMessage_Params__"] =
    new mojom_types.UserDefinedType()
      ..structType = _regressionTestsTestInterfaceSomeMessageParams();
  map["regression_tests_Regression551_Get_Params__"] =
    new mojom_types.UserDefinedType()
      ..structType = _regressionTestsRegression551GetParams();
  map["regression_tests_Regression551_Get_ResponseParams__"] =
    new mojom_types.UserDefinedType()
      ..structType = _regressionTestsRegression551GetResponseParams();
  map["regression_tests_ServiceName_serviceName_Params__"] =
    new mojom_types.UserDefinedType()
      ..structType = _regressionTestsServiceNameServiceNameParams();
  map["regression_tests_ServiceName_serviceName_ResponseParams__"] =
    new mojom_types.UserDefinedType()
      ..structType = _regressionTestsServiceNameServiceNameResponseParams();
  map["regression_tests_CheckMethodWithEmptyResponse__"] =
    new mojom_types.UserDefinedType()
      ..interfaceType = _regressionTestsCheckMethodWithEmptyResponse();
  map["regression_tests_CheckNameCollision__"] =
    new mojom_types.UserDefinedType()
      ..interfaceType = _regressionTestsCheckNameCollision();
  map["regression_tests_CheckEnumCaps__"] =
    new mojom_types.UserDefinedType()
      ..interfaceType = _regressionTestsCheckEnumCaps();
  map["regression_tests_TestInterface__"] =
    new mojom_types.UserDefinedType()
      ..interfaceType = _regressionTestsTestInterface();
  map["regression_tests_Regression551__"] =
    new mojom_types.UserDefinedType()
      ..interfaceType = _regressionTestsRegression551();
  map["regression_tests_ServiceName__"] =
    new mojom_types.UserDefinedType()
      ..interfaceType = _regressionTestsServiceName();
  return map;
}

var _mojomDesc;
Map<String, mojom_types.UserDefinedType> getAllMojomTypeDefinitions() {
  if (_mojomDesc == null) {
    _mojomDesc = _initDescriptions();
  }
  return _mojomDesc;
}

