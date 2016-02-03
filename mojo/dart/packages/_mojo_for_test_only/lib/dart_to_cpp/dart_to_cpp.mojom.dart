// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library dart_to_cpp_mojom;

import 'dart:async';
import 'dart:collection';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class EchoArgs extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(104, 0)
  ];
  int si64 = 0;
  int si32 = 0;
  int si16 = 0;
  int si8 = 0;
  int ui8 = 0;
  int ui64 = 0;
  int ui32 = 0;
  int ui16 = 0;
  double floatVal = 0.0;
  double floatInf = 0.0;
  double floatNan = 0.0;
  core.MojoMessagePipeEndpoint messageHandle = null;
  double doubleVal = 0.0;
  double doubleInf = 0.0;
  double doubleNan = 0.0;
  String name = null;
  List<String> stringArray = null;
  core.MojoDataPipeConsumer dataHandle = null;

  EchoArgs() : super(kVersions.last.size);

  static EchoArgs deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static EchoArgs decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    EchoArgs result = new EchoArgs();

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
      
      result.si64 = decoder0.decodeInt64(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.si32 = decoder0.decodeInt32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.si16 = decoder0.decodeInt16(20);
    }
    if (mainDataHeader.version >= 0) {
      
      result.si8 = decoder0.decodeInt8(22);
    }
    if (mainDataHeader.version >= 0) {
      
      result.ui8 = decoder0.decodeUint8(23);
    }
    if (mainDataHeader.version >= 0) {
      
      result.ui64 = decoder0.decodeUint64(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.ui32 = decoder0.decodeUint32(32);
    }
    if (mainDataHeader.version >= 0) {
      
      result.ui16 = decoder0.decodeUint16(36);
    }
    if (mainDataHeader.version >= 0) {
      
      result.floatVal = decoder0.decodeFloat(40);
    }
    if (mainDataHeader.version >= 0) {
      
      result.floatInf = decoder0.decodeFloat(44);
    }
    if (mainDataHeader.version >= 0) {
      
      result.floatNan = decoder0.decodeFloat(48);
    }
    if (mainDataHeader.version >= 0) {
      
      result.messageHandle = decoder0.decodeMessagePipeHandle(52, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.doubleVal = decoder0.decodeDouble(56);
    }
    if (mainDataHeader.version >= 0) {
      
      result.doubleInf = decoder0.decodeDouble(64);
    }
    if (mainDataHeader.version >= 0) {
      
      result.doubleNan = decoder0.decodeDouble(72);
    }
    if (mainDataHeader.version >= 0) {
      
      result.name = decoder0.decodeString(80, true);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(88, true);
      if (decoder1 == null) {
        result.stringArray = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.stringArray = new List<String>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.stringArray[i1] = decoder1.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      result.dataHandle = decoder0.decodeConsumerHandle(96, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt64(si64, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "si64 of struct EchoArgs: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(si32, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "si32 of struct EchoArgs: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt16(si16, 20);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "si16 of struct EchoArgs: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt8(si8, 22);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "si8 of struct EchoArgs: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint8(ui8, 23);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "ui8 of struct EchoArgs: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint64(ui64, 24);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "ui64 of struct EchoArgs: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(ui32, 32);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "ui32 of struct EchoArgs: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint16(ui16, 36);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "ui16 of struct EchoArgs: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(floatVal, 40);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "floatVal of struct EchoArgs: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(floatInf, 44);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "floatInf of struct EchoArgs: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(floatNan, 48);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "floatNan of struct EchoArgs: $e";
      rethrow;
    }
    try {
      encoder0.encodeMessagePipeHandle(messageHandle, 52, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "messageHandle of struct EchoArgs: $e";
      rethrow;
    }
    try {
      encoder0.encodeDouble(doubleVal, 56);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "doubleVal of struct EchoArgs: $e";
      rethrow;
    }
    try {
      encoder0.encodeDouble(doubleInf, 64);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "doubleInf of struct EchoArgs: $e";
      rethrow;
    }
    try {
      encoder0.encodeDouble(doubleNan, 72);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "doubleNan of struct EchoArgs: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(name, 80, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "name of struct EchoArgs: $e";
      rethrow;
    }
    try {
      if (stringArray == null) {
        encoder0.encodeNullPointer(88, true);
      } else {
        var encoder1 = encoder0.encodePointerArray(stringArray.length, 88, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < stringArray.length; ++i0) {
          encoder1.encodeString(stringArray[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "stringArray of struct EchoArgs: $e";
      rethrow;
    }
    try {
      encoder0.encodeConsumerHandle(dataHandle, 96, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "dataHandle of struct EchoArgs: $e";
      rethrow;
    }
  }

  String toString() {
    return "EchoArgs("
           "si64: $si64" ", "
           "si32: $si32" ", "
           "si16: $si16" ", "
           "si8: $si8" ", "
           "ui8: $ui8" ", "
           "ui64: $ui64" ", "
           "ui32: $ui32" ", "
           "ui16: $ui16" ", "
           "floatVal: $floatVal" ", "
           "floatInf: $floatInf" ", "
           "floatNan: $floatNan" ", "
           "messageHandle: $messageHandle" ", "
           "doubleVal: $doubleVal" ", "
           "doubleInf: $doubleInf" ", "
           "doubleNan: $doubleNan" ", "
           "name: $name" ", "
           "stringArray: $stringArray" ", "
           "dataHandle: $dataHandle" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

mojom_types.MojomStruct _dartToCppEchoArgs() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'EchoArgs'
      ..fullIdentifier = 'dart_to_cpp.EchoArgs')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Si64')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int64),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Si32')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int32),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Si16')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int16),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Si8')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int8),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Ui64')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.uint64),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Ui32')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.uint32),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Ui16')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.uint16),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Ui8')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.uint8),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'FloatVal')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.float),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'FloatInf')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.float),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'FloatNan')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.float),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'DoubleVal')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.double),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'DoubleInf')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.double),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'DoubleNan')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.double),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Name')
        ..type = (new mojom_types.Type()
          ..stringType = (new mojom_types.StringType()
            ..nullable = true
          )),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'StringArray')
        ..type = (new mojom_types.Type()
          ..arrayType = (new mojom_types.ArrayType()
            ..nullable = true
            ..elementType = (new mojom_types.Type()
                    ..stringType = (new mojom_types.StringType())))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'MessageHandle')
        ..type = (new mojom_types.Type()
          ..handleType = (new mojom_types.HandleType()
            ..kind = mojom_types.HandleTypeKind.messagePipe
            ..nullable = true
          )),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'DataHandle')
        ..type = (new mojom_types.Type()
          ..handleType = (new mojom_types.HandleType()
            ..kind = mojom_types.HandleTypeKind.dataPipeConsumer
            ..nullable = true
          )),];
}


