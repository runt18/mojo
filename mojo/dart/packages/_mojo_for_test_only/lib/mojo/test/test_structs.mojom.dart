// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library test_structs_mojom;

import 'dart:async';
import 'dart:collection';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:_mojo_for_test_only/mojo/test/rect.mojom.dart' as rect_mojom;



class StructOfStructs extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(48, 0)
  ];
  NamedRegion nr = null;
  List<NamedRegion> aNr = null;
  List<RectPair> aRp = null;
  Map<int, NoDefaultFieldValues> mNdfv = null;
  Map<int, HandleStruct> mHs = null;

  StructOfStructs() : super(kVersions.last.size);

  static StructOfStructs deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static StructOfStructs decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    StructOfStructs result = new StructOfStructs();

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
      result.nr = NamedRegion.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.aNr = new List<NamedRegion>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.aNr[i1] = NamedRegion.decode(decoder2);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.aRp = new List<RectPair>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.aRp[i1] = RectPair.decode(decoder2);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(32, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<int> keys0;
        List<NoDefaultFieldValues> values0;
        {
          
          keys0 = decoder1.decodeInt64Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(keys0.length);
            values0 = new List<NoDefaultFieldValues>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              values0[i2] = NoDefaultFieldValues.decode(decoder3);
            }
          }
        }
        result.mNdfv = new Map<int, NoDefaultFieldValues>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(40, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<int> keys0;
        List<HandleStruct> values0;
        {
          
          keys0 = decoder1.decodeInt64Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(keys0.length);
            values0 = new List<HandleStruct>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              values0[i2] = HandleStruct.decode(decoder3);
            }
          }
        }
        result.mHs = new Map<int, HandleStruct>.fromIterables(
            keys0, values0);
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(nr, 8, false);
    
    if (aNr == null) {
      encoder0.encodeNullPointer(16, false);
    } else {
      var encoder1 = encoder0.encodePointerArray(aNr.length, 16, bindings.kUnspecifiedArrayLength);
      for (int i0 = 0; i0 < aNr.length; ++i0) {
        
        encoder1.encodeStruct(aNr[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
      }
    }
    
    if (aRp == null) {
      encoder0.encodeNullPointer(24, false);
    } else {
      var encoder1 = encoder0.encodePointerArray(aRp.length, 24, bindings.kUnspecifiedArrayLength);
      for (int i0 = 0; i0 < aRp.length; ++i0) {
        
        encoder1.encodeStruct(aRp[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
      }
    }
    
    if (mNdfv == null) {
      encoder0.encodeNullPointer(32, false);
    } else {
      var encoder1 = encoder0.encoderForMap(32);
      int size0 = mNdfv.length;
      var keys0 = mNdfv.keys.toList();
      var values0 = mNdfv.values.toList();
      
      encoder1.encodeInt64Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      
      {
        var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
        for (int i1 = 0; i1 < values0.length; ++i1) {
          
          encoder2.encodeStruct(values0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
    }
    
    if (mHs == null) {
      encoder0.encodeNullPointer(40, false);
    } else {
      var encoder1 = encoder0.encoderForMap(40);
      int size0 = mHs.length;
      var keys0 = mHs.keys.toList();
      var values0 = mHs.values.toList();
      
      encoder1.encodeInt64Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      
      {
        var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
        for (int i1 = 0; i1 < values0.length; ++i1) {
          
          encoder2.encodeStruct(values0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
    }
  }

  String toString() {
    return "StructOfStructs("
           "nr: $nr" ", "
           "aNr: $aNr" ", "
           "aRp: $aRp" ", "
           "mNdfv: $mNdfv" ", "
           "mHs: $mHs" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

mojom_types.MojomStruct _testStructsStructOfStructs() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'StructOfStructs'
      ..fullIdentifier = 'mojo.test.StructOfStructs')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Nr')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..identifier = 'test_structs_NamedRegion__'
          ..typeKey = 'test_structs_NamedRegion__'
        )),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'ANr')
        ..type = (new mojom_types.Type()
          ..arrayType = (new mojom_types.ArrayType()
            ..elementType = (new mojom_types.Type()
                    ..typeReference = (new mojom_types.TypeReference()
                    ..identifier = 'test_structs_NamedRegion__'
                    ..typeKey = 'test_structs_NamedRegion__'
                  )))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'ARp')
        ..type = (new mojom_types.Type()
          ..arrayType = (new mojom_types.ArrayType()
            ..elementType = (new mojom_types.Type()
                    ..typeReference = (new mojom_types.TypeReference()
                    ..identifier = 'test_structs_RectPair__'
                    ..typeKey = 'test_structs_RectPair__'
                  )))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'MNdfv')
        ..type = (new mojom_types.Type()
          ..mapType = (new mojom_types.MapType()
            ..keyType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.int64)
            ..valueType = (new mojom_types.Type()
                    ..typeReference = (new mojom_types.TypeReference()
                    ..identifier = 'test_structs_NoDefaultFieldValues__'
                    ..typeKey = 'test_structs_NoDefaultFieldValues__'
                  )))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'MHs')
        ..type = (new mojom_types.Type()
          ..mapType = (new mojom_types.MapType()
            ..keyType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.int64)
            ..valueType = (new mojom_types.Type()
                    ..typeReference = (new mojom_types.TypeReference()
                    ..identifier = 'test_structs_HandleStruct__'
                    ..typeKey = 'test_structs_HandleStruct__'
                  )))),];
}


class NamedRegion extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String name = null;
  List<rect_mojom.Rect> rects = null;

  NamedRegion() : super(kVersions.last.size);

  static NamedRegion deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NamedRegion decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NamedRegion result = new NamedRegion();

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
      
      result.name = decoder0.decodeString(8, true);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      if (decoder1 == null) {
        result.rects = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.rects = new List<rect_mojom.Rect>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.rects[i1] = rect_mojom.Rect.decode(decoder2);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeString(name, 8, true);
    
    if (rects == null) {
      encoder0.encodeNullPointer(16, true);
    } else {
      var encoder1 = encoder0.encodePointerArray(rects.length, 16, bindings.kUnspecifiedArrayLength);
      for (int i0 = 0; i0 < rects.length; ++i0) {
        
        encoder1.encodeStruct(rects[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
      }
    }
  }

  String toString() {
    return "NamedRegion("
           "name: $name" ", "
           "rects: $rects" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["name"] = name;
    map["rects"] = rects;
    return map;
  }
}

mojom_types.MojomStruct _testStructsNamedRegion() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'NamedRegion'
      ..fullIdentifier = 'mojo.test.NamedRegion')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Name')
        ..type = (new mojom_types.Type()
          ..stringType = (new mojom_types.StringType()
            ..nullable = true
          )),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Rects')
        ..type = (new mojom_types.Type()
          ..arrayType = (new mojom_types.ArrayType()
            ..nullable = true
            ..elementType = (new mojom_types.Type()
                    ..typeReference = (new mojom_types.TypeReference()
                    ..identifier = 'rect_Rect__'
                    ..typeKey = 'rect_Rect__'
                  )))),];
}


class RectPair extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  rect_mojom.Rect first = null;
  rect_mojom.Rect second = null;

  RectPair() : super(kVersions.last.size);

  static RectPair deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static RectPair decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    RectPair result = new RectPair();

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
      result.first = rect_mojom.Rect.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.second = rect_mojom.Rect.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(first, 8, true);
    
    encoder0.encodeStruct(second, 16, true);
  }

  String toString() {
    return "RectPair("
           "first: $first" ", "
           "second: $second" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["first"] = first;
    map["second"] = second;
    return map;
  }
}

mojom_types.MojomStruct _testStructsRectPair() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'RectPair'
      ..fullIdentifier = 'mojo.test.RectPair')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'First')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..nullable = true
        
          ..identifier = 'rect_Rect__'
          ..typeKey = 'rect_Rect__'
        )),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Second')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..nullable = true
        
          ..identifier = 'rect_Rect__'
          ..typeKey = 'rect_Rect__'
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

mojom_types.MojomStruct _testStructsEmptyStruct() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'EmptyStruct'
      ..fullIdentifier = 'mojo.test.EmptyStruct')
    ..fields = <mojom_types.StructField>[];
}


class HandleStruct extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  core.MojoMessagePipeEndpoint h = null;
  List<core.MojoMessagePipeEndpoint> arrayH = null;

  HandleStruct() : super(kVersions.last.size);

  static HandleStruct deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static HandleStruct decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    HandleStruct result = new HandleStruct();

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
      
      result.h = decoder0.decodeMessagePipeHandle(8, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.arrayH = decoder0.decodeMessagePipeHandleArray(16, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeMessagePipeHandle(h, 8, true);
    
    encoder0.encodeMessagePipeHandleArray(arrayH, 16, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
  }

  String toString() {
    return "HandleStruct("
           "h: $h" ", "
           "arrayH: $arrayH" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

mojom_types.MojomStruct _testStructsHandleStruct() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'HandleStruct'
      ..fullIdentifier = 'mojo.test.HandleStruct')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'H')
        ..type = (new mojom_types.Type()
          ..handleType = (new mojom_types.HandleType()
            ..kind = mojom_types.HandleTypeKind.messagePipe
            ..nullable = true
          )),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'ArrayH')
        ..type = (new mojom_types.Type()
          ..arrayType = (new mojom_types.ArrayType()
            ..elementType = (new mojom_types.Type()
                    ..handleType = (new mojom_types.HandleType()
                      ..kind = mojom_types.HandleTypeKind.messagePipe)))),];
}


class NullableHandleStruct extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  core.MojoMessagePipeEndpoint h = null;
  int data = 1234;

  NullableHandleStruct() : super(kVersions.last.size);

  static NullableHandleStruct deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NullableHandleStruct decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NullableHandleStruct result = new NullableHandleStruct();

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
      
      result.h = decoder0.decodeMessagePipeHandle(8, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.data = decoder0.decodeInt32(12);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeMessagePipeHandle(h, 8, true);
    
    encoder0.encodeInt32(data, 12);
  }

  String toString() {
    return "NullableHandleStruct("
           "h: $h" ", "
           "data: $data" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

mojom_types.MojomStruct _testStructsNullableHandleStruct() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'NullableHandleStruct'
      ..fullIdentifier = 'mojo.test.NullableHandleStruct')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'H')
        ..type = (new mojom_types.Type()
          ..handleType = (new mojom_types.HandleType()
            ..kind = mojom_types.HandleTypeKind.messagePipe
            ..nullable = true
          )),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Data')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int32),];
}


