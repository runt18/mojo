// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library speech_recognizer_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
class Error extends bindings.MojoEnum {
  static const NETWORK_TIMEOUT = const Error._(1);
  static const NETWORK = const Error._(2);
  static const AUDIO = const Error._(3);
  static const SERVER = const Error._(4);
  static const CLIENT = const Error._(5);
  static const SPEECH_TIMEOUT = const Error._(6);
  static const NO_MATCH = const Error._(7);
  static const RECOGNIZER_BUSY = const Error._(8);
  static const INSUFFICIENT_PERMISSIONS = const Error._(9);

  const Error._(int v) : super(v);

  static const Map<String, Error> valuesMap = const {
    "NETWORK_TIMEOUT": NETWORK_TIMEOUT,
    "NETWORK": NETWORK,
    "AUDIO": AUDIO,
    "SERVER": SERVER,
    "CLIENT": CLIENT,
    "SPEECH_TIMEOUT": SPEECH_TIMEOUT,
    "NO_MATCH": NO_MATCH,
    "RECOGNIZER_BUSY": RECOGNIZER_BUSY,
    "INSUFFICIENT_PERMISSIONS": INSUFFICIENT_PERMISSIONS,
  };
  static const List<Error> values = const [
    NETWORK_TIMEOUT,
    NETWORK,
    AUDIO,
    SERVER,
    CLIENT,
    SPEECH_TIMEOUT,
    NO_MATCH,
    RECOGNIZER_BUSY,
    INSUFFICIENT_PERMISSIONS,
  ];

  static Error valueOf(String name) => valuesMap[name];

  factory Error(int v) {
    switch (v) {
      case 1:
        return NETWORK_TIMEOUT;
      case 2:
        return NETWORK;
      case 3:
        return AUDIO;
      case 4:
        return SERVER;
      case 5:
        return CLIENT;
      case 6:
        return SPEECH_TIMEOUT;
      case 7:
        return NO_MATCH;
      case 8:
        return RECOGNIZER_BUSY;
      case 9:
        return INSUFFICIENT_PERMISSIONS;
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
      case NETWORK_TIMEOUT:
        return 'Error.NETWORK_TIMEOUT';
      case NETWORK:
        return 'Error.NETWORK';
      case AUDIO:
        return 'Error.AUDIO';
      case SERVER:
        return 'Error.SERVER';
      case CLIENT:
        return 'Error.CLIENT';
      case SPEECH_TIMEOUT:
        return 'Error.SPEECH_TIMEOUT';
      case NO_MATCH:
        return 'Error.NO_MATCH';
      case RECOGNIZER_BUSY:
        return 'Error.RECOGNIZER_BUSY';
      case INSUFFICIENT_PERMISSIONS:
        return 'Error.INSUFFICIENT_PERMISSIONS';
    }
  }

  int toJson() => value;
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
    
    encoder0.encodeString(text, 8, false);
    
    encoder0.encodeFloat(confidenceScore, 16);
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


class SpeechRecognizerServiceListenParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  SpeechRecognizerServiceListenParams() : super(kVersions.last.size);

  static SpeechRecognizerServiceListenParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SpeechRecognizerServiceListenParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SpeechRecognizerServiceListenParams result = new SpeechRecognizerServiceListenParams();

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
    return "SpeechRecognizerServiceListenParams("")";
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
    
    encoder0.encodeUnion(resultOrError, 8, false);
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


class SpeechRecognizerServiceStopListeningParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  SpeechRecognizerServiceStopListeningParams() : super(kVersions.last.size);

  static SpeechRecognizerServiceStopListeningParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SpeechRecognizerServiceStopListeningParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SpeechRecognizerServiceStopListeningParams result = new SpeechRecognizerServiceStopListeningParams();

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
    return "SpeechRecognizerServiceStopListeningParams("")";
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
const int kSpeechRecognizerService_listen_name = 0;
const int kSpeechRecognizerService_stopListening_name = 1;
const String SpeechRecognizerServiceName = "speech_recognizer::SpeechRecognizerService";

abstract class SpeechRecognizerService {
  dynamic listen([Function responseFactory = null]);
  void stopListening();

}


class SpeechRecognizerServiceProxyImpl extends bindings.Proxy {
  SpeechRecognizerServiceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  SpeechRecognizerServiceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  SpeechRecognizerServiceProxyImpl.unbound() : super.unbound();

  static SpeechRecognizerServiceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SpeechRecognizerServiceProxyImpl"));
    return new SpeechRecognizerServiceProxyImpl.fromEndpoint(endpoint);
  }

  String get name => SpeechRecognizerServiceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case kSpeechRecognizerService_listen_name:
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
    return "SpeechRecognizerServiceProxyImpl($superString)";
  }
}


class _SpeechRecognizerServiceProxyCalls implements SpeechRecognizerService {
  SpeechRecognizerServiceProxyImpl _proxyImpl;

  _SpeechRecognizerServiceProxyCalls(this._proxyImpl);
    dynamic listen([Function responseFactory = null]) {
      var params = new SpeechRecognizerServiceListenParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kSpeechRecognizerService_listen_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    void stopListening() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new SpeechRecognizerServiceStopListeningParams();
      _proxyImpl.sendMessage(params, kSpeechRecognizerService_stopListening_name);
    }
  
}


class SpeechRecognizerServiceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  SpeechRecognizerService ptr;
  final String name = SpeechRecognizerServiceName;

  SpeechRecognizerServiceProxy(SpeechRecognizerServiceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _SpeechRecognizerServiceProxyCalls(proxyImpl);

  SpeechRecognizerServiceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new SpeechRecognizerServiceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _SpeechRecognizerServiceProxyCalls(impl);
  }

  SpeechRecognizerServiceProxy.fromHandle(core.MojoHandle handle) :
      impl = new SpeechRecognizerServiceProxyImpl.fromHandle(handle) {
    ptr = new _SpeechRecognizerServiceProxyCalls(impl);
  }

  SpeechRecognizerServiceProxy.unbound() :
      impl = new SpeechRecognizerServiceProxyImpl.unbound() {
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

  static const String name = SpeechRecognizerServiceName;


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
      case kSpeechRecognizerService_listen_name:
        var params = SpeechRecognizerServiceListenParams.deserialize(
            message.payload);
        var response = _impl.listen(_SpeechRecognizerServiceListenResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kSpeechRecognizerService_listen_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kSpeechRecognizerService_listen_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kSpeechRecognizerService_stopListening_name:
        var params = SpeechRecognizerServiceStopListeningParams.deserialize(
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
}


