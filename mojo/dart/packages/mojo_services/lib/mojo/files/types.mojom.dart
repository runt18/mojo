// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library types_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
const kOpenFlagRead = 0x1;
const kOpenFlagWrite = 0x2;
const kOpenFlagCreate = 0x4;
const kOpenFlagExclusive = 0x8;
const kOpenFlagAppend = 0x10;
const kOpenFlagTruncate = 0x20;
const kDeleteFlagFileOnly = 0x1;
const kDeleteFlagDirectoryOnly = 0x2;
const kDeleteFlagRecursive = 0x4;
class Error extends bindings.MojoEnum {
  static const OK = const Error._(0);
  static const UNKNOWN = const Error._(1);
  static const INVALID_ARGUMENT = const Error._(2);
  static const PERMISSION_DENIED = const Error._(3);
  static const OUT_OF_RANGE = const Error._(4);
  static const UNIMPLEMENTED = const Error._(5);
  static const CLOSED = const Error._(6);
  static const UNAVAILABLE = const Error._(7);
  static const INTERNAL = const Error._(8);

  const Error._(int v) : super(v);

  static const Map<String, Error> valuesMap = const {
    "OK": OK,
    "UNKNOWN": UNKNOWN,
    "INVALID_ARGUMENT": INVALID_ARGUMENT,
    "PERMISSION_DENIED": PERMISSION_DENIED,
    "OUT_OF_RANGE": OUT_OF_RANGE,
    "UNIMPLEMENTED": UNIMPLEMENTED,
    "CLOSED": CLOSED,
    "UNAVAILABLE": UNAVAILABLE,
    "INTERNAL": INTERNAL,
  };
  static const List<Error> values = const [
    OK,
    UNKNOWN,
    INVALID_ARGUMENT,
    PERMISSION_DENIED,
    OUT_OF_RANGE,
    UNIMPLEMENTED,
    CLOSED,
    UNAVAILABLE,
    INTERNAL,
  ];

  static Error valueOf(String name) => valuesMap[name];

  factory Error(int v) {
    switch (v) {
      case 0:
        return OK;
      case 1:
        return UNKNOWN;
      case 2:
        return INVALID_ARGUMENT;
      case 3:
        return PERMISSION_DENIED;
      case 4:
        return OUT_OF_RANGE;
      case 5:
        return UNIMPLEMENTED;
      case 6:
        return CLOSED;
      case 7:
        return UNAVAILABLE;
      case 8:
        return INTERNAL;
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
      case OK:
        return 'Error.OK';
      case UNKNOWN:
        return 'Error.UNKNOWN';
      case INVALID_ARGUMENT:
        return 'Error.INVALID_ARGUMENT';
      case PERMISSION_DENIED:
        return 'Error.PERMISSION_DENIED';
      case OUT_OF_RANGE:
        return 'Error.OUT_OF_RANGE';
      case UNIMPLEMENTED:
        return 'Error.UNIMPLEMENTED';
      case CLOSED:
        return 'Error.CLOSED';
      case UNAVAILABLE:
        return 'Error.UNAVAILABLE';
      case INTERNAL:
        return 'Error.INTERNAL';
    }
  }

  int toJson() => value;
}
class Whence extends bindings.MojoEnum {
  static const FROM_CURRENT = const Whence._(0);
  static const FROM_START = const Whence._(1);
  static const FROM_END = const Whence._(2);

  const Whence._(int v) : super(v);

  static const Map<String, Whence> valuesMap = const {
    "FROM_CURRENT": FROM_CURRENT,
    "FROM_START": FROM_START,
    "FROM_END": FROM_END,
  };
  static const List<Whence> values = const [
    FROM_CURRENT,
    FROM_START,
    FROM_END,
  ];

  static Whence valueOf(String name) => valuesMap[name];

  factory Whence(int v) {
    switch (v) {
      case 0:
        return FROM_CURRENT;
      case 1:
        return FROM_START;
      case 2:
        return FROM_END;
      default:
        return null;
    }
  }

