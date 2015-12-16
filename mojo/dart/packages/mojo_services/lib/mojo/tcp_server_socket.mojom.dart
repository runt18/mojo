// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library tcp_server_socket_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/network_error.mojom.dart' as network_error_mojom;
import 'package:mojo_services/mojo/net_address.mojom.dart' as net_address_mojom;
import 'package:mojo_services/mojo/tcp_connected_socket.mojom.dart' as tcp_connected_socket_mojom;



class _TcpServerSocketAcceptParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  core.MojoDataPipeConsumer sendStream = null;
  core.MojoDataPipeProducer receiveStream = null;
  Object clientSocket = null;

  _TcpServerSocketAcceptParams() : super(kVersions.last.size);

  static _TcpServerSocketAcceptParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _TcpServerSocketAcceptParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _TcpServerSocketAcceptParams result = new _TcpServerSocketAcceptParams();

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
      
      result.sendStream = decoder0.decodeConsumerHandle(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.receiveStream = decoder0.decodeProducerHandle(12, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.clientSocket = decoder0.decodeInterfaceRequest(16, false, tcp_connected_socket_mojom.TcpConnectedSocketStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeConsumerHandle(sendStream, 8, false);
    
    encoder0.encodeProducerHandle(receiveStream, 12, false);
    
    encoder0.encodeInterfaceRequest(clientSocket, 16, false);
  }

  String toString() {
    return "_TcpServerSocketAcceptParams("
           "sendStream: $sendStream" ", "
           "receiveStream: $receiveStream" ", "
           "clientSocket: $clientSocket" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class TcpServerSocketAcceptResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  network_error_mojom.NetworkError result = null;
  net_address_mojom.NetAddress remoteAddress = null;

  TcpServerSocketAcceptResponseParams() : super(kVersions.last.size);

  static TcpServerSocketAcceptResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TcpServerSocketAcceptResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TcpServerSocketAcceptResponseParams result = new TcpServerSocketAcceptResponseParams();

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
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.remoteAddress = net_address_mojom.NetAddress.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(result, 8, false);
    
    encoder0.encodeStruct(remoteAddress, 16, true);
  }

  String toString() {
    return "TcpServerSocketAcceptResponseParams("
           "result: $result" ", "
           "remoteAddress: $remoteAddress" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["result"] = result;
    map["remoteAddress"] = remoteAddress;
    return map;
  }
}

const int _TcpServerSocket_acceptName = 0;

abstract class TcpServerSocket {
  static const String serviceName = null;
  dynamic accept(core.MojoDataPipeConsumer sendStream,core.MojoDataPipeProducer receiveStream,Object clientSocket,[Function responseFactory = null]);
}


class _TcpServerSocketProxyImpl extends bindings.Proxy {
  _TcpServerSocketProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _TcpServerSocketProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _TcpServerSocketProxyImpl.unbound() : super.unbound();

  static _TcpServerSocketProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _TcpServerSocketProxyImpl"));
    return new _TcpServerSocketProxyImpl.fromEndpoint(endpoint);
  }

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _TcpServerSocket_acceptName:
        var r = TcpServerSocketAcceptResponseParams.deserialize(
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
    return "_TcpServerSocketProxyImpl($superString)";
  }
}


class _TcpServerSocketProxyCalls implements TcpServerSocket {
  _TcpServerSocketProxyImpl _proxyImpl;

  _TcpServerSocketProxyCalls(this._proxyImpl);
    dynamic accept(core.MojoDataPipeConsumer sendStream,core.MojoDataPipeProducer receiveStream,Object clientSocket,[Function responseFactory = null]) {
      var params = new _TcpServerSocketAcceptParams();
      params.sendStream = sendStream;
      params.receiveStream = receiveStream;
      params.clientSocket = clientSocket;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _TcpServerSocket_acceptName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class TcpServerSocketProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  TcpServerSocket ptr;

  TcpServerSocketProxy(_TcpServerSocketProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _TcpServerSocketProxyCalls(proxyImpl);

  TcpServerSocketProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _TcpServerSocketProxyImpl.fromEndpoint(endpoint) {
    ptr = new _TcpServerSocketProxyCalls(impl);
  }

  TcpServerSocketProxy.fromHandle(core.MojoHandle handle) :
      impl = new _TcpServerSocketProxyImpl.fromHandle(handle) {
    ptr = new _TcpServerSocketProxyCalls(impl);
  }

  TcpServerSocketProxy.unbound() :
      impl = new _TcpServerSocketProxyImpl.unbound() {
    ptr = new _TcpServerSocketProxyCalls(impl);
  }

  factory TcpServerSocketProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    TcpServerSocketProxy p = new TcpServerSocketProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static TcpServerSocketProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TcpServerSocketProxy"));
    return new TcpServerSocketProxy.fromEndpoint(endpoint);
  }

  String get serviceName => TcpServerSocket.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "TcpServerSocketProxy($impl)";
  }
}


class TcpServerSocketStub extends bindings.Stub {
  TcpServerSocket _impl = null;

  TcpServerSocketStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  TcpServerSocketStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  TcpServerSocketStub.unbound() : super.unbound();

  static TcpServerSocketStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TcpServerSocketStub"));
    return new TcpServerSocketStub.fromEndpoint(endpoint);
  }


  TcpServerSocketAcceptResponseParams _TcpServerSocketAcceptResponseParamsFactory(network_error_mojom.NetworkError result, net_address_mojom.NetAddress remoteAddress) {
    var mojo_factory_result = new TcpServerSocketAcceptResponseParams();
    mojo_factory_result.result = result;
    mojo_factory_result.remoteAddress = remoteAddress;
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
      case _TcpServerSocket_acceptName:
        var params = _TcpServerSocketAcceptParams.deserialize(
            message.payload);
        var response = _impl.accept(params.sendStream,params.receiveStream,params.clientSocket,_TcpServerSocketAcceptResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _TcpServerSocket_acceptName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _TcpServerSocket_acceptName,
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

  TcpServerSocket get impl => _impl;
  set impl(TcpServerSocket d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "TcpServerSocketStub($superString)";
  }

  int get version => 0;
}


