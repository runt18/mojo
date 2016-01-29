// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library web_socket_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo/mojo/network_error.mojom.dart' as network_error_mojom;



class _WebSocketConnectParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(48, 0)
  ];
  String url = null;
  List<String> protocols = null;
  String origin = null;
  core.MojoDataPipeConsumer sendStream = null;
  Object client = null;

  _WebSocketConnectParams() : super(kVersions.last.size);

  static _WebSocketConnectParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _WebSocketConnectParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _WebSocketConnectParams result = new _WebSocketConnectParams();

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
      
      var decoder1 = decoder0.decodePointer(16, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.protocols = new List<String>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.protocols[i1] = decoder1.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      result.origin = decoder0.decodeString(24, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.sendStream = decoder0.decodeConsumerHandle(32, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.client = decoder0.decodeServiceInterface(36, false, WebSocketClientProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeString(url, 8, false);
    
    if (protocols == null) {
      encoder0.encodeNullPointer(16, false);
    } else {
      var encoder1 = encoder0.encodePointerArray(protocols.length, 16, bindings.kUnspecifiedArrayLength);
      for (int i0 = 0; i0 < protocols.length; ++i0) {
        
        encoder1.encodeString(protocols[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
      }
    }
    
    encoder0.encodeString(origin, 24, false);
    
    encoder0.encodeConsumerHandle(sendStream, 32, false);
    
    encoder0.encodeInterface(client, 36, false);
  }

  String toString() {
    return "_WebSocketConnectParams("
           "url: $url" ", "
           "protocols: $protocols" ", "
           "origin: $origin" ", "
           "sendStream: $sendStream" ", "
           "client: $client" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




class _WebSocketSendParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  bool fin = false;
  WebSocketMessageType type = null;
  int numBytes = 0;

  _WebSocketSendParams() : super(kVersions.last.size);

  static _WebSocketSendParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _WebSocketSendParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _WebSocketSendParams result = new _WebSocketSendParams();

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
      
      result.fin = decoder0.decodeBool(8, 0);
    }
    if (mainDataHeader.version >= 0) {
      
        result.type = WebSocketMessageType.decode(decoder0, 12);
        if (result.type == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable WebSocketMessageType.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.numBytes = decoder0.decodeUint32(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeBool(fin, 8, 0);
    
    encoder0.encodeEnum(type, 12);
    
    encoder0.encodeUint32(numBytes, 16);
  }

  String toString() {
    return "_WebSocketSendParams("
           "fin: $fin" ", "
           "type: $type" ", "
           "numBytes: $numBytes" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["fin"] = fin;
    map["type"] = type;
    map["numBytes"] = numBytes;
    return map;
  }
}




class _WebSocketFlowControlParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int quota = 0;

  _WebSocketFlowControlParams() : super(kVersions.last.size);

  static _WebSocketFlowControlParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _WebSocketFlowControlParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _WebSocketFlowControlParams result = new _WebSocketFlowControlParams();

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
      
      result.quota = decoder0.decodeInt64(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInt64(quota, 8);
  }

  String toString() {
    return "_WebSocketFlowControlParams("
           "quota: $quota" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["quota"] = quota;
    return map;
  }
}




class _WebSocketCloseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int code = 0;
  String reason = null;

  _WebSocketCloseParams() : super(kVersions.last.size);

  static _WebSocketCloseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _WebSocketCloseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _WebSocketCloseParams result = new _WebSocketCloseParams();

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
      
      result.code = decoder0.decodeUint16(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.reason = decoder0.decodeString(16, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint16(code, 8);
    
    encoder0.encodeString(reason, 16, false);
  }

  String toString() {
    return "_WebSocketCloseParams("
           "code: $code" ", "
           "reason: $reason" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["code"] = code;
    map["reason"] = reason;
    return map;
  }
}




class _WebSocketClientDidConnectParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  String selectedSubprotocol = null;
  String extensions = null;
  core.MojoDataPipeConsumer receiveStream = null;

  _WebSocketClientDidConnectParams() : super(kVersions.last.size);

  static _WebSocketClientDidConnectParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _WebSocketClientDidConnectParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _WebSocketClientDidConnectParams result = new _WebSocketClientDidConnectParams();

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
      
      result.selectedSubprotocol = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.extensions = decoder0.decodeString(16, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.receiveStream = decoder0.decodeConsumerHandle(24, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeString(selectedSubprotocol, 8, false);
    
    encoder0.encodeString(extensions, 16, false);
    
    encoder0.encodeConsumerHandle(receiveStream, 24, false);
  }

  String toString() {
    return "_WebSocketClientDidConnectParams("
           "selectedSubprotocol: $selectedSubprotocol" ", "
           "extensions: $extensions" ", "
           "receiveStream: $receiveStream" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




class _WebSocketClientDidReceiveDataParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  bool fin = false;
  WebSocketMessageType type = null;
  int numBytes = 0;

  _WebSocketClientDidReceiveDataParams() : super(kVersions.last.size);

  static _WebSocketClientDidReceiveDataParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _WebSocketClientDidReceiveDataParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _WebSocketClientDidReceiveDataParams result = new _WebSocketClientDidReceiveDataParams();

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
      
      result.fin = decoder0.decodeBool(8, 0);
    }
    if (mainDataHeader.version >= 0) {
      
        result.type = WebSocketMessageType.decode(decoder0, 12);
        if (result.type == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable WebSocketMessageType.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.numBytes = decoder0.decodeUint32(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeBool(fin, 8, 0);
    
    encoder0.encodeEnum(type, 12);
    
    encoder0.encodeUint32(numBytes, 16);
  }

  String toString() {
    return "_WebSocketClientDidReceiveDataParams("
           "fin: $fin" ", "
           "type: $type" ", "
           "numBytes: $numBytes" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["fin"] = fin;
    map["type"] = type;
    map["numBytes"] = numBytes;
    return map;
  }
}




class _WebSocketClientDidReceiveFlowControlParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int quota = 0;

  _WebSocketClientDidReceiveFlowControlParams() : super(kVersions.last.size);

  static _WebSocketClientDidReceiveFlowControlParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _WebSocketClientDidReceiveFlowControlParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _WebSocketClientDidReceiveFlowControlParams result = new _WebSocketClientDidReceiveFlowControlParams();

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
      
      result.quota = decoder0.decodeInt64(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInt64(quota, 8);
  }

  String toString() {
    return "_WebSocketClientDidReceiveFlowControlParams("
           "quota: $quota" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["quota"] = quota;
    return map;
  }
}




class _WebSocketClientDidFailParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String message = null;

  _WebSocketClientDidFailParams() : super(kVersions.last.size);

  static _WebSocketClientDidFailParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _WebSocketClientDidFailParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _WebSocketClientDidFailParams result = new _WebSocketClientDidFailParams();

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
      
      result.message = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeString(message, 8, false);
  }

  String toString() {
    return "_WebSocketClientDidFailParams("
           "message: $message" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["message"] = message;
    return map;
  }
}




class _WebSocketClientDidCloseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  bool wasClean = false;
  int code = 0;
  String reason = null;

  _WebSocketClientDidCloseParams() : super(kVersions.last.size);

  static _WebSocketClientDidCloseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _WebSocketClientDidCloseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _WebSocketClientDidCloseParams result = new _WebSocketClientDidCloseParams();

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
      
      result.wasClean = decoder0.decodeBool(8, 0);
    }
    if (mainDataHeader.version >= 0) {
      
      result.code = decoder0.decodeUint16(10);
    }
    if (mainDataHeader.version >= 0) {
      
      result.reason = decoder0.decodeString(16, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeBool(wasClean, 8, 0);
    
    encoder0.encodeUint16(code, 10);
    
    encoder0.encodeString(reason, 16, false);
  }

  String toString() {
    return "_WebSocketClientDidCloseParams("
           "wasClean: $wasClean" ", "
           "code: $code" ", "
           "reason: $reason" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["wasClean"] = wasClean;
    map["code"] = code;
    map["reason"] = reason;
    return map;
  }
}




const int _WebSocket_connectName = 0;
const int _WebSocket_sendName = 1;
const int _WebSocket_flowControlName = 2;
const int _WebSocket_closeName = 3;
  
class WebSocketMessageType extends bindings.MojoEnum {
  static const WebSocketMessageType continuation = const WebSocketMessageType._(0);
  static const WebSocketMessageType text = const WebSocketMessageType._(1);
  static const WebSocketMessageType binary = const WebSocketMessageType._(2);

  const WebSocketMessageType._(int v) : super(v);

  static const Map<String, WebSocketMessageType> valuesMap = const {
    "continuation": continuation,
    "text": text,
    "binary": binary,
  };
  static const List<WebSocketMessageType> values = const [
    continuation,
    text,
    binary,
  ];

  static WebSocketMessageType valueOf(String name) => valuesMap[name];

  factory WebSocketMessageType(int v) {
    switch (v) {
      case 0:
        return continuation;
      case 1:
        return text;
      case 2:
        return binary;
      default:
        return null;
    }
  }

  static WebSocketMessageType decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    WebSocketMessageType result = new WebSocketMessageType(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum WebSocketMessageType.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case continuation:
        return 'WebSocketMessageType.continuation';
      case text:
        return 'WebSocketMessageType.text';
      case binary:
        return 'WebSocketMessageType.binary';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}





class _WebSocketServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class WebSocket {
  static const String serviceName = null;
  void connect(String url, List<String> protocols, String origin, core.MojoDataPipeConsumer sendStream, Object client);
  void send(bool fin, WebSocketMessageType type, int numBytes);
  void flowControl(int quota);
  void close(int code, String reason);
  static const int kAbnormalCloseCode = 1006;
}


class _WebSocketProxyImpl extends bindings.Proxy {
  _WebSocketProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _WebSocketProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _WebSocketProxyImpl.unbound() : super.unbound();

  static _WebSocketProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _WebSocketProxyImpl"));
    return new _WebSocketProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _WebSocketServiceDescription();

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
    return "_WebSocketProxyImpl($superString)";
  }
}


class _WebSocketProxyCalls implements WebSocket {
  _WebSocketProxyImpl _proxyImpl;

  _WebSocketProxyCalls(this._proxyImpl);
    void connect(String url, List<String> protocols, String origin, core.MojoDataPipeConsumer sendStream, Object client) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _WebSocketConnectParams();
      params.url = url;
      params.protocols = protocols;
      params.origin = origin;
      params.sendStream = sendStream;
      params.client = client;
      _proxyImpl.sendMessage(params, _WebSocket_connectName);
    }
    void send(bool fin, WebSocketMessageType type, int numBytes) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _WebSocketSendParams();
      params.fin = fin;
      params.type = type;
      params.numBytes = numBytes;
      _proxyImpl.sendMessage(params, _WebSocket_sendName);
    }
    void flowControl(int quota) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _WebSocketFlowControlParams();
      params.quota = quota;
      _proxyImpl.sendMessage(params, _WebSocket_flowControlName);
    }
    void close(int code, String reason) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _WebSocketCloseParams();
      params.code = code;
      params.reason = reason;
      _proxyImpl.sendMessage(params, _WebSocket_closeName);
    }
}


class WebSocketProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  WebSocket ptr;

  WebSocketProxy(_WebSocketProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _WebSocketProxyCalls(proxyImpl);

  WebSocketProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _WebSocketProxyImpl.fromEndpoint(endpoint) {
    ptr = new _WebSocketProxyCalls(impl);
  }

  WebSocketProxy.fromHandle(core.MojoHandle handle) :
      impl = new _WebSocketProxyImpl.fromHandle(handle) {
    ptr = new _WebSocketProxyCalls(impl);
  }

  WebSocketProxy.unbound() :
      impl = new _WebSocketProxyImpl.unbound() {
    ptr = new _WebSocketProxyCalls(impl);
  }

  factory WebSocketProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    WebSocketProxy p = new WebSocketProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static WebSocketProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For WebSocketProxy"));
    return new WebSocketProxy.fromEndpoint(endpoint);
  }

  String get serviceName => WebSocket.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "WebSocketProxy($impl)";
  }
}


class WebSocketStub extends bindings.Stub {
  WebSocket _impl = null;

  WebSocketStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  WebSocketStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  WebSocketStub.unbound() : super.unbound();

  static WebSocketStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For WebSocketStub"));
    return new WebSocketStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _WebSocket_connectName:
        var params = _WebSocketConnectParams.deserialize(
            message.payload);
        _impl.connect(params.url, params.protocols, params.origin, params.sendStream, params.client);
        break;
      case _WebSocket_sendName:
        var params = _WebSocketSendParams.deserialize(
            message.payload);
        _impl.send(params.fin, params.type, params.numBytes);
        break;
      case _WebSocket_flowControlName:
        var params = _WebSocketFlowControlParams.deserialize(
            message.payload);
        _impl.flowControl(params.quota);
        break;
      case _WebSocket_closeName:
        var params = _WebSocketCloseParams.deserialize(
            message.payload);
        _impl.close(params.code, params.reason);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  WebSocket get impl => _impl;
  set impl(WebSocket d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "WebSocketStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _WebSocketServiceDescription();
}

const int _WebSocketClient_didConnectName = 0;
const int _WebSocketClient_didReceiveDataName = 1;
const int _WebSocketClient_didReceiveFlowControlName = 2;
const int _WebSocketClient_didFailName = 3;
const int _WebSocketClient_didCloseName = 4;



class _WebSocketClientServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class WebSocketClient {
  static const String serviceName = null;
  void didConnect(String selectedSubprotocol, String extensions, core.MojoDataPipeConsumer receiveStream);
  void didReceiveData(bool fin, WebSocketMessageType type, int numBytes);
  void didReceiveFlowControl(int quota);
  void didFail(String message);
  void didClose(bool wasClean, int code, String reason);
}


class _WebSocketClientProxyImpl extends bindings.Proxy {
  _WebSocketClientProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _WebSocketClientProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _WebSocketClientProxyImpl.unbound() : super.unbound();

