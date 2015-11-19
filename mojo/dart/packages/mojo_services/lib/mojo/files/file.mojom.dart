// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library file_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo_services/mojo/files/types.mojom.dart' as types_mojom;



class FileCloseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  FileCloseParams() : super(kVersions.last.size);

  static FileCloseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileCloseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileCloseParams result = new FileCloseParams();

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
    return "FileCloseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class FileCloseResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error err = null;

  FileCloseResponseParams() : super(kVersions.last.size);

  static FileCloseResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileCloseResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileCloseResponseParams result = new FileCloseResponseParams();

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
      
        result.err = types_mojom.Error.decode(decoder0, 8);
        if (result.err == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable types_mojom.Error.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(err, 8);
  }

  String toString() {
    return "FileCloseResponseParams("
           "err: $err" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["err"] = err;
    return map;
  }
}


class FileReadParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int numBytesToRead = 0;
  types_mojom.Whence whence = null;
  int offset = 0;

  FileReadParams() : super(kVersions.last.size);

  static FileReadParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileReadParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileReadParams result = new FileReadParams();

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
      
      result.numBytesToRead = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
        result.whence = types_mojom.Whence.decode(decoder0, 12);
        if (result.whence == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable types_mojom.Whence.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.offset = decoder0.decodeInt64(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(numBytesToRead, 8);
    
    encoder0.encodeEnum(whence, 12);
    
    encoder0.encodeInt64(offset, 16);
  }

  String toString() {
    return "FileReadParams("
           "numBytesToRead: $numBytesToRead" ", "
           "whence: $whence" ", "
           "offset: $offset" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["numBytesToRead"] = numBytesToRead;
    map["whence"] = whence;
    map["offset"] = offset;
    return map;
  }
}


class FileReadResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  types_mojom.Error error = null;
  List<int> bytesRead = null;

  FileReadResponseParams() : super(kVersions.last.size);

  static FileReadResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileReadResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileReadResponseParams result = new FileReadResponseParams();

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
      
      result.bytesRead = decoder0.decodeUint8Array(16, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(error, 8);
    
    encoder0.encodeUint8Array(bytesRead, 16, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
  }

  String toString() {
    return "FileReadResponseParams("
           "error: $error" ", "
           "bytesRead: $bytesRead" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    map["bytesRead"] = bytesRead;
    return map;
  }
}


class FileWriteParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  List<int> bytesToWrite = null;
  int offset = 0;
  types_mojom.Whence whence = null;

  FileWriteParams() : super(kVersions.last.size);

  static FileWriteParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileWriteParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileWriteParams result = new FileWriteParams();

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
      
      result.bytesToWrite = decoder0.decodeUint8Array(8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 0) {
      
      result.offset = decoder0.decodeInt64(16);
    }
    if (mainDataHeader.version >= 0) {
      
        result.whence = types_mojom.Whence.decode(decoder0, 24);
        if (result.whence == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable types_mojom.Whence.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint8Array(bytesToWrite, 8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    
    encoder0.encodeInt64(offset, 16);
    
    encoder0.encodeEnum(whence, 24);
  }

  String toString() {
    return "FileWriteParams("
           "bytesToWrite: $bytesToWrite" ", "
           "offset: $offset" ", "
           "whence: $whence" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["bytesToWrite"] = bytesToWrite;
    map["offset"] = offset;
    map["whence"] = whence;
    return map;
  }
}


class FileWriteResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error error = null;
  int numBytesWritten = 0;

  FileWriteResponseParams() : super(kVersions.last.size);

  static FileWriteResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileWriteResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileWriteResponseParams result = new FileWriteResponseParams();

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
      
      result.numBytesWritten = decoder0.decodeUint32(12);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(error, 8);
    
    encoder0.encodeUint32(numBytesWritten, 12);
  }

  String toString() {
    return "FileWriteResponseParams("
           "error: $error" ", "
           "numBytesWritten: $numBytesWritten" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    map["numBytesWritten"] = numBytesWritten;
    return map;
  }
}


class FileReadToStreamParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  core.MojoDataPipeProducer source = null;
  types_mojom.Whence whence = null;
  int offset = 0;
  int numBytesToRead = 0;

  FileReadToStreamParams() : super(kVersions.last.size);

  static FileReadToStreamParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileReadToStreamParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileReadToStreamParams result = new FileReadToStreamParams();

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
      
      result.source = decoder0.decodeProducerHandle(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
        result.whence = types_mojom.Whence.decode(decoder0, 12);
        if (result.whence == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable types_mojom.Whence.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.offset = decoder0.decodeInt64(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.numBytesToRead = decoder0.decodeInt64(24);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeProducerHandle(source, 8, false);
    
    encoder0.encodeEnum(whence, 12);
    
    encoder0.encodeInt64(offset, 16);
    
    encoder0.encodeInt64(numBytesToRead, 24);
  }

  String toString() {
    return "FileReadToStreamParams("
           "source: $source" ", "
           "whence: $whence" ", "
           "offset: $offset" ", "
           "numBytesToRead: $numBytesToRead" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class FileReadToStreamResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error error = null;

  FileReadToStreamResponseParams() : super(kVersions.last.size);

  static FileReadToStreamResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileReadToStreamResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileReadToStreamResponseParams result = new FileReadToStreamResponseParams();

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
    return "FileReadToStreamResponseParams("
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    return map;
  }
}


class FileWriteFromStreamParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  core.MojoDataPipeConsumer sink = null;
  types_mojom.Whence whence = null;
  int offset = 0;

  FileWriteFromStreamParams() : super(kVersions.last.size);

  static FileWriteFromStreamParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileWriteFromStreamParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileWriteFromStreamParams result = new FileWriteFromStreamParams();

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
      
      result.sink = decoder0.decodeConsumerHandle(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
        result.whence = types_mojom.Whence.decode(decoder0, 12);
        if (result.whence == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable types_mojom.Whence.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.offset = decoder0.decodeInt64(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeConsumerHandle(sink, 8, false);
    
    encoder0.encodeEnum(whence, 12);
    
    encoder0.encodeInt64(offset, 16);
  }

  String toString() {
    return "FileWriteFromStreamParams("
           "sink: $sink" ", "
           "whence: $whence" ", "
           "offset: $offset" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class FileWriteFromStreamResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error error = null;

  FileWriteFromStreamResponseParams() : super(kVersions.last.size);

  static FileWriteFromStreamResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileWriteFromStreamResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileWriteFromStreamResponseParams result = new FileWriteFromStreamResponseParams();

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
    return "FileWriteFromStreamResponseParams("
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    return map;
  }
}


class FileTellParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  FileTellParams() : super(kVersions.last.size);

  static FileTellParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileTellParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileTellParams result = new FileTellParams();

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
    return "FileTellParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class FileTellResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  types_mojom.Error error = null;
  int position = 0;

  FileTellResponseParams() : super(kVersions.last.size);

  static FileTellResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileTellResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileTellResponseParams result = new FileTellResponseParams();

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
      
      result.position = decoder0.decodeInt64(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(error, 8);
    
    encoder0.encodeInt64(position, 16);
  }

  String toString() {
    return "FileTellResponseParams("
           "error: $error" ", "
           "position: $position" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    map["position"] = position;
    return map;
  }
}


class FileSeekParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int offset = 0;
  types_mojom.Whence whence = null;

  FileSeekParams() : super(kVersions.last.size);

  static FileSeekParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileSeekParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileSeekParams result = new FileSeekParams();

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
      
      result.offset = decoder0.decodeInt64(8);
    }
    if (mainDataHeader.version >= 0) {
      
        result.whence = types_mojom.Whence.decode(decoder0, 16);
        if (result.whence == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable types_mojom.Whence.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInt64(offset, 8);
    
    encoder0.encodeEnum(whence, 16);
  }

  String toString() {
    return "FileSeekParams("
           "offset: $offset" ", "
           "whence: $whence" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["offset"] = offset;
    map["whence"] = whence;
    return map;
  }
}


class FileSeekResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  types_mojom.Error error = null;
  int position = 0;

  FileSeekResponseParams() : super(kVersions.last.size);

  static FileSeekResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileSeekResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileSeekResponseParams result = new FileSeekResponseParams();

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
      
      result.position = decoder0.decodeInt64(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(error, 8);
    
    encoder0.encodeInt64(position, 16);
  }

  String toString() {
    return "FileSeekResponseParams("
           "error: $error" ", "
           "position: $position" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    map["position"] = position;
    return map;
  }
}


class FileStatParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  FileStatParams() : super(kVersions.last.size);

  static FileStatParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileStatParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileStatParams result = new FileStatParams();

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
    return "FileStatParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class FileStatResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  types_mojom.Error error = null;
  types_mojom.FileInformation fileInformation = null;

  FileStatResponseParams() : super(kVersions.last.size);

  static FileStatResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileStatResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileStatResponseParams result = new FileStatResponseParams();

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
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.fileInformation = types_mojom.FileInformation.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(error, 8);
    
    encoder0.encodeStruct(fileInformation, 16, true);
  }

  String toString() {
    return "FileStatResponseParams("
           "error: $error" ", "
           "fileInformation: $fileInformation" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    map["fileInformation"] = fileInformation;
    return map;
  }
}


class FileTruncateParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int size = 0;

  FileTruncateParams() : super(kVersions.last.size);

  static FileTruncateParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileTruncateParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileTruncateParams result = new FileTruncateParams();

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
      
      result.size = decoder0.decodeInt64(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInt64(size, 8);
  }

  String toString() {
    return "FileTruncateParams("
           "size: $size" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["size"] = size;
    return map;
  }
}


class FileTruncateResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error error = null;

  FileTruncateResponseParams() : super(kVersions.last.size);

  static FileTruncateResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileTruncateResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileTruncateResponseParams result = new FileTruncateResponseParams();

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
    return "FileTruncateResponseParams("
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    return map;
  }
}


class FileTouchParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  types_mojom.TimespecOrNow atime = null;
  types_mojom.TimespecOrNow mtime = null;

  FileTouchParams() : super(kVersions.last.size);

  static FileTouchParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileTouchParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileTouchParams result = new FileTouchParams();

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
      result.atime = types_mojom.TimespecOrNow.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.mtime = types_mojom.TimespecOrNow.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(atime, 8, true);
    
    encoder0.encodeStruct(mtime, 16, true);
  }

  String toString() {
    return "FileTouchParams("
           "atime: $atime" ", "
           "mtime: $mtime" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["atime"] = atime;
    map["mtime"] = mtime;
    return map;
  }
}


class FileTouchResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error error = null;

  FileTouchResponseParams() : super(kVersions.last.size);

  static FileTouchResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileTouchResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileTouchResponseParams result = new FileTouchResponseParams();

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
    return "FileTouchResponseParams("
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    return map;
  }
}


class FileDupParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object file = null;

  FileDupParams() : super(kVersions.last.size);

  static FileDupParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileDupParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileDupParams result = new FileDupParams();

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
      
      result.file = decoder0.decodeInterfaceRequest(8, false, FileStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInterfaceRequest(file, 8, false);
  }

  String toString() {
    return "FileDupParams("
           "file: $file" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class FileDupResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error error = null;

  FileDupResponseParams() : super(kVersions.last.size);

  static FileDupResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileDupResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileDupResponseParams result = new FileDupResponseParams();

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
    return "FileDupResponseParams("
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    return map;
  }
}


class FileReopenParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object file = null;
  int openFlags = 0;

  FileReopenParams() : super(kVersions.last.size);

  static FileReopenParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileReopenParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileReopenParams result = new FileReopenParams();

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
      
      result.file = decoder0.decodeInterfaceRequest(8, false, FileStub.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.openFlags = decoder0.decodeUint32(12);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInterfaceRequest(file, 8, false);
    
    encoder0.encodeUint32(openFlags, 12);
  }

  String toString() {
    return "FileReopenParams("
           "file: $file" ", "
           "openFlags: $openFlags" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class FileReopenResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error error = null;

  FileReopenResponseParams() : super(kVersions.last.size);

  static FileReopenResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileReopenResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileReopenResponseParams result = new FileReopenResponseParams();

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
    return "FileReopenResponseParams("
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    return map;
  }
}


class FileAsBufferParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  FileAsBufferParams() : super(kVersions.last.size);

  static FileAsBufferParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileAsBufferParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileAsBufferParams result = new FileAsBufferParams();

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
    return "FileAsBufferParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class FileAsBufferResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error error = null;
  core.MojoSharedBuffer buffer = null;

  FileAsBufferResponseParams() : super(kVersions.last.size);

  static FileAsBufferResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileAsBufferResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileAsBufferResponseParams result = new FileAsBufferResponseParams();

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
      
      result.buffer = decoder0.decodeSharedBufferHandle(12, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(error, 8);
    
    encoder0.encodeSharedBufferHandle(buffer, 12, true);
  }

  String toString() {
    return "FileAsBufferResponseParams("
           "error: $error" ", "
           "buffer: $buffer" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class FileIoctlParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int request = 0;
  List<int> inValues = null;

  FileIoctlParams() : super(kVersions.last.size);

  static FileIoctlParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileIoctlParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileIoctlParams result = new FileIoctlParams();

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
      
      result.request = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.inValues = decoder0.decodeUint32Array(16, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(request, 8);
    
    encoder0.encodeUint32Array(inValues, 16, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
  }

  String toString() {
    return "FileIoctlParams("
           "request: $request" ", "
           "inValues: $inValues" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["request"] = request;
    map["inValues"] = inValues;
    return map;
  }
}


class FileIoctlResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  types_mojom.Error error = null;
  List<int> outValues = null;

  FileIoctlResponseParams() : super(kVersions.last.size);

  static FileIoctlResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileIoctlResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileIoctlResponseParams result = new FileIoctlResponseParams();

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
      
      result.outValues = decoder0.decodeUint32Array(16, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(error, 8);
    
    encoder0.encodeUint32Array(outValues, 16, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
  }

  String toString() {
    return "FileIoctlResponseParams("
           "error: $error" ", "
           "outValues: $outValues" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    map["outValues"] = outValues;
    return map;
  }
}

const int kFile_close_name = 0;
const int kFile_read_name = 1;
const int kFile_write_name = 2;
const int kFile_readToStream_name = 3;
const int kFile_writeFromStream_name = 4;
const int kFile_tell_name = 5;
const int kFile_seek_name = 6;
const int kFile_stat_name = 7;
const int kFile_truncate_name = 8;
const int kFile_touch_name = 9;
const int kFile_dup_name = 10;
const int kFile_reopen_name = 11;
const int kFile_asBuffer_name = 12;
const int kFile_ioctl_name = 13;

const String FileName =
      'mojo::files::File';

abstract class File {
  dynamic close([Function responseFactory = null]);
  dynamic read(int numBytesToRead,int offset,types_mojom.Whence whence,[Function responseFactory = null]);
  dynamic write(List<int> bytesToWrite,int offset,types_mojom.Whence whence,[Function responseFactory = null]);
  dynamic readToStream(core.MojoDataPipeProducer source,int offset,types_mojom.Whence whence,int numBytesToRead,[Function responseFactory = null]);
  dynamic writeFromStream(core.MojoDataPipeConsumer sink,int offset,types_mojom.Whence whence,[Function responseFactory = null]);
  dynamic tell([Function responseFactory = null]);
  dynamic seek(int offset,types_mojom.Whence whence,[Function responseFactory = null]);
  dynamic stat([Function responseFactory = null]);
  dynamic truncate(int size,[Function responseFactory = null]);
  dynamic touch(types_mojom.TimespecOrNow atime,types_mojom.TimespecOrNow mtime,[Function responseFactory = null]);
  dynamic dup(Object file,[Function responseFactory = null]);
  dynamic reopen(Object file,int openFlags,[Function responseFactory = null]);
  dynamic asBuffer([Function responseFactory = null]);
  dynamic ioctl(int request,List<int> inValues,[Function responseFactory = null]);

}


class FileProxyImpl extends bindings.Proxy {
  FileProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  FileProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  FileProxyImpl.unbound() : super.unbound();

  static FileProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For FileProxyImpl"));
    return new FileProxyImpl.fromEndpoint(endpoint);
  }

  String get name => FileName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case kFile_close_name:
        var r = FileCloseResponseParams.deserialize(
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
      case kFile_read_name:
        var r = FileReadResponseParams.deserialize(
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
      case kFile_write_name:
        var r = FileWriteResponseParams.deserialize(
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
      case kFile_readToStream_name:
        var r = FileReadToStreamResponseParams.deserialize(
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
      case kFile_writeFromStream_name:
        var r = FileWriteFromStreamResponseParams.deserialize(
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
      case kFile_tell_name:
        var r = FileTellResponseParams.deserialize(
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
      case kFile_seek_name:
        var r = FileSeekResponseParams.deserialize(
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
      case kFile_stat_name:
        var r = FileStatResponseParams.deserialize(
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
      case kFile_truncate_name:
        var r = FileTruncateResponseParams.deserialize(
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
      case kFile_touch_name:
        var r = FileTouchResponseParams.deserialize(
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
      case kFile_dup_name:
        var r = FileDupResponseParams.deserialize(
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
      case kFile_reopen_name:
        var r = FileReopenResponseParams.deserialize(
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
      case kFile_asBuffer_name:
        var r = FileAsBufferResponseParams.deserialize(
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
      case kFile_ioctl_name:
        var r = FileIoctlResponseParams.deserialize(
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
    return "FileProxyImpl($superString)";
  }
}


class _FileProxyCalls implements File {
  FileProxyImpl _proxyImpl;

  _FileProxyCalls(this._proxyImpl);
    dynamic close([Function responseFactory = null]) {
      var params = new FileCloseParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kFile_close_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic read(int numBytesToRead,int offset,types_mojom.Whence whence,[Function responseFactory = null]) {
      var params = new FileReadParams();
      params.numBytesToRead = numBytesToRead;
      params.offset = offset;
      params.whence = whence;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kFile_read_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic write(List<int> bytesToWrite,int offset,types_mojom.Whence whence,[Function responseFactory = null]) {
      var params = new FileWriteParams();
      params.bytesToWrite = bytesToWrite;
      params.offset = offset;
      params.whence = whence;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kFile_write_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic readToStream(core.MojoDataPipeProducer source,int offset,types_mojom.Whence whence,int numBytesToRead,[Function responseFactory = null]) {
      var params = new FileReadToStreamParams();
      params.source = source;
      params.offset = offset;
      params.whence = whence;
      params.numBytesToRead = numBytesToRead;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kFile_readToStream_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic writeFromStream(core.MojoDataPipeConsumer sink,int offset,types_mojom.Whence whence,[Function responseFactory = null]) {
      var params = new FileWriteFromStreamParams();
      params.sink = sink;
      params.offset = offset;
      params.whence = whence;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kFile_writeFromStream_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic tell([Function responseFactory = null]) {
      var params = new FileTellParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kFile_tell_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic seek(int offset,types_mojom.Whence whence,[Function responseFactory = null]) {
      var params = new FileSeekParams();
      params.offset = offset;
      params.whence = whence;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kFile_seek_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic stat([Function responseFactory = null]) {
      var params = new FileStatParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kFile_stat_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic truncate(int size,[Function responseFactory = null]) {
      var params = new FileTruncateParams();
      params.size = size;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kFile_truncate_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic touch(types_mojom.TimespecOrNow atime,types_mojom.TimespecOrNow mtime,[Function responseFactory = null]) {
      var params = new FileTouchParams();
      params.atime = atime;
      params.mtime = mtime;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kFile_touch_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic dup(Object file,[Function responseFactory = null]) {
      var params = new FileDupParams();
      params.file = file;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kFile_dup_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic reopen(Object file,int openFlags,[Function responseFactory = null]) {
      var params = new FileReopenParams();
      params.file = file;
      params.openFlags = openFlags;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kFile_reopen_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic asBuffer([Function responseFactory = null]) {
      var params = new FileAsBufferParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kFile_asBuffer_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic ioctl(int request,List<int> inValues,[Function responseFactory = null]) {
      var params = new FileIoctlParams();
      params.request = request;
      params.inValues = inValues;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kFile_ioctl_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class FileProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  File ptr;
  final String name = FileName;

  FileProxy(FileProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _FileProxyCalls(proxyImpl);

  FileProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new FileProxyImpl.fromEndpoint(endpoint) {
    ptr = new _FileProxyCalls(impl);
  }

  FileProxy.fromHandle(core.MojoHandle handle) :
      impl = new FileProxyImpl.fromHandle(handle) {
    ptr = new _FileProxyCalls(impl);
  }

  FileProxy.unbound() :
      impl = new FileProxyImpl.unbound() {
    ptr = new _FileProxyCalls(impl);
  }

  factory FileProxy.connectToService(
      bindings.ServiceConnector s, String url) {
    FileProxy p = new FileProxy.unbound();
    s.connectToService(url, p);
    return p;
  }

  static FileProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For FileProxy"));
    return new FileProxy.fromEndpoint(endpoint);
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
    return "FileProxy($impl)";
  }
}


class FileStub extends bindings.Stub {
  File _impl = null;

  FileStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  FileStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  FileStub.unbound() : super.unbound();

  static FileStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For FileStub"));
    return new FileStub.fromEndpoint(endpoint);
  }

  static const String name = FileName;


  FileCloseResponseParams _FileCloseResponseParamsFactory(types_mojom.Error err) {
    var mojo_factory_result = new FileCloseResponseParams();
    mojo_factory_result.err = err;
    return mojo_factory_result;
  }
  FileReadResponseParams _FileReadResponseParamsFactory(types_mojom.Error error, List<int> bytesRead) {
    var mojo_factory_result = new FileReadResponseParams();
    mojo_factory_result.error = error;
    mojo_factory_result.bytesRead = bytesRead;
    return mojo_factory_result;
  }
  FileWriteResponseParams _FileWriteResponseParamsFactory(types_mojom.Error error, int numBytesWritten) {
    var mojo_factory_result = new FileWriteResponseParams();
    mojo_factory_result.error = error;
    mojo_factory_result.numBytesWritten = numBytesWritten;
    return mojo_factory_result;
  }
  FileReadToStreamResponseParams _FileReadToStreamResponseParamsFactory(types_mojom.Error error) {
    var mojo_factory_result = new FileReadToStreamResponseParams();
    mojo_factory_result.error = error;
    return mojo_factory_result;
  }
  FileWriteFromStreamResponseParams _FileWriteFromStreamResponseParamsFactory(types_mojom.Error error) {
    var mojo_factory_result = new FileWriteFromStreamResponseParams();
    mojo_factory_result.error = error;
    return mojo_factory_result;
  }
  FileTellResponseParams _FileTellResponseParamsFactory(types_mojom.Error error, int position) {
    var mojo_factory_result = new FileTellResponseParams();
    mojo_factory_result.error = error;
    mojo_factory_result.position = position;
    return mojo_factory_result;
  }
  FileSeekResponseParams _FileSeekResponseParamsFactory(types_mojom.Error error, int position) {
    var mojo_factory_result = new FileSeekResponseParams();
    mojo_factory_result.error = error;
    mojo_factory_result.position = position;
    return mojo_factory_result;
  }
  FileStatResponseParams _FileStatResponseParamsFactory(types_mojom.Error error, types_mojom.FileInformation fileInformation) {
    var mojo_factory_result = new FileStatResponseParams();
    mojo_factory_result.error = error;
    mojo_factory_result.fileInformation = fileInformation;
    return mojo_factory_result;
  }
  FileTruncateResponseParams _FileTruncateResponseParamsFactory(types_mojom.Error error) {
    var mojo_factory_result = new FileTruncateResponseParams();
    mojo_factory_result.error = error;
    return mojo_factory_result;
  }
  FileTouchResponseParams _FileTouchResponseParamsFactory(types_mojom.Error error) {
    var mojo_factory_result = new FileTouchResponseParams();
    mojo_factory_result.error = error;
    return mojo_factory_result;
  }
  FileDupResponseParams _FileDupResponseParamsFactory(types_mojom.Error error) {
    var mojo_factory_result = new FileDupResponseParams();
    mojo_factory_result.error = error;
    return mojo_factory_result;
  }
  FileReopenResponseParams _FileReopenResponseParamsFactory(types_mojom.Error error) {
    var mojo_factory_result = new FileReopenResponseParams();
    mojo_factory_result.error = error;
    return mojo_factory_result;
  }
  FileAsBufferResponseParams _FileAsBufferResponseParamsFactory(types_mojom.Error error, core.MojoSharedBuffer buffer) {
    var mojo_factory_result = new FileAsBufferResponseParams();
    mojo_factory_result.error = error;
    mojo_factory_result.buffer = buffer;
    return mojo_factory_result;
  }
  FileIoctlResponseParams _FileIoctlResponseParamsFactory(types_mojom.Error error, List<int> outValues) {
    var mojo_factory_result = new FileIoctlResponseParams();
    mojo_factory_result.error = error;
    mojo_factory_result.outValues = outValues;
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
      case kFile_close_name:
        var params = FileCloseParams.deserialize(
            message.payload);
        var response = _impl.close(_FileCloseResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kFile_close_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kFile_close_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kFile_read_name:
        var params = FileReadParams.deserialize(
            message.payload);
        var response = _impl.read(params.numBytesToRead,params.offset,params.whence,_FileReadResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kFile_read_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kFile_read_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kFile_write_name:
        var params = FileWriteParams.deserialize(
            message.payload);
        var response = _impl.write(params.bytesToWrite,params.offset,params.whence,_FileWriteResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kFile_write_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kFile_write_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kFile_readToStream_name:
        var params = FileReadToStreamParams.deserialize(
            message.payload);
        var response = _impl.readToStream(params.source,params.offset,params.whence,params.numBytesToRead,_FileReadToStreamResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kFile_readToStream_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kFile_readToStream_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kFile_writeFromStream_name:
        var params = FileWriteFromStreamParams.deserialize(
            message.payload);
        var response = _impl.writeFromStream(params.sink,params.offset,params.whence,_FileWriteFromStreamResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kFile_writeFromStream_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kFile_writeFromStream_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kFile_tell_name:
        var params = FileTellParams.deserialize(
            message.payload);
        var response = _impl.tell(_FileTellResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kFile_tell_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kFile_tell_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kFile_seek_name:
        var params = FileSeekParams.deserialize(
            message.payload);
        var response = _impl.seek(params.offset,params.whence,_FileSeekResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kFile_seek_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kFile_seek_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kFile_stat_name:
        var params = FileStatParams.deserialize(
            message.payload);
        var response = _impl.stat(_FileStatResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kFile_stat_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kFile_stat_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kFile_truncate_name:
        var params = FileTruncateParams.deserialize(
            message.payload);
        var response = _impl.truncate(params.size,_FileTruncateResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kFile_truncate_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kFile_truncate_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kFile_touch_name:
        var params = FileTouchParams.deserialize(
            message.payload);
        var response = _impl.touch(params.atime,params.mtime,_FileTouchResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kFile_touch_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kFile_touch_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kFile_dup_name:
        var params = FileDupParams.deserialize(
            message.payload);
        var response = _impl.dup(params.file,_FileDupResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kFile_dup_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kFile_dup_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kFile_reopen_name:
        var params = FileReopenParams.deserialize(
            message.payload);
        var response = _impl.reopen(params.file,params.openFlags,_FileReopenResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kFile_reopen_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kFile_reopen_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kFile_asBuffer_name:
        var params = FileAsBufferParams.deserialize(
            message.payload);
        var response = _impl.asBuffer(_FileAsBufferResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kFile_asBuffer_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kFile_asBuffer_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kFile_ioctl_name:
        var params = FileIoctlParams.deserialize(
            message.payload);
        var response = _impl.ioctl(params.request,params.inValues,_FileIoctlResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kFile_ioctl_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kFile_ioctl_name,
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

  File get impl => _impl;
  set impl(File d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "FileStub($superString)";
  }

  int get version => 0;
}


