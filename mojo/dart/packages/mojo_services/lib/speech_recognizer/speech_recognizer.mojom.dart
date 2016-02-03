// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library speech_recognizer_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;

class Error extends bindings.MojoEnum {
  static const Error networkTimeout = const Error._(1);
  static const Error network = const Error._(2);
  static const Error audio = const Error._(3);
  static const Error server = const Error._(4);
  static const Error client = const Error._(5);
  static const Error speechTimeout = const Error._(6);
  static const Error noMatch = const Error._(7);
  static const Error recognizerBusy = const Error._(8);
  static const Error insufficientPermissions = const Error._(9);

  const Error._(int v) : super(v);

  static const Map<String, Error> valuesMap = const {
    "networkTimeout": networkTimeout,
    "network": network,
    "audio": audio,
    "server": server,
    "client": client,
    "speechTimeout": speechTimeout,
    "noMatch": noMatch,
    "recognizerBusy": recognizerBusy,
    "insufficientPermissions": insufficientPermissions,
  };
  static const List<Error> values = const [
    networkTimeout,
    network,
    audio,
    server,
    client,
    speechTimeout,
    noMatch,
    recognizerBusy,
    insufficientPermissions,
  ];

  static Error valueOf(String name) => valuesMap[name];

  factory Error(int v) {
    switch (v) {
      case 1:
        return networkTimeout;
      case 2:
        return network;
      case 3:
        return audio;
      case 4:
        return server;
      case 5:
        return client;
      case 6:
        return speechTimeout;
      case 7:
        return noMatch;
      case 8:
        return recognizerBusy;
      case 9:
        return insufficientPermissions;
      default:
        return null;
    }
  }

  static Error decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    Error result = new Error(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum Error.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case networkTimeout:
        return 'Error.networkTimeout';
      case network:
        return 'Error.network';
      case audio:
        return 'Error.audio';
      case server:
        return 'Error.server';
      case client:
        return 'Error.client';
      case speechTimeout:
        return 'Error.speechTimeout';
      case noMatch:
        return 'Error.noMatch';
      case recognizerBusy:
        return 'Error.recognizerBusy';
      case insufficientPermissions:
        return 'Error.insufficientPermissions';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}





class UtteranceCandidate extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String text = null;
  double confidenceScore = 0.0;

  UtteranceCandidate() : super(kVersions.last.size);

  static UtteranceCandidate deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UtteranceCandidate decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UtteranceCandidate result = new UtteranceCandidate();

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
      
      result.text = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.confidenceScore = decoder0.decodeFloat(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(text, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "text of struct UtteranceCandidate: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(confidenceScore, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "confidenceScore of struct UtteranceCandidate: $e";
      rethrow;
    }
  }

  String toString() {
    return "UtteranceCandidate("
           "text: $text" ", "
           "confidenceScore: $confidenceScore" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["text"] = text;
    map["confidenceScore"] = confidenceScore;
    return map;
  }
}




class _SpeechRecognizerServiceListenParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _SpeechRecognizerServiceListenParams() : super(kVersions.last.size);

  static _SpeechRecognizerServiceListenParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SpeechRecognizerServiceListenParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SpeechRecognizerServiceListenParams result = new _SpeechRecognizerServiceListenParams();

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
    return "_SpeechRecognizerServiceListenParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}




class SpeechRecognizerServiceListenResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  ResultOrError resultOrError = null;

  SpeechRecognizerServiceListenResponseParams() : super(kVersions.last.size);

  static SpeechRecognizerServiceListenResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SpeechRecognizerServiceListenResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SpeechRecognizerServiceListenResponseParams result = new SpeechRecognizerServiceListenResponseParams();

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
      
        result.resultOrError = ResultOrError.decode(decoder0, 8);
        if (result.resultOrError == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable ResultOrError.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUnion(resultOrError, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "resultOrError of struct SpeechRecognizerServiceListenResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "SpeechRecognizerServiceListenResponseParams("
           "resultOrError: $resultOrError" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["resultOrError"] = resultOrError;
    return map;
  }
}




class _SpeechRecognizerServiceStopListeningParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _SpeechRecognizerServiceStopListeningParams() : super(kVersions.last.size);

  static _SpeechRecognizerServiceStopListeningParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SpeechRecognizerServiceStopListeningParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SpeechRecognizerServiceStopListeningParams result = new _SpeechRecognizerServiceStopListeningParams();

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
    return "_SpeechRecognizerServiceStopListeningParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}





enum ResultOrErrorTag {
  errorCode,
  results,
  unknown
}

class ResultOrError extends bindings.Union {
  static final _tag_to_int = const {
    ResultOrErrorTag.errorCode: 0,
    ResultOrErrorTag.results: 1,
  };

  static final _int_to_tag = const {
    0: ResultOrErrorTag.errorCode,
    1: ResultOrErrorTag.results,
  };

  var _data;
  ResultOrErrorTag _tag = ResultOrErrorTag.unknown;

  ResultOrErrorTag get tag => _tag;
  Error get errorCode {
    if (_tag != ResultOrErrorTag.errorCode) {
      throw new bindings.UnsetUnionTagError(_tag, ResultOrErrorTag.errorCode);
    }
    return _data;
  }

  set errorCode(Error value) {
    _tag = ResultOrErrorTag.errorCode;
    _data = value;
  }
  List<UtteranceCandidate> get results {
    if (_tag != ResultOrErrorTag.results) {
      throw new bindings.UnsetUnionTagError(_tag, ResultOrErrorTag.results);
    }
    return _data;
  }

  set results(List<UtteranceCandidate> value) {
    _tag = ResultOrErrorTag.results;
    _data = value;
  }

  static ResultOrError decode(bindings.Decoder decoder0, int offset) {
    int size = decoder0.decodeUint32(offset);
    if (size == 0) {
      return null;
    }
    ResultOrError result = new ResultOrError();

    // TODO(azani): Handle unknown union member.
    ResultOrErrorTag tag = _int_to_tag[decoder0.decodeUint32(offset + 4)];
    switch (tag) {
      case ResultOrErrorTag.errorCode:
        
          result.errorCode = Error.decode(decoder0, offset + 8);
          if (result.errorCode == null) {
            throw new bindings.MojoCodecError(
              'Trying to decode null union for non-nullable Error.');
          }
        break;
      case ResultOrErrorTag.results:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        {
          var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
          result.results = new List<UtteranceCandidate>(si1.numElements);
          for (int i1 = 0; i1 < si1.numElements; ++i1) {
            
            var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
            result.results[i1] = UtteranceCandidate.decode(decoder2);
          }
        }
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $tag");
    }

    return result;
  }

  void encode(bindings.Encoder encoder0, int offset) {
    // TODO(azani): Error when trying to encode an unknown member.
    encoder0.encodeUint32(16, offset);
    encoder0.encodeUint32(_tag_to_int[_tag], offset + 4);
    switch (_tag) {
      case ResultOrErrorTag.errorCode:
        encoder0.encodeEnum(errorCode, offset + 8);
        break;
      case ResultOrErrorTag.results:
        if (results == null) {
          encoder0.encodeNullPointer(offset + 8, false);
        } else {
          var encoder1 = encoder0.encodePointerArray(results.length, offset + 8, bindings.kUnspecifiedArrayLength);
          for (int i0 = 0; i0 < results.length; ++i0) {
            encoder1.encodeStruct(results[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
          }
        }
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $_tag");
    }
  }

  String toString() {
    String result = "ResultOrError(";
    switch (_tag) {
      case ResultOrErrorTag.errorCode:
        result += "errorCode";
        break;
      case ResultOrErrorTag.results:
        result += "results";
        break;
      default:
        result += "unknown";
    }
    result += ": $_data)";
    return result;
  }
}



const int _SpeechRecognizerService_listenName = 0;
const int _SpeechRecognizerService_stopListeningName = 1;



class _SpeechRecognizerServiceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class SpeechRecognizerService {
  static const String serviceName = "speech_recognizer::SpeechRecognizerService";
  dynamic listen([Function responseFactory = null]);
  void stopListening();
}


class _SpeechRecognizerServiceProxyImpl extends bindings.Proxy {
  _SpeechRecognizerServiceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _SpeechRecognizerServiceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _SpeechRecognizerServiceProxyImpl.unbound() : super.unbound();

  static _SpeechRecognizerServiceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _SpeechRecognizerServiceProxyImpl"));
    return new _SpeechRecognizerServiceProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _SpeechRecognizerServiceServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _SpeechRecognizerService_listenName:
        var r = SpeechRecognizerServiceListenResponseParams.deserialize(
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
    return "_SpeechRecognizerServiceProxyImpl($superString)";
  }
}


class _SpeechRecognizerServiceProxyCalls implements SpeechRecognizerService {
  _SpeechRecognizerServiceProxyImpl _proxyImpl;

  _SpeechRecognizerServiceProxyCalls(this._proxyImpl);
    dynamic listen([Function responseFactory = null]) {
      var params = new _SpeechRecognizerServiceListenParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _SpeechRecognizerService_listenName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    void stopListening() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _SpeechRecognizerServiceStopListeningParams();
      _proxyImpl.sendMessage(params, _SpeechRecognizerService_stopListeningName);
    }
}


class SpeechRecognizerServiceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  SpeechRecognizerService ptr;

  SpeechRecognizerServiceProxy(_SpeechRecognizerServiceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _SpeechRecognizerServiceProxyCalls(proxyImpl);

  SpeechRecognizerServiceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _SpeechRecognizerServiceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _SpeechRecognizerServiceProxyCalls(impl);
  }

  SpeechRecognizerServiceProxy.fromHandle(core.MojoHandle handle) :
      impl = new _SpeechRecognizerServiceProxyImpl.fromHandle(handle) {
    ptr = new _SpeechRecognizerServiceProxyCalls(impl);
  }

  SpeechRecognizerServiceProxy.unbound() :
      impl = new _SpeechRecognizerServiceProxyImpl.unbound() {
    ptr = new _SpeechRecognizerServiceProxyCalls(impl);
  }

  factory SpeechRecognizerServiceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    SpeechRecognizerServiceProxy p = new SpeechRecognizerServiceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static SpeechRecognizerServiceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SpeechRecognizerServiceProxy"));
    return new SpeechRecognizerServiceProxy.fromEndpoint(endpoint);
  }

  String get serviceName => SpeechRecognizerService.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "SpeechRecognizerServiceProxy($impl)";
  }
}


