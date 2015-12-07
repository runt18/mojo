// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library clipboard_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;



class ClipboardGetSequenceNumberParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  ClipboardType clipboardType = null;

  ClipboardGetSequenceNumberParams() : super(kVersions.last.size);

  static ClipboardGetSequenceNumberParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ClipboardGetSequenceNumberParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ClipboardGetSequenceNumberParams result = new ClipboardGetSequenceNumberParams();

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
      
        result.clipboardType = ClipboardType.decode(decoder0, 8);
        if (result.clipboardType == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable ClipboardType.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(clipboardType, 8);
  }

  String toString() {
    return "ClipboardGetSequenceNumberParams("
           "clipboardType: $clipboardType" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["clipboardType"] = clipboardType;
    return map;
  }
}


class ClipboardGetSequenceNumberResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int sequence = 0;

  ClipboardGetSequenceNumberResponseParams() : super(kVersions.last.size);

  static ClipboardGetSequenceNumberResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ClipboardGetSequenceNumberResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ClipboardGetSequenceNumberResponseParams result = new ClipboardGetSequenceNumberResponseParams();

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
      
      result.sequence = decoder0.decodeUint64(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint64(sequence, 8);
  }

  String toString() {
    return "ClipboardGetSequenceNumberResponseParams("
           "sequence: $sequence" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["sequence"] = sequence;
    return map;
  }
}


class ClipboardGetAvailableMimeTypesParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  ClipboardType clipboardTypes = null;

  ClipboardGetAvailableMimeTypesParams() : super(kVersions.last.size);

  static ClipboardGetAvailableMimeTypesParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ClipboardGetAvailableMimeTypesParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ClipboardGetAvailableMimeTypesParams result = new ClipboardGetAvailableMimeTypesParams();

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
      
        result.clipboardTypes = ClipboardType.decode(decoder0, 8);
        if (result.clipboardTypes == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable ClipboardType.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(clipboardTypes, 8);
  }

  String toString() {
    return "ClipboardGetAvailableMimeTypesParams("
           "clipboardTypes: $clipboardTypes" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["clipboardTypes"] = clipboardTypes;
    return map;
  }
}


class ClipboardGetAvailableMimeTypesResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<String> types = null;

  ClipboardGetAvailableMimeTypesResponseParams() : super(kVersions.last.size);

  static ClipboardGetAvailableMimeTypesResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ClipboardGetAvailableMimeTypesResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ClipboardGetAvailableMimeTypesResponseParams result = new ClipboardGetAvailableMimeTypesResponseParams();

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
        result.types = new List<String>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.types[i1] = decoder1.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    if (types == null) {
      encoder0.encodeNullPointer(8, false);
    } else {
      var encoder1 = encoder0.encodePointerArray(types.length, 8, bindings.kUnspecifiedArrayLength);
      for (int i0 = 0; i0 < types.length; ++i0) {
        
        encoder1.encodeString(types[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
      }
    }
  }

  String toString() {
    return "ClipboardGetAvailableMimeTypesResponseParams("
           "types: $types" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["types"] = types;
    return map;
  }
}


class ClipboardReadMimeTypeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  ClipboardType clipboardType = null;
  String mimeType = null;

  ClipboardReadMimeTypeParams() : super(kVersions.last.size);

  static ClipboardReadMimeTypeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ClipboardReadMimeTypeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ClipboardReadMimeTypeParams result = new ClipboardReadMimeTypeParams();

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
      
        result.clipboardType = ClipboardType.decode(decoder0, 8);
        if (result.clipboardType == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable ClipboardType.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.mimeType = decoder0.decodeString(16, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(clipboardType, 8);
    
    encoder0.encodeString(mimeType, 16, false);
  }

  String toString() {
    return "ClipboardReadMimeTypeParams("
           "clipboardType: $clipboardType" ", "
           "mimeType: $mimeType" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["clipboardType"] = clipboardType;
    map["mimeType"] = mimeType;
    return map;
  }
}


class ClipboardReadMimeTypeResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<int> data = null;

  ClipboardReadMimeTypeResponseParams() : super(kVersions.last.size);

  static ClipboardReadMimeTypeResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ClipboardReadMimeTypeResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ClipboardReadMimeTypeResponseParams result = new ClipboardReadMimeTypeResponseParams();

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
      
      result.data = decoder0.decodeUint8Array(8, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint8Array(data, 8, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
  }

  String toString() {
    return "ClipboardReadMimeTypeResponseParams("
           "data: $data" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["data"] = data;
    return map;
  }
}


class ClipboardWriteClipboardDataParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  ClipboardType clipboardType = null;
  Map<String, List<int>> data = null;

  ClipboardWriteClipboardDataParams() : super(kVersions.last.size);

  static ClipboardWriteClipboardDataParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ClipboardWriteClipboardDataParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ClipboardWriteClipboardDataParams result = new ClipboardWriteClipboardDataParams();

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
      
        result.clipboardType = ClipboardType.decode(decoder0, 8);
        if (result.clipboardType == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable ClipboardType.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      if (decoder1 == null) {
        result.data = null;
      } else {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<List<int>> values0;
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
            values0 = new List<List<int>>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              values0[i2] = decoder2.decodeUint8Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
            }
          }
        }
        result.data = new Map<String, List<int>>.fromIterables(
            keys0, values0);
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(clipboardType, 8);
    
    if (data == null) {
      encoder0.encodeNullPointer(16, true);
    } else {
      var encoder1 = encoder0.encoderForMap(16);
      int size0 = data.length;
      var keys0 = data.keys.toList();
      var values0 = data.values.toList();
      
      {
        var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
        for (int i1 = 0; i1 < keys0.length; ++i1) {
          
          encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
      
      {
        var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
        for (int i1 = 0; i1 < values0.length; ++i1) {
          
          encoder2.encodeUint8Array(values0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
      }
    }
  }

  String toString() {
    return "ClipboardWriteClipboardDataParams("
           "clipboardType: $clipboardType" ", "
           "data: $data" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["clipboardType"] = clipboardType;
    map["data"] = data;
    return map;
  }
}

const int kClipboard_getSequenceNumber_name = 0;
const int kClipboard_getAvailableMimeTypes_name = 1;
const int kClipboard_readMimeType_name = 2;
const int kClipboard_writeClipboardData_name = 3;
const String ClipboardName = "mojo::Clipboard";
  class ClipboardType extends bindings.MojoEnum {
  static const COPY_PASTE = const ClipboardType._(0);
  static const SELECTION = const ClipboardType._(1);
  static const DRAG = const ClipboardType._(2);

  const ClipboardType._(int v) : super(v);

  static const Map<String, ClipboardType> valuesMap = const {
    "COPY_PASTE": COPY_PASTE,
    "SELECTION": SELECTION,
    "DRAG": DRAG,
  };
  static const List<ClipboardType> values = const [
    COPY_PASTE,
    SELECTION,
    DRAG,
  ];

  static ClipboardType valueOf(String name) => valuesMap[name];

  factory ClipboardType(int v) {
    switch (v) {
      case 0:
        return COPY_PASTE;
      case 1:
        return SELECTION;
      case 2:
        return DRAG;
      default:
        return null;
    }
  }

  static ClipboardType decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    ClipboardType result = new ClipboardType(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum ClipboardType.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case COPY_PASTE:
        return 'ClipboardType.COPY_PASTE';
      case SELECTION:
        return 'ClipboardType.SELECTION';
      case DRAG:
        return 'ClipboardType.DRAG';
    }
  }

  int toJson() => value;
}

abstract class Clipboard {
  dynamic getSequenceNumber(ClipboardType clipboardType,[Function responseFactory = null]);
  dynamic getAvailableMimeTypes(ClipboardType clipboardTypes,[Function responseFactory = null]);
  dynamic readMimeType(ClipboardType clipboardType,String mimeType,[Function responseFactory = null]);
  void writeClipboardData(ClipboardType clipboardType, Map<String, List<int>> data);

  static const MIME_TYPE_TEXT = "text/plain";
  static const MIME_TYPE_HTML = "text/html";
  static const MIME_TYPE_URL = "text/url";
}


class ClipboardProxyImpl extends bindings.Proxy {
  ClipboardProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  ClipboardProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  ClipboardProxyImpl.unbound() : super.unbound();

  static ClipboardProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ClipboardProxyImpl"));
    return new ClipboardProxyImpl.fromEndpoint(endpoint);
  }

  String get name => ClipboardName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case kClipboard_getSequenceNumber_name:
        var r = ClipboardGetSequenceNumberResponseParams.deserialize(
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
      case kClipboard_getAvailableMimeTypes_name:
        var r = ClipboardGetAvailableMimeTypesResponseParams.deserialize(
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
      case kClipboard_readMimeType_name:
        var r = ClipboardReadMimeTypeResponseParams.deserialize(
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
    return "ClipboardProxyImpl($superString)";
  }
}


class _ClipboardProxyCalls implements Clipboard {
  ClipboardProxyImpl _proxyImpl;

  _ClipboardProxyCalls(this._proxyImpl);
    dynamic getSequenceNumber(ClipboardType clipboardType,[Function responseFactory = null]) {
      var params = new ClipboardGetSequenceNumberParams();
      params.clipboardType = clipboardType;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kClipboard_getSequenceNumber_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic getAvailableMimeTypes(ClipboardType clipboardTypes,[Function responseFactory = null]) {
      var params = new ClipboardGetAvailableMimeTypesParams();
      params.clipboardTypes = clipboardTypes;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kClipboard_getAvailableMimeTypes_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic readMimeType(ClipboardType clipboardType,String mimeType,[Function responseFactory = null]) {
      var params = new ClipboardReadMimeTypeParams();
      params.clipboardType = clipboardType;
      params.mimeType = mimeType;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kClipboard_readMimeType_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    void writeClipboardData(ClipboardType clipboardType, Map<String, List<int>> data) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new ClipboardWriteClipboardDataParams();
      params.clipboardType = clipboardType;
      params.data = data;
      _proxyImpl.sendMessage(params, kClipboard_writeClipboardData_name);
    }
  
}


class ClipboardProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  Clipboard ptr;
  final String name = ClipboardName;

  ClipboardProxy(ClipboardProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ClipboardProxyCalls(proxyImpl);

  ClipboardProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new ClipboardProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ClipboardProxyCalls(impl);
  }

  ClipboardProxy.fromHandle(core.MojoHandle handle) :
      impl = new ClipboardProxyImpl.fromHandle(handle) {
    ptr = new _ClipboardProxyCalls(impl);
  }

  ClipboardProxy.unbound() :
      impl = new ClipboardProxyImpl.unbound() {
    ptr = new _ClipboardProxyCalls(impl);
  }

  factory ClipboardProxy.connectToService(
      bindings.ServiceConnector s, String url) {
    ClipboardProxy p = new ClipboardProxy.unbound();
    s.connectToService(url, p);
    return p;
  }

  static ClipboardProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ClipboardProxy"));
    return new ClipboardProxy.fromEndpoint(endpoint);
  }

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "ClipboardProxy($impl)";
  }
}


class ClipboardStub extends bindings.Stub {
  Clipboard _impl = null;

  ClipboardStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  ClipboardStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  ClipboardStub.unbound() : super.unbound();

  static ClipboardStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ClipboardStub"));
    return new ClipboardStub.fromEndpoint(endpoint);
  }

  static const String name = ClipboardName;


  ClipboardGetSequenceNumberResponseParams _ClipboardGetSequenceNumberResponseParamsFactory(int sequence) {
    var mojo_factory_result = new ClipboardGetSequenceNumberResponseParams();
    mojo_factory_result.sequence = sequence;
    return mojo_factory_result;
  }
  ClipboardGetAvailableMimeTypesResponseParams _ClipboardGetAvailableMimeTypesResponseParamsFactory(List<String> types) {
    var mojo_factory_result = new ClipboardGetAvailableMimeTypesResponseParams();
    mojo_factory_result.types = types;
    return mojo_factory_result;
  }
  ClipboardReadMimeTypeResponseParams _ClipboardReadMimeTypeResponseParamsFactory(List<int> data) {
    var mojo_factory_result = new ClipboardReadMimeTypeResponseParams();
    mojo_factory_result.data = data;
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
      case kClipboard_getSequenceNumber_name:
        var params = ClipboardGetSequenceNumberParams.deserialize(
            message.payload);
        var response = _impl.getSequenceNumber(params.clipboardType,_ClipboardGetSequenceNumberResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kClipboard_getSequenceNumber_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kClipboard_getSequenceNumber_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kClipboard_getAvailableMimeTypes_name:
        var params = ClipboardGetAvailableMimeTypesParams.deserialize(
            message.payload);
        var response = _impl.getAvailableMimeTypes(params.clipboardTypes,_ClipboardGetAvailableMimeTypesResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kClipboard_getAvailableMimeTypes_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kClipboard_getAvailableMimeTypes_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kClipboard_readMimeType_name:
        var params = ClipboardReadMimeTypeParams.deserialize(
            message.payload);
        var response = _impl.readMimeType(params.clipboardType,params.mimeType,_ClipboardReadMimeTypeResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kClipboard_readMimeType_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kClipboard_readMimeType_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kClipboard_writeClipboardData_name:
        var params = ClipboardWriteClipboardDataParams.deserialize(
            message.payload);
        _impl.writeClipboardData(params.clipboardType, params.data);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  Clipboard get impl => _impl;
  set impl(Clipboard d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "ClipboardStub($superString)";
  }

  int get version => 0;
}


