// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library sample_interfaces_mojom;

import 'dart:async';
import 'dart:collection';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
const int kLong = 4405;

class Enum extends bindings.MojoEnum {
  static const Enum value = const Enum._(0);

  const Enum._(int v) : super(v);

  static const Map<String, Enum> valuesMap = const {
    "value": value,
  };
  static const List<Enum> values = const [
    value,
  ];

  static Enum valueOf(String name) => valuesMap[name];

  factory Enum(int v) {
    switch (v) {
      case 0:
        return value;
      default:
        return null;
    }
  }

  static Enum decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    Enum result = new Enum(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum Enum.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case value:
        return 'Enum.value';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

mojom_types.MojomEnum _sampleInterfacesEnum() {
  return new mojom_types.MojomEnum()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'Enum'
      ..fullIdentifier = 'sample.Enum')
    ..values = <mojom_types.EnumValue>[
      new mojom_types.EnumValue()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Value')
        ..enumTypeKey = 'sample_interfaces_Enum__'
        ..intValue = 0,];
}



class _ProviderEchoStringParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String a = null;

  _ProviderEchoStringParams() : super(kVersions.last.size);

  static _ProviderEchoStringParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ProviderEchoStringParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ProviderEchoStringParams result = new _ProviderEchoStringParams();

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
      
      result.a = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(a, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a of struct _ProviderEchoStringParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ProviderEchoStringParams("
           "a: $a" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["a"] = a;
    return map;
  }
}

mojom_types.MojomStruct _sampleInterfacesProviderEchoStringParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'ProviderEchoStringParams'
      ..fullIdentifier = 'sample.Provider_EchoString_Params')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'A')
        ..type = (new mojom_types.Type()
          ..stringType = (new mojom_types.StringType())),];
}


class ProviderEchoStringResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String a = null;

  ProviderEchoStringResponseParams() : super(kVersions.last.size);

  static ProviderEchoStringResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ProviderEchoStringResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ProviderEchoStringResponseParams result = new ProviderEchoStringResponseParams();

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
      
      result.a = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(a, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a of struct ProviderEchoStringResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "ProviderEchoStringResponseParams("
           "a: $a" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["a"] = a;
    return map;
  }
}

mojom_types.MojomStruct _sampleInterfacesProviderEchoStringResponseParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'ProviderEchoStringResponseParams'
      ..fullIdentifier = 'sample.Provider_EchoString_ResponseParams')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'A')
        ..type = (new mojom_types.Type()
          ..stringType = (new mojom_types.StringType())),];
}


class _ProviderEchoStringsParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String a = null;
  String b = null;

  _ProviderEchoStringsParams() : super(kVersions.last.size);

  static _ProviderEchoStringsParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ProviderEchoStringsParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ProviderEchoStringsParams result = new _ProviderEchoStringsParams();

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
      
      result.a = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.b = decoder0.decodeString(16, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(a, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a of struct _ProviderEchoStringsParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(b, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "b of struct _ProviderEchoStringsParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ProviderEchoStringsParams("
           "a: $a" ", "
           "b: $b" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["a"] = a;
    map["b"] = b;
    return map;
  }
}

mojom_types.MojomStruct _sampleInterfacesProviderEchoStringsParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'ProviderEchoStringsParams'
      ..fullIdentifier = 'sample.Provider_EchoStrings_Params')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'A')
        ..type = (new mojom_types.Type()
          ..stringType = (new mojom_types.StringType())),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'B')
        ..type = (new mojom_types.Type()
          ..stringType = (new mojom_types.StringType())),];
}


class ProviderEchoStringsResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String a = null;
  String b = null;

  ProviderEchoStringsResponseParams() : super(kVersions.last.size);

  static ProviderEchoStringsResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ProviderEchoStringsResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ProviderEchoStringsResponseParams result = new ProviderEchoStringsResponseParams();

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
      
      result.a = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.b = decoder0.decodeString(16, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(a, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a of struct ProviderEchoStringsResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(b, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "b of struct ProviderEchoStringsResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "ProviderEchoStringsResponseParams("
           "a: $a" ", "
           "b: $b" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["a"] = a;
    map["b"] = b;
    return map;
  }
}

mojom_types.MojomStruct _sampleInterfacesProviderEchoStringsResponseParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'ProviderEchoStringsResponseParams'
      ..fullIdentifier = 'sample.Provider_EchoStrings_ResponseParams')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'A')
        ..type = (new mojom_types.Type()
          ..stringType = (new mojom_types.StringType())),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'B')
        ..type = (new mojom_types.Type()
          ..stringType = (new mojom_types.StringType())),];
}


class _ProviderEchoMessagePipeHandleParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  core.MojoMessagePipeEndpoint a = null;

  _ProviderEchoMessagePipeHandleParams() : super(kVersions.last.size);

  static _ProviderEchoMessagePipeHandleParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ProviderEchoMessagePipeHandleParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ProviderEchoMessagePipeHandleParams result = new _ProviderEchoMessagePipeHandleParams();

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
      
      result.a = decoder0.decodeMessagePipeHandle(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeMessagePipeHandle(a, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a of struct _ProviderEchoMessagePipeHandleParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ProviderEchoMessagePipeHandleParams("
           "a: $a" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

mojom_types.MojomStruct _sampleInterfacesProviderEchoMessagePipeHandleParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'ProviderEchoMessagePipeHandleParams'
      ..fullIdentifier = 'sample.Provider_EchoMessagePipeHandle_Params')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'A')
        ..type = (new mojom_types.Type()
          ..handleType = (new mojom_types.HandleType()
            ..kind = mojom_types.HandleTypeKind.messagePipe)),];
}


class ProviderEchoMessagePipeHandleResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  core.MojoMessagePipeEndpoint a = null;

  ProviderEchoMessagePipeHandleResponseParams() : super(kVersions.last.size);

  static ProviderEchoMessagePipeHandleResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ProviderEchoMessagePipeHandleResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ProviderEchoMessagePipeHandleResponseParams result = new ProviderEchoMessagePipeHandleResponseParams();

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
      
      result.a = decoder0.decodeMessagePipeHandle(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeMessagePipeHandle(a, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a of struct ProviderEchoMessagePipeHandleResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "ProviderEchoMessagePipeHandleResponseParams("
           "a: $a" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

mojom_types.MojomStruct _sampleInterfacesProviderEchoMessagePipeHandleResponseParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'ProviderEchoMessagePipeHandleResponseParams'
      ..fullIdentifier = 'sample.Provider_EchoMessagePipeHandle_ResponseParams')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'A')
        ..type = (new mojom_types.Type()
          ..handleType = (new mojom_types.HandleType()
            ..kind = mojom_types.HandleTypeKind.messagePipe)),];
}


class _ProviderEchoEnumParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Enum a = null;

  _ProviderEchoEnumParams() : super(kVersions.last.size);

  static _ProviderEchoEnumParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ProviderEchoEnumParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ProviderEchoEnumParams result = new _ProviderEchoEnumParams();

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
      
        result.a = Enum.decode(decoder0, 8);
        if (result.a == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable Enum.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(a, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a of struct _ProviderEchoEnumParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ProviderEchoEnumParams("
           "a: $a" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["a"] = a;
    return map;
  }
}

mojom_types.MojomStruct _sampleInterfacesProviderEchoEnumParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'ProviderEchoEnumParams'
      ..fullIdentifier = 'sample.Provider_EchoEnum_Params')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'A')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..identifier = 'sample_interfaces_Enum__'
          ..typeKey = 'sample_interfaces_Enum__'
        )),];
}


class ProviderEchoEnumResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Enum a = null;

  ProviderEchoEnumResponseParams() : super(kVersions.last.size);

  static ProviderEchoEnumResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ProviderEchoEnumResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ProviderEchoEnumResponseParams result = new ProviderEchoEnumResponseParams();

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
      
        result.a = Enum.decode(decoder0, 8);
        if (result.a == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable Enum.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(a, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a of struct ProviderEchoEnumResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "ProviderEchoEnumResponseParams("
           "a: $a" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["a"] = a;
    return map;
  }
}

mojom_types.MojomStruct _sampleInterfacesProviderEchoEnumResponseParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'ProviderEchoEnumResponseParams'
      ..fullIdentifier = 'sample.Provider_EchoEnum_ResponseParams')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'A')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..identifier = 'sample_interfaces_Enum__'
          ..typeKey = 'sample_interfaces_Enum__'
        )),];
}


class _ProviderEchoIntParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int a = 0;

  _ProviderEchoIntParams() : super(kVersions.last.size);

  static _ProviderEchoIntParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ProviderEchoIntParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ProviderEchoIntParams result = new _ProviderEchoIntParams();

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
      
      result.a = decoder0.decodeInt32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(a, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a of struct _ProviderEchoIntParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ProviderEchoIntParams("
           "a: $a" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["a"] = a;
    return map;
  }
}

mojom_types.MojomStruct _sampleInterfacesProviderEchoIntParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'ProviderEchoIntParams'
      ..fullIdentifier = 'sample.Provider_EchoInt_Params')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'A')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int32),];
}


class ProviderEchoIntResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int a = 0;

  ProviderEchoIntResponseParams() : super(kVersions.last.size);

  static ProviderEchoIntResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ProviderEchoIntResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ProviderEchoIntResponseParams result = new ProviderEchoIntResponseParams();

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
      
      result.a = decoder0.decodeInt32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(a, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a of struct ProviderEchoIntResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "ProviderEchoIntResponseParams("
           "a: $a" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["a"] = a;
    return map;
  }
}

mojom_types.MojomStruct _sampleInterfacesProviderEchoIntResponseParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'ProviderEchoIntResponseParams'
      ..fullIdentifier = 'sample.Provider_EchoInt_ResponseParams')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'A')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int32),];
}


class _IntegerAccessorGetIntegerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _IntegerAccessorGetIntegerParams() : super(kVersions.last.size);

  static _IntegerAccessorGetIntegerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _IntegerAccessorGetIntegerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _IntegerAccessorGetIntegerParams result = new _IntegerAccessorGetIntegerParams();

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
    return "_IntegerAccessorGetIntegerParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

