// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library command_buffer_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo_services/mojo/gpu_capabilities.mojom.dart' as gpu_capabilities_mojom;



class CommandBufferState extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(40, 0)
  ];
  int numEntries = 0;
  int getOffset = 0;
  int putOffset = 0;
  int token = 0;
  int error = 0;
  int contextLostReason = 0;
  int generation = 0;

  CommandBufferState() : super(kVersions.last.size);

  static CommandBufferState deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static CommandBufferState decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    CommandBufferState result = new CommandBufferState();

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
      
      result.numEntries = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.getOffset = decoder0.decodeInt32(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.putOffset = decoder0.decodeInt32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.token = decoder0.decodeInt32(20);
    }
    if (mainDataHeader.version >= 0) {
      
      result.error = decoder0.decodeInt32(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.contextLostReason = decoder0.decodeInt32(28);
    }
    if (mainDataHeader.version >= 0) {
      
      result.generation = decoder0.decodeUint32(32);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInt32(numEntries, 8);
    
    encoder0.encodeInt32(getOffset, 12);
    
    encoder0.encodeInt32(putOffset, 16);
    
    encoder0.encodeInt32(token, 20);
    
    encoder0.encodeInt32(error, 24);
    
    encoder0.encodeInt32(contextLostReason, 28);
    
    encoder0.encodeUint32(generation, 32);
  }

  String toString() {
    return "CommandBufferState("
           "numEntries: $numEntries" ", "
           "getOffset: $getOffset" ", "
           "putOffset: $putOffset" ", "
           "token: $token" ", "
           "error: $error" ", "
           "contextLostReason: $contextLostReason" ", "
           "generation: $generation" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["numEntries"] = numEntries;
    map["getOffset"] = getOffset;
    map["putOffset"] = putOffset;
    map["token"] = token;
    map["error"] = error;
    map["contextLostReason"] = contextLostReason;
    map["generation"] = generation;
    return map;
  }
}


class _CommandBufferSyncClientDidInitializeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  bool success = false;
  gpu_capabilities_mojom.GpuCapabilities capabilities = null;

  _CommandBufferSyncClientDidInitializeParams() : super(kVersions.last.size);

  static _CommandBufferSyncClientDidInitializeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CommandBufferSyncClientDidInitializeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CommandBufferSyncClientDidInitializeParams result = new _CommandBufferSyncClientDidInitializeParams();

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
      
      result.success = decoder0.decodeBool(8, 0);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.capabilities = gpu_capabilities_mojom.GpuCapabilities.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeBool(success, 8, 0);
    
    encoder0.encodeStruct(capabilities, 16, false);
  }

  String toString() {
    return "_CommandBufferSyncClientDidInitializeParams("
           "success: $success" ", "
           "capabilities: $capabilities" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["success"] = success;
    map["capabilities"] = capabilities;
    return map;
  }
}


class _CommandBufferSyncClientDidMakeProgressParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  CommandBufferState state = null;

  _CommandBufferSyncClientDidMakeProgressParams() : super(kVersions.last.size);

  static _CommandBufferSyncClientDidMakeProgressParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CommandBufferSyncClientDidMakeProgressParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CommandBufferSyncClientDidMakeProgressParams result = new _CommandBufferSyncClientDidMakeProgressParams();

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
      result.state = CommandBufferState.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(state, 8, false);
  }

  String toString() {
    return "_CommandBufferSyncClientDidMakeProgressParams("
           "state: $state" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["state"] = state;
    return map;
  }
}


class _CommandBufferSyncPointClientDidInsertSyncPointParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int syncPoint = 0;

  _CommandBufferSyncPointClientDidInsertSyncPointParams() : super(kVersions.last.size);

  static _CommandBufferSyncPointClientDidInsertSyncPointParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CommandBufferSyncPointClientDidInsertSyncPointParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CommandBufferSyncPointClientDidInsertSyncPointParams result = new _CommandBufferSyncPointClientDidInsertSyncPointParams();

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
      
      result.syncPoint = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(syncPoint, 8);
  }

  String toString() {
    return "_CommandBufferSyncPointClientDidInsertSyncPointParams("
           "syncPoint: $syncPoint" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["syncPoint"] = syncPoint;
    return map;
  }
}


