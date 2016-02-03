// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library process_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/files/file.mojom.dart' as file_mojom;
import 'package:mojo_services/mojo/files/types.mojom.dart' as types_mojom;



class _ProcessSpawnParams extends bindings.Struct {
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

  _ProcessSpawnParams() : super(kVersions.last.size);

  static _ProcessSpawnParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ProcessSpawnParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ProcessSpawnParams result = new _ProcessSpawnParams();

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
    try {
      encoder0.encodeUint8Array(path, 8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "path of struct _ProcessSpawnParams: $e";
      rethrow;
    }
    try {
      if (argv == null) {
        encoder0.encodeNullPointer(16, true);
      } else {
        var encoder1 = encoder0.encodePointerArray(argv.length, 16, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < argv.length; ++i0) {
          encoder1.encodeUint8Array(argv[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "argv of struct _ProcessSpawnParams: $e";
      rethrow;
    }
    try {
      if (envp == null) {
        encoder0.encodeNullPointer(24, true);
      } else {
        var encoder1 = encoder0.encodePointerArray(envp.length, 24, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < envp.length; ++i0) {
          encoder1.encodeUint8Array(envp[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "envp of struct _ProcessSpawnParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterface(stdinFile, 32, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "stdinFile of struct _ProcessSpawnParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterface(stdoutFile, 40, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "stdoutFile of struct _ProcessSpawnParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterface(stderrFile, 48, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "stderrFile of struct _ProcessSpawnParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(processController, 56, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "processController of struct _ProcessSpawnParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ProcessSpawnParams("
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
    try {
      encoder0.encodeEnum(error, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct ProcessSpawnResponseParams: $e";
      rethrow;
    }
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




class _ProcessSpawnWithTerminalParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(48, 0)
  ];
  List<int> path = null;
  List<List<int>> argv = null;
  List<List<int>> envp = null;
  Object terminalFile = null;
  Object processController = null;

  _ProcessSpawnWithTerminalParams() : super(kVersions.last.size);

  static _ProcessSpawnWithTerminalParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ProcessSpawnWithTerminalParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ProcessSpawnWithTerminalParams result = new _ProcessSpawnWithTerminalParams();

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
    try {
      encoder0.encodeUint8Array(path, 8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "path of struct _ProcessSpawnWithTerminalParams: $e";
      rethrow;
    }
    try {
      if (argv == null) {
        encoder0.encodeNullPointer(16, true);
      } else {
        var encoder1 = encoder0.encodePointerArray(argv.length, 16, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < argv.length; ++i0) {
          encoder1.encodeUint8Array(argv[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "argv of struct _ProcessSpawnWithTerminalParams: $e";
      rethrow;
    }
    try {
      if (envp == null) {
        encoder0.encodeNullPointer(24, true);
      } else {
        var encoder1 = encoder0.encodePointerArray(envp.length, 24, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < envp.length; ++i0) {
          encoder1.encodeUint8Array(envp[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "envp of struct _ProcessSpawnWithTerminalParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterface(terminalFile, 32, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "terminalFile of struct _ProcessSpawnWithTerminalParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(processController, 40, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "processController of struct _ProcessSpawnWithTerminalParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ProcessSpawnWithTerminalParams("
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
    try {
      encoder0.encodeEnum(error, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct ProcessSpawnWithTerminalResponseParams: $e";
      rethrow;
    }
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




class _ProcessControllerWaitParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _ProcessControllerWaitParams() : super(kVersions.last.size);

  static _ProcessControllerWaitParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ProcessControllerWaitParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ProcessControllerWaitParams result = new _ProcessControllerWaitParams();

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
    return "_ProcessControllerWaitParams("")";
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
    try {
      encoder0.encodeEnum(error, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct ProcessControllerWaitResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(exitStatus, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "exitStatus of struct ProcessControllerWaitResponseParams: $e";
      rethrow;
    }
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




class _ProcessControllerKillParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int signal = 0;

  _ProcessControllerKillParams() : super(kVersions.last.size);

  static _ProcessControllerKillParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ProcessControllerKillParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ProcessControllerKillParams result = new _ProcessControllerKillParams();

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
    try {
      encoder0.encodeInt32(signal, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "signal of struct _ProcessControllerKillParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ProcessControllerKillParams("
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
    try {
      encoder0.encodeEnum(error, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct ProcessControllerKillResponseParams: $e";
      rethrow;
    }
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




const int _Process_spawnName = 0;
const int _Process_spawnWithTerminalName = 1;



class _ProcessServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class Process {
  static const String serviceName = "native_support::Process";
  dynamic spawn(List<int> path,List<List<int>> argv,List<List<int>> envp,Object stdinFile,Object stdoutFile,Object stderrFile,Object processController,[Function responseFactory = null]);
  dynamic spawnWithTerminal(List<int> path,List<List<int>> argv,List<List<int>> envp,Object terminalFile,Object processController,[Function responseFactory = null]);
}


class _ProcessProxyImpl extends bindings.Proxy {
  _ProcessProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ProcessProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _ProcessProxyImpl.unbound() : super.unbound();

  static _ProcessProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _ProcessProxyImpl"));
    return new _ProcessProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _ProcessServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _Process_spawnName:
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
      case _Process_spawnWithTerminalName:
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
    return "_ProcessProxyImpl($superString)";
  }
}


class _ProcessProxyCalls implements Process {
  _ProcessProxyImpl _proxyImpl;

  _ProcessProxyCalls(this._proxyImpl);
    dynamic spawn(List<int> path,List<List<int>> argv,List<List<int>> envp,Object stdinFile,Object stdoutFile,Object stderrFile,Object processController,[Function responseFactory = null]) {
      var params = new _ProcessSpawnParams();
      params.path = path;
      params.argv = argv;
      params.envp = envp;
      params.stdinFile = stdinFile;
      params.stdoutFile = stdoutFile;
      params.stderrFile = stderrFile;
      params.processController = processController;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _Process_spawnName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic spawnWithTerminal(List<int> path,List<List<int>> argv,List<List<int>> envp,Object terminalFile,Object processController,[Function responseFactory = null]) {
      var params = new _ProcessSpawnWithTerminalParams();
      params.path = path;
      params.argv = argv;
      params.envp = envp;
      params.terminalFile = terminalFile;
      params.processController = processController;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _Process_spawnWithTerminalName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class ProcessProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  Process ptr;

  ProcessProxy(_ProcessProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ProcessProxyCalls(proxyImpl);

  ProcessProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _ProcessProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ProcessProxyCalls(impl);
  }

  ProcessProxy.fromHandle(core.MojoHandle handle) :
      impl = new _ProcessProxyImpl.fromHandle(handle) {
    ptr = new _ProcessProxyCalls(impl);
  }

  ProcessProxy.unbound() :
      impl = new _ProcessProxyImpl.unbound() {
    ptr = new _ProcessProxyCalls(impl);
  }

  factory ProcessProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ProcessProxy p = new ProcessProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static ProcessProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ProcessProxy"));
    return new ProcessProxy.fromEndpoint(endpoint);
  }

  String get serviceName => Process.serviceName;

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
      case _Process_spawnName:
        var params = _ProcessSpawnParams.deserialize(
            message.payload);
        var response = _impl.spawn(params.path,params.argv,params.envp,params.stdinFile,params.stdoutFile,params.stderrFile,params.processController,_ProcessSpawnResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _Process_spawnName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _Process_spawnName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _Process_spawnWithTerminalName:
        var params = _ProcessSpawnWithTerminalParams.deserialize(
            message.payload);
        var response = _impl.spawnWithTerminal(params.path,params.argv,params.envp,params.terminalFile,params.processController,_ProcessSpawnWithTerminalResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _Process_spawnWithTerminalName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _Process_spawnWithTerminalName,
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

  service_describer.ServiceDescription get serviceDescription =>
    new _ProcessServiceDescription();
}

const int _ProcessController_waitName = 0;
const int _ProcessController_killName = 1;



class _ProcessControllerServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class ProcessController {
  static const String serviceName = null;
  dynamic wait([Function responseFactory = null]);
  dynamic kill(int signal,[Function responseFactory = null]);
}


class _ProcessControllerProxyImpl extends bindings.Proxy {
  _ProcessControllerProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ProcessControllerProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _ProcessControllerProxyImpl.unbound() : super.unbound();

  static _ProcessControllerProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _ProcessControllerProxyImpl"));
    return new _ProcessControllerProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _ProcessControllerServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _ProcessController_waitName:
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
      case _ProcessController_killName:
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
    return "_ProcessControllerProxyImpl($superString)";
  }
}


class _ProcessControllerProxyCalls implements ProcessController {
  _ProcessControllerProxyImpl _proxyImpl;

  _ProcessControllerProxyCalls(this._proxyImpl);
    dynamic wait([Function responseFactory = null]) {
      var params = new _ProcessControllerWaitParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _ProcessController_waitName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic kill(int signal,[Function responseFactory = null]) {
      var params = new _ProcessControllerKillParams();
      params.signal = signal;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _ProcessController_killName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class ProcessControllerProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  ProcessController ptr;

  ProcessControllerProxy(_ProcessControllerProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ProcessControllerProxyCalls(proxyImpl);

  ProcessControllerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _ProcessControllerProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ProcessControllerProxyCalls(impl);
  }

  ProcessControllerProxy.fromHandle(core.MojoHandle handle) :
      impl = new _ProcessControllerProxyImpl.fromHandle(handle) {
    ptr = new _ProcessControllerProxyCalls(impl);
  }

  ProcessControllerProxy.unbound() :
      impl = new _ProcessControllerProxyImpl.unbound() {
    ptr = new _ProcessControllerProxyCalls(impl);
  }

  factory ProcessControllerProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ProcessControllerProxy p = new ProcessControllerProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static ProcessControllerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ProcessControllerProxy"));
    return new ProcessControllerProxy.fromEndpoint(endpoint);
  }

  String get serviceName => ProcessController.serviceName;

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
      case _ProcessController_waitName:
        var params = _ProcessControllerWaitParams.deserialize(
            message.payload);
        var response = _impl.wait(_ProcessControllerWaitResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _ProcessController_waitName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _ProcessController_waitName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _ProcessController_killName:
        var params = _ProcessControllerKillParams.deserialize(
            message.payload);
        var response = _impl.kill(params.signal,_ProcessControllerKillResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _ProcessController_killName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _ProcessController_killName,
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

  service_describer.ServiceDescription get serviceDescription =>
    new _ProcessControllerServiceDescription();
}