mojom_types.MojomStruct _sampleInterfacesIntegerAccessorGetIntegerParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'IntegerAccessorGetIntegerParams'
      ..fullIdentifier = 'sample.IntegerAccessor_GetInteger_Params')
    ..fields = <mojom_types.StructField>[];
}


class IntegerAccessorGetIntegerResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0),
    const bindings.StructDataHeader(24, 2)
  ];
  int data = 0;
  Enum type = null;

  IntegerAccessorGetIntegerResponseParams() : super(kVersions.last.size);

  static IntegerAccessorGetIntegerResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static IntegerAccessorGetIntegerResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    IntegerAccessorGetIntegerResponseParams result = new IntegerAccessorGetIntegerResponseParams();

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
      
      result.data = decoder0.decodeInt64(8);
    }
    if (mainDataHeader.version >= 2) {
      
        result.type = Enum.decode(decoder0, 16);
        if (result.type == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable Enum.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt64(data, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "data of struct IntegerAccessorGetIntegerResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(type, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "type of struct IntegerAccessorGetIntegerResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "IntegerAccessorGetIntegerResponseParams("
           "data: $data" ", "
           "type: $type" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["data"] = data;
    map["type"] = type;
    return map;
  }
}

mojom_types.MojomStruct _sampleInterfacesIntegerAccessorGetIntegerResponseParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'IntegerAccessorGetIntegerResponseParams'
      ..fullIdentifier = 'sample.IntegerAccessor_GetInteger_ResponseParams')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Data')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int64),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Type')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..identifier = 'sample_interfaces_Enum__'
          ..typeKey = 'sample_interfaces_Enum__'
        )),];
}


class _IntegerAccessorSetIntegerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0),
    const bindings.StructDataHeader(24, 3)
  ];
  int data = 0;
  Enum type = null;

  _IntegerAccessorSetIntegerParams() : super(kVersions.last.size);

  static _IntegerAccessorSetIntegerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _IntegerAccessorSetIntegerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _IntegerAccessorSetIntegerParams result = new _IntegerAccessorSetIntegerParams();

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
      
      result.data = decoder0.decodeInt64(8);
    }
    if (mainDataHeader.version >= 3) {
      
        result.type = Enum.decode(decoder0, 16);
        if (result.type == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable Enum.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt64(data, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "data of struct _IntegerAccessorSetIntegerParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(type, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "type of struct _IntegerAccessorSetIntegerParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_IntegerAccessorSetIntegerParams("
           "data: $data" ", "
           "type: $type" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["data"] = data;
    map["type"] = type;
    return map;
  }
}

mojom_types.MojomStruct _sampleInterfacesIntegerAccessorSetIntegerParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'IntegerAccessorSetIntegerParams'
      ..fullIdentifier = 'sample.IntegerAccessor_SetInteger_Params')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Data')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int64),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Type')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..identifier = 'sample_interfaces_Enum__'
          ..typeKey = 'sample_interfaces_Enum__'
        )),];
}


class _SampleInterfaceSampleMethod0Params extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _SampleInterfaceSampleMethod0Params() : super(kVersions.last.size);

  static _SampleInterfaceSampleMethod0Params deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SampleInterfaceSampleMethod0Params decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SampleInterfaceSampleMethod0Params result = new _SampleInterfaceSampleMethod0Params();

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
    return "_SampleInterfaceSampleMethod0Params("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

mojom_types.MojomStruct _sampleInterfacesSampleInterfaceSampleMethod0Params() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'SampleInterfaceSampleMethod0Params'
      ..fullIdentifier = 'sample.SampleInterface_SampleMethod0_Params')
    ..fields = <mojom_types.StructField>[];
}


class _SampleInterfaceSampleMethod1Params extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int in1 = 0;
  String in2 = null;

  _SampleInterfaceSampleMethod1Params() : super(kVersions.last.size);

  static _SampleInterfaceSampleMethod1Params deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SampleInterfaceSampleMethod1Params decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SampleInterfaceSampleMethod1Params result = new _SampleInterfaceSampleMethod1Params();

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
      
      result.in1 = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.in2 = decoder0.decodeString(16, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(in1, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "in1 of struct _SampleInterfaceSampleMethod1Params: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(in2, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "in2 of struct _SampleInterfaceSampleMethod1Params: $e";
      rethrow;
    }
  }

  String toString() {
    return "_SampleInterfaceSampleMethod1Params("
           "in1: $in1" ", "
           "in2: $in2" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["in1"] = in1;
    map["in2"] = in2;
    return map;
  }
}

mojom_types.MojomStruct _sampleInterfacesSampleInterfaceSampleMethod1Params() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'SampleInterfaceSampleMethod1Params'
      ..fullIdentifier = 'sample.SampleInterface_SampleMethod1_Params')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'In1')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.int32),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'In2')
        ..type = (new mojom_types.Type()
          ..stringType = (new mojom_types.StringType()
            ..nullable = true
          )),];
}


