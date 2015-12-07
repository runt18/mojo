// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library terminal_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo_services/mojo/files/file.mojom.dart' as file_mojom;
import 'package:mojo_services/mojo/files/types.mojom.dart' as types_mojom;
import 'package:mojo_services/mojo/terminal/terminal_client.mojom.dart' as terminal_client_mojom;



class TerminalConnectParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object terminalFile = null;
  bool force = false;

  TerminalConnectParams() : super(kVersions.last.size);

  static TerminalConnectParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TerminalConnectParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TerminalConnectParams result = new TerminalConnectParams();

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
      
      result.terminalFile = decoder0.decodeInterfaceRequest(8, false, file_mojom.FileStub.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.force = decoder0.decodeBool(12, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInterfaceRequest(terminalFile, 8, false);
    
    encoder0.encodeBool(force, 12, 0);
  }

  String toString() {
    return "TerminalConnectParams("
           "terminalFile: $terminalFile" ", "
           "force: $force" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class TerminalConnectResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error error = null;

  TerminalConnectResponseParams() : super(kVersions.last.size);

  static TerminalConnectResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TerminalConnectResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TerminalConnectResponseParams result = new TerminalConnectResponseParams();

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
      
        result.error = types_mojom.Error.decode(decoder0, 8);
        if (result.error == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable types_mojom.Error.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(error, 8);
  }

  String toString() {
    return "TerminalConnectResponseParams("
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    return map;
  }
}


class TerminalConnectToClientParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  Object terminalClient = null;
  bool force = false;

  TerminalConnectToClientParams() : super(kVersions.last.size);

  static TerminalConnectToClientParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TerminalConnectToClientParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TerminalConnectToClientParams result = new TerminalConnectToClientParams();

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
      
      result.terminalClient = decoder0.decodeServiceInterface(8, false, terminal_client_mojom.TerminalClientProxy.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.force = decoder0.decodeBool(16, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInterface(terminalClient, 8, false);
    
    encoder0.encodeBool(force, 16, 0);
  }

  String toString() {
    return "TerminalConnectToClientParams("
           "terminalClient: $terminalClient" ", "
           "force: $force" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class TerminalConnectToClientResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error error = null;

  TerminalConnectToClientResponseParams() : super(kVersions.last.size);

  static TerminalConnectToClientResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TerminalConnectToClientResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TerminalConnectToClientResponseParams result = new TerminalConnectToClientResponseParams();

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
      
        result.error = types_mojom.Error.decode(decoder0, 8);
        if (result.error == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable types_mojom.Error.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(error, 8);
  }

  String toString() {
    return "TerminalConnectToClientResponseParams("
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    return map;
  }
}


class TerminalGetSizeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  TerminalGetSizeParams() : super(kVersions.last.size);

  static TerminalGetSizeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TerminalGetSizeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TerminalGetSizeParams result = new TerminalGetSizeParams();

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
    return "TerminalGetSizeParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class TerminalGetSizeResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  types_mojom.Error error = null;
  int rows = 0;
  int columns = 0;

  TerminalGetSizeResponseParams() : super(kVersions.last.size);

  static TerminalGetSizeResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TerminalGetSizeResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TerminalGetSizeResponseParams result = new TerminalGetSizeResponseParams();

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
      
        result.error = types_mojom.Error.decode(decoder0, 8);
        if (result.error == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable types_mojom.Error.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.rows = decoder0.decodeUint32(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.columns = decoder0.decodeUint32(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(error, 8);
    
    encoder0.encodeUint32(rows, 12);
    
    encoder0.encodeUint32(columns, 16);
  }

  String toString() {
    return "TerminalGetSizeResponseParams("
           "error: $error" ", "
           "rows: $rows" ", "
           "columns: $columns" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    map["rows"] = rows;
    map["columns"] = columns;
    return map;
  }
}


class TerminalSetSizeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int rows = 0;
  int columns = 0;
  bool reset = false;

  TerminalSetSizeParams() : super(kVersions.last.size);

  static TerminalSetSizeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TerminalSetSizeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TerminalSetSizeParams result = new TerminalSetSizeParams();

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
      
      result.rows = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.columns = decoder0.decodeUint32(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.reset = decoder0.decodeBool(16, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(rows, 8);
    
    encoder0.encodeUint32(columns, 12);
    
    encoder0.encodeBool(reset, 16, 0);
  }

  String toString() {
    return "TerminalSetSizeParams("
           "rows: $rows" ", "
           "columns: $columns" ", "
           "reset: $reset" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["rows"] = rows;
    map["columns"] = columns;
    map["reset"] = reset;
    return map;
  }
}


class TerminalSetSizeResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  types_mojom.Error error = null;
  int rows = 0;
  int columns = 0;

  TerminalSetSizeResponseParams() : super(kVersions.last.size);

  static TerminalSetSizeResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TerminalSetSizeResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TerminalSetSizeResponseParams result = new TerminalSetSizeResponseParams();

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
      
        result.error = types_mojom.Error.decode(decoder0, 8);
        if (result.error == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable types_mojom.Error.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.rows = decoder0.decodeUint32(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.columns = decoder0.decodeUint32(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(error, 8);
    
    encoder0.encodeUint32(rows, 12);
    
    encoder0.encodeUint32(columns, 16);
  }

  String toString() {
    return "TerminalSetSizeResponseParams("
           "error: $error" ", "
           "rows: $rows" ", "
           "columns: $columns" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    map["rows"] = rows;
    map["columns"] = columns;
    return map;
  }
}

const int kTerminal_connect_name = 0;
const int kTerminal_connectToClient_name = 1;
const int kTerminal_getSize_name = 2;
const int kTerminal_setSize_name = 3;
const String TerminalName = "mojo::terminal::Terminal";

abstract class Terminal {
  dynamic connect(Object terminalFile,bool force,[Function responseFactory = null]);
  dynamic connectToClient(Object terminalClient,bool force,[Function responseFactory = null]);
  dynamic getSize([Function responseFactory = null]);
  dynamic setSize(int rows,int columns,bool reset,[Function responseFactory = null]);

}


class TerminalProxyImpl extends bindings.Proxy {
  TerminalProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  TerminalProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  TerminalProxyImpl.unbound() : super.unbound();

  static TerminalProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TerminalProxyImpl"));
    return new TerminalProxyImpl.fromEndpoint(endpoint);
  }

  String get name => TerminalName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case kTerminal_connect_name:
        var r = TerminalConnectResponseParams.deserialize(
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
      case kTerminal_connectToClient_name:
        var r = TerminalConnectToClientResponseParams.deserialize(
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
      case kTerminal_getSize_name:
        var r = TerminalGetSizeResponseParams.deserialize(
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
      case kTerminal_setSize_name:
        var r = TerminalSetSizeResponseParams.deserialize(
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
    return "TerminalProxyImpl($superString)";
  }
}


class _TerminalProxyCalls implements Terminal {
  TerminalProxyImpl _proxyImpl;

  _TerminalProxyCalls(this._proxyImpl);
    dynamic connect(Object terminalFile,bool force,[Function responseFactory = null]) {
      var params = new TerminalConnectParams();
      params.terminalFile = terminalFile;
      params.force = force;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kTerminal_connect_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic connectToClient(Object terminalClient,bool force,[Function responseFactory = null]) {
      var params = new TerminalConnectToClientParams();
      params.terminalClient = terminalClient;
      params.force = force;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kTerminal_connectToClient_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic getSize([Function responseFactory = null]) {
      var params = new TerminalGetSizeParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kTerminal_getSize_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic setSize(int rows,int columns,bool reset,[Function responseFactory = null]) {
      var params = new TerminalSetSizeParams();
      params.rows = rows;
      params.columns = columns;
      params.reset = reset;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kTerminal_setSize_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class TerminalProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  Terminal ptr;
  final String name = TerminalName;

  TerminalProxy(TerminalProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _TerminalProxyCalls(proxyImpl);

  TerminalProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new TerminalProxyImpl.fromEndpoint(endpoint) {
    ptr = new _TerminalProxyCalls(impl);
  }

  TerminalProxy.fromHandle(core.MojoHandle handle) :
      impl = new TerminalProxyImpl.fromHandle(handle) {
    ptr = new _TerminalProxyCalls(impl);
  }

  TerminalProxy.unbound() :
      impl = new TerminalProxyImpl.unbound() {
    ptr = new _TerminalProxyCalls(impl);
  }

  factory TerminalProxy.connectToService(
      bindings.ServiceConnector s, String url) {
    TerminalProxy p = new TerminalProxy.unbound();
    s.connectToService(url, p);
    return p;
  }

  static TerminalProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TerminalProxy"));
    return new TerminalProxy.fromEndpoint(endpoint);
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
    return "TerminalProxy($impl)";
  }
}


class TerminalStub extends bindings.Stub {
  Terminal _impl = null;

  TerminalStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  TerminalStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  TerminalStub.unbound() : super.unbound();

  static TerminalStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TerminalStub"));
    return new TerminalStub.fromEndpoint(endpoint);
  }

  static const String name = TerminalName;


  TerminalConnectResponseParams _TerminalConnectResponseParamsFactory(types_mojom.Error error) {
    var mojo_factory_result = new TerminalConnectResponseParams();
    mojo_factory_result.error = error;
    return mojo_factory_result;
  }
  TerminalConnectToClientResponseParams _TerminalConnectToClientResponseParamsFactory(types_mojom.Error error) {
    var mojo_factory_result = new TerminalConnectToClientResponseParams();
    mojo_factory_result.error = error;
    return mojo_factory_result;
  }
  TerminalGetSizeResponseParams _TerminalGetSizeResponseParamsFactory(types_mojom.Error error, int rows, int columns) {
    var mojo_factory_result = new TerminalGetSizeResponseParams();
    mojo_factory_result.error = error;
    mojo_factory_result.rows = rows;
    mojo_factory_result.columns = columns;
    return mojo_factory_result;
  }
  TerminalSetSizeResponseParams _TerminalSetSizeResponseParamsFactory(types_mojom.Error error, int rows, int columns) {
    var mojo_factory_result = new TerminalSetSizeResponseParams();
    mojo_factory_result.error = error;
    mojo_factory_result.rows = rows;
    mojo_factory_result.columns = columns;
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
      case kTerminal_connect_name:
        var params = TerminalConnectParams.deserialize(
            message.payload);
        var response = _impl.connect(params.terminalFile,params.force,_TerminalConnectResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kTerminal_connect_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kTerminal_connect_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kTerminal_connectToClient_name:
        var params = TerminalConnectToClientParams.deserialize(
            message.payload);
        var response = _impl.connectToClient(params.terminalClient,params.force,_TerminalConnectToClientResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kTerminal_connectToClient_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kTerminal_connectToClient_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kTerminal_getSize_name:
        var params = TerminalGetSizeParams.deserialize(
            message.payload);
        var response = _impl.getSize(_TerminalGetSizeResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kTerminal_getSize_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kTerminal_getSize_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kTerminal_setSize_name:
        var params = TerminalSetSizeParams.deserialize(
            message.payload);
        var response = _impl.setSize(params.rows,params.columns,params.reset,_TerminalSetSizeResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kTerminal_setSize_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kTerminal_setSize_name,
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

  Terminal get impl => _impl;
  set impl(Terminal d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "TerminalStub($superString)";
  }

  int get version => 0;
}