  static Whence decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    Whence result = new Whence(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum Whence.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case FROM_CURRENT:
        return 'Whence.FROM_CURRENT';
      case FROM_START:
        return 'Whence.FROM_START';
      case FROM_END:
        return 'Whence.FROM_END';
    }
  }

  int toJson() => value;
}
class FileType extends bindings.MojoEnum {
  static const UNKNOWN = const FileType._(0);
  static const REGULAR_FILE = const FileType._(1);
  static const DIRECTORY = const FileType._(2);

  const FileType._(int v) : super(v);

  static const Map<String, FileType> valuesMap = const {
    "UNKNOWN": UNKNOWN,
    "REGULAR_FILE": REGULAR_FILE,
    "DIRECTORY": DIRECTORY,
  };
  static const List<FileType> values = const [
    UNKNOWN,
    REGULAR_FILE,
    DIRECTORY,
  ];

  static FileType valueOf(String name) => valuesMap[name];

  factory FileType(int v) {
    switch (v) {
      case 0:
        return UNKNOWN;
      case 1:
        return REGULAR_FILE;
      case 2:
        return DIRECTORY;
      default:
        return null;
    }
  }

  static FileType decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    FileType result = new FileType(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum FileType.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case UNKNOWN:
        return 'FileType.UNKNOWN';
      case REGULAR_FILE:
        return 'FileType.REGULAR_FILE';
      case DIRECTORY:
        return 'FileType.DIRECTORY';
    }
  }

  int toJson() => value;
}



class Timespec extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int seconds = 0;
  int nanoseconds = 0;

  Timespec() : super(kVersions.last.size);

  static Timespec deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Timespec decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Timespec result = new Timespec();

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
      
      result.seconds = decoder0.decodeInt64(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.nanoseconds = decoder0.decodeInt32(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInt64(seconds, 8);
    
    encoder0.encodeInt32(nanoseconds, 16);
  }

  String toString() {
    return "Timespec("
           "seconds: $seconds" ", "
           "nanoseconds: $nanoseconds" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["seconds"] = seconds;
    map["nanoseconds"] = nanoseconds;
    return map;
  }
}


class TimespecOrNow extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  bool now = false;
  Timespec timespec = null;

  TimespecOrNow() : super(kVersions.last.size);

  static TimespecOrNow deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TimespecOrNow decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TimespecOrNow result = new TimespecOrNow();

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
      
      result.now = decoder0.decodeBool(8, 0);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.timespec = Timespec.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeBool(now, 8, 0);
    
    encoder0.encodeStruct(timespec, 16, true);
  }

  String toString() {
    return "TimespecOrNow("
           "now: $now" ", "
           "timespec: $timespec" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["now"] = now;
    map["timespec"] = timespec;
    return map;
  }
}


class FileInformation extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(40, 0)
  ];
  FileType type = null;
  int size = 0;
  Timespec atime = null;
  Timespec mtime = null;

  FileInformation() : super(kVersions.last.size);

  static FileInformation deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileInformation decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileInformation result = new FileInformation();

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
      
        result.type = FileType.decode(decoder0, 8);
        if (result.type == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable FileType.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.size = decoder0.decodeInt64(16);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, true);
      result.atime = Timespec.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(32, true);
      result.mtime = Timespec.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(type, 8);
    
    encoder0.encodeInt64(size, 16);
    
    encoder0.encodeStruct(atime, 24, true);
    
    encoder0.encodeStruct(mtime, 32, true);
  }

  String toString() {
    return "FileInformation("
           "type: $type" ", "
           "size: $size" ", "
           "atime: $atime" ", "
           "mtime: $mtime" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["type"] = type;
    map["size"] = size;
    map["atime"] = atime;
    map["mtime"] = mtime;
    return map;
  }
}


class DirectoryEntry extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  FileType type = null;
  String name = null;

  DirectoryEntry() : super(kVersions.last.size);

  static DirectoryEntry deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static DirectoryEntry decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    DirectoryEntry result = new DirectoryEntry();

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
      
        result.type = FileType.decode(decoder0, 8);
        if (result.type == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable FileType.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.name = decoder0.decodeString(16, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(type, 8);
    
    encoder0.encodeString(name, 16, false);
  }

  String toString() {
    return "DirectoryEntry("
           "type: $type" ", "
           "name: $name" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["type"] = type;
    map["name"] = name;
    return map;
  }
}