class NoDefaultFieldValues extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(160, 0)
  ];
  bool f0 = false;
  int f1 = 0;
  int f2 = 0;
  int f3 = 0;
  int f4 = 0;
  int f5 = 0;
  int f6 = 0;
  int f7 = 0;
  int f8 = 0;
  double f9 = 0.0;
  core.MojoMessagePipeEndpoint f13 = null;
  double f10 = 0.0;
  String f11 = null;
  String f12 = null;
  core.MojoDataPipeConsumer f14 = null;
  core.MojoDataPipeProducer f15 = null;
  core.MojoMessagePipeEndpoint f16 = null;
  core.MojoDataPipeConsumer f17 = null;
  core.MojoDataPipeProducer f18 = null;
  core.MojoHandle f19 = null;
  core.MojoHandle f20 = null;
  core.MojoSharedBuffer f21 = null;
  core.MojoSharedBuffer f22 = null;
  List<String> f23 = null;
  List<String> f24 = null;
  List<String> f25 = null;
  List<String> f26 = null;
  EmptyStruct f27 = null;
  EmptyStruct f28 = null;

  NoDefaultFieldValues() : super(kVersions.last.size);

  static NoDefaultFieldValues deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NoDefaultFieldValues decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NoDefaultFieldValues result = new NoDefaultFieldValues();

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
      
      result.f0 = decoder0.decodeBool(8, 0);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f1 = decoder0.decodeInt8(9);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f2 = decoder0.decodeUint8(10);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f3 = decoder0.decodeInt16(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f4 = decoder0.decodeUint16(14);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f5 = decoder0.decodeInt32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f6 = decoder0.decodeUint32(20);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f7 = decoder0.decodeInt64(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f8 = decoder0.decodeUint64(32);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f9 = decoder0.decodeFloat(40);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f13 = decoder0.decodeMessagePipeHandle(44, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f10 = decoder0.decodeDouble(48);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f11 = decoder0.decodeString(56, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f12 = decoder0.decodeString(64, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f14 = decoder0.decodeConsumerHandle(72, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f15 = decoder0.decodeProducerHandle(76, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f16 = decoder0.decodeMessagePipeHandle(80, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f17 = decoder0.decodeConsumerHandle(84, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f18 = decoder0.decodeProducerHandle(88, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f19 = decoder0.decodeHandle(92, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f20 = decoder0.decodeHandle(96, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f21 = decoder0.decodeSharedBufferHandle(100, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f22 = decoder0.decodeSharedBufferHandle(104, true);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(112, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.f23 = new List<String>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.f23[i1] = decoder1.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(120, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.f24 = new List<String>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.f24[i1] = decoder1.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, true);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(128, true);
      if (decoder1 == null) {
        result.f25 = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.f25 = new List<String>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.f25[i1] = decoder1.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(136, true);
      if (decoder1 == null) {
        result.f26 = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.f26 = new List<String>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.f26[i1] = decoder1.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, true);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(144, false);
      result.f27 = EmptyStruct.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(152, true);
      result.f28 = EmptyStruct.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeBool(f0, 8, 0);
    
    encoder0.encodeInt8(f1, 9);
    
    encoder0.encodeUint8(f2, 10);
    
    encoder0.encodeInt16(f3, 12);
    
    encoder0.encodeUint16(f4, 14);
    
    encoder0.encodeInt32(f5, 16);
    
    encoder0.encodeUint32(f6, 20);
    
    encoder0.encodeInt64(f7, 24);
    
    encoder0.encodeUint64(f8, 32);
    
    encoder0.encodeFloat(f9, 40);
    
    encoder0.encodeMessagePipeHandle(f13, 44, false);
    
    encoder0.encodeDouble(f10, 48);
    
    encoder0.encodeString(f11, 56, false);
    
    encoder0.encodeString(f12, 64, true);
    
    encoder0.encodeConsumerHandle(f14, 72, false);
    
    encoder0.encodeProducerHandle(f15, 76, false);
    
    encoder0.encodeMessagePipeHandle(f16, 80, true);
    
    encoder0.encodeConsumerHandle(f17, 84, true);
    
    encoder0.encodeProducerHandle(f18, 88, true);
    
    encoder0.encodeHandle(f19, 92, false);
    
    encoder0.encodeHandle(f20, 96, true);
    
    encoder0.encodeSharedBufferHandle(f21, 100, false);
    
    encoder0.encodeSharedBufferHandle(f22, 104, true);
    
    if (f23 == null) {
      encoder0.encodeNullPointer(112, false);
    } else {
      var encoder1 = encoder0.encodePointerArray(f23.length, 112, bindings.kUnspecifiedArrayLength);
      for (int i0 = 0; i0 < f23.length; ++i0) {
        
        encoder1.encodeString(f23[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
      }
    }
    
    if (f24 == null) {
      encoder0.encodeNullPointer(120, false);
    } else {
      var encoder1 = encoder0.encodePointerArray(f24.length, 120, bindings.kUnspecifiedArrayLength);
      for (int i0 = 0; i0 < f24.length; ++i0) {
        
        encoder1.encodeString(f24[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, true);
      }
    }
    
    if (f25 == null) {
      encoder0.encodeNullPointer(128, true);
    } else {
      var encoder1 = encoder0.encodePointerArray(f25.length, 128, bindings.kUnspecifiedArrayLength);
      for (int i0 = 0; i0 < f25.length; ++i0) {
        
        encoder1.encodeString(f25[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
      }
    }
    
    if (f26 == null) {
      encoder0.encodeNullPointer(136, true);
    } else {
      var encoder1 = encoder0.encodePointerArray(f26.length, 136, bindings.kUnspecifiedArrayLength);
      for (int i0 = 0; i0 < f26.length; ++i0) {
        
        encoder1.encodeString(f26[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, true);
      }
    }
    
    encoder0.encodeStruct(f27, 144, false);
    
    encoder0.encodeStruct(f28, 152, true);
  }

  String toString() {
    return "NoDefaultFieldValues("
           "f0: $f0" ", "
           "f1: $f1" ", "
           "f2: $f2" ", "
           "f3: $f3" ", "
           "f4: $f4" ", "
           "f5: $f5" ", "
           "f6: $f6" ", "
           "f7: $f7" ", "
           "f8: $f8" ", "
           "f9: $f9" ", "
           "f13: $f13" ", "
           "f10: $f10" ", "
           "f11: $f11" ", "
           "f12: $f12" ", "
           "f14: $f14" ", "
           "f15: $f15" ", "
           "f16: $f16" ", "
           "f17: $f17" ", "
           "f18: $f18" ", "
           "f19: $f19" ", "
           "f20: $f20" ", "
           "f21: $f21" ", "
           "f22: $f22" ", "
           "f23: $f23" ", "
           "f24: $f24" ", "
           "f25: $f25" ", "
           "f26: $f26" ", "
           "f27: $f27" ", "
           "f28: $f28" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

mojom_types.MojomStruct _testStructsNoDefaultFieldValues() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'NoDefaultFieldValues'
      ..fullIdentifier = 'mojo.test.NoDefaultFieldValues')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F0')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.bool),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F1')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int8),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F2')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.uint8),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F3')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int16),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F4')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.uint16),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F5')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int32),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F6')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.uint32),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F7')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int64),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F8')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.uint64),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F9')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.float),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F10')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.double),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F11')
        ..type = (new mojom_types.Type()
          ..stringType = (new mojom_types.StringType())),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F12')
        ..type = (new mojom_types.Type()
          ..stringType = (new mojom_types.StringType()
            ..nullable = true
          )),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F13')
        ..type = (new mojom_types.Type()
          ..handleType = (new mojom_types.HandleType()
            ..kind = mojom_types.HandleTypeKind.messagePipe)),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F14')
        ..type = (new mojom_types.Type()
          ..handleType = (new mojom_types.HandleType()
            ..kind = mojom_types.HandleTypeKind.dataPipeConsumer)),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F15')
        ..type = (new mojom_types.Type()
          ..handleType = (new mojom_types.HandleType()
            ..kind = mojom_types.HandleTypeKind.dataPipeProducer)),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F16')
        ..type = (new mojom_types.Type()
          ..handleType = (new mojom_types.HandleType()
            ..kind = mojom_types.HandleTypeKind.messagePipe
            ..nullable = true
          )),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F17')
        ..type = (new mojom_types.Type()
          ..handleType = (new mojom_types.HandleType()
            ..kind = mojom_types.HandleTypeKind.dataPipeConsumer
            ..nullable = true
          )),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F18')
        ..type = (new mojom_types.Type()
          ..handleType = (new mojom_types.HandleType()
            ..kind = mojom_types.HandleTypeKind.dataPipeProducer
            ..nullable = true
          )),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F19')
        ..type = (new mojom_types.Type()
          ..handleType = (new mojom_types.HandleType()
            ..kind = mojom_types.HandleTypeKind.unspecified)),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F20')
        ..type = (new mojom_types.Type()
          ..handleType = (new mojom_types.HandleType()
            ..kind = mojom_types.HandleTypeKind.unspecified
            ..nullable = true
          )),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F21')
        ..type = (new mojom_types.Type()
          ..handleType = (new mojom_types.HandleType()
            ..kind = mojom_types.HandleTypeKind.sharedBuffer)),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F22')
        ..type = (new mojom_types.Type()
          ..handleType = (new mojom_types.HandleType()
            ..kind = mojom_types.HandleTypeKind.sharedBuffer
            ..nullable = true
          )),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F23')
        ..type = (new mojom_types.Type()
          ..arrayType = (new mojom_types.ArrayType()
            ..elementType = (new mojom_types.Type()
                    ..stringType = (new mojom_types.StringType())))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F24')
        ..type = (new mojom_types.Type()
          ..arrayType = (new mojom_types.ArrayType()
            ..elementType = (new mojom_types.Type()
                    ..stringType = (new mojom_types.StringType()
                      ..nullable = true
                    )))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F25')
        ..type = (new mojom_types.Type()
          ..arrayType = (new mojom_types.ArrayType()
            ..nullable = true
            ..elementType = (new mojom_types.Type()
                    ..stringType = (new mojom_types.StringType())))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F26')
        ..type = (new mojom_types.Type()
          ..arrayType = (new mojom_types.ArrayType()
            ..nullable = true
            ..elementType = (new mojom_types.Type()
                    ..stringType = (new mojom_types.StringType()
                      ..nullable = true
                    )))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F27')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..identifier = 'test_structs_EmptyStruct__'
          ..typeKey = 'test_structs_EmptyStruct__'
        )),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F28')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..nullable = true
        
          ..identifier = 'test_structs_EmptyStruct__'
          ..typeKey = 'test_structs_EmptyStruct__'
        )),];
}


class DefaultFieldValues extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(96, 0)
  ];
  static const String kFoo = "foo";
  bool f0 = true;
  int f1 = 100;
  int f2 = 100;
  int f3 = 100;
  int f4 = 100;
  int f5 = 100;
  int f6 = 100;
  int f7 = 100;
  int f8 = 100;
  double f9 = 100;
  double f10 = 100.0;
  double f11 = 100;
  double f12 = 100.0;
  String f13 = "foo";
  String f14 = "foo";
  rect_mojom.Rect f15 = new rect_mojom.Rect();
  rect_mojom.Rect f16 = new rect_mojom.Rect();

  DefaultFieldValues() : super(kVersions.last.size);

  static DefaultFieldValues deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static DefaultFieldValues decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    DefaultFieldValues result = new DefaultFieldValues();

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
      
      result.f0 = decoder0.decodeBool(8, 0);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f1 = decoder0.decodeInt8(9);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f2 = decoder0.decodeUint8(10);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f3 = decoder0.decodeInt16(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f4 = decoder0.decodeUint16(14);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f5 = decoder0.decodeInt32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f6 = decoder0.decodeUint32(20);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f7 = decoder0.decodeInt64(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f8 = decoder0.decodeUint64(32);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f9 = decoder0.decodeFloat(40);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f10 = decoder0.decodeFloat(44);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f11 = decoder0.decodeDouble(48);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f12 = decoder0.decodeDouble(56);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f13 = decoder0.decodeString(64, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f14 = decoder0.decodeString(72, true);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(80, false);
      result.f15 = rect_mojom.Rect.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(88, true);
      result.f16 = rect_mojom.Rect.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeBool(f0, 8, 0);
    
    encoder0.encodeInt8(f1, 9);
    
    encoder0.encodeUint8(f2, 10);
    
    encoder0.encodeInt16(f3, 12);
    
    encoder0.encodeUint16(f4, 14);
    
    encoder0.encodeInt32(f5, 16);
    
    encoder0.encodeUint32(f6, 20);
    
    encoder0.encodeInt64(f7, 24);
    
    encoder0.encodeUint64(f8, 32);
    
    encoder0.encodeFloat(f9, 40);
    
    encoder0.encodeFloat(f10, 44);
    
    encoder0.encodeDouble(f11, 48);
    
    encoder0.encodeDouble(f12, 56);
    
    encoder0.encodeString(f13, 64, false);
    
    encoder0.encodeString(f14, 72, true);
    
    encoder0.encodeStruct(f15, 80, false);
    
    encoder0.encodeStruct(f16, 88, true);
  }

  String toString() {
    return "DefaultFieldValues("
           "f0: $f0" ", "
           "f1: $f1" ", "
           "f2: $f2" ", "
           "f3: $f3" ", "
           "f4: $f4" ", "
           "f5: $f5" ", "
           "f6: $f6" ", "
           "f7: $f7" ", "
           "f8: $f8" ", "
           "f9: $f9" ", "
           "f10: $f10" ", "
           "f11: $f11" ", "
           "f12: $f12" ", "
           "f13: $f13" ", "
           "f14: $f14" ", "
           "f15: $f15" ", "
           "f16: $f16" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["f0"] = f0;
    map["f1"] = f1;
    map["f2"] = f2;
    map["f3"] = f3;
    map["f4"] = f4;
    map["f5"] = f5;
    map["f6"] = f6;
    map["f7"] = f7;
    map["f8"] = f8;
    map["f9"] = f9;
    map["f10"] = f10;
    map["f11"] = f11;
    map["f12"] = f12;
    map["f13"] = f13;
    map["f14"] = f14;
    map["f15"] = f15;
    map["f16"] = f16;
    return map;
  }
}

mojom_types.MojomStruct _testStructsDefaultFieldValues() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'DefaultFieldValues'
      ..fullIdentifier = 'mojo.test.DefaultFieldValues')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F0')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.bool),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F1')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int8),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F2')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.uint8),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F3')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int16),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F4')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.uint16),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F5')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int32),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F6')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.uint32),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F7')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int64),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F8')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.uint64),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F9')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.float),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F10')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.float),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F11')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.double),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F12')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.double),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F13')
        ..type = (new mojom_types.Type()
          ..stringType = (new mojom_types.StringType())),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F14')
        ..type = (new mojom_types.Type()
          ..stringType = (new mojom_types.StringType()
            ..nullable = true
          )),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F15')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..identifier = 'rect_Rect__'
          ..typeKey = 'rect_Rect__'
        )),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F16')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..nullable = true
        
          ..identifier = 'rect_Rect__'
          ..typeKey = 'rect_Rect__'
        )),];
}


class ScopedConstantsEType extends bindings.MojoEnum {
  static const ScopedConstantsEType e0 = const ScopedConstantsEType._(0);
  static const ScopedConstantsEType e1 = const ScopedConstantsEType._(1);
  static const ScopedConstantsEType e2 = const ScopedConstantsEType._(10);
  static const ScopedConstantsEType e3 = const ScopedConstantsEType._(10);
  static const ScopedConstantsEType e4 = const ScopedConstantsEType._(11);

  const ScopedConstantsEType._(int v) : super(v);

  static const Map<String, ScopedConstantsEType> valuesMap = const {
    "e0": e0,
    "e1": e1,
    "e2": e2,
    "e3": e3,
    "e4": e4,
  };
  static const List<ScopedConstantsEType> values = const [
    e0,
    e1,
    e2,
    e3,
    e4,
  ];

  static ScopedConstantsEType valueOf(String name) => valuesMap[name];

  factory ScopedConstantsEType(int v) {
    switch (v) {
      case 0:
        return e0;
      case 1:
        return e1;
      case 10:
        return e2;
      case 10:
        return e3;
      case 11:
        return e4;
      default:
        return null;
    }
  }

  static ScopedConstantsEType decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    ScopedConstantsEType result = new ScopedConstantsEType(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum ScopedConstantsEType.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case e0:
        return 'ScopedConstantsEType.e0';
      case e1:
        return 'ScopedConstantsEType.e1';
      case e2:
        return 'ScopedConstantsEType.e2';
      case e3:
        return 'ScopedConstantsEType.e3';
      case e4:
        return 'ScopedConstantsEType.e4';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

mojom_types.MojomEnum _testStructsEType() {
  return new mojom_types.MojomEnum()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'EType'
      ..fullIdentifier = 'mojo.test.EType')
    ..values = <mojom_types.EnumValue>[
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'E0')
        ..enumTypeKey = 'test_structs_EType__'
        ..intValue = 0,
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'E1')
        ..enumTypeKey = 'test_structs_EType__'
        ..intValue = 1,
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'E2')
        ..enumTypeKey = 'test_structs_EType__'
        ..intValue = 10,
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'E3')
        ..enumTypeKey = 'test_structs_EType__'
        ..intValue = 10,
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'E4')
        ..enumTypeKey = 'test_structs_EType__'
        ..intValue = 11,];
}

class ScopedConstants extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(40, 0)
  ];
  static const int ten = 10;
  static const int alsoTen = 10;
  ScopedConstantsEType f0 = new ScopedConstantsEType(0);
  ScopedConstantsEType f1 = new ScopedConstantsEType(1);
  ScopedConstantsEType f2 = new ScopedConstantsEType(10);
  ScopedConstantsEType f3 = new ScopedConstantsEType(10);
  ScopedConstantsEType f4 = new ScopedConstantsEType(11);
  int f5 = 10;
  int f6 = 10;

  ScopedConstants() : super(kVersions.last.size);

  static ScopedConstants deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ScopedConstants decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ScopedConstants result = new ScopedConstants();

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
      
        result.f0 = ScopedConstantsEType.decode(decoder0, 8);
        if (result.f0 == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable ScopedConstantsEType.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
        result.f1 = ScopedConstantsEType.decode(decoder0, 12);
        if (result.f1 == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable ScopedConstantsEType.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
        result.f2 = ScopedConstantsEType.decode(decoder0, 16);
        if (result.f2 == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable ScopedConstantsEType.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
        result.f3 = ScopedConstantsEType.decode(decoder0, 20);
        if (result.f3 == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable ScopedConstantsEType.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
        result.f4 = ScopedConstantsEType.decode(decoder0, 24);
        if (result.f4 == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable ScopedConstantsEType.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.f5 = decoder0.decodeInt32(28);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f6 = decoder0.decodeInt32(32);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(f0, 8);
    
    encoder0.encodeEnum(f1, 12);
    
    encoder0.encodeEnum(f2, 16);
    
    encoder0.encodeEnum(f3, 20);
    
    encoder0.encodeEnum(f4, 24);
    
    encoder0.encodeInt32(f5, 28);
    
    encoder0.encodeInt32(f6, 32);
  }

  String toString() {
    return "ScopedConstants("
           "f0: $f0" ", "
           "f1: $f1" ", "
           "f2: $f2" ", "
           "f3: $f3" ", "
           "f4: $f4" ", "
           "f5: $f5" ", "
           "f6: $f6" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["f0"] = f0;
    map["f1"] = f1;
    map["f2"] = f2;
    map["f3"] = f3;
    map["f4"] = f4;
    map["f5"] = f5;
    map["f6"] = f6;
    return map;
  }
}

mojom_types.MojomStruct _testStructsScopedConstants() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'ScopedConstants'
      ..fullIdentifier = 'mojo.test.ScopedConstants')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F0')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..identifier = 'test_structs_EType__'
          ..typeKey = 'test_structs_EType__'
        )),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F1')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..identifier = 'test_structs_EType__'
          ..typeKey = 'test_structs_EType__'
        )),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F2')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..identifier = 'test_structs_EType__'
          ..typeKey = 'test_structs_EType__'
        )),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F3')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..identifier = 'test_structs_EType__'
          ..typeKey = 'test_structs_EType__'
        )),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F4')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..identifier = 'test_structs_EType__'
          ..typeKey = 'test_structs_EType__'
        )),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F5')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int32),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F6')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int32),];
}


