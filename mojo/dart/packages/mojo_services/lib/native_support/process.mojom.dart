// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library process_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo_services/mojo/files/file.mojom.dart' as file_mojom;
import 'package:mojo_services/mojo/files/types.mojom.dart' as types_mojom;



class ProcessSpawnParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(64, 0)
  ];
  List<int> path = null;
  List<List<int>> argv = null;
  List<List<int>> envp = null;
  Object stdinFile = null;
  Object stdoutFile = null;
  Object stderrFile = null;
  Object processController = null;

  ProcessSpawnParams() : super(kVersions.last.size);

  static ProcessSpawnParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ProcessSpawnParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ProcessSpawnParams result = new ProcessSpawnParams();

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
      
      result.path = decoder0.decodeUint8Array(8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      if (decoder1 == null) {
        result.argv = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.argv = new List<List<int>>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.argv[i1] = decoder1.decodeUint8Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, true);
      if (decoder1 == null) {
        result.envp = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.envp = new List<List<int>>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.envp[i1] = decoder1.decodeUint8Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      result.stdinFile = decoder0.decodeServiceInterface(32, true, file_mojom.FileProxy.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.stdoutFile = decoder0.decodeServiceInterface(40, true, file_mojom.FileProxy.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.stderrFile = decoder0.decodeServiceInterface(48, true, file_mojom.FileProxy.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.processController = decoder0.decodeInterfaceRequest(56, false, ProcessControllerStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint8Array(path, 8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    
    if (argv == null) {
      encoder0.encodeNullPointer(16, true);
    } else {
      var encoder1 = encoder0.encodePointerArray(argv.length, 16, bindings.kUnspecifiedArrayLength);
      for (int i0 = 0; i0 < argv.length; ++i0) {
        
        encoder1.encodeUint8Array(argv[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      }
    }
    
    if (envp == null) {
      encoder0.encodeNullPointer(24, true);
    } else {
      var encoder1 = encoder0.encodePointerArray(envp.length, 24, bindings.kUnspecifiedArrayLength);
      for (int i0 = 0; i0 < envp.length; ++i0) {
        
        encoder1.encodeUint8Array(envp[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      }
    }
    
    encoder0.encodeInterface(stdinFile, 32, true);
    
    encoder0.encodeInterface(stdoutFile, 40, true);
    
    encoder0.encodeInterface(stderrFile, 48, true);
    
    encoder0.encodeInterfaceRequest(processController, 56, false);
  }

  String toString() {
    return "ProcessSpawnParams("
           "path: $path" ", "
           "argv: $argv" ", "
           "envp: $envp" ", "
           "stdinFile: $stdinFile" ", "
           "stdoutFile: $stdoutFile" ", "
           "stderrFile: $stderrFile" ", "
           "processController: $processController" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class ProcessSpawnResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error error = null;

  ProcessSpawnResponseParams() : super(kVersions.last.size);

  static ProcessSpawnResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ProcessSpawnResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ProcessSpawnResponseParams result = new ProcessSpawnResponseParams();

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
    return "ProcessSpawnResponseParams("
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    return map;
  }
}


class ProcessSpawnWithTerminalParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(48, 0)
  ];
  List<int> path = null;
  List<List<int>> argv = null;
  List<List<int>> envp = null;
  Object terminalFile = null;
  Object processController = null;

  ProcessSpawnWithTerminalParams() : super(kVersions.last.size);

  static ProcessSpawnWithTerminalParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ProcessSpawnWithTerminalParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ProcessSpawnWithTerminalParams result = new ProcessSpawnWithTerminalParams();

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
      
      result.path = decoder0.decodeUint8Array(8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      if (decoder1 == null) {
        result.argv = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.argv = new List<List<int>>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.argv[i1] = decoder1.decodeUint8Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, true);
      if (decoder1 == null) {
        result.envp = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.envp = new List<List<int>>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.envp[i1] = decoder1.decodeUint8Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      result.terminalFile = decoder0.decodeServiceInterface(32, false, file_mojom.FileProxy.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.processController = decoder0.decodeInterfaceRequest(40, false, ProcessControllerStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint8Array(path, 8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    
    if (argv == null) {
      encoder0.encodeNullPointer(16, true);
    } else {
      var encoder1 = encoder0.encodePointerArray(argv.length, 16, bindings.kUnspecifiedArrayLength);
      for (int i0 = 0; i0 < argv.length; ++i0) {
        
        encoder1.encodeUint8Array(argv[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      }
    }
    
    if (envp == null) {
      encoder0.encodeNullPointer(24, true);
    } else {
      var encoder1 = encoder0.encodePointerArray(envp.length, 24, bindings.kUnspecifiedArrayLength);
      for (int i0 = 0; i0 < envp.length; ++i0) {
        
        encoder1.encodeUint8Array(envp[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      }
    }
    
    encoder0.encodeInterface(terminalFile, 32, false);
    
    encoder0.encodeInterfaceRequest(processController, 40, false);
  }

  String toString() {
    return "ProcessSpawnWithTerminalParams("
           "path: $path" ", "
           "argv: $argv" ", "
           "envp: $envp" ", "
           "terminalFile: $terminalFile" ", "
           "processController: $processController" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class ProcessSpawnWithTerminalResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error error = null;

  ProcessSpawnWithTerminalResponseParams() : super(kVersions.last.size);

  static ProcessSpawnWithTerminalResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ProcessSpawnWithTerminalResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ProcessSpawnWithTerminalResponseParams result = new ProcessSpawnWithTerminalResponseParams();

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
    return "ProcessSpawnWithTerminalResponseParams("
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    return map;
  }
}


class ProcessControllerWaitParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  ProcessControllerWaitParams() : super(kVersions.last.size);

  static ProcessControllerWaitParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ProcessControllerWaitParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ProcessControllerWaitParams result = new ProcessControllerWaitParams();

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
    return "ProcessControllerWaitParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class ProcessControllerWaitResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error error = null;
  int exitStatus = 0;

  ProcessControllerWaitResponseParams() : super(kVersions.last.size);

  static ProcessControllerWaitResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ProcessControllerWaitResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ProcessControllerWaitResponseParams result = new ProcessControllerWaitResponseParams();

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
      
      result.exitStatus = decoder0.decodeInt32(12);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(error, 8);
    
    encoder0.encodeInt32(exitStatus, 12);
  }

  String toString() {
    return "ProcessControllerWaitResponseParams("
           "error: $error" ", "
           "exitStatus: $exitStatus" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    map["exitStatus"] = exitStatus;
    return map;
  }
}


class ProcessControllerKillParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int signal = 0;

  ProcessControllerKillParams() : super(kVersions.last.size);

  static ProcessControllerKillParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ProcessControllerKillParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ProcessControllerKillParams result = new ProcessControllerKillParams();

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
      
      result.signal = decoder0.decodeInt32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInt32(signal, 8);
  }

  String toString() {
    return "ProcessControllerKillParams("
           "signal: $signal" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["signal"] = signal;
    return map;
  }
}


class ProcessControllerKillResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error error = null;

  ProcessControllerKillResponseParams() : super(kVersions.last.size);

  static ProcessControllerKillResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ProcessControllerKillResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ProcessControllerKillResponseParams result = new ProcessControllerKillResponseParams();

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
    return "ProcessControllerKillResponseParams("
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    return map;
  }
}

const int kProcess_spawn_name = 0;
const int kProcess_spawnWithTerminal_name = 1;

const String ProcessName =
      'native_support::Process';

abstract class Process {
  dynamic spawn(List<int> path,List<List<int>> argv,List<List<int>> envp,Object stdinFile,Object stdoutFile,Object stderrFile,Object processController,[Function responseFactory = null]);
  dynamic spawnWithTerminal(List<int> path,List<List<int>> argv,List<List<int>> envp,Object terminalFile,Object processController,[Function responseFactory = null]);

}


class ProcessProxyImpl extends bindings.Proxy {
  ProcessProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  ProcessProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  ProcessProxyImpl.unbound() : super.unbound();

  static ProcessProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ProcessProxyImpl"));
    return new ProcessProxyImpl.fromEndpoint(endpoint);
  }

  String get name => ProcessName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case kProcess_spawn_name:
        var r = ProcessSpawnResponseParams.deserialize(
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
      case kProcess_spawnWithTerminal_name:
        var r = ProcessSpawnWithTerminalResponseParams.deserialize(
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
    return "ProcessProxyImpl($superString)";
  }
}


class _ProcessProxyCalls implements Process {
  ProcessProxyImpl _proxyImpl;

  _ProcessProxyCalls(this._proxyImpl);
    dynamic spawn(List<int> path,List<List<int>> argv,List<List<int>> envp,Object stdinFile,Object stdoutFile,Object stderrFile,Object processController,[Function responseFactory = null]) {
      var params = new ProcessSpawnParams();
      params.path = path;
      params.argv = argv;
      params.envp = envp;
      params.stdinFile = stdinFile;
      params.stdoutFile = stdoutFile;
      params.stderrFile = stderrFile;
      params.processController = processController;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kProcess_spawn_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic spawnWithTerminal(List<int> path,List<List<int>> argv,List<List<int>> envp,Object terminalFile,Object processController,[Function responseFactory = null]) {
      var params = new ProcessSpawnWithTerminalParams();
      params.path = path;
      params.argv = argv;
      params.envp = envp;
      params.terminalFile = terminalFile;
      params.processController = processController;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kProcess_spawnWithTerminal_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class ProcessProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  Process ptr;
  final String name = ProcessName;

  ProcessProxy(ProcessProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ProcessProxyCalls(proxyImpl);

  ProcessProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new ProcessProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ProcessProxyCalls(impl);
  }

  ProcessProxy.fromHandle(core.MojoHandle handle) :
      impl = new ProcessProxyImpl.fromHandle(handle) {
    ptr = new _ProcessProxyCalls(impl);
  }

  ProcessProxy.unbound() :
      impl = new ProcessProxyImpl.unbound() {
    ptr = new _ProcessProxyCalls(impl);
  }

  factory ProcessProxy.connectToService(
      bindings.ServiceConnector s, String url) {
    ProcessProxy p = new ProcessProxy.unbound();
    s.connectToService(url, p);
    return p;
  }

  static ProcessProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ProcessProxy"));
    return new ProcessProxy.fromEndpoint(endpoint);
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
    return "ProcessProxy($impl)";
  }
}


class ProcessStub extends bindings.Stub {
  Process _impl = null;

  ProcessStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  ProcessStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  ProcessStub.unbound() : super.unbound();

  static ProcessStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ProcessStub"));
    return new ProcessStub.fromEndpoint(endpoint);
  }

  static const String name = ProcessName;


  ProcessSpawnResponseParams _ProcessSpawnResponseParamsFactory(types_mojom.Error error) {
    var mojo_factory_result = new ProcessSpawnResponseParams();
    mojo_factory_result.error = error;
    return mojo_factory_result;
  }
  ProcessSpawnWithTerminalResponseParams _ProcessSpawnWithTerminalResponseParamsFactory(types_mojom.Error error) {
    var mojo_factory_result = new ProcessSpawnWithTerminalResponseParams();
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
      case kProcess_spawn_name:
        var params = ProcessSpawnParams.deserialize(
            message.payload);
        var response = _impl.spawn(params.path,params.argv,params.envp,params.stdinFile,params.stdoutFile,params.stderrFile,params.processController,_ProcessSpawnResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kProcess_spawn_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kProcess_spawn_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kProcess_spawnWithTerminal_name:
        var params = ProcessSpawnWithTerminalParams.deserialize(
            message.payload);
        var response = _impl.spawnWithTerminal(params.path,params.argv,params.envp,params.terminalFile,params.processController,_ProcessSpawnWithTerminalResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kProcess_spawnWithTerminal_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kProcess_spawnWithTerminal_name,
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

  Process get impl => _impl;
  set impl(Process d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "ProcessStub($superString)";
  }

  int get version => 0;
}

const int kProcessController_wait_name = 0;
const int kProcessController_kill_name = 1;

const String ProcessControllerName =
      'native_support::ProcessController';

abstract class ProcessController {
  dynamic wait([Function responseFactory = null]);
  dynamic kill(int signal,[Function responseFactory = null]);

}


class ProcessControllerProxyImpl extends bindings.Proxy {
  ProcessControllerProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  ProcessControllerProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  ProcessControllerProxyImpl.unbound() : super.unbound();

  static ProcessControllerProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ProcessControllerProxyImpl"));
    return new ProcessControllerProxyImpl.fromEndpoint(endpoint);
  }

  String get name => ProcessControllerName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case kProcessController_wait_name:
        var r = ProcessControllerWaitResponseParams.deserialize(
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
      case kProcessController_kill_name:
        var r = ProcessControllerKillResponseParams.deserialize(
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
    return "ProcessControllerProxyImpl($superString)";
  }
}


class _ProcessControllerProxyCalls implements ProcessController {
  ProcessControllerProxyImpl _proxyImpl;

  _ProcessControllerProxyCalls(this._proxyImpl);
    dynamic wait([Function responseFactory = null]) {
      var params = new ProcessControllerWaitParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kProcessController_wait_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic kill(int signal,[Function responseFactory = null]) {
      var params = new ProcessControllerKillParams();
      params.signal = signal;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kProcessController_kill_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class ProcessControllerProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  ProcessController ptr;
  final String name = ProcessControllerName;

  ProcessControllerProxy(ProcessControllerProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ProcessControllerProxyCalls(proxyImpl);

  ProcessControllerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new ProcessControllerProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ProcessControllerProxyCalls(impl);
  }

  ProcessControllerProxy.fromHandle(core.MojoHandle handle) :
      impl = new ProcessControllerProxyImpl.fromHandle(handle) {
    ptr = new _ProcessControllerProxyCalls(impl);
  }

  ProcessControllerProxy.unbound() :
      impl = new ProcessControllerProxyImpl.unbound() {
    ptr = new _ProcessControllerProxyCalls(impl);
  }

  factory ProcessControllerProxy.connectToService(
      bindings.ServiceConnector s, String url) {
    ProcessControllerProxy p = new ProcessControllerProxy.unbound();
    s.connectToService(url, p);
    return p;
  }

  static ProcessControllerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ProcessControllerProxy"));
    return new ProcessControllerProxy.fromEndpoint(endpoint);
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
    return "ProcessControllerProxy($impl)";
  }
}


class ProcessControllerStub extends bindings.Stub {
  ProcessController _impl = null;

  ProcessControllerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  ProcessControllerStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  ProcessControllerStub.unbound() : super.unbound();

  static ProcessControllerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ProcessControllerStub"));
    return new ProcessControllerStub.fromEndpoint(endpoint);
  }

  static const String name = ProcessControllerName;


  ProcessControllerWaitResponseParams _ProcessControllerWaitResponseParamsFactory(types_mojom.Error error, int exitStatus) {
    var mojo_factory_result = new ProcessControllerWaitResponseParams();
    mojo_factory_result.error = error;
    mojo_factory_result.exitStatus = exitStatus;
    return mojo_factory_result;
  }
  ProcessControllerKillResponseParams _ProcessControllerKillResponseParamsFactory(types_mojom.Error error) {
    var mojo_factory_result = new ProcessControllerKillResponseParams();
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
      case kProcessController_wait_name:
        var params = ProcessControllerWaitParams.deserialize(
            message.payload);
        var response = _impl.wait(_ProcessControllerWaitResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kProcessController_wait_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kProcessController_wait_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kProcessController_kill_name:
        var params = ProcessControllerKillParams.deserialize(
            message.payload);
        var response = _impl.kill(params.signal,_ProcessControllerKillResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kProcessController_kill_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kProcessController_kill_name,
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

  ProcessController get impl => _impl;
  set impl(ProcessController d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "ProcessControllerStub($superString)";
  }

  int get version => 0;
}


