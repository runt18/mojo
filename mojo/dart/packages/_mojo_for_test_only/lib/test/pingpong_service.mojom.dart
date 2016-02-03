// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library pingpong_service_mojom;

import 'dart:async';
import 'dart:collection';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class _PingPongServiceSetClientParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object client = null;

  _PingPongServiceSetClientParams() : super(kVersions.last.size);

  static _PingPongServiceSetClientParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _PingPongServiceSetClientParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _PingPongServiceSetClientParams result = new _PingPongServiceSetClientParams();

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
      
      result.client = decoder0.decodeServiceInterface(8, false, PingPongClientProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(client, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "client of struct _PingPongServiceSetClientParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_PingPongServiceSetClientParams("
           "client: $client" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

mojom_types.MojomStruct _pingpongServicePingPongServiceSetClientParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'PingPongServiceSetClientParams'
      ..fullIdentifier = 'test.PingPongService_SetClient_Params')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Client')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..identifier = 'pingpong_service_PingPongClient__'
          ..typeKey = 'pingpong_service_PingPongClient__'
        )),];
}


class _PingPongServicePingParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int pingValue = 0;

  _PingPongServicePingParams() : super(kVersions.last.size);

  static _PingPongServicePingParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _PingPongServicePingParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _PingPongServicePingParams result = new _PingPongServicePingParams();

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
      
      result.pingValue = decoder0.decodeUint16(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint16(pingValue, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "pingValue of struct _PingPongServicePingParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_PingPongServicePingParams("
           "pingValue: $pingValue" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["pingValue"] = pingValue;
    return map;
  }
}

mojom_types.MojomStruct _pingpongServicePingPongServicePingParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'PingPongServicePingParams'
      ..fullIdentifier = 'test.PingPongService_Ping_Params')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'PingValue')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.uint16),];
}


class _PingPongServicePingTargetUrlParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String url = null;
  int count = 0;

  _PingPongServicePingTargetUrlParams() : super(kVersions.last.size);

  static _PingPongServicePingTargetUrlParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _PingPongServicePingTargetUrlParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _PingPongServicePingTargetUrlParams result = new _PingPongServicePingTargetUrlParams();

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
      
      result.count = decoder0.decodeUint16(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(url, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "url of struct _PingPongServicePingTargetUrlParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint16(count, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "count of struct _PingPongServicePingTargetUrlParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_PingPongServicePingTargetUrlParams("
           "url: $url" ", "
           "count: $count" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["url"] = url;
    map["count"] = count;
    return map;
  }
}

mojom_types.MojomStruct _pingpongServicePingPongServicePingTargetUrlParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'PingPongServicePingTargetUrlParams'
      ..fullIdentifier = 'test.PingPongService_PingTargetURL_Params')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Url')
        ..type = (new mojom_types.Type()
          ..stringType = (new mojom_types.StringType())),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Count')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.uint16),];
}


class PingPongServicePingTargetUrlResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool ok = false;

  PingPongServicePingTargetUrlResponseParams() : super(kVersions.last.size);

  static PingPongServicePingTargetUrlResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static PingPongServicePingTargetUrlResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    PingPongServicePingTargetUrlResponseParams result = new PingPongServicePingTargetUrlResponseParams();

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
      
      result.ok = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeBool(ok, 8, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "ok of struct PingPongServicePingTargetUrlResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "PingPongServicePingTargetUrlResponseParams("
           "ok: $ok" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["ok"] = ok;
    return map;
  }
}

mojom_types.MojomStruct _pingpongServicePingPongServicePingTargetUrlResponseParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'PingPongServicePingTargetUrlResponseParams'
      ..fullIdentifier = 'test.PingPongService_PingTargetURL_ResponseParams')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Ok')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.bool),];
}


class _PingPongServicePingTargetServiceParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  Object service = null;
  int count = 0;

  _PingPongServicePingTargetServiceParams() : super(kVersions.last.size);

  static _PingPongServicePingTargetServiceParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _PingPongServicePingTargetServiceParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _PingPongServicePingTargetServiceParams result = new _PingPongServicePingTargetServiceParams();

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
      
      result.service = decoder0.decodeServiceInterface(8, false, PingPongServiceProxy.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.count = decoder0.decodeUint16(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(service, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "service of struct _PingPongServicePingTargetServiceParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint16(count, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "count of struct _PingPongServicePingTargetServiceParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_PingPongServicePingTargetServiceParams("
           "service: $service" ", "
           "count: $count" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

mojom_types.MojomStruct _pingpongServicePingPongServicePingTargetServiceParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'PingPongServicePingTargetServiceParams'
      ..fullIdentifier = 'test.PingPongService_PingTargetService_Params')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Service')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..identifier = 'pingpong_service_PingPongService__'
          ..typeKey = 'pingpong_service_PingPongService__'
        )),
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Count')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.uint16),];
}


class PingPongServicePingTargetServiceResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool ok = false;

  PingPongServicePingTargetServiceResponseParams() : super(kVersions.last.size);

  static PingPongServicePingTargetServiceResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static PingPongServicePingTargetServiceResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    PingPongServicePingTargetServiceResponseParams result = new PingPongServicePingTargetServiceResponseParams();

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
      
      result.ok = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeBool(ok, 8, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "ok of struct PingPongServicePingTargetServiceResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "PingPongServicePingTargetServiceResponseParams("
           "ok: $ok" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["ok"] = ok;
    return map;
  }
}

mojom_types.MojomStruct _pingpongServicePingPongServicePingTargetServiceResponseParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'PingPongServicePingTargetServiceResponseParams'
      ..fullIdentifier = 'test.PingPongService_PingTargetService_ResponseParams')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Ok')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.bool),];
}


class _PingPongServiceGetPingPongServiceParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object service = null;

  _PingPongServiceGetPingPongServiceParams() : super(kVersions.last.size);

  static _PingPongServiceGetPingPongServiceParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _PingPongServiceGetPingPongServiceParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _PingPongServiceGetPingPongServiceParams result = new _PingPongServiceGetPingPongServiceParams();

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
      
      result.service = decoder0.decodeInterfaceRequest(8, false, PingPongServiceStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(service, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "service of struct _PingPongServiceGetPingPongServiceParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_PingPongServiceGetPingPongServiceParams("
           "service: $service" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

mojom_types.MojomStruct _pingpongServicePingPongServiceGetPingPongServiceParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'PingPongServiceGetPingPongServiceParams'
      ..fullIdentifier = 'test.PingPongService_GetPingPongService_Params')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Service')
        ..type = (new mojom_types.Type()
          ..typeReference = (new mojom_types.TypeReference()
          ..isInterfaceRequest = true
          ..identifier = 'pingpong_service_PingPongService__'
          ..typeKey = 'pingpong_service_PingPongService__'
        )),];
}


class _PingPongServiceQuitParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _PingPongServiceQuitParams() : super(kVersions.last.size);

  static _PingPongServiceQuitParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _PingPongServiceQuitParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _PingPongServiceQuitParams result = new _PingPongServiceQuitParams();

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
    return "_PingPongServiceQuitParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

mojom_types.MojomStruct _pingpongServicePingPongServiceQuitParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'PingPongServiceQuitParams'
      ..fullIdentifier = 'test.PingPongService_Quit_Params')
    ..fields = <mojom_types.StructField>[];
}


class _PingPongClientPongParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int pongValue = 0;

  _PingPongClientPongParams() : super(kVersions.last.size);

  static _PingPongClientPongParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _PingPongClientPongParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _PingPongClientPongParams result = new _PingPongClientPongParams();

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
      
      result.pongValue = decoder0.decodeUint16(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint16(pongValue, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "pongValue of struct _PingPongClientPongParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_PingPongClientPongParams("
           "pongValue: $pongValue" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["pongValue"] = pongValue;
    return map;
  }
}

mojom_types.MojomStruct _pingpongServicePingPongClientPongParams() {
  return new mojom_types.MojomStruct()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'PingPongClientPongParams'
      ..fullIdentifier = 'test.PingPongClient_Pong_Params')
    ..fields = <mojom_types.StructField>[
      new mojom_types.StructField()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'PongValue')
        ..type = (new mojom_types.Type()
          ..simpleType = mojom_types.SimpleType.uint16),];
}


const int _PingPongService_setClientName = 0;
const int _PingPongService_pingName = 1;
const int _PingPongService_pingTargetUrlName = 2;
const int _PingPongService_pingTargetServiceName = 3;
const int _PingPongService_getPingPongServiceName = 4;
const int _PingPongService_quitName = 5;