class MapKeyTypes extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(104, 0)
  ];
  Map<bool, bool> f0 = null;
  Map<int, int> f1 = null;
  Map<int, int> f2 = null;
  Map<int, int> f3 = null;
  Map<int, int> f4 = null;
  Map<int, int> f5 = null;
  Map<int, int> f6 = null;
  Map<int, int> f7 = null;
  Map<int, int> f8 = null;
  Map<double, double> f9 = null;
  Map<double, double> f10 = null;
  Map<String, String> f11 = null;

  MapKeyTypes() : super(kVersions.last.size);

  static MapKeyTypes deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MapKeyTypes decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MapKeyTypes result = new MapKeyTypes();

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
        decoder1.decodeDataHeaderForMap();
        List<bool> keys0;
        List<bool> values0;
        {
          
          keys0 = decoder1.decodeBoolArray(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          values0 = decoder1.decodeBoolArray(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
        }
        result.f0 = new Map<bool, bool>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<int> keys0;
        List<int> values0;
        {
          
          keys0 = decoder1.decodeInt8Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          values0 = decoder1.decodeInt8Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
        }
        result.f1 = new Map<int, int>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<int> keys0;
        List<int> values0;
        {
          
          keys0 = decoder1.decodeUint8Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          values0 = decoder1.decodeUint8Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
        }
        result.f2 = new Map<int, int>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(32, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<int> keys0;
        List<int> values0;
        {
          
          keys0 = decoder1.decodeInt16Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          values0 = decoder1.decodeInt16Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
        }
        result.f3 = new Map<int, int>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(40, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<int> keys0;
        List<int> values0;
        {
          
          keys0 = decoder1.decodeUint16Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          values0 = decoder1.decodeUint16Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
        }
        result.f4 = new Map<int, int>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(48, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<int> keys0;
        List<int> values0;
        {
          
          keys0 = decoder1.decodeInt32Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          values0 = decoder1.decodeInt32Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
        }
        result.f5 = new Map<int, int>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(56, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<int> keys0;
        List<int> values0;
        {
          
          keys0 = decoder1.decodeUint32Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          values0 = decoder1.decodeUint32Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
        }
        result.f6 = new Map<int, int>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(64, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<int> keys0;
        List<int> values0;
        {
          
          keys0 = decoder1.decodeInt64Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          values0 = decoder1.decodeInt64Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
        }
        result.f7 = new Map<int, int>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(72, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<int> keys0;
        List<int> values0;
        {
          
          keys0 = decoder1.decodeUint64Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          values0 = decoder1.decodeUint64Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
        }
        result.f8 = new Map<int, int>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(80, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<double> keys0;
        List<double> values0;
        {
          
          keys0 = decoder1.decodeFloatArray(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          values0 = decoder1.decodeFloatArray(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
        }
        result.f9 = new Map<double, double>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(88, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<double> keys0;
        List<double> values0;
        {
          
          keys0 = decoder1.decodeDoubleArray(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          values0 = decoder1.decodeDoubleArray(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
        }
        result.f10 = new Map<double, double>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(96, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<String> values0;
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
            values0 = new List<String>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              values0[i2] = decoder2.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
            }
          }
        }
        result.f11 = new Map<String, String>.fromIterables(
            keys0, values0);
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    if (f0 == null) {
      encoder0.encodeNullPointer(8, false);
    } else {
      var encoder1 = encoder0.encoderForMap(8);
      int size0 = f0.length;
      var keys0 = f0.keys.toList();
      var values0 = f0.values.toList();
      
      encoder1.encodeBoolArray(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      
      encoder1.encodeBoolArray(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    
    if (f1 == null) {
      encoder0.encodeNullPointer(16, false);
    } else {
      var encoder1 = encoder0.encoderForMap(16);
      int size0 = f1.length;
      var keys0 = f1.keys.toList();
      var values0 = f1.values.toList();
      
      encoder1.encodeInt8Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      
      encoder1.encodeInt8Array(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    
    if (f2 == null) {
      encoder0.encodeNullPointer(24, false);
    } else {
      var encoder1 = encoder0.encoderForMap(24);
      int size0 = f2.length;
      var keys0 = f2.keys.toList();
      var values0 = f2.values.toList();
      
      encoder1.encodeUint8Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      
      encoder1.encodeUint8Array(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    
    if (f3 == null) {
      encoder0.encodeNullPointer(32, false);
    } else {
      var encoder1 = encoder0.encoderForMap(32);
      int size0 = f3.length;
      var keys0 = f3.keys.toList();
      var values0 = f3.values.toList();
      
      encoder1.encodeInt16Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      
      encoder1.encodeInt16Array(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    
    if (f4 == null) {
      encoder0.encodeNullPointer(40, false);
    } else {
      var encoder1 = encoder0.encoderForMap(40);
      int size0 = f4.length;
      var keys0 = f4.keys.toList();
      var values0 = f4.values.toList();
      
      encoder1.encodeUint16Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      
      encoder1.encodeUint16Array(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    
    if (f5 == null) {
      encoder0.encodeNullPointer(48, false);
    } else {
      var encoder1 = encoder0.encoderForMap(48);
      int size0 = f5.length;
      var keys0 = f5.keys.toList();
      var values0 = f5.values.toList();
      
      encoder1.encodeInt32Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      
      encoder1.encodeInt32Array(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    
    if (f6 == null) {
      encoder0.encodeNullPointer(56, false);
    } else {
      var encoder1 = encoder0.encoderForMap(56);
      int size0 = f6.length;
      var keys0 = f6.keys.toList();
      var values0 = f6.values.toList();
      
      encoder1.encodeUint32Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      
      encoder1.encodeUint32Array(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    
    if (f7 == null) {
      encoder0.encodeNullPointer(64, false);
    } else {
      var encoder1 = encoder0.encoderForMap(64);
      int size0 = f7.length;
      var keys0 = f7.keys.toList();
      var values0 = f7.values.toList();
      
      encoder1.encodeInt64Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      
      encoder1.encodeInt64Array(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    
    if (f8 == null) {
      encoder0.encodeNullPointer(72, false);
    } else {
      var encoder1 = encoder0.encoderForMap(72);
      int size0 = f8.length;
      var keys0 = f8.keys.toList();
      var values0 = f8.values.toList();
      
      encoder1.encodeUint64Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      
      encoder1.encodeUint64Array(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    
    if (f9 == null) {
      encoder0.encodeNullPointer(80, false);
    } else {
      var encoder1 = encoder0.encoderForMap(80);
      int size0 = f9.length;
      var keys0 = f9.keys.toList();
      var values0 = f9.values.toList();
      
      encoder1.encodeFloatArray(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      
      encoder1.encodeFloatArray(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    
    if (f10 == null) {
      encoder0.encodeNullPointer(88, false);
    } else {
      var encoder1 = encoder0.encoderForMap(88);
      int size0 = f10.length;
      var keys0 = f10.keys.toList();
      var values0 = f10.values.toList();
      
      encoder1.encodeDoubleArray(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      
      encoder1.encodeDoubleArray(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    
    if (f11 == null) {
      encoder0.encodeNullPointer(96, false);
    } else {
      var encoder1 = encoder0.encoderForMap(96);
      int size0 = f11.length;
      var keys0 = f11.keys.toList();
      var values0 = f11.values.toList();
      
      {
        var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
        for (int i1 = 0; i1 < keys0.length; ++i1) {
          
          encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
      
      {
        var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
        for (int i1 = 0; i1 < values0.length; ++i1) {
          
          encoder2.encodeString(values0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
    }
  }

  String toString() {
    return "MapKeyTypes("
           "f0: $f0" ", "
           "f1: $f1" ", "
           "f2: $f2" ", "
           "f3: $f3" ", "
           "f4: $f4" ", "
           "f5: $f5" ", "
           "f6: $f6" ", "
           "f7: $f7" ", "
           "f8: $f8" ", "
           "f9: $f9" ", "
           "f10: $f10" ", "
           "f11: $f11" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["f0"] = f0;
    map["f1"] = f1;
    map["f2"] = f2;
    map["f3"] = f3;
    map["f4"] = f4;
    map["f5"] = f5;
    map["f6"] = f6;
    map["f7"] = f7;
    map["f8"] = f8;
    map["f9"] = f9;
    map["f10"] = f10;
    map["f11"] = f11;
    return map;
  }
}

mojom_types.MojomStruct _testStructsMapKeyTypes() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'MapKeyTypes'
      ..fullIdentifier = 'mojo.test.MapKeyTypes')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F0')
        ..type = (new mojom_types.Type()
          ..mapType = (new mojom_types.MapType()
            ..keyType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.bool)
            ..valueType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.bool))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F1')
        ..type = (new mojom_types.Type()
          ..mapType = (new mojom_types.MapType()
            ..keyType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.int8)
            ..valueType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.int8))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F2')
        ..type = (new mojom_types.Type()
          ..mapType = (new mojom_types.MapType()
            ..keyType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.uint8)
            ..valueType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.uint8))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F3')
        ..type = (new mojom_types.Type()
          ..mapType = (new mojom_types.MapType()
            ..keyType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.int16)
            ..valueType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.int16))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F4')
        ..type = (new mojom_types.Type()
          ..mapType = (new mojom_types.MapType()
            ..keyType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.uint16)
            ..valueType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.uint16))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F5')
        ..type = (new mojom_types.Type()
          ..mapType = (new mojom_types.MapType()
            ..keyType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.int32)
            ..valueType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.int32))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F6')
        ..type = (new mojom_types.Type()
          ..mapType = (new mojom_types.MapType()
            ..keyType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.uint32)
            ..valueType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.uint32))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F7')
        ..type = (new mojom_types.Type()
          ..mapType = (new mojom_types.MapType()
            ..keyType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.int64)
            ..valueType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.int64))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F8')
        ..type = (new mojom_types.Type()
          ..mapType = (new mojom_types.MapType()
            ..keyType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.uint64)
            ..valueType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.uint64))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F9')
        ..type = (new mojom_types.Type()
          ..mapType = (new mojom_types.MapType()
            ..keyType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.float)
            ..valueType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.float))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F10')
        ..type = (new mojom_types.Type()
          ..mapType = (new mojom_types.MapType()
            ..keyType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.double)
            ..valueType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.double))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F11')
        ..type = (new mojom_types.Type()
          ..mapType = (new mojom_types.MapType()
            ..keyType = (new mojom_types.Type()
                    ..stringType = (new mojom_types.StringType()))
            ..valueType = (new mojom_types.Type()
                    ..stringType = (new mojom_types.StringType())))),];
}


class MapValueTypes extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(104, 0)
  ];
  Map<String, List<String>> f0 = null;
  Map<String, List<String>> f1 = null;
  Map<String, List<String>> f2 = null;
  Map<String, List<String>> f3 = null;
  Map<String, List<List<String>>> f4 = null;
  Map<String, List<List<String>>> f5 = null;
  Map<String, rect_mojom.Rect> f6 = null;
  Map<String, Map<String, String>> f7 = null;
  Map<String, List<Map<String, String>>> f8 = null;
  Map<String, core.MojoHandle> f9 = null;
  Map<String, List<core.MojoHandle>> f10 = null;
  Map<String, Map<String, core.MojoHandle>> f11 = null;

  MapValueTypes() : super(kVersions.last.size);

  static MapValueTypes deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MapValueTypes decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MapValueTypes result = new MapValueTypes();

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
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<List<String>> values0;
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
            values0 = new List<List<String>>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              {
                var si3 = decoder3.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
                values0[i2] = new List<String>(si3.numElements);
                for (int i3 = 0; i3 < si3.numElements; ++i3) {
                  
                  values0[i2][i3] = decoder3.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i3, false);
                }
              }
            }
          }
        }
        result.f0 = new Map<String, List<String>>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<List<String>> values0;
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
            values0 = new List<List<String>>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, true);
              if (decoder3 == null) {
                values0[i2] = null;
              } else {
                var si3 = decoder3.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
                values0[i2] = new List<String>(si3.numElements);
                for (int i3 = 0; i3 < si3.numElements; ++i3) {
                  
                  values0[i2][i3] = decoder3.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i3, false);
                }
              }
            }
          }
        }
        result.f1 = new Map<String, List<String>>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<List<String>> values0;
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
            values0 = new List<List<String>>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              {
                var si3 = decoder3.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
                values0[i2] = new List<String>(si3.numElements);
                for (int i3 = 0; i3 < si3.numElements; ++i3) {
                  
                  values0[i2][i3] = decoder3.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i3, true);
                }
              }
            }
          }
        }
        result.f2 = new Map<String, List<String>>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(32, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<List<String>> values0;
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
            values0 = new List<List<String>>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              {
                var si3 = decoder3.decodeDataHeaderForPointerArray(2);
                values0[i2] = new List<String>(si3.numElements);
                for (int i3 = 0; i3 < si3.numElements; ++i3) {
                  
                  values0[i2][i3] = decoder3.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i3, false);
                }
              }
            }
          }
        }
        result.f3 = new Map<String, List<String>>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(40, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<List<List<String>>> values0;
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
            values0 = new List<List<List<String>>>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              {
                var si3 = decoder3.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
                values0[i2] = new List<List<String>>(si3.numElements);
                for (int i3 = 0; i3 < si3.numElements; ++i3) {
                  
                  var decoder4 = decoder3.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i3, true);
                  if (decoder4 == null) {
                    values0[i2][i3] = null;
                  } else {
                    var si4 = decoder4.decodeDataHeaderForPointerArray(2);
                    values0[i2][i3] = new List<String>(si4.numElements);
                    for (int i4 = 0; i4 < si4.numElements; ++i4) {
                      
                      values0[i2][i3][i4] = decoder4.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i4, false);
                    }
                  }
                }
              }
            }
          }
        }
        result.f4 = new Map<String, List<List<String>>>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(48, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<List<List<String>>> values0;
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
            values0 = new List<List<List<String>>>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              {
                var si3 = decoder3.decodeDataHeaderForPointerArray(1);
                values0[i2] = new List<List<String>>(si3.numElements);
                for (int i3 = 0; i3 < si3.numElements; ++i3) {
                  
                  var decoder4 = decoder3.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i3, false);
                  {
                    var si4 = decoder4.decodeDataHeaderForPointerArray(2);
                    values0[i2][i3] = new List<String>(si4.numElements);
                    for (int i4 = 0; i4 < si4.numElements; ++i4) {
                      
                      values0[i2][i3][i4] = decoder4.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i4, false);
                    }
                  }
                }
              }
            }
          }
        }
        result.f5 = new Map<String, List<List<String>>>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(56, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<rect_mojom.Rect> values0;
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
            values0 = new List<rect_mojom.Rect>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, true);
              values0[i2] = rect_mojom.Rect.decode(decoder3);
            }
          }
        }
        result.f6 = new Map<String, rect_mojom.Rect>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(64, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<Map<String, String>> values0;
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
            values0 = new List<Map<String, String>>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              {
                decoder3.decodeDataHeaderForMap();
                List<String> keys2;
                List<String> values2;
                {
                  
                  var decoder4 = decoder3.decodePointer(bindings.ArrayDataHeader.kHeaderSize, false);
                  {
                    var si4 = decoder4.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
                    keys2 = new List<String>(si4.numElements);
                    for (int i4 = 0; i4 < si4.numElements; ++i4) {
                      
                      keys2[i4] = decoder4.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i4, false);
                    }
                  }
                }
                {
                  
                  var decoder4 = decoder3.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
                  {
                    var si4 = decoder4.decodeDataHeaderForPointerArray(keys2.length);
                    values2 = new List<String>(si4.numElements);
                    for (int i4 = 0; i4 < si4.numElements; ++i4) {
                      
                      values2[i4] = decoder4.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i4, false);
                    }
                  }
                }
                values0[i2] = new Map<String, String>.fromIterables(
                    keys2, values2);
              }
            }
          }
        }
        result.f7 = new Map<String, Map<String, String>>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(72, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<List<Map<String, String>>> values0;
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
            values0 = new List<List<Map<String, String>>>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              {
                var si3 = decoder3.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
                values0[i2] = new List<Map<String, String>>(si3.numElements);
                for (int i3 = 0; i3 < si3.numElements; ++i3) {
                  
                  var decoder4 = decoder3.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i3, false);
                  {
                    decoder4.decodeDataHeaderForMap();
                    List<String> keys3;
                    List<String> values3;
                    {
                      
                      var decoder5 = decoder4.decodePointer(bindings.ArrayDataHeader.kHeaderSize, false);
                      {
                        var si5 = decoder5.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
                        keys3 = new List<String>(si5.numElements);
                        for (int i5 = 0; i5 < si5.numElements; ++i5) {
                          
                          keys3[i5] = decoder5.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i5, false);
                        }
                      }
                    }
                    {
                      
                      var decoder5 = decoder4.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
                      {
                        var si5 = decoder5.decodeDataHeaderForPointerArray(keys3.length);
                        values3 = new List<String>(si5.numElements);
                        for (int i5 = 0; i5 < si5.numElements; ++i5) {
                          
                          values3[i5] = decoder5.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i5, false);
                        }
                      }
                    }
                    values0[i2][i3] = new Map<String, String>.fromIterables(
                        keys3, values3);
                  }
                }
              }
            }
          }
        }
        result.f8 = new Map<String, List<Map<String, String>>>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(80, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<core.MojoHandle> values0;
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
          
          values0 = decoder1.decodeHandleArray(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
        }
        result.f9 = new Map<String, core.MojoHandle>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(88, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<List<core.MojoHandle>> values0;
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
            values0 = new List<List<core.MojoHandle>>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              values0[i2] = decoder2.decodeHandleArray(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
            }
          }
        }
        result.f10 = new Map<String, List<core.MojoHandle>>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(96, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<Map<String, core.MojoHandle>> values0;
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
            values0 = new List<Map<String, core.MojoHandle>>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              {
                decoder3.decodeDataHeaderForMap();
                List<String> keys2;
                List<core.MojoHandle> values2;
                {
                  
                  var decoder4 = decoder3.decodePointer(bindings.ArrayDataHeader.kHeaderSize, false);
                  {
                    var si4 = decoder4.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
                    keys2 = new List<String>(si4.numElements);
                    for (int i4 = 0; i4 < si4.numElements; ++i4) {
                      
                      keys2[i4] = decoder4.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i4, false);
                    }
                  }
                }
                {
                  
                  values2 = decoder3.decodeHandleArray(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys2.length);
                }
                values0[i2] = new Map<String, core.MojoHandle>.fromIterables(
                    keys2, values2);
              }
            }
          }
        }
        result.f11 = new Map<String, Map<String, core.MojoHandle>>.fromIterables(
            keys0, values0);
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    if (f0 == null) {
      encoder0.encodeNullPointer(8, false);
    } else {
      var encoder1 = encoder0.encoderForMap(8);
      int size0 = f0.length;
      var keys0 = f0.keys.toList();
      var values0 = f0.values.toList();
      
      {
        var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
        for (int i1 = 0; i1 < keys0.length; ++i1) {
          
          encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
      
      {
        var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
        for (int i1 = 0; i1 < values0.length; ++i1) {
          
          if (values0[i1] == null) {
            encoder2.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          } else {
            var encoder3 = encoder2.encodePointerArray(values0[i1].length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kUnspecifiedArrayLength);
            for (int i2 = 0; i2 < values0[i1].length; ++i2) {
              
              encoder3.encodeString(values0[i1][i2], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
            }
          }
        }
      }
    }
    
    if (f1 == null) {
      encoder0.encodeNullPointer(16, false);
    } else {
      var encoder1 = encoder0.encoderForMap(16);
      int size0 = f1.length;
      var keys0 = f1.keys.toList();
      var values0 = f1.values.toList();
      
      {
        var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
        for (int i1 = 0; i1 < keys0.length; ++i1) {
          
          encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
      
      {
        var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
        for (int i1 = 0; i1 < values0.length; ++i1) {
          
          if (values0[i1] == null) {
            encoder2.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, true);
          } else {
            var encoder3 = encoder2.encodePointerArray(values0[i1].length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kUnspecifiedArrayLength);
            for (int i2 = 0; i2 < values0[i1].length; ++i2) {
              
              encoder3.encodeString(values0[i1][i2], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
            }
          }
        }
      }
    }
    
    if (f2 == null) {
      encoder0.encodeNullPointer(24, false);
    } else {
      var encoder1 = encoder0.encoderForMap(24);
      int size0 = f2.length;
      var keys0 = f2.keys.toList();
      var values0 = f2.values.toList();
      
      {
        var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
        for (int i1 = 0; i1 < keys0.length; ++i1) {
          
          encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
      
      {
        var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
        for (int i1 = 0; i1 < values0.length; ++i1) {
          
          if (values0[i1] == null) {
            encoder2.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          } else {
            var encoder3 = encoder2.encodePointerArray(values0[i1].length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kUnspecifiedArrayLength);
            for (int i2 = 0; i2 < values0[i1].length; ++i2) {
              
              encoder3.encodeString(values0[i1][i2], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, true);
            }
          }
        }
      }
    }
    
    if (f3 == null) {
      encoder0.encodeNullPointer(32, false);
    } else {
      var encoder1 = encoder0.encoderForMap(32);
      int size0 = f3.length;
      var keys0 = f3.keys.toList();
      var values0 = f3.values.toList();
      
      {
        var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
        for (int i1 = 0; i1 < keys0.length; ++i1) {
          
          encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
      
      {
        var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
        for (int i1 = 0; i1 < values0.length; ++i1) {
          
          if (values0[i1] == null) {
            encoder2.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          } else {
            var encoder3 = encoder2.encodePointerArray(values0[i1].length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, 2);
            for (int i2 = 0; i2 < values0[i1].length; ++i2) {
              
              encoder3.encodeString(values0[i1][i2], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
            }
          }
        }
      }
    }
    
    if (f4 == null) {
      encoder0.encodeNullPointer(40, false);
    } else {
      var encoder1 = encoder0.encoderForMap(40);
      int size0 = f4.length;
      var keys0 = f4.keys.toList();
      var values0 = f4.values.toList();
      
      {
        var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
        for (int i1 = 0; i1 < keys0.length; ++i1) {
          
          encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
      
      {
        var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
        for (int i1 = 0; i1 < values0.length; ++i1) {
          
          if (values0[i1] == null) {
            encoder2.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          } else {
            var encoder3 = encoder2.encodePointerArray(values0[i1].length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kUnspecifiedArrayLength);
            for (int i2 = 0; i2 < values0[i1].length; ++i2) {
              
              if (values0[i1][i2] == null) {
                encoder3.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, true);
              } else {
                var encoder4 = encoder3.encodePointerArray(values0[i1][i2].length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, 2);
                for (int i3 = 0; i3 < values0[i1][i2].length; ++i3) {
                  
                  encoder4.encodeString(values0[i1][i2][i3], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i3, false);
                }
              }
            }
          }
        }
      }
    }
    
    if (f5 == null) {
      encoder0.encodeNullPointer(48, false);
    } else {
      var encoder1 = encoder0.encoderForMap(48);
      int size0 = f5.length;
      var keys0 = f5.keys.toList();
      var values0 = f5.values.toList();
      
      {
        var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
        for (int i1 = 0; i1 < keys0.length; ++i1) {
          
          encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
      
      {
        var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
        for (int i1 = 0; i1 < values0.length; ++i1) {
          
          if (values0[i1] == null) {
            encoder2.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          } else {
            var encoder3 = encoder2.encodePointerArray(values0[i1].length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, 1);
            for (int i2 = 0; i2 < values0[i1].length; ++i2) {
              
              if (values0[i1][i2] == null) {
                encoder3.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              } else {
                var encoder4 = encoder3.encodePointerArray(values0[i1][i2].length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, 2);
                for (int i3 = 0; i3 < values0[i1][i2].length; ++i3) {
                  
                  encoder4.encodeString(values0[i1][i2][i3], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i3, false);
                }
              }
            }
          }
        }
      }
    }
    
    if (f6 == null) {
      encoder0.encodeNullPointer(56, false);
    } else {
      var encoder1 = encoder0.encoderForMap(56);
      int size0 = f6.length;
      var keys0 = f6.keys.toList();
      var values0 = f6.values.toList();
      
      {
        var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
        for (int i1 = 0; i1 < keys0.length; ++i1) {
          
          encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
      
      {
        var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
        for (int i1 = 0; i1 < values0.length; ++i1) {
          
          encoder2.encodeStruct(values0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, true);
        }
      }
    }
    
    if (f7 == null) {
      encoder0.encodeNullPointer(64, false);
    } else {
      var encoder1 = encoder0.encoderForMap(64);
      int size0 = f7.length;
      var keys0 = f7.keys.toList();
      var values0 = f7.values.toList();
      
      {
        var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
        for (int i1 = 0; i1 < keys0.length; ++i1) {
          
          encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
      
      {
        var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
        for (int i1 = 0; i1 < values0.length; ++i1) {
          
          if (values0[i1] == null) {
            encoder2.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          } else {
            var encoder3 = encoder2.encoderForMap(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1);
            int size2 = values0[i1].length;
            var keys2 = values0[i1].keys.toList();
            var values2 = values0[i1].values.toList();
            
            {
              var encoder4 = encoder3.encodePointerArray(keys2.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
              for (int i3 = 0; i3 < keys2.length; ++i3) {
                
                encoder4.encodeString(keys2[i3], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i3, false);
              }
            }
            
            {
              var encoder4 = encoder3.encodePointerArray(values2.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
              for (int i3 = 0; i3 < values2.length; ++i3) {
                
                encoder4.encodeString(values2[i3], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i3, false);
              }
            }
          }
        }
      }
    }
    
    if (f8 == null) {
      encoder0.encodeNullPointer(72, false);
    } else {
      var encoder1 = encoder0.encoderForMap(72);
      int size0 = f8.length;
      var keys0 = f8.keys.toList();
      var values0 = f8.values.toList();
      
      {
        var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
        for (int i1 = 0; i1 < keys0.length; ++i1) {
          
          encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
      
      {
        var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
        for (int i1 = 0; i1 < values0.length; ++i1) {
          
          if (values0[i1] == null) {
            encoder2.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          } else {
            var encoder3 = encoder2.encodePointerArray(values0[i1].length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kUnspecifiedArrayLength);
            for (int i2 = 0; i2 < values0[i1].length; ++i2) {
              
              if (values0[i1][i2] == null) {
                encoder3.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              } else {
                var encoder4 = encoder3.encoderForMap(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2);
                int size3 = values0[i1][i2].length;
                var keys3 = values0[i1][i2].keys.toList();
                var values3 = values0[i1][i2].values.toList();
                
                {
                  var encoder5 = encoder4.encodePointerArray(keys3.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
                  for (int i4 = 0; i4 < keys3.length; ++i4) {
                    
                    encoder5.encodeString(keys3[i4], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i4, false);
                  }
                }
                
                {
                  var encoder5 = encoder4.encodePointerArray(values3.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
                  for (int i4 = 0; i4 < values3.length; ++i4) {
                    
                    encoder5.encodeString(values3[i4], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i4, false);
                  }
                }
              }
            }
          }
        }
      }
    }
    
    if (f9 == null) {
      encoder0.encodeNullPointer(80, false);
    } else {
      var encoder1 = encoder0.encoderForMap(80);
      int size0 = f9.length;
      var keys0 = f9.keys.toList();
      var values0 = f9.values.toList();
      
      {
        var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
        for (int i1 = 0; i1 < keys0.length; ++i1) {
          
          encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
      
      encoder1.encodeHandleArray(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    
    if (f10 == null) {
      encoder0.encodeNullPointer(88, false);
    } else {
      var encoder1 = encoder0.encoderForMap(88);
      int size0 = f10.length;
      var keys0 = f10.keys.toList();
      var values0 = f10.values.toList();
      
      {
        var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
        for (int i1 = 0; i1 < keys0.length; ++i1) {
          
          encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
      
      {
        var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
        for (int i1 = 0; i1 < values0.length; ++i1) {
          
          encoder2.encodeHandleArray(values0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
      }
    }
    
    if (f11 == null) {
      encoder0.encodeNullPointer(96, false);
    } else {
      var encoder1 = encoder0.encoderForMap(96);
      int size0 = f11.length;
      var keys0 = f11.keys.toList();
      var values0 = f11.values.toList();
      
      {
        var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
        for (int i1 = 0; i1 < keys0.length; ++i1) {
          
          encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
      
      {
        var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
        for (int i1 = 0; i1 < values0.length; ++i1) {
          
          if (values0[i1] == null) {
            encoder2.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          } else {
            var encoder3 = encoder2.encoderForMap(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1);
            int size2 = values0[i1].length;
            var keys2 = values0[i1].keys.toList();
            var values2 = values0[i1].values.toList();
            
            {
              var encoder4 = encoder3.encodePointerArray(keys2.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
              for (int i3 = 0; i3 < keys2.length; ++i3) {
                
                encoder4.encodeString(keys2[i3], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i3, false);
              }
            }
            
            encoder3.encodeHandleArray(values2, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
          }
        }
      }
    }
  }

  String toString() {
    return "MapValueTypes("
           "f0: $f0" ", "
           "f1: $f1" ", "
           "f2: $f2" ", "
           "f3: $f3" ", "
           "f4: $f4" ", "
           "f5: $f5" ", "
           "f6: $f6" ", "
           "f7: $f7" ", "
           "f8: $f8" ", "
           "f9: $f9" ", "
           "f10: $f10" ", "
           "f11: $f11" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

mojom_types.MojomStruct _testStructsMapValueTypes() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'MapValueTypes'
      ..fullIdentifier = 'mojo.test.MapValueTypes')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F0')
        ..type = (new mojom_types.Type()
          ..mapType = (new mojom_types.MapType()
            ..keyType = (new mojom_types.Type()
                    ..stringType = (new mojom_types.StringType()))
            ..valueType = (new mojom_types.Type()
                    ..arrayType = (new mojom_types.ArrayType()
                      ..elementType = (new mojom_types.Type()
                              ..stringType = (new mojom_types.StringType())))))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F1')
        ..type = (new mojom_types.Type()
          ..mapType = (new mojom_types.MapType()
            ..keyType = (new mojom_types.Type()
                    ..stringType = (new mojom_types.StringType()))
            ..valueType = (new mojom_types.Type()
                    ..arrayType = (new mojom_types.ArrayType()
                      ..nullable = true
                      ..elementType = (new mojom_types.Type()
                              ..stringType = (new mojom_types.StringType())))))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F2')
        ..type = (new mojom_types.Type()
          ..mapType = (new mojom_types.MapType()
            ..keyType = (new mojom_types.Type()
                    ..stringType = (new mojom_types.StringType()))
            ..valueType = (new mojom_types.Type()
                    ..arrayType = (new mojom_types.ArrayType()
                      ..elementType = (new mojom_types.Type()
                              ..stringType = (new mojom_types.StringType()
                                ..nullable = true
                              )))))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F3')
        ..type = (new mojom_types.Type()
          ..mapType = (new mojom_types.MapType()
            ..keyType = (new mojom_types.Type()
                    ..stringType = (new mojom_types.StringType()))
            ..valueType = (new mojom_types.Type()
                    ..arrayType = (new mojom_types.ArrayType()
                      ..fixedLength = 2
                      ..elementType = (new mojom_types.Type()
                              ..stringType = (new mojom_types.StringType())))))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F4')
        ..type = (new mojom_types.Type()
          ..mapType = (new mojom_types.MapType()
            ..keyType = (new mojom_types.Type()
                    ..stringType = (new mojom_types.StringType()))
            ..valueType = (new mojom_types.Type()
                    ..arrayType = (new mojom_types.ArrayType()
                      ..elementType = (new mojom_types.Type()
                              ..arrayType = (new mojom_types.ArrayType()
                                ..nullable = true
                                ..fixedLength = 2
                                ..elementType = (new mojom_types.Type()
                                        ..stringType = (new mojom_types.StringType())))))))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F5')
        ..type = (new mojom_types.Type()
          ..mapType = (new mojom_types.MapType()
            ..keyType = (new mojom_types.Type()
                    ..stringType = (new mojom_types.StringType()))
            ..valueType = (new mojom_types.Type()
                    ..arrayType = (new mojom_types.ArrayType()
                      ..fixedLength = 1
                      ..elementType = (new mojom_types.Type()
                              ..arrayType = (new mojom_types.ArrayType()
                                ..fixedLength = 2
                                ..elementType = (new mojom_types.Type()
                                        ..stringType = (new mojom_types.StringType())))))))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F6')
        ..type = (new mojom_types.Type()
          ..mapType = (new mojom_types.MapType()
            ..keyType = (new mojom_types.Type()
                    ..stringType = (new mojom_types.StringType()))
            ..valueType = (new mojom_types.Type()
                    ..typeReference = (new mojom_types.TypeReference()
                    ..nullable = true
                  
                    ..identifier = 'rect_Rect__'
                    ..typeKey = 'rect_Rect__'
                  )))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F7')
        ..type = (new mojom_types.Type()
          ..mapType = (new mojom_types.MapType()
            ..keyType = (new mojom_types.Type()
                    ..stringType = (new mojom_types.StringType()))
            ..valueType = (new mojom_types.Type()
                    ..mapType = (new mojom_types.MapType()
                      ..keyType = (new mojom_types.Type()
                              ..stringType = (new mojom_types.StringType()))
                      ..valueType = (new mojom_types.Type()
                              ..stringType = (new mojom_types.StringType())))))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F8')
        ..type = (new mojom_types.Type()
          ..mapType = (new mojom_types.MapType()
            ..keyType = (new mojom_types.Type()
                    ..stringType = (new mojom_types.StringType()))
            ..valueType = (new mojom_types.Type()
                    ..arrayType = (new mojom_types.ArrayType()
                      ..elementType = (new mojom_types.Type()
                              ..mapType = (new mojom_types.MapType()
                                ..keyType = (new mojom_types.Type()
                                        ..stringType = (new mojom_types.StringType()))
                                ..valueType = (new mojom_types.Type()
                                        ..stringType = (new mojom_types.StringType())))))))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F9')
        ..type = (new mojom_types.Type()
          ..mapType = (new mojom_types.MapType()
            ..keyType = (new mojom_types.Type()
                    ..stringType = (new mojom_types.StringType()))
            ..valueType = (new mojom_types.Type()
                    ..handleType = (new mojom_types.HandleType()
                      ..kind = mojom_types.HandleTypeKind.unspecified)))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F10')
        ..type = (new mojom_types.Type()
          ..mapType = (new mojom_types.MapType()
            ..keyType = (new mojom_types.Type()
                    ..stringType = (new mojom_types.StringType()))
            ..valueType = (new mojom_types.Type()
                    ..arrayType = (new mojom_types.ArrayType()
                      ..elementType = (new mojom_types.Type()
                              ..handleType = (new mojom_types.HandleType()
                                ..kind = mojom_types.HandleTypeKind.unspecified)))))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F11')
        ..type = (new mojom_types.Type()
          ..mapType = (new mojom_types.MapType()
            ..keyType = (new mojom_types.Type()
                    ..stringType = (new mojom_types.StringType()))
            ..valueType = (new mojom_types.Type()
                    ..mapType = (new mojom_types.MapType()
                      ..keyType = (new mojom_types.Type()
                              ..stringType = (new mojom_types.StringType()))
                      ..valueType = (new mojom_types.Type()
                              ..handleType = (new mojom_types.HandleType()
                                ..kind = mojom_types.HandleTypeKind.unspecified)))))),];
}


class ArrayValueTypes extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(56, 0)
  ];
  List<int> f0 = null;
  List<int> f1 = null;
  List<int> f2 = null;
  List<int> f3 = null;
  List<double> f4 = null;
  List<double> f5 = null;

  ArrayValueTypes() : super(kVersions.last.size);

  static ArrayValueTypes deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ArrayValueTypes decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ArrayValueTypes result = new ArrayValueTypes();

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
      
      result.f0 = decoder0.decodeInt8Array(8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f1 = decoder0.decodeInt16Array(16, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f2 = decoder0.decodeInt32Array(24, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f3 = decoder0.decodeInt64Array(32, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f4 = decoder0.decodeFloatArray(40, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f5 = decoder0.decodeDoubleArray(48, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInt8Array(f0, 8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    
    encoder0.encodeInt16Array(f1, 16, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    
    encoder0.encodeInt32Array(f2, 24, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    
    encoder0.encodeInt64Array(f3, 32, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    
    encoder0.encodeFloatArray(f4, 40, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    
    encoder0.encodeDoubleArray(f5, 48, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
  }

  String toString() {
    return "ArrayValueTypes("
           "f0: $f0" ", "
           "f1: $f1" ", "
           "f2: $f2" ", "
           "f3: $f3" ", "
           "f4: $f4" ", "
           "f5: $f5" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["f0"] = f0;
    map["f1"] = f1;
    map["f2"] = f2;
    map["f3"] = f3;
    map["f4"] = f4;
    map["f5"] = f5;
    return map;
  }
}

mojom_types.MojomStruct _testStructsArrayValueTypes() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'ArrayValueTypes'
      ..fullIdentifier = 'mojo.test.ArrayValueTypes')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F0')
        ..type = (new mojom_types.Type()
          ..arrayType = (new mojom_types.ArrayType()
            ..elementType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.int8))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F1')
        ..type = (new mojom_types.Type()
          ..arrayType = (new mojom_types.ArrayType()
            ..elementType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.int16))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F2')
        ..type = (new mojom_types.Type()
          ..arrayType = (new mojom_types.ArrayType()
            ..elementType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.int32))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F3')
        ..type = (new mojom_types.Type()
          ..arrayType = (new mojom_types.ArrayType()
            ..elementType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.int64))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F4')
        ..type = (new mojom_types.Type()
          ..arrayType = (new mojom_types.ArrayType()
            ..elementType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.float))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F5')
        ..type = (new mojom_types.Type()
          ..arrayType = (new mojom_types.ArrayType()
            ..elementType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.double))),];
}


class FloatNumberValues extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(72, 0)
  ];
  static const double v0 = double.INFINITY;
  static const double v1 = double.NEGATIVE_INFINITY;
  static const double v2 = double.NAN;
  static const double v3 = double.INFINITY;
  static const double v4 = double.NEGATIVE_INFINITY;
  static const double v5 = double.NAN;
  static const double v6 = 0.0;
  static const double v7 = 1234567890.123;
  static const double v8 = 1.2e+20;
  static const double v9 = -1.2e+20;
  double f0 = double.INFINITY;
  double f1 = double.NEGATIVE_INFINITY;
  double f2 = double.NAN;
  double f3 = double.INFINITY;
  double f4 = double.NEGATIVE_INFINITY;
  double f5 = double.NAN;
  double f6 = 0.0;
  double f7 = 1234567890.123;
  double f8 = 1.2e+20;
  double f9 = -1.2e+20;

  FloatNumberValues() : super(kVersions.last.size);

  static FloatNumberValues deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FloatNumberValues decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FloatNumberValues result = new FloatNumberValues();

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
      
      result.f0 = decoder0.decodeDouble(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f1 = decoder0.decodeDouble(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f2 = decoder0.decodeDouble(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f3 = decoder0.decodeFloat(32);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f4 = decoder0.decodeFloat(36);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f5 = decoder0.decodeFloat(40);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f6 = decoder0.decodeFloat(44);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f7 = decoder0.decodeDouble(48);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f8 = decoder0.decodeDouble(56);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f9 = decoder0.decodeDouble(64);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeDouble(f0, 8);
    
    encoder0.encodeDouble(f1, 16);
    
    encoder0.encodeDouble(f2, 24);
    
    encoder0.encodeFloat(f3, 32);
    
    encoder0.encodeFloat(f4, 36);
    
    encoder0.encodeFloat(f5, 40);
    
    encoder0.encodeFloat(f6, 44);
    
    encoder0.encodeDouble(f7, 48);
    
    encoder0.encodeDouble(f8, 56);
    
    encoder0.encodeDouble(f9, 64);
  }

  String toString() {
    return "FloatNumberValues("
           "f0: $f0" ", "
           "f1: $f1" ", "
           "f2: $f2" ", "
           "f3: $f3" ", "
           "f4: $f4" ", "
           "f5: $f5" ", "
           "f6: $f6" ", "
           "f7: $f7" ", "
           "f8: $f8" ", "
           "f9: $f9" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["f0"] = f0;
    map["f1"] = f1;
    map["f2"] = f2;
    map["f3"] = f3;
    map["f4"] = f4;
    map["f5"] = f5;
    map["f6"] = f6;
    map["f7"] = f7;
    map["f8"] = f8;
    map["f9"] = f9;
    return map;
  }
}

mojom_types.MojomStruct _testStructsFloatNumberValues() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'FloatNumberValues'
      ..fullIdentifier = 'mojo.test.FloatNumberValues')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F0')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.double),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F1')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.double),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F2')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.double),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F3')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.float),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F4')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.float),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F5')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.float),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F6')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.float),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F7')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.double),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F8')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.double),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F9')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.double),];
}


class IntegerNumberValues extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(88, 0)
  ];
  static const int v0 = -128;
  static const int v1 = -1;
  static const int v2 = 0;
  static const int v3 = 42;
  static const int v4 = 127;
  static const int v5 = -32768;
  static const int v6 = -1;
  static const int v7 = 0;
  static const int v8 = 12345;
  static const int v9 = 32767;
  static const int v10 = -2147483648;
  static const int v11 = -1;
  static const int v12 = 0;
  static const int v13 = 1234567890;
  static const int v14 = 2147483647;
  static const int v15 = -9007199254740991;
  static const int v16 = -1;
  static const int v17 = 0;
  static const int v18 = 1234567890123456;
  static const int v19 = 9007199254740991;
  int f0 = -128;
  int f1 = -1;
  int f2 = 0;
  int f3 = 42;
  int f4 = 127;
  int f5 = -32768;
  int f6 = -1;
  int f7 = 0;
  int f8 = 12345;
  int f9 = 32767;
  int f10 = -2147483648;
  int f11 = -1;
  int f12 = 0;
  int f13 = 1234567890;
  int f14 = 2147483647;
  int f15 = -9007199254740991;
  int f16 = -1;
  int f17 = 0;
  int f18 = 1234567890123456;
  int f19 = 9007199254740991;

  IntegerNumberValues() : super(kVersions.last.size);

  static IntegerNumberValues deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static IntegerNumberValues decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    IntegerNumberValues result = new IntegerNumberValues();

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
      
      result.f0 = decoder0.decodeInt8(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f1 = decoder0.decodeInt8(9);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f2 = decoder0.decodeInt8(10);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f3 = decoder0.decodeInt8(11);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f4 = decoder0.decodeInt8(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f5 = decoder0.decodeInt16(14);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f6 = decoder0.decodeInt16(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f7 = decoder0.decodeInt16(18);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f8 = decoder0.decodeInt16(20);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f9 = decoder0.decodeInt16(22);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f10 = decoder0.decodeInt32(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f11 = decoder0.decodeInt32(28);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f12 = decoder0.decodeInt32(32);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f13 = decoder0.decodeInt32(36);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f14 = decoder0.decodeInt32(40);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f15 = decoder0.decodeInt64(48);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f16 = decoder0.decodeInt64(56);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f17 = decoder0.decodeInt64(64);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f18 = decoder0.decodeInt64(72);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f19 = decoder0.decodeInt64(80);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInt8(f0, 8);
    
    encoder0.encodeInt8(f1, 9);
    
    encoder0.encodeInt8(f2, 10);
    
    encoder0.encodeInt8(f3, 11);
    
    encoder0.encodeInt8(f4, 12);
    
    encoder0.encodeInt16(f5, 14);
    
    encoder0.encodeInt16(f6, 16);
    
    encoder0.encodeInt16(f7, 18);
    
    encoder0.encodeInt16(f8, 20);
    
    encoder0.encodeInt16(f9, 22);
    
    encoder0.encodeInt32(f10, 24);
    
    encoder0.encodeInt32(f11, 28);
    
    encoder0.encodeInt32(f12, 32);
    
    encoder0.encodeInt32(f13, 36);
    
    encoder0.encodeInt32(f14, 40);
    
    encoder0.encodeInt64(f15, 48);
    
    encoder0.encodeInt64(f16, 56);
    
    encoder0.encodeInt64(f17, 64);
    
    encoder0.encodeInt64(f18, 72);
    
    encoder0.encodeInt64(f19, 80);
  }

  String toString() {
    return "IntegerNumberValues("
           "f0: $f0" ", "
           "f1: $f1" ", "
           "f2: $f2" ", "
           "f3: $f3" ", "
           "f4: $f4" ", "
           "f5: $f5" ", "
           "f6: $f6" ", "
           "f7: $f7" ", "
           "f8: $f8" ", "
           "f9: $f9" ", "
           "f10: $f10" ", "
           "f11: $f11" ", "
           "f12: $f12" ", "
           "f13: $f13" ", "
           "f14: $f14" ", "
           "f15: $f15" ", "
           "f16: $f16" ", "
           "f17: $f17" ", "
           "f18: $f18" ", "
           "f19: $f19" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["f0"] = f0;
    map["f1"] = f1;
    map["f2"] = f2;
    map["f3"] = f3;
    map["f4"] = f4;
    map["f5"] = f5;
    map["f6"] = f6;
    map["f7"] = f7;
    map["f8"] = f8;
    map["f9"] = f9;
    map["f10"] = f10;
    map["f11"] = f11;
    map["f12"] = f12;
    map["f13"] = f13;
    map["f14"] = f14;
    map["f15"] = f15;
    map["f16"] = f16;
    map["f17"] = f17;
    map["f18"] = f18;
    map["f19"] = f19;
    return map;
  }
}

mojom_types.MojomStruct _testStructsIntegerNumberValues() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'IntegerNumberValues'
      ..fullIdentifier = 'mojo.test.IntegerNumberValues')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F0')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int8),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F1')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int8),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F2')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int8),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F3')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int8),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F4')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int8),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F5')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int16),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F6')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int16),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F7')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int16),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F8')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int16),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F9')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int16),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F10')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int32),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F11')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int32),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F12')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int32),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F13')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int32),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F14')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int32),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F15')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int64),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F16')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int64),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F17')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int64),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F18')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int64),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F19')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int64),];
}


class UnsignedNumberValues extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(56, 0)
  ];
  static const int v0 = 0;
  static const int v1 = 42;
  static const int v2 = 255;
  static const int v3 = 0;
  static const int v4 = 12345;
  static const int v5 = 65535;
  static const int v6 = 0;
  static const int v7 = 1234567890;
  static const int v8 = 4294967295;
  static const int v9 = 0;
  static const int v10 = 1234567890123456;
  static const int v11 = 9007199254740991;
  int f0 = 0;
  int f1 = 42;
  int f2 = 255;
  int f3 = 0;
  int f4 = 12345;
  int f5 = 65535;
  int f6 = 0;
  int f7 = 1234567890;
  int f8 = 4294967295;
  int f9 = 0;
  int f10 = 1234567890123456;
  int f11 = 9007199254740991;

  UnsignedNumberValues() : super(kVersions.last.size);

  static UnsignedNumberValues deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UnsignedNumberValues decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UnsignedNumberValues result = new UnsignedNumberValues();

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
      
      result.f0 = decoder0.decodeUint8(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f1 = decoder0.decodeUint8(9);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f2 = decoder0.decodeUint8(10);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f3 = decoder0.decodeUint16(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f4 = decoder0.decodeUint16(14);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f5 = decoder0.decodeUint16(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f6 = decoder0.decodeUint32(20);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f7 = decoder0.decodeUint32(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f8 = decoder0.decodeUint32(28);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f9 = decoder0.decodeUint64(32);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f10 = decoder0.decodeUint64(40);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f11 = decoder0.decodeUint64(48);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint8(f0, 8);
    
    encoder0.encodeUint8(f1, 9);
    
    encoder0.encodeUint8(f2, 10);
    
    encoder0.encodeUint16(f3, 12);
    
    encoder0.encodeUint16(f4, 14);
    
    encoder0.encodeUint16(f5, 16);
    
    encoder0.encodeUint32(f6, 20);
    
    encoder0.encodeUint32(f7, 24);
    
    encoder0.encodeUint32(f8, 28);
    
    encoder0.encodeUint64(f9, 32);
    
    encoder0.encodeUint64(f10, 40);
    
    encoder0.encodeUint64(f11, 48);
  }

  String toString() {
    return "UnsignedNumberValues("
           "f0: $f0" ", "
           "f1: $f1" ", "
           "f2: $f2" ", "
           "f3: $f3" ", "
           "f4: $f4" ", "
           "f5: $f5" ", "
           "f6: $f6" ", "
           "f7: $f7" ", "
           "f8: $f8" ", "
           "f9: $f9" ", "
           "f10: $f10" ", "
           "f11: $f11" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["f0"] = f0;
    map["f1"] = f1;
    map["f2"] = f2;
    map["f3"] = f3;
    map["f4"] = f4;
    map["f5"] = f5;
    map["f6"] = f6;
    map["f7"] = f7;
    map["f8"] = f8;
    map["f9"] = f9;
    map["f10"] = f10;
    map["f11"] = f11;
    return map;
  }
}

mojom_types.MojomStruct _testStructsUnsignedNumberValues() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'UnsignedNumberValues'
      ..fullIdentifier = 'mojo.test.UnsignedNumberValues')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F0')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.uint8),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F1')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.uint8),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F2')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.uint8),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F3')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.uint16),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F4')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.uint16),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F5')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.uint16),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F6')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.uint32),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F7')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.uint32),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F8')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.uint32),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F9')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.uint64),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F10')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.uint64),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F11')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.uint64),];
}