class SampleInterfaceSampleMethod1ResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String out1 = null;
  Enum out2 = null;

  SampleInterfaceSampleMethod1ResponseParams() : super(kVersions.last.size);

  static SampleInterfaceSampleMethod1ResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SampleInterfaceSampleMethod1ResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SampleInterfaceSampleMethod1ResponseParams result = new SampleInterfaceSampleMethod1ResponseParams();

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
      
      result.out1 = decoder0.decodeString(8, true);
    }
    if (mainDataHeader.version >= 0) {
      
        result.out2 = Enum.decode(decoder0, 16);
        if (result.out2 == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable Enum.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(out1, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "out1 of struct SampleInterfaceSampleMethod1ResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(out2, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "out2 of struct SampleInterfaceSampleMethod1ResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "SampleInterfaceSampleMethod1ResponseParams("
           "out1: $out1" ", "
           "out2: $out2" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["out1"] = out1;
    map["out2"] = out2;
    return map;
  }
}

mojom_types.MojomStruct _sampleInterfacesSampleInterfaceSampleMethod1ResponseParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'SampleInterfaceSampleMethod1ResponseParams'
      ..fullIdentifier = 'sample.SampleInterface_SampleMethod1_ResponseParams')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Out1')
        ..type = (new mojom_types.Type()
          ..stringType = (new mojom_types.StringType()
            ..nullable = true
          )),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Out2')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..identifier = 'sample_interfaces_Enum__'
          ..typeKey = 'sample_interfaces_Enum__'
        )),];
}


class _SampleInterfaceSampleMethod2Params extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _SampleInterfaceSampleMethod2Params() : super(kVersions.last.size);

  static _SampleInterfaceSampleMethod2Params deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SampleInterfaceSampleMethod2Params decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SampleInterfaceSampleMethod2Params result = new _SampleInterfaceSampleMethod2Params();

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
    return "_SampleInterfaceSampleMethod2Params("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

mojom_types.MojomStruct _sampleInterfacesSampleInterfaceSampleMethod2Params() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'SampleInterfaceSampleMethod2Params'
      ..fullIdentifier = 'sample.SampleInterface_SampleMethod2_Params')
    ..fields = <mojom_types.StructField>[];
}


const int _Provider_echoStringName = 0;
const int _Provider_echoStringsName = 1;
const int _Provider_echoMessagePipeHandleName = 2;
const int _Provider_echoEnumName = 3;
const int _Provider_echoIntName = 4;

mojom_types.MojomInterface _sampleInterfacesProvider() {
  return new mojom_types.MojomInterface()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'Provider'
      ..fullIdentifier = 'sample.Provider')
    ..interfaceName = 'Provider'
    ..methods = <int, mojom_types.MojomMethod>{
      _Provider_echoStringName: new mojom_types.MojomMethod()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'EchoString')
        ..ordinal = _Provider_echoStringName
        ..responseParams = _sampleInterfacesProviderEchoStringResponseParams()
        ..parameters = _sampleInterfacesProviderEchoStringParams(),
      _Provider_echoStringsName: new mojom_types.MojomMethod()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'EchoStrings')
        ..ordinal = _Provider_echoStringsName
        ..responseParams = _sampleInterfacesProviderEchoStringsResponseParams()
        ..parameters = _sampleInterfacesProviderEchoStringsParams(),
      _Provider_echoMessagePipeHandleName: new mojom_types.MojomMethod()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'EchoMessagePipeHandle')
        ..ordinal = _Provider_echoMessagePipeHandleName
        ..responseParams = _sampleInterfacesProviderEchoMessagePipeHandleResponseParams()
        ..parameters = _sampleInterfacesProviderEchoMessagePipeHandleParams(),
      _Provider_echoEnumName: new mojom_types.MojomMethod()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'EchoEnum')
        ..ordinal = _Provider_echoEnumName
        ..responseParams = _sampleInterfacesProviderEchoEnumResponseParams()
        ..parameters = _sampleInterfacesProviderEchoEnumParams(),
      _Provider_echoIntName: new mojom_types.MojomMethod()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'EchoInt')
        ..ordinal = _Provider_echoIntName
        ..responseParams = _sampleInterfacesProviderEchoIntResponseParams()
        ..parameters = _sampleInterfacesProviderEchoIntParams(),
    };
}

class _ProviderServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      _sampleInterfacesProvider();

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      getAllMojomTypeDefinitions()[typeKey];

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      getAllMojomTypeDefinitions();
}

abstract class Provider {
  static const String serviceName = null;
  dynamic echoString(String a,[Function responseFactory = null]);
  dynamic echoStrings(String a,String b,[Function responseFactory = null]);
  dynamic echoMessagePipeHandle(core.MojoMessagePipeEndpoint a,[Function responseFactory = null]);
  dynamic echoEnum(Enum a,[Function responseFactory = null]);
  dynamic echoInt(int a,[Function responseFactory = null]);
}


class _ProviderProxyImpl extends bindings.Proxy {
  _ProviderProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ProviderProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _ProviderProxyImpl.unbound() : super.unbound();

