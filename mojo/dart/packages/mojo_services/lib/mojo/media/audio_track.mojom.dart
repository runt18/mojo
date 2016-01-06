// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library audio_track_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo_services/mojo/media/media_common.mojom.dart' as media_common_mojom;
import 'package:mojo_services/mojo/media/media_pipe.mojom.dart' as media_pipe_mojom;
import 'package:mojo_services/mojo/media/media_types.mojom.dart' as media_types_mojom;
import 'package:mojo_services/mojo/media/rate_control.mojom.dart' as rate_control_mojom;



class AudioTrackDescriptor extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<media_types_mojom.MediaTypeSet> supportedMediaTypes = null;

  AudioTrackDescriptor() : super(kVersions.last.size);

  static AudioTrackDescriptor deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static AudioTrackDescriptor decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    AudioTrackDescriptor result = new AudioTrackDescriptor();

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
        result.supportedMediaTypes = new List<media_types_mojom.MediaTypeSet>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.supportedMediaTypes[i1] = media_types_mojom.MediaTypeSet.decode(decoder2);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    if (supportedMediaTypes == null) {
      encoder0.encodeNullPointer(8, false);
    } else {
      var encoder1 = encoder0.encodePointerArray(supportedMediaTypes.length, 8, bindings.kUnspecifiedArrayLength);
      for (int i0 = 0; i0 < supportedMediaTypes.length; ++i0) {
        
        encoder1.encodeStruct(supportedMediaTypes[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
      }
    }
  }

  String toString() {
    return "AudioTrackDescriptor("
           "supportedMediaTypes: $supportedMediaTypes" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["supportedMediaTypes"] = supportedMediaTypes;
    return map;
  }
}


class AudioTrackConfiguration extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  media_types_mojom.MediaType mediaType = null;
  int maxFrames = 0;
  int audioFrameRatio = 1;
  int mediaTimeRatio = 1;

  AudioTrackConfiguration() : super(kVersions.last.size);

  static AudioTrackConfiguration deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static AudioTrackConfiguration decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    AudioTrackConfiguration result = new AudioTrackConfiguration();

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
      result.mediaType = media_types_mojom.MediaType.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.maxFrames = decoder0.decodeUint64(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.audioFrameRatio = decoder0.decodeUint32(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.mediaTimeRatio = decoder0.decodeUint32(28);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(mediaType, 8, false);
    
    encoder0.encodeUint64(maxFrames, 16);
    
    encoder0.encodeUint32(audioFrameRatio, 24);
    
    encoder0.encodeUint32(mediaTimeRatio, 28);
  }

  String toString() {
    return "AudioTrackConfiguration("
           "mediaType: $mediaType" ", "
           "maxFrames: $maxFrames" ", "
           "audioFrameRatio: $audioFrameRatio" ", "
           "mediaTimeRatio: $mediaTimeRatio" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["mediaType"] = mediaType;
    map["maxFrames"] = maxFrames;
    map["audioFrameRatio"] = audioFrameRatio;
    map["mediaTimeRatio"] = mediaTimeRatio;
    return map;
  }
}


class _AudioTrackDescribeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _AudioTrackDescribeParams() : super(kVersions.last.size);

  static _AudioTrackDescribeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _AudioTrackDescribeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _AudioTrackDescribeParams result = new _AudioTrackDescribeParams();

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
    return "_AudioTrackDescribeParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class AudioTrackDescribeResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  AudioTrackDescriptor descriptor = null;

  AudioTrackDescribeResponseParams() : super(kVersions.last.size);

  static AudioTrackDescribeResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static AudioTrackDescribeResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    AudioTrackDescribeResponseParams result = new AudioTrackDescribeResponseParams();

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
      result.descriptor = AudioTrackDescriptor.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(descriptor, 8, false);
  }

  String toString() {
    return "AudioTrackDescribeResponseParams("
           "descriptor: $descriptor" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["descriptor"] = descriptor;
    return map;
  }
}


class _AudioTrackConfigureParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  AudioTrackConfiguration configuration = null;
  Object pipe = null;

  _AudioTrackConfigureParams() : super(kVersions.last.size);

  static _AudioTrackConfigureParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _AudioTrackConfigureParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _AudioTrackConfigureParams result = new _AudioTrackConfigureParams();

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
      result.configuration = AudioTrackConfiguration.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.pipe = decoder0.decodeInterfaceRequest(16, false, media_pipe_mojom.MediaPipeStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(configuration, 8, false);
    
    encoder0.encodeInterfaceRequest(pipe, 16, false);
  }

  String toString() {
    return "_AudioTrackConfigureParams("
           "configuration: $configuration" ", "
           "pipe: $pipe" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class AudioTrackConfigureResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  media_common_mojom.MediaResult result = null;

  AudioTrackConfigureResponseParams() : super(kVersions.last.size);

  static AudioTrackConfigureResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static AudioTrackConfigureResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    AudioTrackConfigureResponseParams result = new AudioTrackConfigureResponseParams();

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
    return "AudioTrackConfigureResponseParams("
           "result: $result" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["result"] = result;
    return map;
  }
}


class _AudioTrackGetRateControlParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object rateControl = null;

  _AudioTrackGetRateControlParams() : super(kVersions.last.size);

  static _AudioTrackGetRateControlParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _AudioTrackGetRateControlParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _AudioTrackGetRateControlParams result = new _AudioTrackGetRateControlParams();

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
      
      result.rateControl = decoder0.decodeInterfaceRequest(8, false, rate_control_mojom.RateControlStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInterfaceRequest(rateControl, 8, false);
  }

  String toString() {
    return "_AudioTrackGetRateControlParams("
           "rateControl: $rateControl" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class AudioTrackGetRateControlResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  media_common_mojom.MediaResult result = null;

  AudioTrackGetRateControlResponseParams() : super(kVersions.last.size);

  static AudioTrackGetRateControlResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static AudioTrackGetRateControlResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    AudioTrackGetRateControlResponseParams result = new AudioTrackGetRateControlResponseParams();

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
    return "AudioTrackGetRateControlResponseParams("
           "result: $result" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["result"] = result;
    return map;
  }
}

const int _AudioTrack_describeName = 0;
const int _AudioTrack_configureName = 1;
const int _AudioTrack_getRateControlName = 2;

abstract class AudioTrack {
  static const String serviceName = null;
  dynamic describe([Function responseFactory = null]);
  dynamic configure(AudioTrackConfiguration configuration,Object pipe,[Function responseFactory = null]);
  dynamic getRateControl(Object rateControl,[Function responseFactory = null]);
}


class _AudioTrackProxyImpl extends bindings.Proxy {
  _AudioTrackProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _AudioTrackProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _AudioTrackProxyImpl.unbound() : super.unbound();

  static _AudioTrackProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _AudioTrackProxyImpl"));
    return new _AudioTrackProxyImpl.fromEndpoint(endpoint);
  }

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _AudioTrack_describeName:
        var r = AudioTrackDescribeResponseParams.deserialize(
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
      case _AudioTrack_configureName:
        var r = AudioTrackConfigureResponseParams.deserialize(
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
      case _AudioTrack_getRateControlName:
        var r = AudioTrackGetRateControlResponseParams.deserialize(
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
    return "_AudioTrackProxyImpl($superString)";
  }
}


class _AudioTrackProxyCalls implements AudioTrack {
  _AudioTrackProxyImpl _proxyImpl;

  _AudioTrackProxyCalls(this._proxyImpl);
    dynamic describe([Function responseFactory = null]) {
      var params = new _AudioTrackDescribeParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _AudioTrack_describeName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic configure(AudioTrackConfiguration configuration,Object pipe,[Function responseFactory = null]) {
      var params = new _AudioTrackConfigureParams();
      params.configuration = configuration;
      params.pipe = pipe;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _AudioTrack_configureName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic getRateControl(Object rateControl,[Function responseFactory = null]) {
      var params = new _AudioTrackGetRateControlParams();
      params.rateControl = rateControl;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _AudioTrack_getRateControlName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class AudioTrackProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  AudioTrack ptr;

  AudioTrackProxy(_AudioTrackProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _AudioTrackProxyCalls(proxyImpl);

  AudioTrackProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _AudioTrackProxyImpl.fromEndpoint(endpoint) {
    ptr = new _AudioTrackProxyCalls(impl);
  }

  AudioTrackProxy.fromHandle(core.MojoHandle handle) :
      impl = new _AudioTrackProxyImpl.fromHandle(handle) {
    ptr = new _AudioTrackProxyCalls(impl);
  }

  AudioTrackProxy.unbound() :
      impl = new _AudioTrackProxyImpl.unbound() {
    ptr = new _AudioTrackProxyCalls(impl);
  }

  factory AudioTrackProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    AudioTrackProxy p = new AudioTrackProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static AudioTrackProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For AudioTrackProxy"));
    return new AudioTrackProxy.fromEndpoint(endpoint);
  }

  String get serviceName => AudioTrack.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "AudioTrackProxy($impl)";
  }
}


class AudioTrackStub extends bindings.Stub {
  AudioTrack _impl = null;

  AudioTrackStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  AudioTrackStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  AudioTrackStub.unbound() : super.unbound();

  static AudioTrackStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For AudioTrackStub"));
    return new AudioTrackStub.fromEndpoint(endpoint);
  }


  AudioTrackDescribeResponseParams _AudioTrackDescribeResponseParamsFactory(AudioTrackDescriptor descriptor) {
    var mojo_factory_result = new AudioTrackDescribeResponseParams();
    mojo_factory_result.descriptor = descriptor;
    return mojo_factory_result;
  }
  AudioTrackConfigureResponseParams _AudioTrackConfigureResponseParamsFactory(media_common_mojom.MediaResult result) {
    var mojo_factory_result = new AudioTrackConfigureResponseParams();
    mojo_factory_result.result = result;
    return mojo_factory_result;
  }
  AudioTrackGetRateControlResponseParams _AudioTrackGetRateControlResponseParamsFactory(media_common_mojom.MediaResult result) {
    var mojo_factory_result = new AudioTrackGetRateControlResponseParams();
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
      case _AudioTrack_describeName:
        var params = _AudioTrackDescribeParams.deserialize(
            message.payload);
        var response = _impl.describe(_AudioTrackDescribeResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _AudioTrack_describeName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _AudioTrack_describeName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _AudioTrack_configureName:
        var params = _AudioTrackConfigureParams.deserialize(
            message.payload);
        var response = _impl.configure(params.configuration,params.pipe,_AudioTrackConfigureResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _AudioTrack_configureName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _AudioTrack_configureName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _AudioTrack_getRateControlName:
        var params = _AudioTrackGetRateControlParams.deserialize(
            message.payload);
        var response = _impl.getRateControl(params.rateControl,_AudioTrackGetRateControlResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _AudioTrack_getRateControlName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _AudioTrack_getRateControlName,
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

  AudioTrack get impl => _impl;
  set impl(AudioTrack d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "AudioTrackStub($superString)";
  }

  int get version => 0;
}