class BitArrayValues extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(64, 0)
  ];
  List<bool> f0 = null;
  List<bool> f1 = null;
  List<bool> f2 = null;
  List<bool> f3 = null;
  List<List<bool>> f4 = null;
  List<List<bool>> f5 = null;
  List<List<bool>> f6 = null;

  BitArrayValues() : super(kVersions.last.size);

  static BitArrayValues deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static BitArrayValues decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    BitArrayValues result = new BitArrayValues();

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
      
      result.f0 = decoder0.decodeBoolArray(8, bindings.kNothingNullable, 1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f1 = decoder0.decodeBoolArray(16, bindings.kNothingNullable, 7);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f2 = decoder0.decodeBoolArray(24, bindings.kNothingNullable, 9);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f3 = decoder0.decodeBoolArray(32, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(40, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.f4 = new List<List<bool>>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.f4[i1] = decoder1.decodeBoolArray(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(48, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.f5 = new List<List<bool>>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.f5[i1] = decoder1.decodeBoolArray(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(56, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.f6 = new List<List<bool>>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.f6[i1] = decoder1.decodeBoolArray(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kArrayNullable, 2);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeBoolArray(f0, 8, bindings.kNothingNullable, 1);
    
    encoder0.encodeBoolArray(f1, 16, bindings.kNothingNullable, 7);
    
    encoder0.encodeBoolArray(f2, 24, bindings.kNothingNullable, 9);
    
    encoder0.encodeBoolArray(f3, 32, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    
    if (f4 == null) {
      encoder0.encodeNullPointer(40, false);
    } else {
      var encoder1 = encoder0.encodePointerArray(f4.length, 40, bindings.kUnspecifiedArrayLength);
      for (int i0 = 0; i0 < f4.length; ++i0) {
        
        encoder1.encodeBoolArray(f4[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      }
    }
    
    if (f5 == null) {
      encoder0.encodeNullPointer(48, false);
    } else {
      var encoder1 = encoder0.encodePointerArray(f5.length, 48, bindings.kUnspecifiedArrayLength);
      for (int i0 = 0; i0 < f5.length; ++i0) {
        
        encoder1.encodeBoolArray(f5[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
      }
    }
    
    if (f6 == null) {
      encoder0.encodeNullPointer(56, false);
    } else {
      var encoder1 = encoder0.encodePointerArray(f6.length, 56, bindings.kUnspecifiedArrayLength);
      for (int i0 = 0; i0 < f6.length; ++i0) {
        
        encoder1.encodeBoolArray(f6[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, bindings.kArrayNullable, 2);
      }
    }
  }

  String toString() {
    return "BitArrayValues("
           "f0: $f0" ", "
           "f1: $f1" ", "
           "f2: $f2" ", "
           "f3: $f3" ", "
           "f4: $f4" ", "
           "f5: $f5" ", "
           "f6: $f6" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["f0"] = f0;
    map["f1"] = f1;
    map["f2"] = f2;
    map["f3"] = f3;
    map["f4"] = f4;
    map["f5"] = f5;
    map["f6"] = f6;
    return map;
  }
}

mojom_types.MojomStruct _testStructsBitArrayValues() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'BitArrayValues'
      ..fullIdentifier = 'mojo.test.BitArrayValues')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F0')
        ..type = (new mojom_types.Type()
          ..arrayType = (new mojom_types.ArrayType()
            ..fixedLength = 1
            ..elementType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.bool))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F1')
        ..type = (new mojom_types.Type()
          ..arrayType = (new mojom_types.ArrayType()
            ..fixedLength = 7
            ..elementType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.bool))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F2')
        ..type = (new mojom_types.Type()
          ..arrayType = (new mojom_types.ArrayType()
            ..fixedLength = 9
            ..elementType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.bool))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F3')
        ..type = (new mojom_types.Type()
          ..arrayType = (new mojom_types.ArrayType()
            ..elementType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.bool))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F4')
        ..type = (new mojom_types.Type()
          ..arrayType = (new mojom_types.ArrayType()
            ..elementType = (new mojom_types.Type()
                    ..arrayType = (new mojom_types.ArrayType()
                      ..elementType = (new mojom_types.Type()
                              ..simpleType = mojom_types.SimpleType.bool))))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F5')
        ..type = (new mojom_types.Type()
          ..arrayType = (new mojom_types.ArrayType()
            ..elementType = (new mojom_types.Type()
                    ..arrayType = (new mojom_types.ArrayType()
                      ..nullable = true
                      ..elementType = (new mojom_types.Type()
                              ..simpleType = mojom_types.SimpleType.bool))))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'F6')
        ..type = (new mojom_types.Type()
          ..arrayType = (new mojom_types.ArrayType()
            ..elementType = (new mojom_types.Type()
                    ..arrayType = (new mojom_types.ArrayType()
                      ..nullable = true
                      ..fixedLength = 2
                      ..elementType = (new mojom_types.Type()
                              ..simpleType = mojom_types.SimpleType.bool))))),];
}


class MultiVersionStruct extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0),
    const bindings.StructDataHeader(24, 1),
    const bindings.StructDataHeader(32, 3),
    const bindings.StructDataHeader(40, 5),
    const bindings.StructDataHeader(48, 7),
    const bindings.StructDataHeader(48, 9)
  ];
  int fInt32 = 0;
  core.MojoMessagePipeEndpoint fMessagePipe = null;
  rect_mojom.Rect fRect = null;
  String fString = null;
  List<int> fArray = null;
  bool fBool = false;
  int fInt16 = 0;

  MultiVersionStruct() : super(kVersions.last.size);

  static MultiVersionStruct deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MultiVersionStruct decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MultiVersionStruct result = new MultiVersionStruct();

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
      
      result.fInt32 = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 7) {
      
      result.fMessagePipe = decoder0.decodeMessagePipeHandle(12, true);
    }
    if (mainDataHeader.version >= 1) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.fRect = rect_mojom.Rect.decode(decoder1);
    }
    if (mainDataHeader.version >= 3) {
      
      result.fString = decoder0.decodeString(24, true);
    }
    if (mainDataHeader.version >= 5) {
      
      result.fArray = decoder0.decodeInt8Array(32, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 7) {
      
      result.fBool = decoder0.decodeBool(40, 0);
    }
    if (mainDataHeader.version >= 9) {
      
      result.fInt16 = decoder0.decodeInt16(42);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInt32(fInt32, 8);
    
    encoder0.encodeMessagePipeHandle(fMessagePipe, 12, true);
    
    encoder0.encodeStruct(fRect, 16, true);
    
    encoder0.encodeString(fString, 24, true);
    
    encoder0.encodeInt8Array(fArray, 32, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    
    encoder0.encodeBool(fBool, 40, 0);
    
    encoder0.encodeInt16(fInt16, 42);
  }

  String toString() {
    return "MultiVersionStruct("
           "fInt32: $fInt32" ", "
           "fMessagePipe: $fMessagePipe" ", "
           "fRect: $fRect" ", "
           "fString: $fString" ", "
           "fArray: $fArray" ", "
           "fBool: $fBool" ", "
           "fInt16: $fInt16" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

mojom_types.MojomStruct _testStructsMultiVersionStruct() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'MultiVersionStruct'
      ..fullIdentifier = 'mojo.test.MultiVersionStruct')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'FInt32')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int32),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'FRect')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..nullable = true
        
          ..identifier = 'rect_Rect__'
          ..typeKey = 'rect_Rect__'
        )),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'FString')
        ..type = (new mojom_types.Type()
          ..stringType = (new mojom_types.StringType()
            ..nullable = true
          )),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'FArray')
        ..type = (new mojom_types.Type()
          ..arrayType = (new mojom_types.ArrayType()
            ..nullable = true
            ..elementType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.int8))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'FMessagePipe')
        ..type = (new mojom_types.Type()
          ..handleType = (new mojom_types.HandleType()
            ..kind = mojom_types.HandleTypeKind.messagePipe
            ..nullable = true
          )),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'FBool')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.bool),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'FInt16')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int16),];
}