class EchoArgsList extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  EchoArgsList next = null;
  EchoArgs item = null;

  EchoArgsList() : super(kVersions.last.size);

  static EchoArgsList deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static EchoArgsList decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    EchoArgsList result = new EchoArgsList();

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
      result.next = EchoArgsList.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.item = EchoArgs.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(next, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "next of struct EchoArgsList: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(item, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "item of struct EchoArgsList: $e";
      rethrow;
    }
  }

  String toString() {
    return "EchoArgsList("
           "next: $next" ", "
           "item: $item" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

mojom_types.MojomStruct _dartToCppEchoArgsList() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'EchoArgsList'
      ..fullIdentifier = 'dart_to_cpp.EchoArgsList')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Next')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..nullable = true
        
          ..identifier = 'dart_to_cpp_EchoArgsList__'
          ..typeKey = 'dart_to_cpp_EchoArgsList__'
        )),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Item')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..nullable = true
        
          ..identifier = 'dart_to_cpp_EchoArgs__'
          ..typeKey = 'dart_to_cpp_EchoArgs__'
        )),];
}


class _CppSideStartTestParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _CppSideStartTestParams() : super(kVersions.last.size);

  static _CppSideStartTestParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CppSideStartTestParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CppSideStartTestParams result = new _CppSideStartTestParams();

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
    return "_CppSideStartTestParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