class _CommandBufferLostContextObserverDidLoseContextParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int contextLostReason = 0;

  _CommandBufferLostContextObserverDidLoseContextParams() : super(kVersions.last.size);

  static _CommandBufferLostContextObserverDidLoseContextParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CommandBufferLostContextObserverDidLoseContextParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CommandBufferLostContextObserverDidLoseContextParams result = new _CommandBufferLostContextObserverDidLoseContextParams();

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
      
      result.contextLostReason = decoder0.decodeInt32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInt32(contextLostReason, 8);
  }

  String toString() {
    return "_CommandBufferLostContextObserverDidLoseContextParams("
           "contextLostReason: $contextLostReason" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["contextLostReason"] = contextLostReason;
    return map;
  }
}


class _CommandBufferInitializeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(40, 0)
  ];
  Object syncClient = null;
  Object syncPointClient = null;
  Object lostObserver = null;
  core.MojoSharedBuffer sharedState = null;

  _CommandBufferInitializeParams() : super(kVersions.last.size);

  static _CommandBufferInitializeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CommandBufferInitializeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CommandBufferInitializeParams result = new _CommandBufferInitializeParams();

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
      
      result.syncClient = decoder0.decodeServiceInterface(8, false, CommandBufferSyncClientProxy.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.syncPointClient = decoder0.decodeServiceInterface(16, false, CommandBufferSyncPointClientProxy.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.lostObserver = decoder0.decodeServiceInterface(24, false, CommandBufferLostContextObserverProxy.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.sharedState = decoder0.decodeSharedBufferHandle(32, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInterface(syncClient, 8, false);
    
    encoder0.encodeInterface(syncPointClient, 16, false);
    
    encoder0.encodeInterface(lostObserver, 24, false);
    
    encoder0.encodeSharedBufferHandle(sharedState, 32, false);
  }

  String toString() {
    return "_CommandBufferInitializeParams("
           "syncClient: $syncClient" ", "
           "syncPointClient: $syncPointClient" ", "
           "lostObserver: $lostObserver" ", "
           "sharedState: $sharedState" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _CommandBufferSetGetBufferParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int buffer = 0;

  _CommandBufferSetGetBufferParams() : super(kVersions.last.size);

  static _CommandBufferSetGetBufferParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CommandBufferSetGetBufferParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CommandBufferSetGetBufferParams result = new _CommandBufferSetGetBufferParams();

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
      
      result.buffer = decoder0.decodeInt32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInt32(buffer, 8);
  }

  String toString() {
    return "_CommandBufferSetGetBufferParams("
           "buffer: $buffer" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["buffer"] = buffer;
    return map;
  }
}


class _CommandBufferFlushParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int putOffset = 0;

  _CommandBufferFlushParams() : super(kVersions.last.size);

  static _CommandBufferFlushParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CommandBufferFlushParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CommandBufferFlushParams result = new _CommandBufferFlushParams();

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
      
      result.putOffset = decoder0.decodeInt32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInt32(putOffset, 8);
  }

  String toString() {
    return "_CommandBufferFlushParams("
           "putOffset: $putOffset" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["putOffset"] = putOffset;
    return map;
  }
}


class _CommandBufferMakeProgressParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int lastGetOffset = 0;

  _CommandBufferMakeProgressParams() : super(kVersions.last.size);

  static _CommandBufferMakeProgressParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CommandBufferMakeProgressParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CommandBufferMakeProgressParams result = new _CommandBufferMakeProgressParams();

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
      
      result.lastGetOffset = decoder0.decodeInt32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInt32(lastGetOffset, 8);
  }

  String toString() {
    return "_CommandBufferMakeProgressParams("
           "lastGetOffset: $lastGetOffset" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["lastGetOffset"] = lastGetOffset;
    return map;
  }
}


class _CommandBufferRegisterTransferBufferParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int id = 0;
  core.MojoSharedBuffer transferBuffer = null;
  int size = 0;

  _CommandBufferRegisterTransferBufferParams() : super(kVersions.last.size);

  static _CommandBufferRegisterTransferBufferParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CommandBufferRegisterTransferBufferParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CommandBufferRegisterTransferBufferParams result = new _CommandBufferRegisterTransferBufferParams();

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
      
      result.id = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.transferBuffer = decoder0.decodeSharedBufferHandle(12, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.size = decoder0.decodeUint32(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInt32(id, 8);
    
    encoder0.encodeSharedBufferHandle(transferBuffer, 12, false);
    
    encoder0.encodeUint32(size, 16);
  }

  String toString() {
    return "_CommandBufferRegisterTransferBufferParams("
           "id: $id" ", "
           "transferBuffer: $transferBuffer" ", "
           "size: $size" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _CommandBufferDestroyTransferBufferParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int id = 0;

  _CommandBufferDestroyTransferBufferParams() : super(kVersions.last.size);

  static _CommandBufferDestroyTransferBufferParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CommandBufferDestroyTransferBufferParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CommandBufferDestroyTransferBufferParams result = new _CommandBufferDestroyTransferBufferParams();

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
      
      result.id = decoder0.decodeInt32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInt32(id, 8);
  }

  String toString() {
    return "_CommandBufferDestroyTransferBufferParams("
           "id: $id" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["id"] = id;
    return map;
  }
}


class _CommandBufferInsertSyncPointParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool retire = false;

  _CommandBufferInsertSyncPointParams() : super(kVersions.last.size);

  static _CommandBufferInsertSyncPointParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CommandBufferInsertSyncPointParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CommandBufferInsertSyncPointParams result = new _CommandBufferInsertSyncPointParams();

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
      
      result.retire = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeBool(retire, 8, 0);
  }

  String toString() {
    return "_CommandBufferInsertSyncPointParams("
           "retire: $retire" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["retire"] = retire;
    return map;
  }
}


class _CommandBufferRetireSyncPointParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int syncPoint = 0;

  _CommandBufferRetireSyncPointParams() : super(kVersions.last.size);

  static _CommandBufferRetireSyncPointParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CommandBufferRetireSyncPointParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CommandBufferRetireSyncPointParams result = new _CommandBufferRetireSyncPointParams();

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
      
      result.syncPoint = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(syncPoint, 8);
  }

  String toString() {
    return "_CommandBufferRetireSyncPointParams("
           "syncPoint: $syncPoint" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["syncPoint"] = syncPoint;
    return map;
  }
}


class _CommandBufferEchoParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _CommandBufferEchoParams() : super(kVersions.last.size);

  static _CommandBufferEchoParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CommandBufferEchoParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CommandBufferEchoParams result = new _CommandBufferEchoParams();

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
    return "_CommandBufferEchoParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class CommandBufferEchoResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  CommandBufferEchoResponseParams() : super(kVersions.last.size);

  static CommandBufferEchoResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static CommandBufferEchoResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    CommandBufferEchoResponseParams result = new CommandBufferEchoResponseParams();

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
    return "CommandBufferEchoResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

const int _CommandBufferSyncClient_didInitializeName = 0;
const int _CommandBufferSyncClient_didMakeProgressName = 1;

abstract class CommandBufferSyncClient {
  static const String serviceName = null;
  void didInitialize(bool success, gpu_capabilities_mojom.GpuCapabilities capabilities);
  void didMakeProgress(CommandBufferState state);
}


class _CommandBufferSyncClientProxyImpl extends bindings.Proxy {
  _CommandBufferSyncClientProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _CommandBufferSyncClientProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _CommandBufferSyncClientProxyImpl.unbound() : super.unbound();

  static _CommandBufferSyncClientProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _CommandBufferSyncClientProxyImpl"));
    return new _CommandBufferSyncClientProxyImpl.fromEndpoint(endpoint);
  }

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  String toString() {
    var superString = super.toString();
    return "_CommandBufferSyncClientProxyImpl($superString)";
  }
}


class _CommandBufferSyncClientProxyCalls implements CommandBufferSyncClient {
  _CommandBufferSyncClientProxyImpl _proxyImpl;

  _CommandBufferSyncClientProxyCalls(this._proxyImpl);
    void didInitialize(bool success, gpu_capabilities_mojom.GpuCapabilities capabilities) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _CommandBufferSyncClientDidInitializeParams();
      params.success = success;
      params.capabilities = capabilities;
      _proxyImpl.sendMessage(params, _CommandBufferSyncClient_didInitializeName);
    }
    void didMakeProgress(CommandBufferState state) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _CommandBufferSyncClientDidMakeProgressParams();
      params.state = state;
      _proxyImpl.sendMessage(params, _CommandBufferSyncClient_didMakeProgressName);
    }
}


class CommandBufferSyncClientProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  CommandBufferSyncClient ptr;

  CommandBufferSyncClientProxy(_CommandBufferSyncClientProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _CommandBufferSyncClientProxyCalls(proxyImpl);

  CommandBufferSyncClientProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _CommandBufferSyncClientProxyImpl.fromEndpoint(endpoint) {
    ptr = new _CommandBufferSyncClientProxyCalls(impl);
  }

  CommandBufferSyncClientProxy.fromHandle(core.MojoHandle handle) :
      impl = new _CommandBufferSyncClientProxyImpl.fromHandle(handle) {
    ptr = new _CommandBufferSyncClientProxyCalls(impl);
  }

  CommandBufferSyncClientProxy.unbound() :
      impl = new _CommandBufferSyncClientProxyImpl.unbound() {
    ptr = new _CommandBufferSyncClientProxyCalls(impl);
  }

  factory CommandBufferSyncClientProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    CommandBufferSyncClientProxy p = new CommandBufferSyncClientProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static CommandBufferSyncClientProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CommandBufferSyncClientProxy"));
    return new CommandBufferSyncClientProxy.fromEndpoint(endpoint);
  }

  String get serviceName => CommandBufferSyncClient.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "CommandBufferSyncClientProxy($impl)";
  }
}


class CommandBufferSyncClientStub extends bindings.Stub {
  CommandBufferSyncClient _impl = null;

  CommandBufferSyncClientStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  CommandBufferSyncClientStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  CommandBufferSyncClientStub.unbound() : super.unbound();

  static CommandBufferSyncClientStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CommandBufferSyncClientStub"));
    return new CommandBufferSyncClientStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _CommandBufferSyncClient_didInitializeName:
        var params = _CommandBufferSyncClientDidInitializeParams.deserialize(
            message.payload);
        _impl.didInitialize(params.success, params.capabilities);
        break;
      case _CommandBufferSyncClient_didMakeProgressName:
        var params = _CommandBufferSyncClientDidMakeProgressParams.deserialize(
            message.payload);
        _impl.didMakeProgress(params.state);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  CommandBufferSyncClient get impl => _impl;
  set impl(CommandBufferSyncClient d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "CommandBufferSyncClientStub($superString)";
  }

  int get version => 0;
}

const int _CommandBufferSyncPointClient_didInsertSyncPointName = 0;

abstract class CommandBufferSyncPointClient {
  static const String serviceName = null;
  void didInsertSyncPoint(int syncPoint);
}


class _CommandBufferSyncPointClientProxyImpl extends bindings.Proxy {
  _CommandBufferSyncPointClientProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _CommandBufferSyncPointClientProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _CommandBufferSyncPointClientProxyImpl.unbound() : super.unbound();

  static _CommandBufferSyncPointClientProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _CommandBufferSyncPointClientProxyImpl"));
    return new _CommandBufferSyncPointClientProxyImpl.fromEndpoint(endpoint);
  }

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  String toString() {
    var superString = super.toString();
    return "_CommandBufferSyncPointClientProxyImpl($superString)";
  }
}


class _CommandBufferSyncPointClientProxyCalls implements CommandBufferSyncPointClient {
  _CommandBufferSyncPointClientProxyImpl _proxyImpl;

  _CommandBufferSyncPointClientProxyCalls(this._proxyImpl);
    void didInsertSyncPoint(int syncPoint) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _CommandBufferSyncPointClientDidInsertSyncPointParams();
      params.syncPoint = syncPoint;
      _proxyImpl.sendMessage(params, _CommandBufferSyncPointClient_didInsertSyncPointName);
    }
}


class CommandBufferSyncPointClientProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  CommandBufferSyncPointClient ptr;

  CommandBufferSyncPointClientProxy(_CommandBufferSyncPointClientProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _CommandBufferSyncPointClientProxyCalls(proxyImpl);

  CommandBufferSyncPointClientProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _CommandBufferSyncPointClientProxyImpl.fromEndpoint(endpoint) {
    ptr = new _CommandBufferSyncPointClientProxyCalls(impl);
  }

  CommandBufferSyncPointClientProxy.fromHandle(core.MojoHandle handle) :
      impl = new _CommandBufferSyncPointClientProxyImpl.fromHandle(handle) {
    ptr = new _CommandBufferSyncPointClientProxyCalls(impl);
  }

  CommandBufferSyncPointClientProxy.unbound() :
      impl = new _CommandBufferSyncPointClientProxyImpl.unbound() {
    ptr = new _CommandBufferSyncPointClientProxyCalls(impl);
  }

  factory CommandBufferSyncPointClientProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    CommandBufferSyncPointClientProxy p = new CommandBufferSyncPointClientProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static CommandBufferSyncPointClientProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CommandBufferSyncPointClientProxy"));
    return new CommandBufferSyncPointClientProxy.fromEndpoint(endpoint);
  }

  String get serviceName => CommandBufferSyncPointClient.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "CommandBufferSyncPointClientProxy($impl)";
  }
}


class CommandBufferSyncPointClientStub extends bindings.Stub {
  CommandBufferSyncPointClient _impl = null;

  CommandBufferSyncPointClientStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  CommandBufferSyncPointClientStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  CommandBufferSyncPointClientStub.unbound() : super.unbound();

  static CommandBufferSyncPointClientStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CommandBufferSyncPointClientStub"));
    return new CommandBufferSyncPointClientStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _CommandBufferSyncPointClient_didInsertSyncPointName:
        var params = _CommandBufferSyncPointClientDidInsertSyncPointParams.deserialize(
            message.payload);
        _impl.didInsertSyncPoint(params.syncPoint);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  CommandBufferSyncPointClient get impl => _impl;
  set impl(CommandBufferSyncPointClient d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "CommandBufferSyncPointClientStub($superString)";
  }

  int get version => 0;
}

const int _CommandBufferLostContextObserver_didLoseContextName = 0;

abstract class CommandBufferLostContextObserver {
  static const String serviceName = null;
  void didLoseContext(int contextLostReason);
}


class _CommandBufferLostContextObserverProxyImpl extends bindings.Proxy {
  _CommandBufferLostContextObserverProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _CommandBufferLostContextObserverProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _CommandBufferLostContextObserverProxyImpl.unbound() : super.unbound();

  static _CommandBufferLostContextObserverProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _CommandBufferLostContextObserverProxyImpl"));
    return new _CommandBufferLostContextObserverProxyImpl.fromEndpoint(endpoint);
  }

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  String toString() {
    var superString = super.toString();
    return "_CommandBufferLostContextObserverProxyImpl($superString)";
  }
}


class _CommandBufferLostContextObserverProxyCalls implements CommandBufferLostContextObserver {
  _CommandBufferLostContextObserverProxyImpl _proxyImpl;

  _CommandBufferLostContextObserverProxyCalls(this._proxyImpl);
    void didLoseContext(int contextLostReason) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _CommandBufferLostContextObserverDidLoseContextParams();
      params.contextLostReason = contextLostReason;
      _proxyImpl.sendMessage(params, _CommandBufferLostContextObserver_didLoseContextName);
    }
}


class CommandBufferLostContextObserverProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  CommandBufferLostContextObserver ptr;

  CommandBufferLostContextObserverProxy(_CommandBufferLostContextObserverProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _CommandBufferLostContextObserverProxyCalls(proxyImpl);

  CommandBufferLostContextObserverProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _CommandBufferLostContextObserverProxyImpl.fromEndpoint(endpoint) {
    ptr = new _CommandBufferLostContextObserverProxyCalls(impl);
  }

  CommandBufferLostContextObserverProxy.fromHandle(core.MojoHandle handle) :
      impl = new _CommandBufferLostContextObserverProxyImpl.fromHandle(handle) {
    ptr = new _CommandBufferLostContextObserverProxyCalls(impl);
  }

  CommandBufferLostContextObserverProxy.unbound() :
      impl = new _CommandBufferLostContextObserverProxyImpl.unbound() {
    ptr = new _CommandBufferLostContextObserverProxyCalls(impl);
  }

  factory CommandBufferLostContextObserverProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    CommandBufferLostContextObserverProxy p = new CommandBufferLostContextObserverProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static CommandBufferLostContextObserverProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CommandBufferLostContextObserverProxy"));
    return new CommandBufferLostContextObserverProxy.fromEndpoint(endpoint);
  }

  String get serviceName => CommandBufferLostContextObserver.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "CommandBufferLostContextObserverProxy($impl)";
  }
}