class MultiVersionStructV0 extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int fInt32 = 0;

  MultiVersionStructV0() : super(kVersions.last.size);

  static MultiVersionStructV0 deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MultiVersionStructV0 decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MultiVersionStructV0 result = new MultiVersionStructV0();

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
      
      result.fInt32 = decoder0.decodeInt32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInt32(fInt32, 8);
  }

  String toString() {
    return "MultiVersionStructV0("
           "fInt32: $fInt32" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["fInt32"] = fInt32;
    return map;
  }
}

mojom_types.MojomStruct _testStructsMultiVersionStructV0() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'MultiVersionStructV0'
      ..fullIdentifier = 'mojo.test.MultiVersionStructV0')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'FInt32')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int32),];
}


class MultiVersionStructV1 extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0),
    const bindings.StructDataHeader(24, 1)
  ];
  int fInt32 = 0;
  rect_mojom.Rect fRect = null;

  MultiVersionStructV1() : super(kVersions.last.size);

  static MultiVersionStructV1 deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MultiVersionStructV1 decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MultiVersionStructV1 result = new MultiVersionStructV1();

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
      
      result.fInt32 = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 1) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.fRect = rect_mojom.Rect.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInt32(fInt32, 8);
    
    encoder0.encodeStruct(fRect, 16, true);
  }

  String toString() {
    return "MultiVersionStructV1("
           "fInt32: $fInt32" ", "
           "fRect: $fRect" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["fInt32"] = fInt32;
    map["fRect"] = fRect;
    return map;
  }
}

