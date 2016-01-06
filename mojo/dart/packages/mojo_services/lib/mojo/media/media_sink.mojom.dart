// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library media_sink_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo_services/mojo/media/media_clock.mojom.dart' as media_clock_mojom;
import 'package:mojo_services/mojo/media/media_common.mojom.dart' as media_common_mojom;
import 'package:mojo_services/mojo/media/media_state.mojom.dart' as media_state_mojom;
import 'package:mojo_services/mojo/media/media_transport.mojom.dart' as media_transport_mojom;
import 'package:mojo_services/mojo/media/media_types.mojom.dart' as media_types_mojom;
import 'package:mojo_services/mojo/media/rate_control.mojom.dart' as rate_control_mojom;



class MediaSinkStatus extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  media_state_mojom.MediaState state = null;
  rate_control_mojom.TimelineTransform timelineTransform = null;

  MediaSinkStatus() : super(kVersions.last.size);

  static MediaSinkStatus deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaSinkStatus decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaSinkStatus result = new MediaSinkStatus();

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
      
        result.state = media_state_mojom.MediaState.decode(decoder0, 8);
        if (result.state == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable media_state_mojom.MediaState.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.timelineTransform = rate_control_mojom.TimelineTransform.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(state, 8);
    
    encoder0.encodeStruct(timelineTransform, 16, true);
  }

  String toString() {
    return "MediaSinkStatus("
           "state: $state" ", "
           "timelineTransform: $timelineTransform" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["state"] = state;
    map["timelineTransform"] = timelineTransform;
    return map;
  }
}


class _MediaSinkGetClockDispositionParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _MediaSinkGetClockDispositionParams() : super(kVersions.last.size);

  static _MediaSinkGetClockDispositionParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaSinkGetClockDispositionParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaSinkGetClockDispositionParams result = new _MediaSinkGetClockDispositionParams();

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
    return "_MediaSinkGetClockDispositionParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class MediaSinkGetClockDispositionResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  media_clock_mojom.ClockDisposition clockDisposition = null;

  MediaSinkGetClockDispositionResponseParams() : super(kVersions.last.size);

  static MediaSinkGetClockDispositionResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaSinkGetClockDispositionResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaSinkGetClockDispositionResponseParams result = new MediaSinkGetClockDispositionResponseParams();

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
      
        result.clockDisposition = media_clock_mojom.ClockDisposition.decode(decoder0, 8);
        if (result.clockDisposition == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable media_clock_mojom.ClockDisposition.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(clockDisposition, 8);
  }

  String toString() {
    return "MediaSinkGetClockDispositionResponseParams("
           "clockDisposition: $clockDisposition" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["clockDisposition"] = clockDisposition;
    return map;
  }
}


class _MediaSinkGetMasterClockParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object masterClock = null;

  _MediaSinkGetMasterClockParams() : super(kVersions.last.size);

  static _MediaSinkGetMasterClockParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaSinkGetMasterClockParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaSinkGetMasterClockParams result = new _MediaSinkGetMasterClockParams();

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
      
      result.masterClock = decoder0.decodeInterfaceRequest(8, false, media_clock_mojom.ClockStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInterfaceRequest(masterClock, 8, false);
  }

  String toString() {
    return "_MediaSinkGetMasterClockParams("
           "masterClock: $masterClock" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _MediaSinkSetMasterClockParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object masterClock = null;

  _MediaSinkSetMasterClockParams() : super(kVersions.last.size);

  static _MediaSinkSetMasterClockParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaSinkSetMasterClockParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaSinkSetMasterClockParams result = new _MediaSinkSetMasterClockParams();

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
      
      result.masterClock = decoder0.decodeServiceInterface(8, true, media_clock_mojom.ClockProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInterface(masterClock, 8, true);
  }

  String toString() {
    return "_MediaSinkSetMasterClockParams("
           "masterClock: $masterClock" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _MediaSinkGetConsumerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object consumer = null;

  _MediaSinkGetConsumerParams() : super(kVersions.last.size);

  static _MediaSinkGetConsumerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaSinkGetConsumerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaSinkGetConsumerParams result = new _MediaSinkGetConsumerParams();

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
      
      result.consumer = decoder0.decodeInterfaceRequest(8, false, media_transport_mojom.MediaConsumerStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInterfaceRequest(consumer, 8, false);
  }

  String toString() {
    return "_MediaSinkGetConsumerParams("
           "consumer: $consumer" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _MediaSinkGetStatusParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int versionLastSeen = 0;

  _MediaSinkGetStatusParams() : super(kVersions.last.size);

  static _MediaSinkGetStatusParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaSinkGetStatusParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaSinkGetStatusParams result = new _MediaSinkGetStatusParams();

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
      
      result.versionLastSeen = decoder0.decodeUint64(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint64(versionLastSeen, 8);
  }

  String toString() {
    return "_MediaSinkGetStatusParams("
           "versionLastSeen: $versionLastSeen" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["versionLastSeen"] = versionLastSeen;
    return map;
  }
}


class MediaSinkGetStatusResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int version = 0;
  MediaSinkStatus status = null;

  MediaSinkGetStatusResponseParams() : super(kVersions.last.size);

  static MediaSinkGetStatusResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaSinkGetStatusResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaSinkGetStatusResponseParams result = new MediaSinkGetStatusResponseParams();

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
      
      result.version = decoder0.decodeUint64(8);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.status = MediaSinkStatus.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint64(version, 8);
    
    encoder0.encodeStruct(status, 16, false);
  }

  String toString() {
    return "MediaSinkGetStatusResponseParams("
           "version: $version" ", "
           "status: $status" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["version"] = version;
    map["status"] = status;
    return map;
  }
}


class _MediaSinkPlayParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _MediaSinkPlayParams() : super(kVersions.last.size);

  static _MediaSinkPlayParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaSinkPlayParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaSinkPlayParams result = new _MediaSinkPlayParams();

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
    return "_MediaSinkPlayParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _MediaSinkPauseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _MediaSinkPauseParams() : super(kVersions.last.size);

  static _MediaSinkPauseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaSinkPauseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaSinkPauseParams result = new _MediaSinkPauseParams();

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
    return "_MediaSinkPauseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

const int _MediaSink_getClockDispositionName = 0;
const int _MediaSink_getMasterClockName = 1;
const int _MediaSink_setMasterClockName = 2;
const int _MediaSink_getConsumerName = 3;
const int _MediaSink_getStatusName = 4;
const int _MediaSink_playName = 5;
const int _MediaSink_pauseName = 6;

abstract class MediaSink {
  static const String serviceName = null;
  dynamic getClockDisposition([Function responseFactory = null]);
  void getMasterClock(Object masterClock);
  void setMasterClock(Object masterClock);
  void getConsumer(Object consumer);
  dynamic getStatus(int versionLastSeen,[Function responseFactory = null]);
  void play();
  void pause();
}


class _MediaSinkProxyImpl extends bindings.Proxy {
  _MediaSinkProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _MediaSinkProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _MediaSinkProxyImpl.unbound() : super.unbound();

  static _MediaSinkProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _MediaSinkProxyImpl"));
    return new _MediaSinkProxyImpl.fromEndpoint(endpoint);
  }

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _MediaSink_getClockDispositionName:
        var r = MediaSinkGetClockDispositionResponseParams.deserialize(
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
      case _MediaSink_getStatusName:
        var r = MediaSinkGetStatusResponseParams.deserialize(
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
    return "_MediaSinkProxyImpl($superString)";
  }
}


class _MediaSinkProxyCalls implements MediaSink {
  _MediaSinkProxyImpl _proxyImpl;

  _MediaSinkProxyCalls(this._proxyImpl);
    dynamic getClockDisposition([Function responseFactory = null]) {
      var params = new _MediaSinkGetClockDispositionParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _MediaSink_getClockDispositionName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    void getMasterClock(Object masterClock) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _MediaSinkGetMasterClockParams();
      params.masterClock = masterClock;
      _proxyImpl.sendMessage(params, _MediaSink_getMasterClockName);
    }
    void setMasterClock(Object masterClock) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _MediaSinkSetMasterClockParams();
      params.masterClock = masterClock;
      _proxyImpl.sendMessage(params, _MediaSink_setMasterClockName);
    }
    void getConsumer(Object consumer) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _MediaSinkGetConsumerParams();
      params.consumer = consumer;
      _proxyImpl.sendMessage(params, _MediaSink_getConsumerName);
    }
    dynamic getStatus(int versionLastSeen,[Function responseFactory = null]) {
      var params = new _MediaSinkGetStatusParams();
      params.versionLastSeen = versionLastSeen;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _MediaSink_getStatusName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    void play() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _MediaSinkPlayParams();
      _proxyImpl.sendMessage(params, _MediaSink_playName);
    }
    void pause() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _MediaSinkPauseParams();
      _proxyImpl.sendMessage(params, _MediaSink_pauseName);
    }
}


class MediaSinkProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  MediaSink ptr;

  MediaSinkProxy(_MediaSinkProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _MediaSinkProxyCalls(proxyImpl);

  MediaSinkProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _MediaSinkProxyImpl.fromEndpoint(endpoint) {
    ptr = new _MediaSinkProxyCalls(impl);
  }

  MediaSinkProxy.fromHandle(core.MojoHandle handle) :
      impl = new _MediaSinkProxyImpl.fromHandle(handle) {
    ptr = new _MediaSinkProxyCalls(impl);
  }

  MediaSinkProxy.unbound() :
      impl = new _MediaSinkProxyImpl.unbound() {
    ptr = new _MediaSinkProxyCalls(impl);
  }

  factory MediaSinkProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    MediaSinkProxy p = new MediaSinkProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static MediaSinkProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MediaSinkProxy"));
    return new MediaSinkProxy.fromEndpoint(endpoint);
  }

  String get serviceName => MediaSink.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "MediaSinkProxy($impl)";
  }
}


class MediaSinkStub extends bindings.Stub {
  MediaSink _impl = null;

  MediaSinkStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  MediaSinkStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  MediaSinkStub.unbound() : super.unbound();

  static MediaSinkStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MediaSinkStub"));
    return new MediaSinkStub.fromEndpoint(endpoint);
  }


  MediaSinkGetClockDispositionResponseParams _MediaSinkGetClockDispositionResponseParamsFactory(media_clock_mojom.ClockDisposition clockDisposition) {
    var mojo_factory_result = new MediaSinkGetClockDispositionResponseParams();
    mojo_factory_result.clockDisposition = clockDisposition;
    return mojo_factory_result;
  }
  MediaSinkGetStatusResponseParams _MediaSinkGetStatusResponseParamsFactory(int version, MediaSinkStatus status) {
    var mojo_factory_result = new MediaSinkGetStatusResponseParams();
    mojo_factory_result.version = version;
    mojo_factory_result.status = status;
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
      case _MediaSink_getClockDispositionName:
        var params = _MediaSinkGetClockDispositionParams.deserialize(
            message.payload);
        var response = _impl.getClockDisposition(_MediaSinkGetClockDispositionResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _MediaSink_getClockDispositionName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _MediaSink_getClockDispositionName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _MediaSink_getMasterClockName:
        var params = _MediaSinkGetMasterClockParams.deserialize(
            message.payload);
        _impl.getMasterClock(params.masterClock);
        break;
      case _MediaSink_setMasterClockName:
        var params = _MediaSinkSetMasterClockParams.deserialize(
            message.payload);
        _impl.setMasterClock(params.masterClock);
        break;
      case _MediaSink_getConsumerName:
        var params = _MediaSinkGetConsumerParams.deserialize(
            message.payload);
        _impl.getConsumer(params.consumer);
        break;
      case _MediaSink_getStatusName:
        var params = _MediaSinkGetStatusParams.deserialize(
            message.payload);
        var response = _impl.getStatus(params.versionLastSeen,_MediaSinkGetStatusResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _MediaSink_getStatusName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _MediaSink_getStatusName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _MediaSink_playName:
        var params = _MediaSinkPlayParams.deserialize(
            message.payload);
        _impl.play();
        break;
      case _MediaSink_pauseName:
        var params = _MediaSinkPauseParams.deserialize(
            message.payload);
        _impl.pause();
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  MediaSink get impl => _impl;
  set impl(MediaSink d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "MediaSinkStub($superString)";
  }

  int get version => 0;
}