mojom_types.MojomInterface _pingpongServicePingPongService() {
  return new mojom_types.MojomInterface()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'PingPongService'
      ..fullIdentifier = 'test.PingPongService')
    ..interfaceName = 'PingPongService'
    ..methods = <int, mojom_types.MojomMethod>{
      _PingPongService_setClientName: new mojom_types.MojomMethod()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'SetClient')
        ..ordinal = _PingPongService_setClientName
        ..parameters = _pingpongServicePingPongServiceSetClientParams(),
      _PingPongService_pingName: new mojom_types.MojomMethod()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Ping')
        ..ordinal = _PingPongService_pingName
        ..parameters = _pingpongServicePingPongServicePingParams(),
      _PingPongService_pingTargetUrlName: new mojom_types.MojomMethod()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'PingTargetUrl')
        ..ordinal = _PingPongService_pingTargetUrlName
        ..responseParams = _pingpongServicePingPongServicePingTargetUrlResponseParams()
        ..parameters = _pingpongServicePingPongServicePingTargetUrlParams(),
      _PingPongService_pingTargetServiceName: new mojom_types.MojomMethod()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'PingTargetService')
        ..ordinal = _PingPongService_pingTargetServiceName
        ..responseParams = _pingpongServicePingPongServicePingTargetServiceResponseParams()
        ..parameters = _pingpongServicePingPongServicePingTargetServiceParams(),
      _PingPongService_getPingPongServiceName: new mojom_types.MojomMethod()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'GetPingPongService')
        ..ordinal = _PingPongService_getPingPongServiceName
        ..parameters = _pingpongServicePingPongServiceGetPingPongServiceParams(),
      _PingPongService_quitName: new mojom_types.MojomMethod()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Quit')
        ..ordinal = _PingPongService_quitName
        ..parameters = _pingpongServicePingPongServiceQuitParams(),
    };
}

class _PingPongServiceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      _pingpongServicePingPongService();

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      getAllMojomTypeDefinitions()[typeKey];

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      getAllMojomTypeDefinitions();
}

abstract class PingPongService {
  static const String serviceName = "test::PingPongService";
  void setClient(Object client);
  void ping(int pingValue);
  dynamic pingTargetUrl(String url,int count,[Function responseFactory = null]);
  dynamic pingTargetService(Object service,int count,[Function responseFactory = null]);
  void getPingPongService(Object service);
  void quit();
}


class _PingPongServiceProxyImpl extends bindings.Proxy {
  _PingPongServiceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _PingPongServiceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _PingPongServiceProxyImpl.unbound() : super.unbound();

  static _PingPongServiceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _PingPongServiceProxyImpl"));
    return new _PingPongServiceProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _PingPongServiceServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _PingPongService_pingTargetUrlName:
        var r = PingPongServicePingTargetUrlResponseParams.deserialize(
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
      case _PingPongService_pingTargetServiceName:
        var r = PingPongServicePingTargetServiceResponseParams.deserialize(
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
    return "_PingPongServiceProxyImpl($superString)";
  }
}


class _PingPongServiceProxyCalls implements PingPongService {
  _PingPongServiceProxyImpl _proxyImpl;

  _PingPongServiceProxyCalls(this._proxyImpl);
    void setClient(Object client) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _PingPongServiceSetClientParams();
      params.client = client;
      _proxyImpl.sendMessage(params, _PingPongService_setClientName);
    }
    void ping(int pingValue) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _PingPongServicePingParams();
      params.pingValue = pingValue;
      _proxyImpl.sendMessage(params, _PingPongService_pingName);
    }
    dynamic pingTargetUrl(String url,int count,[Function responseFactory = null]) {
      var params = new _PingPongServicePingTargetUrlParams();
      params.url = url;
      params.count = count;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _PingPongService_pingTargetUrlName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic pingTargetService(Object service,int count,[Function responseFactory = null]) {
      var params = new _PingPongServicePingTargetServiceParams();
      params.service = service;
      params.count = count;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _PingPongService_pingTargetServiceName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    void getPingPongService(Object service) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _PingPongServiceGetPingPongServiceParams();
      params.service = service;
      _proxyImpl.sendMessage(params, _PingPongService_getPingPongServiceName);
    }
    void quit() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _PingPongServiceQuitParams();
      _proxyImpl.sendMessage(params, _PingPongService_quitName);
    }
}


class PingPongServiceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  PingPongService ptr;

  PingPongServiceProxy(_PingPongServiceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _PingPongServiceProxyCalls(proxyImpl);

  PingPongServiceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _PingPongServiceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _PingPongServiceProxyCalls(impl);
  }

  PingPongServiceProxy.fromHandle(core.MojoHandle handle) :
      impl = new _PingPongServiceProxyImpl.fromHandle(handle) {
    ptr = new _PingPongServiceProxyCalls(impl);
  }

  PingPongServiceProxy.unbound() :
      impl = new _PingPongServiceProxyImpl.unbound() {
    ptr = new _PingPongServiceProxyCalls(impl);
  }

  factory PingPongServiceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    PingPongServiceProxy p = new PingPongServiceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static PingPongServiceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For PingPongServiceProxy"));
    return new PingPongServiceProxy.fromEndpoint(endpoint);
  }

  String get serviceName => PingPongService.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "PingPongServiceProxy($impl)";
  }
}


class PingPongServiceStub extends bindings.Stub {
  PingPongService _impl = null;

  PingPongServiceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  PingPongServiceStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  PingPongServiceStub.unbound() : super.unbound();

  static PingPongServiceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For PingPongServiceStub"));
    return new PingPongServiceStub.fromEndpoint(endpoint);
  }


  PingPongServicePingTargetUrlResponseParams _PingPongServicePingTargetUrlResponseParamsFactory(bool ok) {
    var mojo_factory_result = new PingPongServicePingTargetUrlResponseParams();
    mojo_factory_result.ok = ok;
    return mojo_factory_result;
  }
  PingPongServicePingTargetServiceResponseParams _PingPongServicePingTargetServiceResponseParamsFactory(bool ok) {
    var mojo_factory_result = new PingPongServicePingTargetServiceResponseParams();
    mojo_factory_result.ok = ok;
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
      case _PingPongService_setClientName:
        var params = _PingPongServiceSetClientParams.deserialize(
            message.payload);
        _impl.setClient(params.client);
        break;
      case _PingPongService_pingName:
        var params = _PingPongServicePingParams.deserialize(
            message.payload);
        _impl.ping(params.pingValue);
        break;
      case _PingPongService_pingTargetUrlName:
        var params = _PingPongServicePingTargetUrlParams.deserialize(
            message.payload);
        var response = _impl.pingTargetUrl(params.url,params.count,_PingPongServicePingTargetUrlResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _PingPongService_pingTargetUrlName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _PingPongService_pingTargetUrlName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _PingPongService_pingTargetServiceName:
        var params = _PingPongServicePingTargetServiceParams.deserialize(
            message.payload);
        var response = _impl.pingTargetService(params.service,params.count,_PingPongServicePingTargetServiceResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _PingPongService_pingTargetServiceName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _PingPongService_pingTargetServiceName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _PingPongService_getPingPongServiceName:
        var params = _PingPongServiceGetPingPongServiceParams.deserialize(
            message.payload);
        _impl.getPingPongService(params.service);
        break;
      case _PingPongService_quitName:
        var params = _PingPongServiceQuitParams.deserialize(
            message.payload);
        _impl.quit();
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  PingPongService get impl => _impl;
  set impl(PingPongService d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "PingPongServiceStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _PingPongServiceServiceDescription();
}

const int _PingPongClient_pongName = 0;

mojom_types.MojomInterface _pingpongServicePingPongClient() {
  return new mojom_types.MojomInterface()
    ..declData = (new mojom_types.DeclarationData()
      ..shortName = 'PingPongClient'
      ..fullIdentifier = 'test.PingPongClient')
    ..interfaceName = 'PingPongClient'
    ..methods = <int, mojom_types.MojomMethod>{
      _PingPongClient_pongName: new mojom_types.MojomMethod()
        ..declData = (new mojom_types.DeclarationData()
          ..shortName = 'Pong')
        ..ordinal = _PingPongClient_pongName
        ..parameters = _pingpongServicePingPongClientPongParams(),
    };
}

class _PingPongClientServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      _pingpongServicePingPongClient();

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      getAllMojomTypeDefinitions()[typeKey];

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      getAllMojomTypeDefinitions();
}

abstract class PingPongClient {
  static const String serviceName = null;
  void pong(int pongValue);
}


class _PingPongClientProxyImpl extends bindings.Proxy {
  _PingPongClientProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _PingPongClientProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _PingPongClientProxyImpl.unbound() : super.unbound();

  static _PingPongClientProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _PingPongClientProxyImpl"));
    return new _PingPongClientProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _PingPongClientServiceDescription();

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
    return "_PingPongClientProxyImpl($superString)";
  }
}


class _PingPongClientProxyCalls implements PingPongClient {
  _PingPongClientProxyImpl _proxyImpl;

  _PingPongClientProxyCalls(this._proxyImpl);
    void pong(int pongValue) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _PingPongClientPongParams();
      params.pongValue = pongValue;
      _proxyImpl.sendMessage(params, _PingPongClient_pongName);
    }
}


class PingPongClientProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  PingPongClient ptr;

  PingPongClientProxy(_PingPongClientProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _PingPongClientProxyCalls(proxyImpl);

  PingPongClientProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _PingPongClientProxyImpl.fromEndpoint(endpoint) {
    ptr = new _PingPongClientProxyCalls(impl);
  }

  PingPongClientProxy.fromHandle(core.MojoHandle handle) :
      impl = new _PingPongClientProxyImpl.fromHandle(handle) {
    ptr = new _PingPongClientProxyCalls(impl);
  }

  PingPongClientProxy.unbound() :
      impl = new _PingPongClientProxyImpl.unbound() {
    ptr = new _PingPongClientProxyCalls(impl);
  }

  factory PingPongClientProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    PingPongClientProxy p = new PingPongClientProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static PingPongClientProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For PingPongClientProxy"));
    return new PingPongClientProxy.fromEndpoint(endpoint);
  }

  String get serviceName => PingPongClient.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "PingPongClientProxy($impl)";
  }
}


class PingPongClientStub extends bindings.Stub {
  PingPongClient _impl = null;

  PingPongClientStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  PingPongClientStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  PingPongClientStub.unbound() : super.unbound();

  static PingPongClientStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For PingPongClientStub"));
    return new PingPongClientStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _PingPongClient_pongName:
        var params = _PingPongClientPongParams.deserialize(
            message.payload);
        _impl.pong(params.pongValue);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  PingPongClient get impl => _impl;
  set impl(PingPongClient d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "PingPongClientStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _PingPongClientServiceDescription();
}


Map<String, mojom_types.UserDefinedType> _initDescriptions() {
  var map = new HashMap<String, mojom_types.UserDefinedType>();
  map["pingpong_service_PingPongService_SetClient_Params__"] =
    new mojom_types.UserDefinedType()
      ..structType = _pingpongServicePingPongServiceSetClientParams();
  map["pingpong_service_PingPongService_Ping_Params__"] =
    new mojom_types.UserDefinedType()
      ..structType = _pingpongServicePingPongServicePingParams();
  map["pingpong_service_PingPongService_PingTargetURL_Params__"] =
    new mojom_types.UserDefinedType()
      ..structType = _pingpongServicePingPongServicePingTargetUrlParams();
  map["pingpong_service_PingPongService_PingTargetURL_ResponseParams__"] =
    new mojom_types.UserDefinedType()
      ..structType = _pingpongServicePingPongServicePingTargetUrlResponseParams();
  map["pingpong_service_PingPongService_PingTargetService_Params__"] =
    new mojom_types.UserDefinedType()
      ..structType = _pingpongServicePingPongServicePingTargetServiceParams();
  map["pingpong_service_PingPongService_PingTargetService_ResponseParams__"] =
    new mojom_types.UserDefinedType()
      ..structType = _pingpongServicePingPongServicePingTargetServiceResponseParams();
  map["pingpong_service_PingPongService_GetPingPongService_Params__"] =
    new mojom_types.UserDefinedType()
      ..structType = _pingpongServicePingPongServiceGetPingPongServiceParams();
  map["pingpong_service_PingPongService_Quit_Params__"] =
    new mojom_types.UserDefinedType()
      ..structType = _pingpongServicePingPongServiceQuitParams();
  map["pingpong_service_PingPongClient_Pong_Params__"] =
    new mojom_types.UserDefinedType()
      ..structType = _pingpongServicePingPongClientPongParams();
  map["pingpong_service_PingPongService__"] =
    new mojom_types.UserDefinedType()
      ..interfaceType = _pingpongServicePingPongService();
  map["pingpong_service_PingPongClient__"] =
    new mojom_types.UserDefinedType()
      ..interfaceType = _pingpongServicePingPongClient();
  return map;
}

var _mojomDesc;
Map<String, mojom_types.UserDefinedType> getAllMojomTypeDefinitions() {
  if (_mojomDesc == null) {
    _mojomDesc = _initDescriptions();
  }
  return _mojomDesc;
}

