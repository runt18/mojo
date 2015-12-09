// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library camera_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;



class Photo extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String uniqueId = null;
  core.MojoDataPipeConsumer content = null;

  Photo() : super(kVersions.last.size);

  static Photo deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Photo decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Photo result = new Photo();

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
      
      result.uniqueId = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.content = decoder0.decodeConsumerHandle(16, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeString(uniqueId, 8, false);
    
    encoder0.encodeConsumerHandle(content, 16, false);
  }

  String toString() {
    return "Photo("
           "uniqueId: $uniqueId" ", "
           "content: $content" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class CameraRollServiceUpdateParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  CameraRollServiceUpdateParams() : super(kVersions.last.size);

  static CameraRollServiceUpdateParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static CameraRollServiceUpdateParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    CameraRollServiceUpdateParams result = new CameraRollServiceUpdateParams();

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
    return "CameraRollServiceUpdateParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class CameraRollServiceGetCountParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  CameraRollServiceGetCountParams() : super(kVersions.last.size);

  static CameraRollServiceGetCountParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static CameraRollServiceGetCountParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    CameraRollServiceGetCountParams result = new CameraRollServiceGetCountParams();

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
    return "CameraRollServiceGetCountParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class CameraRollServiceGetCountResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int numPhotos = 0;

  CameraRollServiceGetCountResponseParams() : super(kVersions.last.size);

  static CameraRollServiceGetCountResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static CameraRollServiceGetCountResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    CameraRollServiceGetCountResponseParams result = new CameraRollServiceGetCountResponseParams();

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
      
      result.numPhotos = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(numPhotos, 8);
  }

  String toString() {
    return "CameraRollServiceGetCountResponseParams("
           "numPhotos: $numPhotos" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["numPhotos"] = numPhotos;
    return map;
  }
}


class CameraRollServiceGetPhotoParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int index = 0;

  CameraRollServiceGetPhotoParams() : super(kVersions.last.size);

  static CameraRollServiceGetPhotoParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static CameraRollServiceGetPhotoParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    CameraRollServiceGetPhotoParams result = new CameraRollServiceGetPhotoParams();

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
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(index, 8);
  }

  String toString() {
    return "CameraRollServiceGetPhotoParams("
           "index: $index" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["index"] = index;
    return map;
  }
}


class CameraRollServiceGetPhotoResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Photo photo = null;

  CameraRollServiceGetPhotoResponseParams() : super(kVersions.last.size);

  static CameraRollServiceGetPhotoResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static CameraRollServiceGetPhotoResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    CameraRollServiceGetPhotoResponseParams result = new CameraRollServiceGetPhotoResponseParams();

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
      result.photo = Photo.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(photo, 8, true);
  }

  String toString() {
    return "CameraRollServiceGetPhotoResponseParams("
           "photo: $photo" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class CameraServiceGetLatestFrameParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  CameraServiceGetLatestFrameParams() : super(kVersions.last.size);

  static CameraServiceGetLatestFrameParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static CameraServiceGetLatestFrameParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    CameraServiceGetLatestFrameParams result = new CameraServiceGetLatestFrameParams();

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
    return "CameraServiceGetLatestFrameParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class CameraServiceGetLatestFrameResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  core.MojoDataPipeConsumer content = null;

  CameraServiceGetLatestFrameResponseParams() : super(kVersions.last.size);

  static CameraServiceGetLatestFrameResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static CameraServiceGetLatestFrameResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    CameraServiceGetLatestFrameResponseParams result = new CameraServiceGetLatestFrameResponseParams();

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
      
      result.content = decoder0.decodeConsumerHandle(8, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeConsumerHandle(content, 8, true);
  }

  String toString() {
    return "CameraServiceGetLatestFrameResponseParams("
           "content: $content" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int kCameraRollService_update_name = 0;
const int kCameraRollService_getCount_name = 1;
const int kCameraRollService_getPhoto_name = 2;
const String CameraRollServiceName = "mojo::CameraRollService";

abstract class CameraRollService {
  void update();
  dynamic getCount([Function responseFactory = null]);
  dynamic getPhoto(int index,[Function responseFactory = null]);

}


class CameraRollServiceProxyImpl extends bindings.Proxy {
  CameraRollServiceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  CameraRollServiceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  CameraRollServiceProxyImpl.unbound() : super.unbound();

  static CameraRollServiceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CameraRollServiceProxyImpl"));
    return new CameraRollServiceProxyImpl.fromEndpoint(endpoint);
  }

  String get name => CameraRollServiceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case kCameraRollService_getCount_name:
        var r = CameraRollServiceGetCountResponseParams.deserialize(
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
      case kCameraRollService_getPhoto_name:
        var r = CameraRollServiceGetPhotoResponseParams.deserialize(
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
    return "CameraRollServiceProxyImpl($superString)";
  }
}


class _CameraRollServiceProxyCalls implements CameraRollService {
  CameraRollServiceProxyImpl _proxyImpl;

  _CameraRollServiceProxyCalls(this._proxyImpl);
    void update() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new CameraRollServiceUpdateParams();
      _proxyImpl.sendMessage(params, kCameraRollService_update_name);
    }
  
    dynamic getCount([Function responseFactory = null]) {
      var params = new CameraRollServiceGetCountParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kCameraRollService_getCount_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic getPhoto(int index,[Function responseFactory = null]) {
      var params = new CameraRollServiceGetPhotoParams();
      params.index = index;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kCameraRollService_getPhoto_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class CameraRollServiceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  CameraRollService ptr;
  final String name = CameraRollServiceName;

  CameraRollServiceProxy(CameraRollServiceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _CameraRollServiceProxyCalls(proxyImpl);

  CameraRollServiceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new CameraRollServiceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _CameraRollServiceProxyCalls(impl);
  }

  CameraRollServiceProxy.fromHandle(core.MojoHandle handle) :
      impl = new CameraRollServiceProxyImpl.fromHandle(handle) {
    ptr = new _CameraRollServiceProxyCalls(impl);
  }

  CameraRollServiceProxy.unbound() :
      impl = new CameraRollServiceProxyImpl.unbound() {
    ptr = new _CameraRollServiceProxyCalls(impl);
  }

  factory CameraRollServiceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    CameraRollServiceProxy p = new CameraRollServiceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static CameraRollServiceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CameraRollServiceProxy"));
    return new CameraRollServiceProxy.fromEndpoint(endpoint);
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
    return "CameraRollServiceProxy($impl)";
  }
}


class CameraRollServiceStub extends bindings.Stub {
  CameraRollService _impl = null;

  CameraRollServiceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  CameraRollServiceStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  CameraRollServiceStub.unbound() : super.unbound();

  static CameraRollServiceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CameraRollServiceStub"));
    return new CameraRollServiceStub.fromEndpoint(endpoint);
  }

  static const String name = CameraRollServiceName;


  CameraRollServiceGetCountResponseParams _CameraRollServiceGetCountResponseParamsFactory(int numPhotos) {
    var mojo_factory_result = new CameraRollServiceGetCountResponseParams();
    mojo_factory_result.numPhotos = numPhotos;
    return mojo_factory_result;
  }
  CameraRollServiceGetPhotoResponseParams _CameraRollServiceGetPhotoResponseParamsFactory(Photo photo) {
    var mojo_factory_result = new CameraRollServiceGetPhotoResponseParams();
    mojo_factory_result.photo = photo;
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
      case kCameraRollService_update_name:
        var params = CameraRollServiceUpdateParams.deserialize(
            message.payload);
        _impl.update();
        break;
      case kCameraRollService_getCount_name:
        var params = CameraRollServiceGetCountParams.deserialize(
            message.payload);
        var response = _impl.getCount(_CameraRollServiceGetCountResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kCameraRollService_getCount_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kCameraRollService_getCount_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kCameraRollService_getPhoto_name:
        var params = CameraRollServiceGetPhotoParams.deserialize(
            message.payload);
        var response = _impl.getPhoto(params.index,_CameraRollServiceGetPhotoResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kCameraRollService_getPhoto_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kCameraRollService_getPhoto_name,
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

  CameraRollService get impl => _impl;
  set impl(CameraRollService d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "CameraRollServiceStub($superString)";
  }

  int get version => 0;
}

const int kCameraService_getLatestFrame_name = 0;
const String CameraServiceName = "mojo::CameraService";

abstract class CameraService {
  dynamic getLatestFrame([Function responseFactory = null]);

}


class CameraServiceProxyImpl extends bindings.Proxy {
  CameraServiceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  CameraServiceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  CameraServiceProxyImpl.unbound() : super.unbound();

  static CameraServiceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CameraServiceProxyImpl"));
    return new CameraServiceProxyImpl.fromEndpoint(endpoint);
  }

  String get name => CameraServiceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case kCameraService_getLatestFrame_name:
        var r = CameraServiceGetLatestFrameResponseParams.deserialize(
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
    return "CameraServiceProxyImpl($superString)";
  }
}


class _CameraServiceProxyCalls implements CameraService {
  CameraServiceProxyImpl _proxyImpl;

  _CameraServiceProxyCalls(this._proxyImpl);
    dynamic getLatestFrame([Function responseFactory = null]) {
      var params = new CameraServiceGetLatestFrameParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kCameraService_getLatestFrame_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class CameraServiceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  CameraService ptr;
  final String name = CameraServiceName;

  CameraServiceProxy(CameraServiceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _CameraServiceProxyCalls(proxyImpl);

  CameraServiceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new CameraServiceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _CameraServiceProxyCalls(impl);
  }

  CameraServiceProxy.fromHandle(core.MojoHandle handle) :
      impl = new CameraServiceProxyImpl.fromHandle(handle) {
    ptr = new _CameraServiceProxyCalls(impl);
  }

  CameraServiceProxy.unbound() :
      impl = new CameraServiceProxyImpl.unbound() {
    ptr = new _CameraServiceProxyCalls(impl);
  }

  factory CameraServiceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    CameraServiceProxy p = new CameraServiceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static CameraServiceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CameraServiceProxy"));
    return new CameraServiceProxy.fromEndpoint(endpoint);
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
    return "CameraServiceProxy($impl)";
  }
}


class CameraServiceStub extends bindings.Stub {
  CameraService _impl = null;

  CameraServiceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  CameraServiceStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  CameraServiceStub.unbound() : super.unbound();

  static CameraServiceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CameraServiceStub"));
    return new CameraServiceStub.fromEndpoint(endpoint);
  }

  static const String name = CameraServiceName;


  CameraServiceGetLatestFrameResponseParams _CameraServiceGetLatestFrameResponseParamsFactory(core.MojoDataPipeConsumer content) {
    var mojo_factory_result = new CameraServiceGetLatestFrameResponseParams();
    mojo_factory_result.content = content;
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
      case kCameraService_getLatestFrame_name:
        var params = CameraServiceGetLatestFrameParams.deserialize(
            message.payload);
        var response = _impl.getLatestFrame(_CameraServiceGetLatestFrameResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kCameraService_getLatestFrame_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kCameraService_getLatestFrame_name,
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

  CameraService get impl => _impl;
  set impl(CameraService d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "CameraServiceStub($superString)";
  }

  int get version => 0;
}