mojom_types.MojomStruct _testStructsMultiVersionStructV1() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'MultiVersionStructV1'
      ..fullIdentifier = 'mojo.test.MultiVersionStructV1')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'FInt32')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int32),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'FRect')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..nullable = true
        
          ..identifier = 'rect_Rect__'
          ..typeKey = 'rect_Rect__'
        )),];
}


class MultiVersionStructV3 extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0),
    const bindings.StructDataHeader(24, 1),
    const bindings.StructDataHeader(32, 3)
  ];
  int fInt32 = 0;
  rect_mojom.Rect fRect = null;
  String fString = null;

  MultiVersionStructV3() : super(kVersions.last.size);

  static MultiVersionStructV3 deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MultiVersionStructV3 decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MultiVersionStructV3 result = new MultiVersionStructV3();

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
      
      result.fInt32 = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 1) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.fRect = rect_mojom.Rect.decode(decoder1);
    }
    if (mainDataHeader.version >= 3) {
      
      result.fString = decoder0.decodeString(24, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInt32(fInt32, 8);
    
    encoder0.encodeStruct(fRect, 16, true);
    
    encoder0.encodeString(fString, 24, true);
  }

  String toString() {
    return "MultiVersionStructV3("
           "fInt32: $fInt32" ", "
           "fRect: $fRect" ", "
           "fString: $fString" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["fInt32"] = fInt32;
    map["fRect"] = fRect;
    map["fString"] = fString;
    return map;
  }
}

mojom_types.MojomStruct _testStructsMultiVersionStructV3() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'MultiVersionStructV3'
      ..fullIdentifier = 'mojo.test.MultiVersionStructV3')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'FInt32')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int32),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'FRect')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..nullable = true
        
          ..identifier = 'rect_Rect__'
          ..typeKey = 'rect_Rect__'
        )),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'FString')
        ..type = (new mojom_types.Type()
          ..stringType = (new mojom_types.StringType()
            ..nullable = true
          )),];
}


class MultiVersionStructV5 extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0),
    const bindings.StructDataHeader(24, 1),
    const bindings.StructDataHeader(32, 3),
    const bindings.StructDataHeader(40, 5)
  ];
  int fInt32 = 0;
  rect_mojom.Rect fRect = null;
  String fString = null;
  List<int> fArray = null;

  MultiVersionStructV5() : super(kVersions.last.size);

  static MultiVersionStructV5 deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MultiVersionStructV5 decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MultiVersionStructV5 result = new MultiVersionStructV5();

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
      
      result.fInt32 = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 1) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.fRect = rect_mojom.Rect.decode(decoder1);
    }
    if (mainDataHeader.version >= 3) {
      
      result.fString = decoder0.decodeString(24, true);
    }
    if (mainDataHeader.version >= 5) {
      
      result.fArray = decoder0.decodeInt8Array(32, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInt32(fInt32, 8);
    
    encoder0.encodeStruct(fRect, 16, true);
    
    encoder0.encodeString(fString, 24, true);
    
    encoder0.encodeInt8Array(fArray, 32, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
  }

  String toString() {
    return "MultiVersionStructV5("
           "fInt32: $fInt32" ", "
           "fRect: $fRect" ", "
           "fString: $fString" ", "
           "fArray: $fArray" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["fInt32"] = fInt32;
    map["fRect"] = fRect;
    map["fString"] = fString;
    map["fArray"] = fArray;
    return map;
  }
}

mojom_types.MojomStruct _testStructsMultiVersionStructV5() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'MultiVersionStructV5'
      ..fullIdentifier = 'mojo.test.MultiVersionStructV5')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'FInt32')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int32),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'FRect')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..nullable = true
        
          ..identifier = 'rect_Rect__'
          ..typeKey = 'rect_Rect__'
        )),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'FString')
        ..type = (new mojom_types.Type()
          ..stringType = (new mojom_types.StringType()
            ..nullable = true
          )),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'FArray')
        ..type = (new mojom_types.Type()
          ..arrayType = (new mojom_types.ArrayType()
            ..nullable = true
            ..elementType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.int8))),];
}


