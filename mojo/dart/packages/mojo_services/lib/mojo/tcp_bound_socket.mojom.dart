// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library tcp_bound_socket_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/network_error.mojom.dart' as network_error_mojom;
import 'package:mojo_services/mojo/net_address.mojom.dart' as net_address_mojom;
import 'package:mojo_services/mojo/tcp_connected_socket.mojom.dart' as tcp_connected_socket_mojom;
import 'package:mojo_services/mojo/tcp_server_socket.mojom.dart' as tcp_server_socket_mojom;



class TcpBoundSocketStartListeningParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object server = null;

  TcpBoundSocketStartListeningParams() : super(kVersions.last.size);

  static TcpBoundSocketStartListeningParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TcpBoundSocketStartListeningParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TcpBoundSocketStartListeningParams result = new TcpBoundSocketStartListeningParams();

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
      
      result.server = decoder0.decodeInterfaceRequest(8, false, tcp_server_socket_mojom.TcpServerSocketStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInterfaceRequest(server, 8, false);
  }

  String toString() {
    return "TcpBoundSocketStartListeningParams("
           "server: $server" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class TcpBoundSocketStartListeningResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  network_error_mojom.NetworkError result = null;

  TcpBoundSocketStartListeningResponseParams() : super(kVersions.last.size);

  static TcpBoundSocketStartListeningResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TcpBoundSocketStartListeningResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TcpBoundSocketStartListeningResponseParams result = new TcpBoundSocketStartListeningResponseParams();

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
      result.result = network_error_mojom.NetworkError.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(result, 8, false);
  }

  String toString() {
    return "TcpBoundSocketStartListeningResponseParams("
           "result: $result" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["result"] = result;
    return map;
  }
}


class TcpBoundSocketConnectParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  net_address_mojom.NetAddress remoteAddress = null;
  core.MojoDataPipeConsumer sendStream = null;
  core.MojoDataPipeProducer receiveStream = null;
  Object clientSocket = null;

  TcpBoundSocketConnectParams() : super(kVersions.last.size);

  static TcpBoundSocketConnectParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TcpBoundSocketConnectParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TcpBoundSocketConnectParams result = new TcpBoundSocketConnectParams();

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
      result.remoteAddress = net_address_mojom.NetAddress.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.sendStream = decoder0.decodeConsumerHandle(16, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.receiveStream = decoder0.decodeProducerHandle(20, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.clientSocket = decoder0.decodeInterfaceRequest(24, false, tcp_connected_socket_mojom.TcpConnectedSocketStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(remoteAddress, 8, false);
    
    encoder0.encodeConsumerHandle(sendStream, 16, false);
    
    encoder0.encodeProducerHandle(receiveStream, 20, false);
    
    encoder0.encodeInterfaceRequest(clientSocket, 24, false);
  }

  String toString() {
    return "TcpBoundSocketConnectParams("
           "remoteAddress: $remoteAddress" ", "
           "sendStream: $sendStream" ", "
           "receiveStream: $receiveStream" ", "
           "clientSocket: $clientSocket" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class TcpBoundSocketConnectResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  network_error_mojom.NetworkError result = null;

  TcpBoundSocketConnectResponseParams() : super(kVersions.last.size);

  static TcpBoundSocketConnectResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TcpBoundSocketConnectResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TcpBoundSocketConnectResponseParams result = new TcpBoundSocketConnectResponseParams();

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
      result.result = network_error_mojom.NetworkError.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(result, 8, false);
  }

  String toString() {
    return "TcpBoundSocketConnectResponseParams("
           "result: $result" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["result"] = result;
    return map;
  }
}

const int kTcpBoundSocket_startListening_name = 0;
const int kTcpBoundSocket_connect_name = 1;

const String TcpBoundSocketName =
      'mojo::TCPBoundSocket';

abstract class TcpBoundSocket {
  dynamic startListening(Object server,[Function responseFactory = null]);
  dynamic connect(net_address_mojom.NetAddress remoteAddress,core.MojoDataPipeConsumer sendStream,core.MojoDataPipeProducer receiveStream,Object clientSocket,[Function responseFactory = null]);

}


class TcpBoundSocketProxyImpl extends bindings.Proxy {
  TcpBoundSocketProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  TcpBoundSocketProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  TcpBoundSocketProxyImpl.unbound() : super.unbound();

  static TcpBoundSocketProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TcpBoundSocketProxyImpl"));
    return new TcpBoundSocketProxyImpl.fromEndpoint(endpoint);
  }

  String get name => TcpBoundSocketName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case kTcpBoundSocket_startListening_name:
        var r = TcpBoundSocketStartListeningResponseParams.deserialize(
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
      case kTcpBoundSocket_connect_name:
        var r = TcpBoundSocketConnectResponseParams.deserialize(
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
    return "TcpBoundSocketProxyImpl($superString)";
  }
}


class _TcpBoundSocketProxyCalls implements TcpBoundSocket {
  TcpBoundSocketProxyImpl _proxyImpl;

  _TcpBoundSocketProxyCalls(this._proxyImpl);
    dynamic startListening(Object server,[Function responseFactory = null]) {
      var params = new TcpBoundSocketStartListeningParams();
      params.server = server;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kTcpBoundSocket_startListening_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic connect(net_address_mojom.NetAddress remoteAddress,core.MojoDataPipeConsumer sendStream,core.MojoDataPipeProducer receiveStream,Object clientSocket,[Function responseFactory = null]) {
      var params = new TcpBoundSocketConnectParams();
      params.remoteAddress = remoteAddress;
      params.sendStream = sendStream;
      params.receiveStream = receiveStream;
      params.clientSocket = clientSocket;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kTcpBoundSocket_connect_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class TcpBoundSocketProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  TcpBoundSocket ptr;
  final String name = TcpBoundSocketName;

  TcpBoundSocketProxy(TcpBoundSocketProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _TcpBoundSocketProxyCalls(proxyImpl);

  TcpBoundSocketProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new TcpBoundSocketProxyImpl.fromEndpoint(endpoint) {
    ptr = new _TcpBoundSocketProxyCalls(impl);
  }

  TcpBoundSocketProxy.fromHandle(core.MojoHandle handle) :
      impl = new TcpBoundSocketProxyImpl.fromHandle(handle) {
    ptr = new _TcpBoundSocketProxyCalls(impl);
  }

  TcpBoundSocketProxy.unbound() :
      impl = new TcpBoundSocketProxyImpl.unbound() {
    ptr = new _TcpBoundSocketProxyCalls(impl);
  }

  factory TcpBoundSocketProxy.connectToService(
      bindings.ServiceConnector s, String url) {
    TcpBoundSocketProxy p = new TcpBoundSocketProxy.unbound();
    s.connectToService(url, p);
    return p;
  }

  static TcpBoundSocketProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TcpBoundSocketProxy"));
    return new TcpBoundSocketProxy.fromEndpoint(endpoint);
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
    return "TcpBoundSocketProxy($impl)";
  }
}


class TcpBoundSocketStub extends bindings.Stub {
  TcpBoundSocket _impl = null;

  TcpBoundSocketStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  TcpBoundSocketStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  TcpBoundSocketStub.unbound() : super.unbound();

  static TcpBoundSocketStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TcpBoundSocketStub"));
    return new TcpBoundSocketStub.fromEndpoint(endpoint);
  }

  static const String name = TcpBoundSocketName;


  TcpBoundSocketStartListeningResponseParams _TcpBoundSocketStartListeningResponseParamsFactory(network_error_mojom.NetworkError result) {
    var mojo_factory_result = new TcpBoundSocketStartListeningResponseParams();
    mojo_factory_result.result = result;
    return mojo_factory_result;
  }
  TcpBoundSocketConnectResponseParams _TcpBoundSocketConnectResponseParamsFactory(network_error_mojom.NetworkError result) {
    var mojo_factory_result = new TcpBoundSocketConnectResponseParams();
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
      case kTcpBoundSocket_startListening_name:
        var params = TcpBoundSocketStartListeningParams.deserialize(
            message.payload);
        var response = _impl.startListening(params.server,_TcpBoundSocketStartListeningResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kTcpBoundSocket_startListening_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kTcpBoundSocket_startListening_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kTcpBoundSocket_connect_name:
        var params = TcpBoundSocketConnectParams.deserialize(
            message.payload);
        var response = _impl.connect(params.remoteAddress,params.sendStream,params.receiveStream,params.clientSocket,_TcpBoundSocketConnectResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kTcpBoundSocket_connect_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kTcpBoundSocket_connect_name,
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

  TcpBoundSocket get impl => _impl;
  set impl(TcpBoundSocket d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "TcpBoundSocketStub($superString)";
  }

  int get version => 0;
}