class CommandBufferLostContextObserverStub extends bindings.Stub {
  CommandBufferLostContextObserver _impl = null;

  CommandBufferLostContextObserverStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  CommandBufferLostContextObserverStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  CommandBufferLostContextObserverStub.unbound() : super.unbound();

  static CommandBufferLostContextObserverStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CommandBufferLostContextObserverStub"));
    return new CommandBufferLostContextObserverStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _CommandBufferLostContextObserver_didLoseContextName:
        var params = _CommandBufferLostContextObserverDidLoseContextParams.deserialize(
            message.payload);
        _impl.didLoseContext(params.contextLostReason);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  CommandBufferLostContextObserver get impl => _impl;
  set impl(CommandBufferLostContextObserver d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "CommandBufferLostContextObserverStub($superString)";
  }

  int get version => 0;
}

const int _CommandBuffer_initializeName = 0;
const int _CommandBuffer_setGetBufferName = 1;
const int _CommandBuffer_flushName = 2;
const int _CommandBuffer_makeProgressName = 3;
const int _CommandBuffer_registerTransferBufferName = 4;
const int _CommandBuffer_destroyTransferBufferName = 5;
const int _CommandBuffer_insertSyncPointName = 6;
const int _CommandBuffer_retireSyncPointName = 7;
const int _CommandBuffer_echoName = 8;

abstract class CommandBuffer {
  static const String serviceName = null;
  void initialize(Object syncClient, Object syncPointClient, Object lostObserver, core.MojoSharedBuffer sharedState);
  void setGetBuffer(int buffer);
  void flush(int putOffset);
  void makeProgress(int lastGetOffset);
  void registerTransferBuffer(int id, core.MojoSharedBuffer transferBuffer, int size);
  void destroyTransferBuffer(int id);
  void insertSyncPoint(bool retire);
  void retireSyncPoint(int syncPoint);
  dynamic echo([Function responseFactory = null]);
}


class _CommandBufferProxyImpl extends bindings.Proxy {
  _CommandBufferProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _CommandBufferProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _CommandBufferProxyImpl.unbound() : super.unbound();

  static _CommandBufferProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _CommandBufferProxyImpl"));
    return new _CommandBufferProxyImpl.fromEndpoint(endpoint);
  }

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _CommandBuffer_echoName:
        var r = CommandBufferEchoResponseParams.deserialize(
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
    return "_CommandBufferProxyImpl($superString)";
  }
}


class _CommandBufferProxyCalls implements CommandBuffer {
  _CommandBufferProxyImpl _proxyImpl;