  static _ProviderProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _ProviderProxyImpl"));
    return new _ProviderProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _ProviderServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _Provider_echoStringName:
        var r = ProviderEchoStringResponseParams.deserialize(
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
      case _Provider_echoStringsName:
        var r = ProviderEchoStringsResponseParams.deserialize(
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
      case _Provider_echoMessagePipeHandleName:
        var r = ProviderEchoMessagePipeHandleResponseParams.deserialize(
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
      case _Provider_echoEnumName:
        var r = ProviderEchoEnumResponseParams.deserialize(
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
      case _Provider_echoIntName:
        var r = ProviderEchoIntResponseParams.deserialize(
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
    return "_ProviderProxyImpl($superString)";
  }
}


class _ProviderProxyCalls implements Provider {
  _ProviderProxyImpl _proxyImpl;

  _ProviderProxyCalls(this._proxyImpl);
    dynamic echoString(String a,[Function responseFactory = null]) {
      var params = new _ProviderEchoStringParams();
      params.a = a;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _Provider_echoStringName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic echoStrings(String a,String b,[Function responseFactory = null]) {
      var params = new _ProviderEchoStringsParams();
      params.a = a;
      params.b = b;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _Provider_echoStringsName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic echoMessagePipeHandle(core.MojoMessagePipeEndpoint a,[Function responseFactory = null]) {
      var params = new _ProviderEchoMessagePipeHandleParams();
      params.a = a;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _Provider_echoMessagePipeHandleName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic echoEnum(Enum a,[Function responseFactory = null]) {
      var params = new _ProviderEchoEnumParams();
      params.a = a;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _Provider_echoEnumName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic echoInt(int a,[Function responseFactory = null]) {
      var params = new _ProviderEchoIntParams();
      params.a = a;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _Provider_echoIntName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class ProviderProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  Provider ptr;

  ProviderProxy(_ProviderProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ProviderProxyCalls(proxyImpl);

  ProviderProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _ProviderProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ProviderProxyCalls(impl);
  }

  ProviderProxy.fromHandle(core.MojoHandle handle) :
      impl = new _ProviderProxyImpl.fromHandle(handle) {
    ptr = new _ProviderProxyCalls(impl);
  }

  ProviderProxy.unbound() :
      impl = new _ProviderProxyImpl.unbound() {
    ptr = new _ProviderProxyCalls(impl);
  }

  factory ProviderProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ProviderProxy p = new ProviderProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static ProviderProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ProviderProxy"));
    return new ProviderProxy.fromEndpoint(endpoint);
  }

  String get serviceName => Provider.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "ProviderProxy($impl)";
  }
}


class ProviderStub extends bindings.Stub {
  Provider _impl = null;

  ProviderStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  ProviderStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  ProviderStub.unbound() : super.unbound();

  static ProviderStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ProviderStub"));
    return new ProviderStub.fromEndpoint(endpoint);
  }


  ProviderEchoStringResponseParams _ProviderEchoStringResponseParamsFactory(String a) {
    var mojo_factory_result = new ProviderEchoStringResponseParams();
    mojo_factory_result.a = a;
    return mojo_factory_result;
  }
  ProviderEchoStringsResponseParams _ProviderEchoStringsResponseParamsFactory(String a, String b) {
    var mojo_factory_result = new ProviderEchoStringsResponseParams();
    mojo_factory_result.a = a;
    mojo_factory_result.b = b;
    return mojo_factory_result;
  }
  ProviderEchoMessagePipeHandleResponseParams _ProviderEchoMessagePipeHandleResponseParamsFactory(core.MojoMessagePipeEndpoint a) {
    var mojo_factory_result = new ProviderEchoMessagePipeHandleResponseParams();
    mojo_factory_result.a = a;
    return mojo_factory_result;
  }
  ProviderEchoEnumResponseParams _ProviderEchoEnumResponseParamsFactory(Enum a) {
    var mojo_factory_result = new ProviderEchoEnumResponseParams();
    mojo_factory_result.a = a;
    return mojo_factory_result;
  }
  ProviderEchoIntResponseParams _ProviderEchoIntResponseParamsFactory(int a) {
    var mojo_factory_result = new ProviderEchoIntResponseParams();
    mojo_factory_result.a = a;
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
      case _Provider_echoStringName:
        var params = _ProviderEchoStringParams.deserialize(
            message.payload);
        var response = _impl.echoString(params.a,_ProviderEchoStringResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _Provider_echoStringName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _Provider_echoStringName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _Provider_echoStringsName:
        var params = _ProviderEchoStringsParams.deserialize(
            message.payload);
        var response = _impl.echoStrings(params.a,params.b,_ProviderEchoStringsResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _Provider_echoStringsName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _Provider_echoStringsName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _Provider_echoMessagePipeHandleName:
        var params = _ProviderEchoMessagePipeHandleParams.deserialize(
            message.payload);
        var response = _impl.echoMessagePipeHandle(params.a,_ProviderEchoMessagePipeHandleResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _Provider_echoMessagePipeHandleName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _Provider_echoMessagePipeHandleName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _Provider_echoEnumName:
        var params = _ProviderEchoEnumParams.deserialize(
            message.payload);
        var response = _impl.echoEnum(params.a,_ProviderEchoEnumResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _Provider_echoEnumName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _Provider_echoEnumName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _Provider_echoIntName:
        var params = _ProviderEchoIntParams.deserialize(
            message.payload);
        var response = _impl.echoInt(params.a,_ProviderEchoIntResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _Provider_echoIntName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _Provider_echoIntName,
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

  Provider get impl => _impl;
  set impl(Provider d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "ProviderStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _ProviderServiceDescription();
}

const int _IntegerAccessor_getIntegerName = 0;
const int _IntegerAccessor_setIntegerName = 1;

mojom_types.MojomInterface _sampleInterfacesIntegerAccessor() {
  return new mojom_types.MojomInterface()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'IntegerAccessor'
      ..fullIdentifier = 'sample.IntegerAccessor')
    ..interfaceName = 'IntegerAccessor'
    ..methods = <int, mojom_types.MojomMethod>{
      _IntegerAccessor_getIntegerName: new mojom_types.MojomMethod()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'GetInteger')
        ..ordinal = _IntegerAccessor_getIntegerName
        ..responseParams = _sampleInterfacesIntegerAccessorGetIntegerResponseParams()
        ..parameters = _sampleInterfacesIntegerAccessorGetIntegerParams(),
      _IntegerAccessor_setIntegerName: new mojom_types.MojomMethod()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'SetInteger')
        ..ordinal = _IntegerAccessor_setIntegerName
        ..parameters = _sampleInterfacesIntegerAccessorSetIntegerParams(),
    };
}

class _IntegerAccessorServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      _sampleInterfacesIntegerAccessor();

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      getAllMojomTypeDefinitions()[typeKey];

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      getAllMojomTypeDefinitions();
}

abstract class IntegerAccessor {
  static const String serviceName = null;
  dynamic getInteger([Function responseFactory = null]);
  void setInteger(int data, Enum type);
}


class _IntegerAccessorProxyImpl extends bindings.Proxy {
  _IntegerAccessorProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _IntegerAccessorProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _IntegerAccessorProxyImpl.unbound() : super.unbound();

  static _IntegerAccessorProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _IntegerAccessorProxyImpl"));
    return new _IntegerAccessorProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _IntegerAccessorServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _IntegerAccessor_getIntegerName:
        var r = IntegerAccessorGetIntegerResponseParams.deserialize(
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
    return "_IntegerAccessorProxyImpl($superString)";
  }
}


class _IntegerAccessorProxyCalls implements IntegerAccessor {
  _IntegerAccessorProxyImpl _proxyImpl;

  _IntegerAccessorProxyCalls(this._proxyImpl);
    dynamic getInteger([Function responseFactory = null]) {
      var params = new _IntegerAccessorGetIntegerParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _IntegerAccessor_getIntegerName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    void setInteger(int data, Enum type) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _IntegerAccessorSetIntegerParams();
      params.data = data;
      params.type = type;
      _proxyImpl.sendMessage(params, _IntegerAccessor_setIntegerName);
    }
}


class IntegerAccessorProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  IntegerAccessor ptr;

  IntegerAccessorProxy(_IntegerAccessorProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _IntegerAccessorProxyCalls(proxyImpl);

  IntegerAccessorProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _IntegerAccessorProxyImpl.fromEndpoint(endpoint) {
    ptr = new _IntegerAccessorProxyCalls(impl);
  }

  IntegerAccessorProxy.fromHandle(core.MojoHandle handle) :
      impl = new _IntegerAccessorProxyImpl.fromHandle(handle) {
    ptr = new _IntegerAccessorProxyCalls(impl);
  }

  IntegerAccessorProxy.unbound() :
      impl = new _IntegerAccessorProxyImpl.unbound() {
    ptr = new _IntegerAccessorProxyCalls(impl);
  }

  factory IntegerAccessorProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    IntegerAccessorProxy p = new IntegerAccessorProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static IntegerAccessorProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For IntegerAccessorProxy"));
    return new IntegerAccessorProxy.fromEndpoint(endpoint);
  }

  String get serviceName => IntegerAccessor.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "IntegerAccessorProxy($impl)";
  }
}


class IntegerAccessorStub extends bindings.Stub {
  IntegerAccessor _impl = null;

  IntegerAccessorStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  IntegerAccessorStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  IntegerAccessorStub.unbound() : super.unbound();

  static IntegerAccessorStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For IntegerAccessorStub"));
    return new IntegerAccessorStub.fromEndpoint(endpoint);
  }


  IntegerAccessorGetIntegerResponseParams _IntegerAccessorGetIntegerResponseParamsFactory(int data, Enum type) {
    var mojo_factory_result = new IntegerAccessorGetIntegerResponseParams();
    mojo_factory_result.data = data;
    mojo_factory_result.type = type;
    return mojo_factory_result;
  }

  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          3,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _IntegerAccessor_getIntegerName:
        var params = _IntegerAccessorGetIntegerParams.deserialize(
            message.payload);
        var response = _impl.getInteger(_IntegerAccessorGetIntegerResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _IntegerAccessor_getIntegerName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _IntegerAccessor_getIntegerName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _IntegerAccessor_setIntegerName:
        var params = _IntegerAccessorSetIntegerParams.deserialize(
            message.payload);
        _impl.setInteger(params.data, params.type);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  IntegerAccessor get impl => _impl;
  set impl(IntegerAccessor d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "IntegerAccessorStub($superString)";
  }

  int get version => 3;

  service_describer.ServiceDescription get serviceDescription =>
    new _IntegerAccessorServiceDescription();
}

const int _SampleInterface_sampleMethod0Name = 0;
const int _SampleInterface_sampleMethod1Name = 1;
const int _SampleInterface_sampleMethod2Name = 2;

mojom_types.MojomInterface _sampleInterfacesSampleInterface() {
  return new mojom_types.MojomInterface()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'SampleInterface'
      ..fullIdentifier = 'sample.SampleInterface')
    ..interfaceName = 'SampleInterface'
    ..methods = <int, mojom_types.MojomMethod>{
      _SampleInterface_sampleMethod0Name: new mojom_types.MojomMethod()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'SampleMethod0')
        ..ordinal = _SampleInterface_sampleMethod0Name
        ..parameters = _sampleInterfacesSampleInterfaceSampleMethod0Params(),
      _SampleInterface_sampleMethod1Name: new mojom_types.MojomMethod()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'SampleMethod1')
        ..ordinal = _SampleInterface_sampleMethod1Name
        ..responseParams = _sampleInterfacesSampleInterfaceSampleMethod1ResponseParams()
        ..parameters = _sampleInterfacesSampleInterfaceSampleMethod1Params(),
      _SampleInterface_sampleMethod2Name: new mojom_types.MojomMethod()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'SampleMethod2')
        ..ordinal = _SampleInterface_sampleMethod2Name
        ..parameters = _sampleInterfacesSampleInterfaceSampleMethod2Params(),
    };
}

class _SampleInterfaceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      _sampleInterfacesSampleInterface();

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      getAllMojomTypeDefinitions()[typeKey];

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      getAllMojomTypeDefinitions();
}

abstract class SampleInterface {
  static const String serviceName = null;
  void sampleMethod0();
  dynamic sampleMethod1(int in1,String in2,[Function responseFactory = null]);
  void sampleMethod2();
}


class _SampleInterfaceProxyImpl extends bindings.Proxy {
  _SampleInterfaceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _SampleInterfaceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _SampleInterfaceProxyImpl.unbound() : super.unbound();

  static _SampleInterfaceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _SampleInterfaceProxyImpl"));
    return new _SampleInterfaceProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _SampleInterfaceServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _SampleInterface_sampleMethod1Name:
        var r = SampleInterfaceSampleMethod1ResponseParams.deserialize(
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
    return "_SampleInterfaceProxyImpl($superString)";
  }
}


class _SampleInterfaceProxyCalls implements SampleInterface {
  _SampleInterfaceProxyImpl _proxyImpl;

  _SampleInterfaceProxyCalls(this._proxyImpl);
    void sampleMethod0() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _SampleInterfaceSampleMethod0Params();
      _proxyImpl.sendMessage(params, _SampleInterface_sampleMethod0Name);
    }
    dynamic sampleMethod1(int in1,String in2,[Function responseFactory = null]) {
      var params = new _SampleInterfaceSampleMethod1Params();
      params.in1 = in1;
      params.in2 = in2;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _SampleInterface_sampleMethod1Name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    void sampleMethod2() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _SampleInterfaceSampleMethod2Params();
      _proxyImpl.sendMessage(params, _SampleInterface_sampleMethod2Name);
    }
}


class SampleInterfaceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  SampleInterface ptr;