class MultiVersionStructV7 extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0),
    const bindings.StructDataHeader(24, 1),
    const bindings.StructDataHeader(32, 3),
    const bindings.StructDataHeader(40, 5),
    const bindings.StructDataHeader(48, 7)
  ];
  int fInt32 = 0;
  core.MojoMessagePipeEndpoint fMessagePipe = null;
  rect_mojom.Rect fRect = null;
  String fString = null;
  List<int> fArray = null;
  bool fBool = false;

  MultiVersionStructV7() : super(kVersions.last.size);

  static MultiVersionStructV7 deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MultiVersionStructV7 decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MultiVersionStructV7 result = new MultiVersionStructV7();

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
      
      result.fInt32 = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 7) {
      
      result.fMessagePipe = decoder0.decodeMessagePipeHandle(12, true);
    }
    if (mainDataHeader.version >= 1) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.fRect = rect_mojom.Rect.decode(decoder1);
    }
    if (mainDataHeader.version >= 3) {
      
      result.fString = decoder0.decodeString(24, true);
    }
    if (mainDataHeader.version >= 5) {
      
      result.fArray = decoder0.decodeInt8Array(32, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 7) {
      
      result.fBool = decoder0.decodeBool(40, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInt32(fInt32, 8);
    
    encoder0.encodeMessagePipeHandle(fMessagePipe, 12, true);
    
    encoder0.encodeStruct(fRect, 16, true);
    
    encoder0.encodeString(fString, 24, true);
    
    encoder0.encodeInt8Array(fArray, 32, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    
    encoder0.encodeBool(fBool, 40, 0);
  }

  String toString() {
    return "MultiVersionStructV7("
           "fInt32: $fInt32" ", "
           "fMessagePipe: $fMessagePipe" ", "
           "fRect: $fRect" ", "
           "fString: $fString" ", "
           "fArray: $fArray" ", "
           "fBool: $fBool" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

mojom_types.MojomStruct _testStructsMultiVersionStructV7() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'MultiVersionStructV7'
      ..fullIdentifier = 'mojo.test.MultiVersionStructV7')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'FInt32')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int32),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'FRect')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..nullable = true
        
          ..identifier = 'rect_Rect__'
          ..typeKey = 'rect_Rect__'
        )),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'FString')
        ..type = (new mojom_types.Type()
          ..stringType = (new mojom_types.StringType()
            ..nullable = true
          )),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'FArray')
        ..type = (new mojom_types.Type()
          ..arrayType = (new mojom_types.ArrayType()
            ..nullable = true
            ..elementType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.int8))),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'FMessagePipe')
        ..type = (new mojom_types.Type()
          ..handleType = (new mojom_types.HandleType()
            ..kind = mojom_types.HandleTypeKind.messagePipe
            ..nullable = true
          )),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'FBool')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.bool),];
}


class ContainsInterface extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object someInterface = null;

  ContainsInterface() : super(kVersions.last.size);

  static ContainsInterface deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ContainsInterface decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ContainsInterface result = new ContainsInterface();

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
      
      result.someInterface = decoder0.decodeServiceInterface(8, false, SomeInterfaceProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInterface(someInterface, 8, false);
  }

  String toString() {
    return "ContainsInterface("
           "someInterface: $someInterface" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

mojom_types.MojomStruct _testStructsContainsInterface() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'ContainsInterface'
      ..fullIdentifier = 'mojo.test.ContainsInterface')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'SomeInterface')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..identifier = 'test_structs_SomeInterface__'
          ..typeKey = 'test_structs_SomeInterface__'
        )),];
}


class ContainsOther extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int other = 0;

  ContainsOther() : super(kVersions.last.size);

  static ContainsOther deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ContainsOther decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ContainsOther result = new ContainsOther();

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
      
      result.other = decoder0.decodeInt32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInt32(other, 8);
  }

  String toString() {
    return "ContainsOther("
           "other: $other" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["other"] = other;
    return map;
  }
}

mojom_types.MojomStruct _testStructsContainsOther() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'ContainsOther'
      ..fullIdentifier = 'mojo.test.ContainsOther')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Other')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int32),];
}


class ContainsInterfaceRequest extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object req = null;
  Object nullableReq = null;

  ContainsInterfaceRequest() : super(kVersions.last.size);

  static ContainsInterfaceRequest deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ContainsInterfaceRequest decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ContainsInterfaceRequest result = new ContainsInterfaceRequest();

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
      
      result.req = decoder0.decodeInterfaceRequest(8, false, SomeInterfaceStub.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.nullableReq = decoder0.decodeInterfaceRequest(12, true, SomeInterfaceStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInterfaceRequest(req, 8, false);
    
    encoder0.encodeInterfaceRequest(nullableReq, 12, true);
  }

  String toString() {
    return "ContainsInterfaceRequest("
           "req: $req" ", "
           "nullableReq: $nullableReq" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

mojom_types.MojomStruct _testStructsContainsInterfaceRequest() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'ContainsInterfaceRequest'
      ..fullIdentifier = 'mojo.test.ContainsInterfaceRequest')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Req')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..isInterfaceRequest = true
          ..identifier = 'test_structs_SomeInterface__'
          ..typeKey = 'test_structs_SomeInterface__'
        )),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'NullableReq')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..nullable = true
        
          ..isInterfaceRequest = true
          ..identifier = 'test_structs_SomeInterface__'
          ..typeKey = 'test_structs_SomeInterface__'
        )),];
}


class DartKeywordStructKeywords extends bindings.MojoEnum {
  static const DartKeywordStructKeywords await_ = const DartKeywordStructKeywords._(0);
  static const DartKeywordStructKeywords is_ = const DartKeywordStructKeywords._(1);
  static const DartKeywordStructKeywords rethrow_ = const DartKeywordStructKeywords._(2);

  const DartKeywordStructKeywords._(int v) : super(v);

  static const Map<String, DartKeywordStructKeywords> valuesMap = const {
    "await_": await_,
    "is_": is_,
    "rethrow_": rethrow_,
  };
  static const List<DartKeywordStructKeywords> values = const [
    await_,
    is_,
    rethrow_,
  ];

  static DartKeywordStructKeywords valueOf(String name) => valuesMap[name];

  factory DartKeywordStructKeywords(int v) {
    switch (v) {
      case 0:
        return await_;
      case 1:
        return is_;
      case 2:
        return rethrow_;
      default:
        return null;
    }
  }

  static DartKeywordStructKeywords decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    DartKeywordStructKeywords result = new DartKeywordStructKeywords(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum DartKeywordStructKeywords.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case await_:
        return 'DartKeywordStructKeywords.await_';
      case is_:
        return 'DartKeywordStructKeywords.is_';
      case rethrow_:
        return 'DartKeywordStructKeywords.rethrow_';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

mojom_types.MojomEnum _testStructsKeywords() {
  return new mojom_types.MojomEnum()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'Keywords'
      ..fullIdentifier = 'mojo.test.Keywords')
    ..values = <mojom_types.EnumValue>[
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Await')
        ..enumTypeKey = 'test_structs_Keywords__'
        ..intValue = 0,
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Is')
        ..enumTypeKey = 'test_structs_Keywords__'
        ..intValue = 1,
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Rethrow')
        ..enumTypeKey = 'test_structs_Keywords__'
        ..intValue = 2,];
}

class DartKeywordStruct extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  DartKeywordStructKeywords await_ = null;
  DartKeywordStructKeywords is_ = null;
  DartKeywordStructKeywords rethrow_ = null;

  DartKeywordStruct() : super(kVersions.last.size);

  static DartKeywordStruct deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static DartKeywordStruct decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    DartKeywordStruct result = new DartKeywordStruct();

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
      
        result.await_ = DartKeywordStructKeywords.decode(decoder0, 8);
        if (result.await_ == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable DartKeywordStructKeywords.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
        result.is_ = DartKeywordStructKeywords.decode(decoder0, 12);
        if (result.is_ == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable DartKeywordStructKeywords.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
        result.rethrow_ = DartKeywordStructKeywords.decode(decoder0, 16);
        if (result.rethrow_ == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable DartKeywordStructKeywords.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(await_, 8);
    
    encoder0.encodeEnum(is_, 12);
    
    encoder0.encodeEnum(rethrow_, 16);
  }

  String toString() {
    return "DartKeywordStruct("
           "await_: $await_" ", "
           "is_: $is_" ", "
           "rethrow_: $rethrow_" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["await_"] = await_;
    map["is_"] = is_;
    map["rethrow_"] = rethrow_;
    return map;
  }
}

mojom_types.MojomStruct _testStructsDartKeywordStruct() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'DartKeywordStruct'
      ..fullIdentifier = 'mojo.test.DartKeywordStruct')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Await')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..identifier = 'test_structs_Keywords__'
          ..typeKey = 'test_structs_Keywords__'
        )),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Is')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..identifier = 'test_structs_Keywords__'
          ..typeKey = 'test_structs_Keywords__'
        )),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Rethrow')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..identifier = 'test_structs_Keywords__'
          ..typeKey = 'test_structs_Keywords__'
        )),];
}


class _SomeInterfaceSomeMethodParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  RectPair pair = null;

  _SomeInterfaceSomeMethodParams() : super(kVersions.last.size);

  static _SomeInterfaceSomeMethodParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SomeInterfaceSomeMethodParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SomeInterfaceSomeMethodParams result = new _SomeInterfaceSomeMethodParams();

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
      result.pair = RectPair.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(pair, 8, false);
  }

  String toString() {
    return "_SomeInterfaceSomeMethodParams("
           "pair: $pair" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["pair"] = pair;
    return map;
  }
}

mojom_types.MojomStruct _testStructsSomeInterfaceSomeMethodParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'SomeInterfaceSomeMethodParams'
      ..fullIdentifier = 'mojo.test.SomeInterface_SomeMethod_Params')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Pair')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..identifier = 'test_structs_RectPair__'
          ..typeKey = 'test_structs_RectPair__'
        )),];
}


class SomeInterfaceSomeMethodResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  RectPair otherPair = null;

  SomeInterfaceSomeMethodResponseParams() : super(kVersions.last.size);

  static SomeInterfaceSomeMethodResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SomeInterfaceSomeMethodResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SomeInterfaceSomeMethodResponseParams result = new SomeInterfaceSomeMethodResponseParams();

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
      result.otherPair = RectPair.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(otherPair, 8, false);
  }

  String toString() {
    return "SomeInterfaceSomeMethodResponseParams("
           "otherPair: $otherPair" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["otherPair"] = otherPair;
    return map;
  }
}

mojom_types.MojomStruct _testStructsSomeInterfaceSomeMethodResponseParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'SomeInterfaceSomeMethodResponseParams'
      ..fullIdentifier = 'mojo.test.SomeInterface_SomeMethod_ResponseParams')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'OtherPair')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..identifier = 'test_structs_RectPair__'
          ..typeKey = 'test_structs_RectPair__'
        )),];
}



enum UnionOfStructsTag {
  nr,
  aNr,
  aRp,
  mNdfv,
  mHs,
  unknown
}

class UnionOfStructs extends bindings.Union {
  static final _tag_to_int = const {
    UnionOfStructsTag.nr: 0,
    UnionOfStructsTag.aNr: 1,
    UnionOfStructsTag.aRp: 2,
    UnionOfStructsTag.mNdfv: 3,
    UnionOfStructsTag.mHs: 4,
  };

  static final _int_to_tag = const {
    0: UnionOfStructsTag.nr,
    1: UnionOfStructsTag.aNr,
    2: UnionOfStructsTag.aRp,
    3: UnionOfStructsTag.mNdfv,
    4: UnionOfStructsTag.mHs,
  };

  var _data;
  UnionOfStructsTag _tag = UnionOfStructsTag.unknown;

  UnionOfStructsTag get tag => _tag;
  NamedRegion get nr {
    if (_tag != UnionOfStructsTag.nr) {
      throw new bindings.UnsetUnionTagError(_tag, UnionOfStructsTag.nr);
    }
    return _data;
  }

  set nr(NamedRegion value) {
    _tag = UnionOfStructsTag.nr;
    _data = value;
  }
  List<NamedRegion> get aNr {
    if (_tag != UnionOfStructsTag.aNr) {
      throw new bindings.UnsetUnionTagError(_tag, UnionOfStructsTag.aNr);
    }
    return _data;
  }

  set aNr(List<NamedRegion> value) {
    _tag = UnionOfStructsTag.aNr;
    _data = value;
  }
  List<RectPair> get aRp {
    if (_tag != UnionOfStructsTag.aRp) {
      throw new bindings.UnsetUnionTagError(_tag, UnionOfStructsTag.aRp);
    }
    return _data;
  }

  set aRp(List<RectPair> value) {
    _tag = UnionOfStructsTag.aRp;
    _data = value;
  }
  Map<int, NoDefaultFieldValues> get mNdfv {
    if (_tag != UnionOfStructsTag.mNdfv) {
      throw new bindings.UnsetUnionTagError(_tag, UnionOfStructsTag.mNdfv);
    }
    return _data;
  }

  set mNdfv(Map<int, NoDefaultFieldValues> value) {
    _tag = UnionOfStructsTag.mNdfv;
    _data = value;
  }
  Map<int, HandleStruct> get mHs {
    if (_tag != UnionOfStructsTag.mHs) {
      throw new bindings.UnsetUnionTagError(_tag, UnionOfStructsTag.mHs);
    }
    return _data;
  }

  set mHs(Map<int, HandleStruct> value) {
    _tag = UnionOfStructsTag.mHs;
    _data = value;
  }