mojom_types.MojomStruct _dartToCppCppSideStartTestParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'CppSideStartTestParams'
      ..fullIdentifier = 'dart_to_cpp.CppSide_StartTest_Params')
    ..fields = <mojom_types.StructField>[];
}


class _CppSideTestFinishedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _CppSideTestFinishedParams() : super(kVersions.last.size);

  static _CppSideTestFinishedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CppSideTestFinishedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CppSideTestFinishedParams result = new _CppSideTestFinishedParams();

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
    return "_CppSideTestFinishedParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

mojom_types.MojomStruct _dartToCppCppSideTestFinishedParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'CppSideTestFinishedParams'
      ..fullIdentifier = 'dart_to_cpp.CppSide_TestFinished_Params')
    ..fields = <mojom_types.StructField>[];
}


class _CppSidePingResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _CppSidePingResponseParams() : super(kVersions.last.size);

  static _CppSidePingResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CppSidePingResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CppSidePingResponseParams result = new _CppSidePingResponseParams();

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
    return "_CppSidePingResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

mojom_types.MojomStruct _dartToCppCppSidePingResponseParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'CppSidePingResponseParams'
      ..fullIdentifier = 'dart_to_cpp.CppSide_PingResponse_Params')
    ..fields = <mojom_types.StructField>[];
}


class _CppSideEchoResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  EchoArgsList list = null;

  _CppSideEchoResponseParams() : super(kVersions.last.size);

  static _CppSideEchoResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CppSideEchoResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CppSideEchoResponseParams result = new _CppSideEchoResponseParams();

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
      result.list = EchoArgsList.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(list, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "list of struct _CppSideEchoResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_CppSideEchoResponseParams("
           "list: $list" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

mojom_types.MojomStruct _dartToCppCppSideEchoResponseParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'CppSideEchoResponseParams'
      ..fullIdentifier = 'dart_to_cpp.CppSide_EchoResponse_Params')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'List')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..identifier = 'dart_to_cpp_EchoArgsList__'
          ..typeKey = 'dart_to_cpp_EchoArgsList__'
        )),];
}


class _DartSideSetClientParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object cppSide = null;

  _DartSideSetClientParams() : super(kVersions.last.size);

  static _DartSideSetClientParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _DartSideSetClientParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _DartSideSetClientParams result = new _DartSideSetClientParams();

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
      
      result.cppSide = decoder0.decodeServiceInterface(8, false, CppSideProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(cppSide, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "cppSide of struct _DartSideSetClientParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_DartSideSetClientParams("
           "cppSide: $cppSide" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

mojom_types.MojomStruct _dartToCppDartSideSetClientParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'DartSideSetClientParams'
      ..fullIdentifier = 'dart_to_cpp.DartSide_SetClient_Params')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'CppSide')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..identifier = 'dart_to_cpp_CppSide__'
          ..typeKey = 'dart_to_cpp_CppSide__'
        )),];
}


class _DartSidePingParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _DartSidePingParams() : super(kVersions.last.size);

  static _DartSidePingParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _DartSidePingParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _DartSidePingParams result = new _DartSidePingParams();

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
    return "_DartSidePingParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

mojom_types.MojomStruct _dartToCppDartSidePingParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'DartSidePingParams'
      ..fullIdentifier = 'dart_to_cpp.DartSide_Ping_Params')
    ..fields = <mojom_types.StructField>[];
}


