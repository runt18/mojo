// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library media_source_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo_services/mojo/media/media_clock.mojom.dart' as media_clock_mojom;
import 'package:mojo_services/mojo/media/media_common.mojom.dart' as media_common_mojom;
import 'package:mojo_services/mojo/media/media_metadata.mojom.dart' as media_metadata_mojom;
import 'package:mojo_services/mojo/media/media_state.mojom.dart' as media_state_mojom;
import 'package:mojo_services/mojo/media/media_transport.mojom.dart' as media_transport_mojom;
import 'package:mojo_services/mojo/media/media_types.mojom.dart' as media_types_mojom;



class MediaSourceStreamDescriptor extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  int index = 0;
  media_types_mojom.MediaType mediaType = null;
  media_types_mojom.MediaType originalMediaType = null;

  MediaSourceStreamDescriptor() : super(kVersions.last.size);

  static MediaSourceStreamDescriptor deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaSourceStreamDescriptor decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaSourceStreamDescriptor result = new MediaSourceStreamDescriptor();

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
      
      result.index = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.mediaType = media_types_mojom.MediaType.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, false);
      result.originalMediaType = media_types_mojom.MediaType.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(index, 8);
    
    encoder0.encodeStruct(mediaType, 16, false);
    
    encoder0.encodeStruct(originalMediaType, 24, false);
  }

  String toString() {
    return "MediaSourceStreamDescriptor("
           "index: $index" ", "
           "mediaType: $mediaType" ", "
           "originalMediaType: $originalMediaType" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["index"] = index;
    map["mediaType"] = mediaType;
    map["originalMediaType"] = originalMediaType;
    return map;
  }
}


class MediaSourceStatus extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  media_state_mojom.MediaState state = null;
  media_metadata_mojom.MediaMetadata metadata = null;

  MediaSourceStatus() : super(kVersions.last.size);

  static MediaSourceStatus deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaSourceStatus decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaSourceStatus result = new MediaSourceStatus();

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
      result.metadata = media_metadata_mojom.MediaMetadata.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(state, 8);
    
    encoder0.encodeStruct(metadata, 16, true);
  }

  String toString() {
    return "MediaSourceStatus("
           "state: $state" ", "
           "metadata: $metadata" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["state"] = state;
    map["metadata"] = metadata;
    return map;
  }
}


class _MediaSourceGetStreamsParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _MediaSourceGetStreamsParams() : super(kVersions.last.size);

  static _MediaSourceGetStreamsParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaSourceGetStreamsParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaSourceGetStreamsParams result = new _MediaSourceGetStreamsParams();

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
    return "_MediaSourceGetStreamsParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class MediaSourceGetStreamsResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<MediaSourceStreamDescriptor> streams = null;

  MediaSourceGetStreamsResponseParams() : super(kVersions.last.size);

  static MediaSourceGetStreamsResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaSourceGetStreamsResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaSourceGetStreamsResponseParams result = new MediaSourceGetStreamsResponseParams();

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
        result.streams = new List<MediaSourceStreamDescriptor>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.streams[i1] = MediaSourceStreamDescriptor.decode(decoder2);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    if (streams == null) {
      encoder0.encodeNullPointer(8, false);
    } else {
      var encoder1 = encoder0.encodePointerArray(streams.length, 8, bindings.kUnspecifiedArrayLength);
      for (int i0 = 0; i0 < streams.length; ++i0) {
        
        encoder1.encodeStruct(streams[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
      }
    }
  }

  String toString() {
    return "MediaSourceGetStreamsResponseParams("
           "streams: $streams" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["streams"] = streams;
    return map;
  }
}


class _MediaSourceGetClockDispositionParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _MediaSourceGetClockDispositionParams() : super(kVersions.last.size);

  static _MediaSourceGetClockDispositionParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaSourceGetClockDispositionParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaSourceGetClockDispositionParams result = new _MediaSourceGetClockDispositionParams();

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
    return "_MediaSourceGetClockDispositionParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class MediaSourceGetClockDispositionResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  media_clock_mojom.ClockDisposition clockDisposition = null;

  MediaSourceGetClockDispositionResponseParams() : super(kVersions.last.size);

  static MediaSourceGetClockDispositionResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaSourceGetClockDispositionResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaSourceGetClockDispositionResponseParams result = new MediaSourceGetClockDispositionResponseParams();

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
    return "MediaSourceGetClockDispositionResponseParams("
           "clockDisposition: $clockDisposition" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["clockDisposition"] = clockDisposition;
    return map;
  }
}


class _MediaSourceGetMasterClockParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object masterClock = null;

  _MediaSourceGetMasterClockParams() : super(kVersions.last.size);

  static _MediaSourceGetMasterClockParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaSourceGetMasterClockParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaSourceGetMasterClockParams result = new _MediaSourceGetMasterClockParams();

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
    return "_MediaSourceGetMasterClockParams("
           "masterClock: $masterClock" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _MediaSourceSetMasterClockParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object masterClock = null;

  _MediaSourceSetMasterClockParams() : super(kVersions.last.size);

  static _MediaSourceSetMasterClockParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaSourceSetMasterClockParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaSourceSetMasterClockParams result = new _MediaSourceSetMasterClockParams();

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
    return "_MediaSourceSetMasterClockParams("
           "masterClock: $masterClock" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _MediaSourceGetProducerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int streamIndex = 0;
  Object producer = null;

  _MediaSourceGetProducerParams() : super(kVersions.last.size);

  static _MediaSourceGetProducerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaSourceGetProducerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaSourceGetProducerParams result = new _MediaSourceGetProducerParams();

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
      
      result.streamIndex = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.producer = decoder0.decodeInterfaceRequest(12, false, media_transport_mojom.MediaProducerStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(streamIndex, 8);
    
    encoder0.encodeInterfaceRequest(producer, 12, false);
  }

  String toString() {
    return "_MediaSourceGetProducerParams("
           "streamIndex: $streamIndex" ", "
           "producer: $producer" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _MediaSourceGetPullModeProducerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int streamIndex = 0;
  Object producer = null;

  _MediaSourceGetPullModeProducerParams() : super(kVersions.last.size);

  static _MediaSourceGetPullModeProducerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaSourceGetPullModeProducerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaSourceGetPullModeProducerParams result = new _MediaSourceGetPullModeProducerParams();

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
      
      result.streamIndex = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.producer = decoder0.decodeInterfaceRequest(12, false, media_transport_mojom.MediaPullModeProducerStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(streamIndex, 8);
    
    encoder0.encodeInterfaceRequest(producer, 12, false);
  }

  String toString() {
    return "_MediaSourceGetPullModeProducerParams("
           "streamIndex: $streamIndex" ", "
           "producer: $producer" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _MediaSourceGetStatusParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int versionLastSeen = 0;

  _MediaSourceGetStatusParams() : super(kVersions.last.size);

  static _MediaSourceGetStatusParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaSourceGetStatusParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaSourceGetStatusParams result = new _MediaSourceGetStatusParams();

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
    return "_MediaSourceGetStatusParams("
           "versionLastSeen: $versionLastSeen" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["versionLastSeen"] = versionLastSeen;
    return map;
  }
}


class MediaSourceGetStatusResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int version = 0;
  MediaSourceStatus status = null;

  MediaSourceGetStatusResponseParams() : super(kVersions.last.size);

  static MediaSourceGetStatusResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaSourceGetStatusResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaSourceGetStatusResponseParams result = new MediaSourceGetStatusResponseParams();

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
      result.status = MediaSourceStatus.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint64(version, 8);
    
    encoder0.encodeStruct(status, 16, false);
  }

  String toString() {
    return "MediaSourceGetStatusResponseParams("
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


class _MediaSourcePrepareParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _MediaSourcePrepareParams() : super(kVersions.last.size);

  static _MediaSourcePrepareParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaSourcePrepareParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaSourcePrepareParams result = new _MediaSourcePrepareParams();

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
    return "_MediaSourcePrepareParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class MediaSourcePrepareResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  MediaSourcePrepareResponseParams() : super(kVersions.last.size);

  static MediaSourcePrepareResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaSourcePrepareResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaSourcePrepareResponseParams result = new MediaSourcePrepareResponseParams();

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
    return "MediaSourcePrepareResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

const int _MediaSource_getStreamsName = 0;
const int _MediaSource_getClockDispositionName = 1;
const int _MediaSource_getMasterClockName = 2;
const int _MediaSource_setMasterClockName = 3;
const int _MediaSource_getProducerName = 4;
const int _MediaSource_getPullModeProducerName = 5;
const int _MediaSource_getStatusName = 6;
const int _MediaSource_prepareName = 7;

abstract class MediaSource {
  static const String serviceName = null;
  dynamic getStreams([Function responseFactory = null]);
  dynamic getClockDisposition([Function responseFactory = null]);
  void getMasterClock(Object masterClock);
  void setMasterClock(Object masterClock);
  void getProducer(int streamIndex, Object producer);
  void getPullModeProducer(int streamIndex, Object producer);
  dynamic getStatus(int versionLastSeen,[Function responseFactory = null]);
  dynamic prepare([Function responseFactory = null]);
}


class _MediaSourceProxyImpl extends bindings.Proxy {
  _MediaSourceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _MediaSourceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _MediaSourceProxyImpl.unbound() : super.unbound();

  static _MediaSourceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _MediaSourceProxyImpl"));
    return new _MediaSourceProxyImpl.fromEndpoint(endpoint);
  }

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _MediaSource_getStreamsName:
        var r = MediaSourceGetStreamsResponseParams.deserialize(
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
      case _MediaSource_getClockDispositionName:
        var r = MediaSourceGetClockDispositionResponseParams.deserialize(
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
      case _MediaSource_getStatusName:
        var r = MediaSourceGetStatusResponseParams.deserialize(
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
      case _MediaSource_prepareName:
        var r = MediaSourcePrepareResponseParams.deserialize(
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
    return "_MediaSourceProxyImpl($superString)";
  }
}


class _MediaSourceProxyCalls implements MediaSource {
  _MediaSourceProxyImpl _proxyImpl;

  _MediaSourceProxyCalls(this._proxyImpl);
    dynamic getStreams([Function responseFactory = null]) {
      var params = new _MediaSourceGetStreamsParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _MediaSource_getStreamsName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic getClockDisposition([Function responseFactory = null]) {
      var params = new _MediaSourceGetClockDispositionParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _MediaSource_getClockDispositionName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    void getMasterClock(Object masterClock) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _MediaSourceGetMasterClockParams();
      params.masterClock = masterClock;
      _proxyImpl.sendMessage(params, _MediaSource_getMasterClockName);
    }
    void setMasterClock(Object masterClock) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _MediaSourceSetMasterClockParams();
      params.masterClock = masterClock;
      _proxyImpl.sendMessage(params, _MediaSource_setMasterClockName);
    }
    void getProducer(int streamIndex, Object producer) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _MediaSourceGetProducerParams();
      params.streamIndex = streamIndex;
      params.producer = producer;
      _proxyImpl.sendMessage(params, _MediaSource_getProducerName);
    }
    void getPullModeProducer(int streamIndex, Object producer) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _MediaSourceGetPullModeProducerParams();
      params.streamIndex = streamIndex;
      params.producer = producer;
      _proxyImpl.sendMessage(params, _MediaSource_getPullModeProducerName);
    }
    dynamic getStatus(int versionLastSeen,[Function responseFactory = null]) {
      var params = new _MediaSourceGetStatusParams();
      params.versionLastSeen = versionLastSeen;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _MediaSource_getStatusName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic prepare([Function responseFactory = null]) {
      var params = new _MediaSourcePrepareParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _MediaSource_prepareName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class MediaSourceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  MediaSource ptr;

  MediaSourceProxy(_MediaSourceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _MediaSourceProxyCalls(proxyImpl);

  MediaSourceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _MediaSourceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _MediaSourceProxyCalls(impl);
  }

  MediaSourceProxy.fromHandle(core.MojoHandle handle) :
      impl = new _MediaSourceProxyImpl.fromHandle(handle) {
    ptr = new _MediaSourceProxyCalls(impl);
  }

  MediaSourceProxy.unbound() :
      impl = new _MediaSourceProxyImpl.unbound() {
    ptr = new _MediaSourceProxyCalls(impl);
  }

  factory MediaSourceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    MediaSourceProxy p = new MediaSourceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static MediaSourceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MediaSourceProxy"));
    return new MediaSourceProxy.fromEndpoint(endpoint);
  }

  String get serviceName => MediaSource.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "MediaSourceProxy($impl)";
  }
}


class MediaSourceStub extends bindings.Stub {
  MediaSource _impl = null;

  MediaSourceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  MediaSourceStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  MediaSourceStub.unbound() : super.unbound();

  static MediaSourceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MediaSourceStub"));
    return new MediaSourceStub.fromEndpoint(endpoint);
  }


  MediaSourceGetStreamsResponseParams _MediaSourceGetStreamsResponseParamsFactory(List<MediaSourceStreamDescriptor> streams) {
    var mojo_factory_result = new MediaSourceGetStreamsResponseParams();
    mojo_factory_result.streams = streams;
    return mojo_factory_result;
  }
  MediaSourceGetClockDispositionResponseParams _MediaSourceGetClockDispositionResponseParamsFactory(media_clock_mojom.ClockDisposition clockDisposition) {
    var mojo_factory_result = new MediaSourceGetClockDispositionResponseParams();
    mojo_factory_result.clockDisposition = clockDisposition;
    return mojo_factory_result;
  }
  MediaSourceGetStatusResponseParams _MediaSourceGetStatusResponseParamsFactory(int version, MediaSourceStatus status) {
    var mojo_factory_result = new MediaSourceGetStatusResponseParams();
    mojo_factory_result.version = version;
    mojo_factory_result.status = status;
    return mojo_factory_result;
  }
  MediaSourcePrepareResponseParams _MediaSourcePrepareResponseParamsFactory() {
    var mojo_factory_result = new MediaSourcePrepareResponseParams();
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
      case _MediaSource_getStreamsName:
        var params = _MediaSourceGetStreamsParams.deserialize(
            message.payload);
        var response = _impl.getStreams(_MediaSourceGetStreamsResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _MediaSource_getStreamsName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _MediaSource_getStreamsName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _MediaSource_getClockDispositionName:
        var params = _MediaSourceGetClockDispositionParams.deserialize(
            message.payload);
        var response = _impl.getClockDisposition(_MediaSourceGetClockDispositionResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _MediaSource_getClockDispositionName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _MediaSource_getClockDispositionName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _MediaSource_getMasterClockName:
        var params = _MediaSourceGetMasterClockParams.deserialize(
            message.payload);
        _impl.getMasterClock(params.masterClock);
        break;
      case _MediaSource_setMasterClockName:
        var params = _MediaSourceSetMasterClockParams.deserialize(
            message.payload);
        _impl.setMasterClock(params.masterClock);
        break;
      case _MediaSource_getProducerName:
        var params = _MediaSourceGetProducerParams.deserialize(
            message.payload);
        _impl.getProducer(params.streamIndex, params.producer);
        break;
      case _MediaSource_getPullModeProducerName:
        var params = _MediaSourceGetPullModeProducerParams.deserialize(
            message.payload);
        _impl.getPullModeProducer(params.streamIndex, params.producer);
        break;
      case _MediaSource_getStatusName:
        var params = _MediaSourceGetStatusParams.deserialize(
            message.payload);
        var response = _impl.getStatus(params.versionLastSeen,_MediaSourceGetStatusResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _MediaSource_getStatusName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _MediaSource_getStatusName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _MediaSource_prepareName:
        var params = _MediaSourcePrepareParams.deserialize(
            message.payload);
        var response = _impl.prepare(_MediaSourcePrepareResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _MediaSource_prepareName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _MediaSource_prepareName,
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

  MediaSource get impl => _impl;
  set impl(MediaSource d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "MediaSourceStub($superString)";
  }

  int get version => 0;
}