  _CommandBufferProxyCalls(this._proxyImpl);
    void initialize(Object syncClient, Object syncPointClient, Object lostObserver, core.MojoSharedBuffer sharedState) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _CommandBufferInitializeParams();
      params.syncClient = syncClient;
      params.syncPointClient = syncPointClient;
      params.lostObserver = lostObserver;
      params.sharedState = sharedState;
      _proxyImpl.sendMessage(params, _CommandBuffer_initializeName);
    }
    void setGetBuffer(int buffer) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _CommandBufferSetGetBufferParams();
      params.buffer = buffer;
      _proxyImpl.sendMessage(params, _CommandBuffer_setGetBufferName);
    }
    void flush(int putOffset) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _CommandBufferFlushParams();
      params.putOffset = putOffset;
      _proxyImpl.sendMessage(params, _CommandBuffer_flushName);
    }
    void makeProgress(int lastGetOffset) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _CommandBufferMakeProgressParams();
      params.lastGetOffset = lastGetOffset;
      _proxyImpl.sendMessage(params, _CommandBuffer_makeProgressName);
    }
    void registerTransferBuffer(int id, core.MojoSharedBuffer transferBuffer, int size) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _CommandBufferRegisterTransferBufferParams();
      params.id = id;
      params.transferBuffer = transferBuffer;
      params.size = size;
      _proxyImpl.sendMessage(params, _CommandBuffer_registerTransferBufferName);
    }
    void destroyTransferBuffer(int id) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _CommandBufferDestroyTransferBufferParams();
      params.id = id;
      _proxyImpl.sendMessage(params, _CommandBuffer_destroyTransferBufferName);
    }
    void insertSyncPoint(bool retire) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _CommandBufferInsertSyncPointParams();
      params.retire = retire;
      _proxyImpl.sendMessage(params, _CommandBuffer_insertSyncPointName);
    }
    void retireSyncPoint(int syncPoint) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _CommandBufferRetireSyncPointParams();
      params.syncPoint = syncPoint;
      _proxyImpl.sendMessage(params, _CommandBuffer_retireSyncPointName);
    }
    dynamic echo([Function responseFactory = null]) {
      var params = new _CommandBufferEchoParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _CommandBuffer_echoName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class CommandBufferProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  CommandBuffer ptr;

  CommandBufferProxy(_CommandBufferProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _CommandBufferProxyCalls(proxyImpl);

  CommandBufferProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _CommandBufferProxyImpl.fromEndpoint(endpoint) {
    ptr = new _CommandBufferProxyCalls(impl);
  }

  CommandBufferProxy.fromHandle(core.MojoHandle handle) :
      impl = new _CommandBufferProxyImpl.fromHandle(handle) {
    ptr = new _CommandBufferProxyCalls(impl);
  }

  CommandBufferProxy.unbound() :
      impl = new _CommandBufferProxyImpl.unbound() {
    ptr = new _CommandBufferProxyCalls(impl);
  }

  factory CommandBufferProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    CommandBufferProxy p = new CommandBufferProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static CommandBufferProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CommandBufferProxy"));
    return new CommandBufferProxy.fromEndpoint(endpoint);
  }

  String get serviceName => CommandBuffer.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "CommandBufferProxy($impl)";
  }
}


class CommandBufferStub extends bindings.Stub {
  CommandBuffer _impl = null;

  CommandBufferStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  CommandBufferStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  CommandBufferStub.unbound() : super.unbound();

  static CommandBufferStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CommandBufferStub"));
    return new CommandBufferStub.fromEndpoint(endpoint);
  }


  CommandBufferEchoResponseParams _CommandBufferEchoResponseParamsFactory() {
    var mojo_factory_result = new CommandBufferEchoResponseParams();
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
      case _CommandBuffer_initializeName:
        var params = _CommandBufferInitializeParams.deserialize(
            message.payload);
        _impl.initialize(params.syncClient, params.syncPointClient, params.lostObserver, params.sharedState);
        break;
      case _CommandBuffer_setGetBufferName:
        var params = _CommandBufferSetGetBufferParams.deserialize(
            message.payload);
        _impl.setGetBuffer(params.buffer);
        break;
      case _CommandBuffer_flushName:
        var params = _CommandBufferFlushParams.deserialize(
            message.payload);
        _impl.flush(params.putOffset);
        break;
      case _CommandBuffer_makeProgressName:
        var params = _CommandBufferMakeProgressParams.deserialize(
            message.payload);
        _impl.makeProgress(params.lastGetOffset);
        break;
      case _CommandBuffer_registerTransferBufferName:
        var params = _CommandBufferRegisterTransferBufferParams.deserialize(
            message.payload);
        _impl.registerTransferBuffer(params.id, params.transferBuffer, params.size);
        break;
      case _CommandBuffer_destroyTransferBufferName:
        var params = _CommandBufferDestroyTransferBufferParams.deserialize(
            message.payload);
        _impl.destroyTransferBuffer(params.id);
        break;
      case _CommandBuffer_insertSyncPointName:
        var params = _CommandBufferInsertSyncPointParams.deserialize(
            message.payload);
        _impl.insertSyncPoint(params.retire);
        break;
      case _CommandBuffer_retireSyncPointName:
        var params = _CommandBufferRetireSyncPointParams.deserialize(
            message.payload);
        _impl.retireSyncPoint(params.syncPoint);
        break;
      case _CommandBuffer_echoName:
        var params = _CommandBufferEchoParams.deserialize(
            message.payload);
        var response = _impl.echo(_CommandBufferEchoResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _CommandBuffer_echoName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _CommandBuffer_echoName,
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

  CommandBuffer get impl => _impl;
  set impl(CommandBuffer d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "CommandBufferStub($superString)";
  }

  int get version => 0;
}


