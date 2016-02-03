// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library media_factory_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/media/media_types.mojom.dart' as media_types_mojom;
import 'package:mojo_services/mojo/media/media_player.mojom.dart' as media_player_mojom;
import 'package:mojo_services/mojo/media/media_sink.mojom.dart' as media_sink_mojom;
import 'package:mojo_services/mojo/media/media_source.mojom.dart' as media_source_mojom;



class _MediaFactoryCreatePlayerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String originUrl = null;
  Object player = null;

  _MediaFactoryCreatePlayerParams() : super(kVersions.last.size);

  static _MediaFactoryCreatePlayerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaFactoryCreatePlayerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaFactoryCreatePlayerParams result = new _MediaFactoryCreatePlayerParams();

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
      
      result.originUrl = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.player = decoder0.decodeInterfaceRequest(16, false, media_player_mojom.MediaPlayerStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(originUrl, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "originUrl of struct _MediaFactoryCreatePlayerParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(player, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "player of struct _MediaFactoryCreatePlayerParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaFactoryCreatePlayerParams("
           "originUrl: $originUrl" ", "
           "player: $player" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




class _MediaFactoryCreateSourceParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  String originUrl = null;
  List<media_types_mojom.MediaTypeSet> allowedMediaTypes = null;
  Object source = null;

  _MediaFactoryCreateSourceParams() : super(kVersions.last.size);

  static _MediaFactoryCreateSourceParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaFactoryCreateSourceParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaFactoryCreateSourceParams result = new _MediaFactoryCreateSourceParams();

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
      
      result.originUrl = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      if (decoder1 == null) {
        result.allowedMediaTypes = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.allowedMediaTypes = new List<media_types_mojom.MediaTypeSet>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.allowedMediaTypes[i1] = media_types_mojom.MediaTypeSet.decode(decoder2);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      result.source = decoder0.decodeInterfaceRequest(24, false, media_source_mojom.MediaSourceStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(originUrl, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "originUrl of struct _MediaFactoryCreateSourceParams: $e";
      rethrow;
    }
    try {
      if (allowedMediaTypes == null) {
        encoder0.encodeNullPointer(16, true);
      } else {
        var encoder1 = encoder0.encodePointerArray(allowedMediaTypes.length, 16, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < allowedMediaTypes.length; ++i0) {
          encoder1.encodeStruct(allowedMediaTypes[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "allowedMediaTypes of struct _MediaFactoryCreateSourceParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(source, 24, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "source of struct _MediaFactoryCreateSourceParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaFactoryCreateSourceParams("
           "originUrl: $originUrl" ", "
           "allowedMediaTypes: $allowedMediaTypes" ", "
           "source: $source" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




class _MediaFactoryCreateSinkParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  String destinationUrl = null;
  media_types_mojom.MediaType mediaType = null;
  Object sink = null;

  _MediaFactoryCreateSinkParams() : super(kVersions.last.size);

  static _MediaFactoryCreateSinkParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaFactoryCreateSinkParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaFactoryCreateSinkParams result = new _MediaFactoryCreateSinkParams();

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
      
      result.destinationUrl = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.mediaType = media_types_mojom.MediaType.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.sink = decoder0.decodeInterfaceRequest(24, false, media_sink_mojom.MediaSinkStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(destinationUrl, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "destinationUrl of struct _MediaFactoryCreateSinkParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(mediaType, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "mediaType of struct _MediaFactoryCreateSinkParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(sink, 24, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "sink of struct _MediaFactoryCreateSinkParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaFactoryCreateSinkParams("
           "destinationUrl: $destinationUrl" ", "
           "mediaType: $mediaType" ", "
           "sink: $sink" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




const int _MediaFactory_createPlayerName = 0;
const int _MediaFactory_createSourceName = 1;
const int _MediaFactory_createSinkName = 2;



class _MediaFactoryServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class MediaFactory {
  static const String serviceName = "mojo::media::MediaFactory";
  void createPlayer(String originUrl, Object player);
  void createSource(String originUrl, List<media_types_mojom.MediaTypeSet> allowedMediaTypes, Object source);
  void createSink(String destinationUrl, media_types_mojom.MediaType mediaType, Object sink);
}


class _MediaFactoryProxyImpl extends bindings.Proxy {
  _MediaFactoryProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _MediaFactoryProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _MediaFactoryProxyImpl.unbound() : super.unbound();

  static _MediaFactoryProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _MediaFactoryProxyImpl"));
    return new _MediaFactoryProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _MediaFactoryServiceDescription();

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
    return "_MediaFactoryProxyImpl($superString)";
  }
}


class _MediaFactoryProxyCalls implements MediaFactory {
  _MediaFactoryProxyImpl _proxyImpl;

  _MediaFactoryProxyCalls(this._proxyImpl);
    void createPlayer(String originUrl, Object player) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _MediaFactoryCreatePlayerParams();
      params.originUrl = originUrl;
      params.player = player;
      _proxyImpl.sendMessage(params, _MediaFactory_createPlayerName);
    }
    void createSource(String originUrl, List<media_types_mojom.MediaTypeSet> allowedMediaTypes, Object source) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _MediaFactoryCreateSourceParams();
      params.originUrl = originUrl;
      params.allowedMediaTypes = allowedMediaTypes;
      params.source = source;
      _proxyImpl.sendMessage(params, _MediaFactory_createSourceName);
    }
    void createSink(String destinationUrl, media_types_mojom.MediaType mediaType, Object sink) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _MediaFactoryCreateSinkParams();
      params.destinationUrl = destinationUrl;
      params.mediaType = mediaType;
      params.sink = sink;
      _proxyImpl.sendMessage(params, _MediaFactory_createSinkName);
    }
}


class MediaFactoryProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  MediaFactory ptr;

  MediaFactoryProxy(_MediaFactoryProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _MediaFactoryProxyCalls(proxyImpl);

  MediaFactoryProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _MediaFactoryProxyImpl.fromEndpoint(endpoint) {
    ptr = new _MediaFactoryProxyCalls(impl);
  }

  MediaFactoryProxy.fromHandle(core.MojoHandle handle) :
      impl = new _MediaFactoryProxyImpl.fromHandle(handle) {
    ptr = new _MediaFactoryProxyCalls(impl);
  }

  MediaFactoryProxy.unbound() :
      impl = new _MediaFactoryProxyImpl.unbound() {
    ptr = new _MediaFactoryProxyCalls(impl);
  }

  factory MediaFactoryProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    MediaFactoryProxy p = new MediaFactoryProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static MediaFactoryProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MediaFactoryProxy"));
    return new MediaFactoryProxy.fromEndpoint(endpoint);
  }

  String get serviceName => MediaFactory.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "MediaFactoryProxy($impl)";
  }
}


class MediaFactoryStub extends bindings.Stub {
  MediaFactory _impl = null;

  MediaFactoryStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  MediaFactoryStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  MediaFactoryStub.unbound() : super.unbound();

  static MediaFactoryStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MediaFactoryStub"));
    return new MediaFactoryStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _MediaFactory_createPlayerName:
        var params = _MediaFactoryCreatePlayerParams.deserialize(
            message.payload);
        _impl.createPlayer(params.originUrl, params.player);
        break;
      case _MediaFactory_createSourceName:
        var params = _MediaFactoryCreateSourceParams.deserialize(
            message.payload);
        _impl.createSource(params.originUrl, params.allowedMediaTypes, params.source);
        break;
      case _MediaFactory_createSinkName:
        var params = _MediaFactoryCreateSinkParams.deserialize(
            message.payload);
        _impl.createSink(params.destinationUrl, params.mediaType, params.sink);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  MediaFactory get impl => _impl;
  set impl(MediaFactory d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "MediaFactoryStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _MediaFactoryServiceDescription();
}



