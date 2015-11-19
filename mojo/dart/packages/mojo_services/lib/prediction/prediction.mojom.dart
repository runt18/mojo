// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library prediction_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;



class PrevWordInfo extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String word = null;
  bool isBeginningOfSentence = false;

  PrevWordInfo() : super(kVersions.last.size);

  static PrevWordInfo deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static PrevWordInfo decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    PrevWordInfo result = new PrevWordInfo();

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
      
      result.word = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.isBeginningOfSentence = decoder0.decodeBool(16, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeString(word, 8, false);
    
    encoder0.encodeBool(isBeginningOfSentence, 16, 0);
  }

  String toString() {
    return "PrevWordInfo("
           "word: $word" ", "
           "isBeginningOfSentence: $isBeginningOfSentence" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["word"] = word;
    map["isBeginningOfSentence"] = isBeginningOfSentence;
    return map;
  }
}


class PredictionInfo extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  List<PrevWordInfo> previousWords = null;
  String currentWord = null;

  PredictionInfo() : super(kVersions.last.size);

  static PredictionInfo deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static PredictionInfo decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    PredictionInfo result = new PredictionInfo();

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
        result.previousWords = new List<PrevWordInfo>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.previousWords[i1] = PrevWordInfo.decode(decoder2);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      result.currentWord = decoder0.decodeString(16, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    if (previousWords == null) {
      encoder0.encodeNullPointer(8, false);
    } else {
      var encoder1 = encoder0.encodePointerArray(previousWords.length, 8, bindings.kUnspecifiedArrayLength);
      for (int i0 = 0; i0 < previousWords.length; ++i0) {
        
        encoder1.encodeStruct(previousWords[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
      }
    }
    
    encoder0.encodeString(currentWord, 16, false);
  }

  String toString() {
    return "PredictionInfo("
           "previousWords: $previousWords" ", "
           "currentWord: $currentWord" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["previousWords"] = previousWords;
    map["currentWord"] = currentWord;
    return map;
  }
}


class PredictionServiceGetPredictionListParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  PredictionInfo predictionInfo = null;

  PredictionServiceGetPredictionListParams() : super(kVersions.last.size);

  static PredictionServiceGetPredictionListParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static PredictionServiceGetPredictionListParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    PredictionServiceGetPredictionListParams result = new PredictionServiceGetPredictionListParams();

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
      result.predictionInfo = PredictionInfo.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(predictionInfo, 8, false);
  }

  String toString() {
    return "PredictionServiceGetPredictionListParams("
           "predictionInfo: $predictionInfo" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["predictionInfo"] = predictionInfo;
    return map;
  }
}


class PredictionServiceGetPredictionListResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<String> predictionList = null;

  PredictionServiceGetPredictionListResponseParams() : super(kVersions.last.size);

  static PredictionServiceGetPredictionListResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static PredictionServiceGetPredictionListResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    PredictionServiceGetPredictionListResponseParams result = new PredictionServiceGetPredictionListResponseParams();

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
      if (decoder1 == null) {
        result.predictionList = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.predictionList = new List<String>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.predictionList[i1] = decoder1.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    if (predictionList == null) {
      encoder0.encodeNullPointer(8, true);
    } else {
      var encoder1 = encoder0.encodePointerArray(predictionList.length, 8, bindings.kUnspecifiedArrayLength);
      for (int i0 = 0; i0 < predictionList.length; ++i0) {
        
        encoder1.encodeString(predictionList[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
      }
    }
  }

  String toString() {
    return "PredictionServiceGetPredictionListResponseParams("
           "predictionList: $predictionList" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["predictionList"] = predictionList;
    return map;
  }
}

const int kPredictionService_getPredictionList_name = 0;

const String PredictionServiceName =
      'prediction::PredictionService';

abstract class PredictionService {
  dynamic getPredictionList(PredictionInfo predictionInfo,[Function responseFactory = null]);

}


class PredictionServiceProxyImpl extends bindings.Proxy {
  PredictionServiceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  PredictionServiceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  PredictionServiceProxyImpl.unbound() : super.unbound();

  static PredictionServiceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For PredictionServiceProxyImpl"));
    return new PredictionServiceProxyImpl.fromEndpoint(endpoint);
  }

  String get name => PredictionServiceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case kPredictionService_getPredictionList_name:
        var r = PredictionServiceGetPredictionListResponseParams.deserialize(
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
    return "PredictionServiceProxyImpl($superString)";
  }
}


class _PredictionServiceProxyCalls implements PredictionService {
  PredictionServiceProxyImpl _proxyImpl;

  _PredictionServiceProxyCalls(this._proxyImpl);
    dynamic getPredictionList(PredictionInfo predictionInfo,[Function responseFactory = null]) {
      var params = new PredictionServiceGetPredictionListParams();
      params.predictionInfo = predictionInfo;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kPredictionService_getPredictionList_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class PredictionServiceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  PredictionService ptr;
  final String name = PredictionServiceName;

  PredictionServiceProxy(PredictionServiceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _PredictionServiceProxyCalls(proxyImpl);

  PredictionServiceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new PredictionServiceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _PredictionServiceProxyCalls(impl);
  }

  PredictionServiceProxy.fromHandle(core.MojoHandle handle) :
      impl = new PredictionServiceProxyImpl.fromHandle(handle) {
    ptr = new _PredictionServiceProxyCalls(impl);
  }

  PredictionServiceProxy.unbound() :
      impl = new PredictionServiceProxyImpl.unbound() {
    ptr = new _PredictionServiceProxyCalls(impl);
  }

  factory PredictionServiceProxy.connectToService(
      bindings.ServiceConnector s, String url) {
    PredictionServiceProxy p = new PredictionServiceProxy.unbound();
    s.connectToService(url, p);
    return p;
  }

  static PredictionServiceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For PredictionServiceProxy"));
    return new PredictionServiceProxy.fromEndpoint(endpoint);
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
    return "PredictionServiceProxy($impl)";
  }
}


class PredictionServiceStub extends bindings.Stub {
  PredictionService _impl = null;

  PredictionServiceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  PredictionServiceStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  PredictionServiceStub.unbound() : super.unbound();

  static PredictionServiceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For PredictionServiceStub"));
    return new PredictionServiceStub.fromEndpoint(endpoint);
  }

  static const String name = PredictionServiceName;


  PredictionServiceGetPredictionListResponseParams _PredictionServiceGetPredictionListResponseParamsFactory(List<String> predictionList) {
    var mojo_factory_result = new PredictionServiceGetPredictionListResponseParams();
    mojo_factory_result.predictionList = predictionList;
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
      case kPredictionService_getPredictionList_name:
        var params = PredictionServiceGetPredictionListParams.deserialize(
            message.payload);
        var response = _impl.getPredictionList(params.predictionInfo,_PredictionServiceGetPredictionListResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kPredictionService_getPredictionList_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kPredictionService_getPredictionList_name,
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

  PredictionService get impl => _impl;
  set impl(PredictionService d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "PredictionServiceStub($superString)";
  }

  int get version => 0;
}