  static _WebSocketClientProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _WebSocketClientProxyImpl"));
    return new _WebSocketClientProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _WebSocketClientServiceDescription();

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
    return "_WebSocketClientProxyImpl($superString)";
  }
}


class _WebSocketClientProxyCalls implements WebSocketClient {
  _WebSocketClientProxyImpl _proxyImpl;

  _WebSocketClientProxyCalls(this._proxyImpl);
    void didConnect(String selectedSubprotocol, String extensions, core.MojoDataPipeConsumer receiveStream) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _WebSocketClientDidConnectParams();
      params.selectedSubprotocol = selectedSubprotocol;
      params.extensions = extensions;
      params.receiveStream = receiveStream;
      _proxyImpl.sendMessage(params, _WebSocketClient_didConnectName);
    }
    void didReceiveData(bool fin, WebSocketMessageType type, int numBytes) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _WebSocketClientDidReceiveDataParams();
      params.fin = fin;
      params.type = type;
      params.numBytes = numBytes;
      _proxyImpl.sendMessage(params, _WebSocketClient_didReceiveDataName);
    }
    void didReceiveFlowControl(int quota) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _WebSocketClientDidReceiveFlowControlParams();
      params.quota = quota;
      _proxyImpl.sendMessage(params, _WebSocketClient_didReceiveFlowControlName);
    }
    void didFail(String message) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _WebSocketClientDidFailParams();
      params.message = message;
      _proxyImpl.sendMessage(params, _WebSocketClient_didFailName);
    }
    void didClose(bool wasClean, int code, String reason) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _WebSocketClientDidCloseParams();
      params.wasClean = wasClean;
      params.code = code;
      params.reason = reason;
      _proxyImpl.sendMessage(params, _WebSocketClient_didCloseName);
    }
}


class WebSocketClientProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  WebSocketClient ptr;

  WebSocketClientProxy(_WebSocketClientProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _WebSocketClientProxyCalls(proxyImpl);

  WebSocketClientProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _WebSocketClientProxyImpl.fromEndpoint(endpoint) {
    ptr = new _WebSocketClientProxyCalls(impl);
  }

  WebSocketClientProxy.fromHandle(core.MojoHandle handle) :
      impl = new _WebSocketClientProxyImpl.fromHandle(handle) {
    ptr = new _WebSocketClientProxyCalls(impl);
  }

  WebSocketClientProxy.unbound() :
      impl = new _WebSocketClientProxyImpl.unbound() {
    ptr = new _WebSocketClientProxyCalls(impl);
  }

  factory WebSocketClientProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    WebSocketClientProxy p = new WebSocketClientProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static WebSocketClientProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For WebSocketClientProxy"));
    return new WebSocketClientProxy.fromEndpoint(endpoint);
  }

  String get serviceName => WebSocketClient.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "WebSocketClientProxy($impl)";
  }
}


class WebSocketClientStub extends bindings.Stub {
  WebSocketClient _impl = null;

  WebSocketClientStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  WebSocketClientStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  WebSocketClientStub.unbound() : super.unbound();

  static WebSocketClientStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For WebSocketClientStub"));
    return new WebSocketClientStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _WebSocketClient_didConnectName:
        var params = _WebSocketClientDidConnectParams.deserialize(
            message.payload);
        _impl.didConnect(params.selectedSubprotocol, params.extensions, params.receiveStream);
        break;
      case _WebSocketClient_didReceiveDataName:
        var params = _WebSocketClientDidReceiveDataParams.deserialize(
            message.payload);
        _impl.didReceiveData(params.fin, params.type, params.numBytes);
        break;
      case _WebSocketClient_didReceiveFlowControlName:
        var params = _WebSocketClientDidReceiveFlowControlParams.deserialize(
            message.payload);
        _impl.didReceiveFlowControl(params.quota);
        break;
      case _WebSocketClient_didFailName:
        var params = _WebSocketClientDidFailParams.deserialize(
            message.payload);
        _impl.didFail(params.message);
        break;
      case _WebSocketClient_didCloseName:
        var params = _WebSocketClientDidCloseParams.deserialize(
            message.payload);
        _impl.didClose(params.wasClean, params.code, params.reason);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  WebSocketClient get impl => _impl;
  set impl(WebSocketClient d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "WebSocketClientStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _WebSocketClientServiceDescription();
}