class SpeechRecognizerServiceStub extends bindings.Stub {
  SpeechRecognizerService _impl = null;

  SpeechRecognizerServiceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  SpeechRecognizerServiceStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  SpeechRecognizerServiceStub.unbound() : super.unbound();

  static SpeechRecognizerServiceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SpeechRecognizerServiceStub"));
    return new SpeechRecognizerServiceStub.fromEndpoint(endpoint);
  }


  SpeechRecognizerServiceListenResponseParams _SpeechRecognizerServiceListenResponseParamsFactory(ResultOrError resultOrError) {
    var mojo_factory_result = new SpeechRecognizerServiceListenResponseParams();
    mojo_factory_result.resultOrError = resultOrError;
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
      case _SpeechRecognizerService_listenName:
        var params = _SpeechRecognizerServiceListenParams.deserialize(
            message.payload);
        var response = _impl.listen(_SpeechRecognizerServiceListenResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _SpeechRecognizerService_listenName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _SpeechRecognizerService_listenName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _SpeechRecognizerService_stopListeningName:
        var params = _SpeechRecognizerServiceStopListeningParams.deserialize(
            message.payload);
        _impl.stopListening();
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  SpeechRecognizerService get impl => _impl;
  set impl(SpeechRecognizerService d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "SpeechRecognizerServiceStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _SpeechRecognizerServiceServiceDescription();
}