class _DartSideEchoParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int numIterations = 0;
  EchoArgs arg = null;

  _DartSideEchoParams() : super(kVersions.last.size);

  static _DartSideEchoParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _DartSideEchoParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _DartSideEchoParams result = new _DartSideEchoParams();

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
      
      result.numIterations = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.arg = EchoArgs.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(numIterations, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "numIterations of struct _DartSideEchoParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(arg, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "arg of struct _DartSideEchoParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_DartSideEchoParams("
           "numIterations: $numIterations" ", "
           "arg: $arg" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

mojom_types.MojomStruct _dartToCppDartSideEchoParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'DartSideEchoParams'
      ..fullIdentifier = 'dart_to_cpp.DartSide_Echo_Params')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'NumIterations')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int32),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Arg')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..identifier = 'dart_to_cpp_EchoArgs__'
          ..typeKey = 'dart_to_cpp_EchoArgs__'
        )),];
}


const int _CppSide_startTestName = 88888888;
const int _CppSide_testFinishedName = 99999999;
const int _CppSide_pingResponseName = 100000000;
const int _CppSide_echoResponseName = 100000001;

mojom_types.MojomInterface _dartToCppCppSide() {
  return new mojom_types.MojomInterface()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'CppSide'
      ..fullIdentifier = 'dart_to_cpp.CppSide')
    ..interfaceName = 'CppSide'
    ..methods = <int, mojom_types.MojomMethod>{
      _CppSide_startTestName: new mojom_types.MojomMethod()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'StartTest')
        ..ordinal = _CppSide_startTestName
        ..parameters = _dartToCppCppSideStartTestParams(),
      _CppSide_testFinishedName: new mojom_types.MojomMethod()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'TestFinished')
        ..ordinal = _CppSide_testFinishedName
        ..parameters = _dartToCppCppSideTestFinishedParams(),
      _CppSide_pingResponseName: new mojom_types.MojomMethod()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'PingResponse')
        ..ordinal = _CppSide_pingResponseName
        ..parameters = _dartToCppCppSidePingResponseParams(),
      _CppSide_echoResponseName: new mojom_types.MojomMethod()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'EchoResponse')
        ..ordinal = _CppSide_echoResponseName
        ..parameters = _dartToCppCppSideEchoResponseParams(),
    };
}

class _CppSideServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      _dartToCppCppSide();

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      getAllMojomTypeDefinitions()[typeKey];

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      getAllMojomTypeDefinitions();
}

abstract class CppSide {
  static const String serviceName = null;
  void startTest();
  void testFinished();
  void pingResponse();
  void echoResponse(EchoArgsList list);
}


class _CppSideProxyImpl extends bindings.Proxy {
  _CppSideProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _CppSideProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _CppSideProxyImpl.unbound() : super.unbound();

  static _CppSideProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _CppSideProxyImpl"));
    return new _CppSideProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _CppSideServiceDescription();

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
    return "_CppSideProxyImpl($superString)";
  }
}


class _CppSideProxyCalls implements CppSide {
  _CppSideProxyImpl _proxyImpl;

  _CppSideProxyCalls(this._proxyImpl);
    void startTest() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _CppSideStartTestParams();
      _proxyImpl.sendMessage(params, _CppSide_startTestName);
    }
    void testFinished() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _CppSideTestFinishedParams();
      _proxyImpl.sendMessage(params, _CppSide_testFinishedName);
    }
    void pingResponse() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _CppSidePingResponseParams();
      _proxyImpl.sendMessage(params, _CppSide_pingResponseName);
    }
    void echoResponse(EchoArgsList list) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _CppSideEchoResponseParams();
      params.list = list;
      _proxyImpl.sendMessage(params, _CppSide_echoResponseName);
    }
}


class CppSideProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  CppSide ptr;

  CppSideProxy(_CppSideProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _CppSideProxyCalls(proxyImpl);

  CppSideProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _CppSideProxyImpl.fromEndpoint(endpoint) {
    ptr = new _CppSideProxyCalls(impl);
  }

  CppSideProxy.fromHandle(core.MojoHandle handle) :
      impl = new _CppSideProxyImpl.fromHandle(handle) {
    ptr = new _CppSideProxyCalls(impl);
  }

  CppSideProxy.unbound() :
      impl = new _CppSideProxyImpl.unbound() {
    ptr = new _CppSideProxyCalls(impl);
  }

  factory CppSideProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    CppSideProxy p = new CppSideProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static CppSideProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CppSideProxy"));
    return new CppSideProxy.fromEndpoint(endpoint);
  }

  String get serviceName => CppSide.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "CppSideProxy($impl)";
  }
}


class CppSideStub extends bindings.Stub {
  CppSide _impl = null;

  CppSideStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  CppSideStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  CppSideStub.unbound() : super.unbound();

  static CppSideStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CppSideStub"));
    return new CppSideStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _CppSide_startTestName:
        var params = _CppSideStartTestParams.deserialize(
            message.payload);
        _impl.startTest();
        break;
      case _CppSide_testFinishedName:
        var params = _CppSideTestFinishedParams.deserialize(
            message.payload);
        _impl.testFinished();
        break;
      case _CppSide_pingResponseName:
        var params = _CppSidePingResponseParams.deserialize(
            message.payload);
        _impl.pingResponse();
        break;
      case _CppSide_echoResponseName:
        var params = _CppSideEchoResponseParams.deserialize(
            message.payload);
        _impl.echoResponse(params.list);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  CppSide get impl => _impl;
  set impl(CppSide d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "CppSideStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _CppSideServiceDescription();
}

const int _DartSide_setClientName = 0;
const int _DartSide_pingName = 1;
const int _DartSide_echoName = 2;

mojom_types.MojomInterface _dartToCppDartSide() {
  return new mojom_types.MojomInterface()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'DartSide'
      ..fullIdentifier = 'dart_to_cpp.DartSide')
    ..interfaceName = 'DartSide'
    ..methods = <int, mojom_types.MojomMethod>{
      _DartSide_setClientName: new mojom_types.MojomMethod()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'SetClient')
        ..ordinal = _DartSide_setClientName
        ..parameters = _dartToCppDartSideSetClientParams(),
      _DartSide_pingName: new mojom_types.MojomMethod()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Ping')
        ..ordinal = _DartSide_pingName
        ..parameters = _dartToCppDartSidePingParams(),
      _DartSide_echoName: new mojom_types.MojomMethod()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Echo')
        ..ordinal = _DartSide_echoName
        ..parameters = _dartToCppDartSideEchoParams(),
    };
}

class _DartSideServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      _dartToCppDartSide();

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      getAllMojomTypeDefinitions()[typeKey];

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      getAllMojomTypeDefinitions();
}

abstract class DartSide {
  static const String serviceName = null;
  void setClient(Object cppSide);
  void ping();
  void echo(int numIterations, EchoArgs arg);
}


class _DartSideProxyImpl extends bindings.Proxy {
  _DartSideProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _DartSideProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _DartSideProxyImpl.unbound() : super.unbound();

  static _DartSideProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _DartSideProxyImpl"));
    return new _DartSideProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _DartSideServiceDescription();

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
    return "_DartSideProxyImpl($superString)";
  }
}


class _DartSideProxyCalls implements DartSide {
  _DartSideProxyImpl _proxyImpl;

  _DartSideProxyCalls(this._proxyImpl);
    void setClient(Object cppSide) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _DartSideSetClientParams();
      params.cppSide = cppSide;
      _proxyImpl.sendMessage(params, _DartSide_setClientName);
    }
    void ping() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _DartSidePingParams();
      _proxyImpl.sendMessage(params, _DartSide_pingName);
    }
    void echo(int numIterations, EchoArgs arg) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _DartSideEchoParams();
      params.numIterations = numIterations;
      params.arg = arg;
      _proxyImpl.sendMessage(params, _DartSide_echoName);
    }
}


class DartSideProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  DartSide ptr;

  DartSideProxy(_DartSideProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _DartSideProxyCalls(proxyImpl);

  DartSideProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _DartSideProxyImpl.fromEndpoint(endpoint) {
    ptr = new _DartSideProxyCalls(impl);
  }

  DartSideProxy.fromHandle(core.MojoHandle handle) :
      impl = new _DartSideProxyImpl.fromHandle(handle) {
    ptr = new _DartSideProxyCalls(impl);
  }

  DartSideProxy.unbound() :
      impl = new _DartSideProxyImpl.unbound() {
    ptr = new _DartSideProxyCalls(impl);
  }

  factory DartSideProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    DartSideProxy p = new DartSideProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static DartSideProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For DartSideProxy"));
    return new DartSideProxy.fromEndpoint(endpoint);
  }

  String get serviceName => DartSide.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "DartSideProxy($impl)";
  }
}


class DartSideStub extends bindings.Stub {
  DartSide _impl = null;

  DartSideStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  DartSideStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  DartSideStub.unbound() : super.unbound();

  static DartSideStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For DartSideStub"));
    return new DartSideStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _DartSide_setClientName:
        var params = _DartSideSetClientParams.deserialize(
            message.payload);
        _impl.setClient(params.cppSide);
        break;
      case _DartSide_pingName:
        var params = _DartSidePingParams.deserialize(
            message.payload);
        _impl.ping();
        break;
      case _DartSide_echoName:
        var params = _DartSideEchoParams.deserialize(
            message.payload);
        _impl.echo(params.numIterations, params.arg);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  DartSide get impl => _impl;
  set impl(DartSide d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "DartSideStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _DartSideServiceDescription();
}


Map<String, mojom_types.UserDefinedType> _initDescriptions() {
  var map = new HashMap<String, mojom_types.UserDefinedType>();
  map["dart_to_cpp_EchoArgs__"] =
    new mojom_types.UserDefinedType()
      ..structType = _dartToCppEchoArgs();
  map["dart_to_cpp_EchoArgsList__"] =
    new mojom_types.UserDefinedType()
      ..structType = _dartToCppEchoArgsList();
  map["dart_to_cpp_CppSide_StartTest_Params__"] =
    new mojom_types.UserDefinedType()
      ..structType = _dartToCppCppSideStartTestParams();
  map["dart_to_cpp_CppSide_TestFinished_Params__"] =
    new mojom_types.UserDefinedType()
      ..structType = _dartToCppCppSideTestFinishedParams();
  map["dart_to_cpp_CppSide_PingResponse_Params__"] =
    new mojom_types.UserDefinedType()
      ..structType = _dartToCppCppSidePingResponseParams();
  map["dart_to_cpp_CppSide_EchoResponse_Params__"] =
    new mojom_types.UserDefinedType()
      ..structType = _dartToCppCppSideEchoResponseParams();
  map["dart_to_cpp_DartSide_SetClient_Params__"] =
    new mojom_types.UserDefinedType()
      ..structType = _dartToCppDartSideSetClientParams();
  map["dart_to_cpp_DartSide_Ping_Params__"] =
    new mojom_types.UserDefinedType()
      ..structType = _dartToCppDartSidePingParams();
  map["dart_to_cpp_DartSide_Echo_Params__"] =
    new mojom_types.UserDefinedType()
      ..structType = _dartToCppDartSideEchoParams();
  map["dart_to_cpp_CppSide__"] =
    new mojom_types.UserDefinedType()
      ..interfaceType = _dartToCppCppSide();
  map["dart_to_cpp_DartSide__"] =
    new mojom_types.UserDefinedType()
      ..interfaceType = _dartToCppDartSide();
  return map;
}

var _mojomDesc;
Map<String, mojom_types.UserDefinedType> getAllMojomTypeDefinitions() {
  if (_mojomDesc == null) {
    _mojomDesc = _initDescriptions();
  }
  return _mojomDesc;
}

