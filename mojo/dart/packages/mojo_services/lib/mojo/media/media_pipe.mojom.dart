// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library media_pipe_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo_services/mojo/media/media_common.mojom.dart' as media_common_mojom;



class MediaPacketRegion extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int offset = 0;
  int length = 0;

  MediaPacketRegion() : super(kVersions.last.size);

  static MediaPacketRegion deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaPacketRegion decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaPacketRegion result = new MediaPacketRegion();

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
      
      result.offset = decoder0.decodeUint64(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.length = decoder0.decodeUint64(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint64(offset, 8);
    
    encoder0.encodeUint64(length, 16);
  }

  String toString() {
    return "MediaPacketRegion("
           "offset: $offset" ", "
           "length: $length" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["offset"] = offset;
    map["length"] = length;
    return map;
  }
}


class MediaPacket extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(48, 0)
  ];
  static const int kNoTimestamp = 0x7fffffffffffffff;
  int pts = 0x7fffffffffffffff;
  int duration = 0;
  bool endOfStream = false;
  MediaPacketRegion payload = null;
  List<MediaPacketRegion> extraPayload = null;

  MediaPacket() : super(kVersions.last.size);

  static MediaPacket deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaPacket decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaPacket result = new MediaPacket();

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
      
      result.pts = decoder0.decodeInt64(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.duration = decoder0.decodeUint64(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.endOfStream = decoder0.decodeBool(24, 0);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(32, false);
      result.payload = MediaPacketRegion.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(40, true);
      if (decoder1 == null) {
        result.extraPayload = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.extraPayload = new List<MediaPacketRegion>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.extraPayload[i1] = MediaPacketRegion.decode(decoder2);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInt64(pts, 8);
    
    encoder0.encodeUint64(duration, 16);
    
    encoder0.encodeBool(endOfStream, 24, 0);
    
    encoder0.encodeStruct(payload, 32, false);
    
    if (extraPayload == null) {
      encoder0.encodeNullPointer(40, true);
    } else {
      var encoder1 = encoder0.encodePointerArray(extraPayload.length, 40, bindings.kUnspecifiedArrayLength);
      for (int i0 = 0; i0 < extraPayload.length; ++i0) {
        
        encoder1.encodeStruct(extraPayload[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
      }
    }
  }

  String toString() {
    return "MediaPacket("
           "pts: $pts" ", "
           "duration: $duration" ", "
           "endOfStream: $endOfStream" ", "
           "payload: $payload" ", "
           "extraPayload: $extraPayload" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["pts"] = pts;
    map["duration"] = duration;
    map["endOfStream"] = endOfStream;
    map["payload"] = payload;
    map["extraPayload"] = extraPayload;
    return map;
  }
}


class MediaPipeState extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  static const int kMaxPayloadLen = 0x3FFFFFFFFFFFFFFF;
  core.MojoSharedBuffer payloadBuffer = null;
  int payloadBufferLen = 0;

  MediaPipeState() : super(kVersions.last.size);

  static MediaPipeState deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaPipeState decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaPipeState result = new MediaPipeState();

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
      
      result.payloadBuffer = decoder0.decodeSharedBufferHandle(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.payloadBufferLen = decoder0.decodeUint64(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeSharedBufferHandle(payloadBuffer, 8, false);
    
    encoder0.encodeUint64(payloadBufferLen, 16);
  }

  String toString() {
    return "MediaPipeState("
           "payloadBuffer: $payloadBuffer" ", "
           "payloadBufferLen: $payloadBufferLen" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _MediaPipeGetStateParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _MediaPipeGetStateParams() : super(kVersions.last.size);

  static _MediaPipeGetStateParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaPipeGetStateParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaPipeGetStateParams result = new _MediaPipeGetStateParams();

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
    return "_MediaPipeGetStateParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class MediaPipeGetStateResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  MediaPipeState state = null;

  MediaPipeGetStateResponseParams() : super(kVersions.last.size);

  static MediaPipeGetStateResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaPipeGetStateResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaPipeGetStateResponseParams result = new MediaPipeGetStateResponseParams();

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
      result.state = MediaPipeState.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(state, 8, false);
  }

  String toString() {
    return "MediaPipeGetStateResponseParams("
           "state: $state" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _MediaPipeSendPacketParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  MediaPacket packet = null;

  _MediaPipeSendPacketParams() : super(kVersions.last.size);

  static _MediaPipeSendPacketParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaPipeSendPacketParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaPipeSendPacketParams result = new _MediaPipeSendPacketParams();

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
      result.packet = MediaPacket.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(packet, 8, false);
  }

  String toString() {
    return "_MediaPipeSendPacketParams("
           "packet: $packet" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["packet"] = packet;
    return map;
  }
}


class MediaPipeSendPacketResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  media_common_mojom.MediaResult result = null;

  MediaPipeSendPacketResponseParams() : super(kVersions.last.size);

  static MediaPipeSendPacketResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaPipeSendPacketResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaPipeSendPacketResponseParams result = new MediaPipeSendPacketResponseParams();

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
      
        result.result = media_common_mojom.MediaResult.decode(decoder0, 8);
        if (result.result == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable media_common_mojom.MediaResult.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(result, 8);
  }

  String toString() {
    return "MediaPipeSendPacketResponseParams("
           "result: $result" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["result"] = result;
    return map;
  }
}


class _MediaPipeFlushParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _MediaPipeFlushParams() : super(kVersions.last.size);

  static _MediaPipeFlushParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaPipeFlushParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaPipeFlushParams result = new _MediaPipeFlushParams();

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
    return "_MediaPipeFlushParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class MediaPipeFlushResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  media_common_mojom.MediaResult result = null;

  MediaPipeFlushResponseParams() : super(kVersions.last.size);

  static MediaPipeFlushResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaPipeFlushResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaPipeFlushResponseParams result = new MediaPipeFlushResponseParams();

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
      
        result.result = media_common_mojom.MediaResult.decode(decoder0, 8);
        if (result.result == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable media_common_mojom.MediaResult.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(result, 8);
  }

  String toString() {
    return "MediaPipeFlushResponseParams("
           "result: $result" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["result"] = result;
    return map;
  }
}

const int _MediaPipe_getStateName = 0;
const int _MediaPipe_sendPacketName = 1;
const int _MediaPipe_flushName = 2;

abstract class MediaPipe {
  static const String serviceName = null;
  dynamic getState([Function responseFactory = null]);
  dynamic sendPacket(MediaPacket packet,[Function responseFactory = null]);
  dynamic flush([Function responseFactory = null]);
}


class _MediaPipeProxyImpl extends bindings.Proxy {
  _MediaPipeProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _MediaPipeProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _MediaPipeProxyImpl.unbound() : super.unbound();

  static _MediaPipeProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _MediaPipeProxyImpl"));
    return new _MediaPipeProxyImpl.fromEndpoint(endpoint);
  }

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _MediaPipe_getStateName:
        var r = MediaPipeGetStateResponseParams.deserialize(
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
      case _MediaPipe_sendPacketName:
        var r = MediaPipeSendPacketResponseParams.deserialize(
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
      case _MediaPipe_flushName:
        var r = MediaPipeFlushResponseParams.deserialize(
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
    return "_MediaPipeProxyImpl($superString)";
  }
}


class _MediaPipeProxyCalls implements MediaPipe {
  _MediaPipeProxyImpl _proxyImpl;

  _MediaPipeProxyCalls(this._proxyImpl);
    dynamic getState([Function responseFactory = null]) {
      var params = new _MediaPipeGetStateParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _MediaPipe_getStateName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic sendPacket(MediaPacket packet,[Function responseFactory = null]) {
      var params = new _MediaPipeSendPacketParams();
      params.packet = packet;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _MediaPipe_sendPacketName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic flush([Function responseFactory = null]) {
      var params = new _MediaPipeFlushParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _MediaPipe_flushName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class MediaPipeProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  MediaPipe ptr;

  MediaPipeProxy(_MediaPipeProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _MediaPipeProxyCalls(proxyImpl);

  MediaPipeProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _MediaPipeProxyImpl.fromEndpoint(endpoint) {
    ptr = new _MediaPipeProxyCalls(impl);
  }

  MediaPipeProxy.fromHandle(core.MojoHandle handle) :
      impl = new _MediaPipeProxyImpl.fromHandle(handle) {
    ptr = new _MediaPipeProxyCalls(impl);
  }

  MediaPipeProxy.unbound() :
      impl = new _MediaPipeProxyImpl.unbound() {
    ptr = new _MediaPipeProxyCalls(impl);
  }

  factory MediaPipeProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    MediaPipeProxy p = new MediaPipeProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static MediaPipeProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MediaPipeProxy"));
    return new MediaPipeProxy.fromEndpoint(endpoint);
  }

  String get serviceName => MediaPipe.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "MediaPipeProxy($impl)";
  }
}


class MediaPipeStub extends bindings.Stub {
  MediaPipe _impl = null;

  MediaPipeStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  MediaPipeStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  MediaPipeStub.unbound() : super.unbound();

  static MediaPipeStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MediaPipeStub"));
    return new MediaPipeStub.fromEndpoint(endpoint);
  }


  MediaPipeGetStateResponseParams _MediaPipeGetStateResponseParamsFactory(MediaPipeState state) {
    var mojo_factory_result = new MediaPipeGetStateResponseParams();
    mojo_factory_result.state = state;
    return mojo_factory_result;
  }
  MediaPipeSendPacketResponseParams _MediaPipeSendPacketResponseParamsFactory(media_common_mojom.MediaResult result) {
    var mojo_factory_result = new MediaPipeSendPacketResponseParams();
    mojo_factory_result.result = result;
    return mojo_factory_result;
  }
  MediaPipeFlushResponseParams _MediaPipeFlushResponseParamsFactory(media_common_mojom.MediaResult result) {
    var mojo_factory_result = new MediaPipeFlushResponseParams();
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
      case _MediaPipe_getStateName:
        var params = _MediaPipeGetStateParams.deserialize(
            message.payload);
        var response = _impl.getState(_MediaPipeGetStateResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _MediaPipe_getStateName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _MediaPipe_getStateName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _MediaPipe_sendPacketName:
        var params = _MediaPipeSendPacketParams.deserialize(
            message.payload);
        var response = _impl.sendPacket(params.packet,_MediaPipeSendPacketResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _MediaPipe_sendPacketName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _MediaPipe_sendPacketName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _MediaPipe_flushName:
        var params = _MediaPipeFlushParams.deserialize(
            message.payload);
        var response = _impl.flush(_MediaPipeFlushResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _MediaPipe_flushName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _MediaPipe_flushName,
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

  MediaPipe get impl => _impl;
  set impl(MediaPipe d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "MediaPipeStub($superString)";
  }

  int get version => 0;
}