  SampleInterfaceProxy(_SampleInterfaceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _SampleInterfaceProxyCalls(proxyImpl);

  SampleInterfaceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _SampleInterfaceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _SampleInterfaceProxyCalls(impl);
  }

  SampleInterfaceProxy.fromHandle(core.MojoHandle handle) :
      impl = new _SampleInterfaceProxyImpl.fromHandle(handle) {
    ptr = new _SampleInterfaceProxyCalls(impl);
  }

  SampleInterfaceProxy.unbound() :
      impl = new _SampleInterfaceProxyImpl.unbound() {
    ptr = new _SampleInterfaceProxyCalls(impl);
  }

  factory SampleInterfaceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    SampleInterfaceProxy p = new SampleInterfaceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static SampleInterfaceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SampleInterfaceProxy"));
    return new SampleInterfaceProxy.fromEndpoint(endpoint);
  }

  String get serviceName => SampleInterface.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "SampleInterfaceProxy($impl)";
  }
}


class SampleInterfaceStub extends bindings.Stub {
  SampleInterface _impl = null;

  SampleInterfaceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  SampleInterfaceStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  SampleInterfaceStub.unbound() : super.unbound();

  static SampleInterfaceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SampleInterfaceStub"));
    return new SampleInterfaceStub.fromEndpoint(endpoint);
  }


  SampleInterfaceSampleMethod1ResponseParams _SampleInterfaceSampleMethod1ResponseParamsFactory(String out1, Enum out2) {
    var mojo_factory_result = new SampleInterfaceSampleMethod1ResponseParams();
    mojo_factory_result.out1 = out1;
    mojo_factory_result.out2 = out2;
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
      case _SampleInterface_sampleMethod0Name:
        var params = _SampleInterfaceSampleMethod0Params.deserialize(
            message.payload);
        _impl.sampleMethod0();
        break;
      case _SampleInterface_sampleMethod1Name:
        var params = _SampleInterfaceSampleMethod1Params.deserialize(
            message.payload);
        var response = _impl.sampleMethod1(params.in1,params.in2,_SampleInterfaceSampleMethod1ResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _SampleInterface_sampleMethod1Name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _SampleInterface_sampleMethod1Name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _SampleInterface_sampleMethod2Name:
        var params = _SampleInterfaceSampleMethod2Params.deserialize(
            message.payload);
        _impl.sampleMethod2();
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  SampleInterface get impl => _impl;
  set impl(SampleInterface d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "SampleInterfaceStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _SampleInterfaceServiceDescription();
}


Map<String, mojom_types.UserDefinedType> _initDescriptions() {
  var map = new HashMap<String, mojom_types.UserDefinedType>();
  map["sample_interfaces_Enum__"] =
    new mojom_types.UserDefinedType()
      ..enumType = _sampleInterfacesEnum();
  map["sample_interfaces_Provider_EchoString_Params__"] =
    new mojom_types.UserDefinedType()
      ..structType = _sampleInterfacesProviderEchoStringParams();
  map["sample_interfaces_Provider_EchoString_ResponseParams__"] =
    new mojom_types.UserDefinedType()
      ..structType = _sampleInterfacesProviderEchoStringResponseParams();
  map["sample_interfaces_Provider_EchoStrings_Params__"] =
    new mojom_types.UserDefinedType()
      ..structType = _sampleInterfacesProviderEchoStringsParams();
  map["sample_interfaces_Provider_EchoStrings_ResponseParams__"] =
    new mojom_types.UserDefinedType()
      ..structType = _sampleInterfacesProviderEchoStringsResponseParams();
  map["sample_interfaces_Provider_EchoMessagePipeHandle_Params__"] =
    new mojom_types.UserDefinedType()
      ..structType = _sampleInterfacesProviderEchoMessagePipeHandleParams();
  map["sample_interfaces_Provider_EchoMessagePipeHandle_ResponseParams__"] =
    new mojom_types.UserDefinedType()
      ..structType = _sampleInterfacesProviderEchoMessagePipeHandleResponseParams();
  map["sample_interfaces_Provider_EchoEnum_Params__"] =
    new mojom_types.UserDefinedType()
      ..structType = _sampleInterfacesProviderEchoEnumParams();
  map["sample_interfaces_Provider_EchoEnum_ResponseParams__"] =
    new mojom_types.UserDefinedType()
      ..structType = _sampleInterfacesProviderEchoEnumResponseParams();
  map["sample_interfaces_Provider_EchoInt_Params__"] =
    new mojom_types.UserDefinedType()
      ..structType = _sampleInterfacesProviderEchoIntParams();
  map["sample_interfaces_Provider_EchoInt_ResponseParams__"] =
    new mojom_types.UserDefinedType()
      ..structType = _sampleInterfacesProviderEchoIntResponseParams();
  map["sample_interfaces_IntegerAccessor_GetInteger_Params__"] =
    new mojom_types.UserDefinedType()
      ..structType = _sampleInterfacesIntegerAccessorGetIntegerParams();
  map["sample_interfaces_IntegerAccessor_GetInteger_ResponseParams__"] =
    new mojom_types.UserDefinedType()
      ..structType = _sampleInterfacesIntegerAccessorGetIntegerResponseParams();
  map["sample_interfaces_IntegerAccessor_SetInteger_Params__"] =
    new mojom_types.UserDefinedType()
      ..structType = _sampleInterfacesIntegerAccessorSetIntegerParams();
  map["sample_interfaces_SampleInterface_SampleMethod0_Params__"] =
    new mojom_types.UserDefinedType()
      ..structType = _sampleInterfacesSampleInterfaceSampleMethod0Params();
  map["sample_interfaces_SampleInterface_SampleMethod1_Params__"] =
    new mojom_types.UserDefinedType()
      ..structType = _sampleInterfacesSampleInterfaceSampleMethod1Params();
  map["sample_interfaces_SampleInterface_SampleMethod1_ResponseParams__"] =
    new mojom_types.UserDefinedType()
      ..structType = _sampleInterfacesSampleInterfaceSampleMethod1ResponseParams();
  map["sample_interfaces_SampleInterface_SampleMethod2_Params__"] =
    new mojom_types.UserDefinedType()
      ..structType = _sampleInterfacesSampleInterfaceSampleMethod2Params();
  map["sample_interfaces_Provider__"] =
    new mojom_types.UserDefinedType()
      ..interfaceType = _sampleInterfacesProvider();
  map["sample_interfaces_IntegerAccessor__"] =
    new mojom_types.UserDefinedType()
      ..interfaceType = _sampleInterfacesIntegerAccessor();
  map["sample_interfaces_SampleInterface__"] =
    new mojom_types.UserDefinedType()
      ..interfaceType = _sampleInterfacesSampleInterface();
  return map;
}

var _mojomDesc;
Map<String, mojom_types.UserDefinedType> getAllMojomTypeDefinitions() {
  if (_mojomDesc == null) {
    _mojomDesc = _initDescriptions();
  }
  return _mojomDesc;
}