  static UnionOfStructs decode(bindings.Decoder decoder0, int offset) {
    int size = decoder0.decodeUint32(offset);
    if (size == 0) {
      return null;
    }
    UnionOfStructs result = new UnionOfStructs();

    // TODO(azani): Handle unknown union member.
    UnionOfStructsTag tag = _int_to_tag[decoder0.decodeUint32(offset + 4)];
    switch (tag) {
      case UnionOfStructsTag.nr:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        result.nr = NamedRegion.decode(decoder1);
        break;
      case UnionOfStructsTag.aNr:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        {
          var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
          result.aNr = new List<NamedRegion>(si1.numElements);
          for (int i1 = 0; i1 < si1.numElements; ++i1) {
            
            var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
            result.aNr[i1] = NamedRegion.decode(decoder2);
          }
        }
        break;
      case UnionOfStructsTag.aRp:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        {
          var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
          result.aRp = new List<RectPair>(si1.numElements);
          for (int i1 = 0; i1 < si1.numElements; ++i1) {
            
            var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
            result.aRp[i1] = RectPair.decode(decoder2);
          }
        }
        break;
      case UnionOfStructsTag.mNdfv:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        {
          decoder1.decodeDataHeaderForMap();
          List<int> keys0;
          List<NoDefaultFieldValues> values0;
          {
            
            keys0 = decoder1.decodeInt64Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
          }
          {
            
            var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
            {
              var si2 = decoder2.decodeDataHeaderForPointerArray(keys0.length);
              values0 = new List<NoDefaultFieldValues>(si2.numElements);
              for (int i2 = 0; i2 < si2.numElements; ++i2) {
                
                var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
                values0[i2] = NoDefaultFieldValues.decode(decoder3);
              }
            }
          }
          result.mNdfv = new Map<int, NoDefaultFieldValues>.fromIterables(
              keys0, values0);
        }
        break;
      case UnionOfStructsTag.mHs:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        {
          decoder1.decodeDataHeaderForMap();
          List<int> keys0;
          List<HandleStruct> values0;
          {
            
            keys0 = decoder1.decodeInt64Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
          }
          {
            
            var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
            {
              var si2 = decoder2.decodeDataHeaderForPointerArray(keys0.length);
              values0 = new List<HandleStruct>(si2.numElements);
              for (int i2 = 0; i2 < si2.numElements; ++i2) {
                
                var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
                values0[i2] = HandleStruct.decode(decoder3);
              }
            }
          }
          result.mHs = new Map<int, HandleStruct>.fromIterables(
              keys0, values0);
        }
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $tag");
    }

    return result;
  }

  void encode(bindings.Encoder encoder0, int offset) {
    // TODO(azani): Error when trying to encode an unknown member.
    encoder0.encodeUint32(16, offset);
    encoder0.encodeUint32(_tag_to_int[_tag], offset + 4);
    switch (_tag) {
      case UnionOfStructsTag.nr:
        
        encoder0.encodeStruct(nr, offset + 8, false);
        break;
      case UnionOfStructsTag.aNr:
        
        if (aNr == null) {
          encoder0.encodeNullPointer(offset + 8, false);
        } else {
          var encoder1 = encoder0.encodePointerArray(aNr.length, offset + 8, bindings.kUnspecifiedArrayLength);
          for (int i0 = 0; i0 < aNr.length; ++i0) {
            
            encoder1.encodeStruct(aNr[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
          }
        }
        break;
      case UnionOfStructsTag.aRp:
        
        if (aRp == null) {
          encoder0.encodeNullPointer(offset + 8, false);
        } else {
          var encoder1 = encoder0.encodePointerArray(aRp.length, offset + 8, bindings.kUnspecifiedArrayLength);
          for (int i0 = 0; i0 < aRp.length; ++i0) {
            
            encoder1.encodeStruct(aRp[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
          }
        }
        break;
      case UnionOfStructsTag.mNdfv:
        
        if (mNdfv == null) {
          encoder0.encodeNullPointer(offset + 8, false);
        } else {
          var encoder1 = encoder0.encoderForMap(offset + 8);
          int size0 = mNdfv.length;
          var keys0 = mNdfv.keys.toList();
          var values0 = mNdfv.values.toList();
          
          encoder1.encodeInt64Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
          
          {
            var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
            for (int i1 = 0; i1 < values0.length; ++i1) {
              
              encoder2.encodeStruct(values0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
            }
          }
        }
        break;
      case UnionOfStructsTag.mHs:
        
        if (mHs == null) {
          encoder0.encodeNullPointer(offset + 8, false);
        } else {
          var encoder1 = encoder0.encoderForMap(offset + 8);
          int size0 = mHs.length;
          var keys0 = mHs.keys.toList();
          var values0 = mHs.values.toList();
          
          encoder1.encodeInt64Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
          
          {
            var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
            for (int i1 = 0; i1 < values0.length; ++i1) {
              
              encoder2.encodeStruct(values0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
            }
          }
        }
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $_tag");
    }
  }

  String toString() {
    String result = "UnionOfStructs(";
    switch (_tag) {
      case UnionOfStructsTag.nr:
        result += "nr";
        break;
      case UnionOfStructsTag.aNr:
        result += "aNr";
        break;
      case UnionOfStructsTag.aRp:
        result += "aRp";
        break;
      case UnionOfStructsTag.mNdfv:
        result += "mNdfv";
        break;
      case UnionOfStructsTag.mHs:
        result += "mHs";
        break;
      default:
        result += "unknown";
    }
    result += ": $_data)";
    return result;
  }
}

mojom_types.MojomUnion _testStructsUnionOfStructs() {
  return new mojom_types.MojomUnion()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'UnionOfStructs'
      ..fullIdentifier = 'mojo.test.UnionOfStructs')
    ..fields = <mojom_types.UnionField>[
      new mojom_types.UnionField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Nr')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..identifier = 'test_structs_NamedRegion__'
          ..typeKey = 'test_structs_NamedRegion__'
        ))
        ..tag = 0,
      new mojom_types.UnionField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'ANr')
        ..type = (new mojom_types.Type()
          ..arrayType = (new mojom_types.ArrayType()
            ..elementType = (new mojom_types.Type()
                    ..typeReference = (new mojom_types.TypeReference()
                    ..identifier = 'test_structs_NamedRegion__'
                    ..typeKey = 'test_structs_NamedRegion__'
                  ))))
        ..tag = 1,
      new mojom_types.UnionField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'ARp')
        ..type = (new mojom_types.Type()
          ..arrayType = (new mojom_types.ArrayType()
            ..elementType = (new mojom_types.Type()
                    ..typeReference = (new mojom_types.TypeReference()
                    ..identifier = 'test_structs_RectPair__'
                    ..typeKey = 'test_structs_RectPair__'
                  ))))
        ..tag = 2,
      new mojom_types.UnionField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'MNdfv')
        ..type = (new mojom_types.Type()
          ..mapType = (new mojom_types.MapType()
            ..keyType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.int64)
            ..valueType = (new mojom_types.Type()
                    ..typeReference = (new mojom_types.TypeReference()
                    ..identifier = 'test_structs_NoDefaultFieldValues__'
                    ..typeKey = 'test_structs_NoDefaultFieldValues__'
                  ))))
        ..tag = 3,
      new mojom_types.UnionField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'MHs')
        ..type = (new mojom_types.Type()
          ..mapType = (new mojom_types.MapType()
            ..keyType = (new mojom_types.Type()
                    ..simpleType = mojom_types.SimpleType.int64)
            ..valueType = (new mojom_types.Type()
                    ..typeReference = (new mojom_types.TypeReference()
                    ..identifier = 'test_structs_HandleStruct__'
                    ..typeKey = 'test_structs_HandleStruct__'
                  ))))
        ..tag = 4,];
}

const int _SomeInterface_someMethodName = 0;

mojom_types.MojomInterface _testStructsSomeInterface() {
  return new mojom_types.MojomInterface()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'SomeInterface'
      ..fullIdentifier = 'mojo.test.SomeInterface')
    ..interfaceName = 'SomeInterface'
    ..methods = <int, mojom_types.MojomMethod>{
      _SomeInterface_someMethodName: new mojom_types.MojomMethod()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'SomeMethod')
        ..ordinal = _SomeInterface_someMethodName
        ..responseParams = _testStructsSomeInterfaceSomeMethodResponseParams()
        ..parameters = _testStructsSomeInterfaceSomeMethodParams(),
    };
}

class _SomeInterfaceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      _testStructsSomeInterface();

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      getAllMojomTypeDefinitions()[typeKey];

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      getAllMojomTypeDefinitions();
}

abstract class SomeInterface {
  static const String serviceName = null;
  dynamic someMethod(RectPair pair,[Function responseFactory = null]);
}


class _SomeInterfaceProxyImpl extends bindings.Proxy {
  _SomeInterfaceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _SomeInterfaceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _SomeInterfaceProxyImpl.unbound() : super.unbound();

  static _SomeInterfaceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _SomeInterfaceProxyImpl"));
    return new _SomeInterfaceProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _SomeInterfaceServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _SomeInterface_someMethodName:
        var r = SomeInterfaceSomeMethodResponseParams.deserialize(
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
    return "_SomeInterfaceProxyImpl($superString)";
  }
}


class _SomeInterfaceProxyCalls implements SomeInterface {
  _SomeInterfaceProxyImpl _proxyImpl;

  _SomeInterfaceProxyCalls(this._proxyImpl);
    dynamic someMethod(RectPair pair,[Function responseFactory = null]) {
      var params = new _SomeInterfaceSomeMethodParams();
      params.pair = pair;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _SomeInterface_someMethodName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class SomeInterfaceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  SomeInterface ptr;

  SomeInterfaceProxy(_SomeInterfaceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _SomeInterfaceProxyCalls(proxyImpl);

  SomeInterfaceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _SomeInterfaceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _SomeInterfaceProxyCalls(impl);
  }

  SomeInterfaceProxy.fromHandle(core.MojoHandle handle) :
      impl = new _SomeInterfaceProxyImpl.fromHandle(handle) {
    ptr = new _SomeInterfaceProxyCalls(impl);
  }

  SomeInterfaceProxy.unbound() :
      impl = new _SomeInterfaceProxyImpl.unbound() {
    ptr = new _SomeInterfaceProxyCalls(impl);
  }

  factory SomeInterfaceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    SomeInterfaceProxy p = new SomeInterfaceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static SomeInterfaceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SomeInterfaceProxy"));
    return new SomeInterfaceProxy.fromEndpoint(endpoint);
  }

  String get serviceName => SomeInterface.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "SomeInterfaceProxy($impl)";
  }
}


class SomeInterfaceStub extends bindings.Stub {
  SomeInterface _impl = null;

  SomeInterfaceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  SomeInterfaceStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  SomeInterfaceStub.unbound() : super.unbound();

  static SomeInterfaceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SomeInterfaceStub"));
    return new SomeInterfaceStub.fromEndpoint(endpoint);
  }


  SomeInterfaceSomeMethodResponseParams _SomeInterfaceSomeMethodResponseParamsFactory(RectPair otherPair) {
    var mojo_factory_result = new SomeInterfaceSomeMethodResponseParams();
    mojo_factory_result.otherPair = otherPair;
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
      case _SomeInterface_someMethodName:
        var params = _SomeInterfaceSomeMethodParams.deserialize(
            message.payload);
        var response = _impl.someMethod(params.pair,_SomeInterfaceSomeMethodResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _SomeInterface_someMethodName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _SomeInterface_someMethodName,
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

  SomeInterface get impl => _impl;
  set impl(SomeInterface d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "SomeInterfaceStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _SomeInterfaceServiceDescription();
}


Map<String, mojom_types.UserDefinedType> _initDescriptions() {
  var map = new HashMap<String, mojom_types.UserDefinedType>();
  map["test_structs_StructOfStructs__"] =
    new mojom_types.UserDefinedType()
      ..structType = _testStructsStructOfStructs();
  map["test_structs_NamedRegion__"] =
    new mojom_types.UserDefinedType()
      ..structType = _testStructsNamedRegion();
  map["test_structs_RectPair__"] =
    new mojom_types.UserDefinedType()
      ..structType = _testStructsRectPair();
  map["test_structs_EmptyStruct__"] =
    new mojom_types.UserDefinedType()
      ..structType = _testStructsEmptyStruct();
  map["test_structs_HandleStruct__"] =
    new mojom_types.UserDefinedType()
      ..structType = _testStructsHandleStruct();
  map["test_structs_NullableHandleStruct__"] =
    new mojom_types.UserDefinedType()
      ..structType = _testStructsNullableHandleStruct();
  map["test_structs_NoDefaultFieldValues__"] =
    new mojom_types.UserDefinedType()
      ..structType = _testStructsNoDefaultFieldValues();
  map["test_structs_DefaultFieldValues__"] =
    new mojom_types.UserDefinedType()
      ..structType = _testStructsDefaultFieldValues();
  map["test_structs_ScopedConstants__"] =
    new mojom_types.UserDefinedType()
      ..structType = _testStructsScopedConstants();
    map["test_structs_EType__"] =
    new mojom_types.UserDefinedType()
      ..enumType = _testStructsEType();
  map["test_structs_MapKeyTypes__"] =
    new mojom_types.UserDefinedType()
      ..structType = _testStructsMapKeyTypes();
  map["test_structs_MapValueTypes__"] =
    new mojom_types.UserDefinedType()
      ..structType = _testStructsMapValueTypes();
  map["test_structs_ArrayValueTypes__"] =
    new mojom_types.UserDefinedType()
      ..structType = _testStructsArrayValueTypes();
  map["test_structs_FloatNumberValues__"] =
    new mojom_types.UserDefinedType()
      ..structType = _testStructsFloatNumberValues();
  map["test_structs_IntegerNumberValues__"] =
    new mojom_types.UserDefinedType()
      ..structType = _testStructsIntegerNumberValues();
  map["test_structs_UnsignedNumberValues__"] =
    new mojom_types.UserDefinedType()
      ..structType = _testStructsUnsignedNumberValues();
  map["test_structs_BitArrayValues__"] =
    new mojom_types.UserDefinedType()
      ..structType = _testStructsBitArrayValues();
  map["test_structs_MultiVersionStruct__"] =
    new mojom_types.UserDefinedType()
      ..structType = _testStructsMultiVersionStruct();
  map["test_structs_MultiVersionStructV0__"] =
    new mojom_types.UserDefinedType()
      ..structType = _testStructsMultiVersionStructV0();
  map["test_structs_MultiVersionStructV1__"] =
    new mojom_types.UserDefinedType()
      ..structType = _testStructsMultiVersionStructV1();
  map["test_structs_MultiVersionStructV3__"] =
    new mojom_types.UserDefinedType()
      ..structType = _testStructsMultiVersionStructV3();
  map["test_structs_MultiVersionStructV5__"] =
    new mojom_types.UserDefinedType()
      ..structType = _testStructsMultiVersionStructV5();
  map["test_structs_MultiVersionStructV7__"] =
    new mojom_types.UserDefinedType()
      ..structType = _testStructsMultiVersionStructV7();
  map["test_structs_ContainsInterface__"] =
    new mojom_types.UserDefinedType()
      ..structType = _testStructsContainsInterface();
  map["test_structs_ContainsOther__"] =
    new mojom_types.UserDefinedType()
      ..structType = _testStructsContainsOther();
  map["test_structs_ContainsInterfaceRequest__"] =
    new mojom_types.UserDefinedType()
      ..structType = _testStructsContainsInterfaceRequest();
  map["test_structs_DartKeywordStruct__"] =
    new mojom_types.UserDefinedType()
      ..structType = _testStructsDartKeywordStruct();
    map["test_structs_Keywords__"] =
    new mojom_types.UserDefinedType()
      ..enumType = _testStructsKeywords();
  map["test_structs_SomeInterface_SomeMethod_Params__"] =
    new mojom_types.UserDefinedType()
      ..structType = _testStructsSomeInterfaceSomeMethodParams();
  map["test_structs_SomeInterface_SomeMethod_ResponseParams__"] =
    new mojom_types.UserDefinedType()
      ..structType = _testStructsSomeInterfaceSomeMethodResponseParams();
  map["test_structs_UnionOfStructs__"] =
    new mojom_types.UserDefinedType()
      ..unionType = _testStructsUnionOfStructs();
  map["test_structs_SomeInterface__"] =
    new mojom_types.UserDefinedType()
      ..interfaceType = _testStructsSomeInterface();
  rect_mojom.getAllMojomTypeDefinitions()
      .forEach((String s, mojom_types.UserDefinedType udt) {
    map[s] = udt;
  });

  return map;
}

var _mojomDesc;
Map<String, mojom_types.UserDefinedType> getAllMojomTypeDefinitions() {
  if (_mojomDesc == null) {
    _mojomDesc = _initDescriptions();
  }
  return _mojomDesc;
}

