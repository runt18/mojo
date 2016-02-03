// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library files_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/files/directory.mojom.dart' as directory_mojom;
import 'package:mojo_services/mojo/files/types.mojom.dart' as types_mojom;



class _FilesOpenFileSystemParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String fileSystem = null;
  Object directory = null;

  _FilesOpenFileSystemParams() : super(kVersions.last.size);

  static _FilesOpenFileSystemParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _FilesOpenFileSystemParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _FilesOpenFileSystemParams result = new _FilesOpenFileSystemParams();

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
      
      result.fileSystem = decoder0.decodeString(8, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.directory = decoder0.decodeInterfaceRequest(16, false, directory_mojom.DirectoryStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(fileSystem, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fileSystem of struct _FilesOpenFileSystemParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(directory, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "directory of struct _FilesOpenFileSystemParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_FilesOpenFileSystemParams("
           "fileSystem: $fileSystem" ", "
           "directory: $directory" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




class FilesOpenFileSystemResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error error = null;

  FilesOpenFileSystemResponseParams() : super(kVersions.last.size);

  static FilesOpenFileSystemResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FilesOpenFileSystemResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FilesOpenFileSystemResponseParams result = new FilesOpenFileSystemResponseParams();

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
    try {
      encoder0.encodeEnum(error, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct FilesOpenFileSystemResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "FilesOpenFileSystemResponseParams("
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    return map;
  }
}




const int _Files_openFileSystemName = 0;



class _FilesServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class Files {
  static const String serviceName = "mojo::files::Files";
  dynamic openFileSystem(String fileSystem,Object directory,[Function responseFactory = null]);
}


class _FilesProxyImpl extends bindings.Proxy {
  _FilesProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _FilesProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _FilesProxyImpl.unbound() : super.unbound();

  static _FilesProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _FilesProxyImpl"));
    return new _FilesProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _FilesServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _Files_openFileSystemName:
        var r = FilesOpenFileSystemResponseParams.deserialize(
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
    return "_FilesProxyImpl($superString)";
  }
}


class _FilesProxyCalls implements Files {
  _FilesProxyImpl _proxyImpl;

  _FilesProxyCalls(this._proxyImpl);
    dynamic openFileSystem(String fileSystem,Object directory,[Function responseFactory = null]) {
      var params = new _FilesOpenFileSystemParams();
      params.fileSystem = fileSystem;
      params.directory = directory;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _Files_openFileSystemName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class FilesProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  Files ptr;

  FilesProxy(_FilesProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _FilesProxyCalls(proxyImpl);

  FilesProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _FilesProxyImpl.fromEndpoint(endpoint) {
    ptr = new _FilesProxyCalls(impl);
  }

  FilesProxy.fromHandle(core.MojoHandle handle) :
      impl = new _FilesProxyImpl.fromHandle(handle) {
    ptr = new _FilesProxyCalls(impl);
  }

  FilesProxy.unbound() :
      impl = new _FilesProxyImpl.unbound() {
    ptr = new _FilesProxyCalls(impl);
  }

  factory FilesProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    FilesProxy p = new FilesProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static FilesProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For FilesProxy"));
    return new FilesProxy.fromEndpoint(endpoint);
  }

  String get serviceName => Files.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "FilesProxy($impl)";
  }
}


class FilesStub extends bindings.Stub {
  Files _impl = null;

  FilesStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  FilesStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  FilesStub.unbound() : super.unbound();

  static FilesStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For FilesStub"));
    return new FilesStub.fromEndpoint(endpoint);
  }


  FilesOpenFileSystemResponseParams _FilesOpenFileSystemResponseParamsFactory(types_mojom.Error error) {
    var mojo_factory_result = new FilesOpenFileSystemResponseParams();
    mojo_factory_result.error = error;
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
      case _Files_openFileSystemName:
        var params = _FilesOpenFileSystemParams.deserialize(
            message.payload);
        var response = _impl.openFileSystem(params.fileSystem,params.directory,_FilesOpenFileSystemResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _Files_openFileSystemName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _Files_openFileSystemName,
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

  Files get impl => _impl;
  set impl(Files d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "FilesStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _FilesServiceDescription();
}



