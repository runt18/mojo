// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library types_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;

const int kOpenFlagRead = 1;
const int kOpenFlagWrite = 2;
const int kOpenFlagCreate = 4;
const int kOpenFlagExclusive = 8;
const int kOpenFlagAppend = 16;
const int kOpenFlagTruncate = 32;
const int kDeleteFlagFileOnly = 1;
const int kDeleteFlagDirectoryOnly = 2;
const int kDeleteFlagRecursive = 4;

class Error extends bindings.MojoEnum {
  static const Error ok = const Error._(0);
  static const Error unknown = const Error._(1);
  static const Error invalidArgument = const Error._(2);
  static const Error permissionDenied = const Error._(3);
  static const Error outOfRange = const Error._(4);
  static const Error unimplemented = const Error._(5);
  static const Error closed = const Error._(6);
  static const Error unavailable = const Error._(7);
  static const Error internal = const Error._(8);

  const Error._(int v) : super(v);

  static const Map<String, Error> valuesMap = const {
    "ok": ok,
    "unknown": unknown,
    "invalidArgument": invalidArgument,
    "permissionDenied": permissionDenied,
    "outOfRange": outOfRange,
    "unimplemented": unimplemented,
    "closed": closed,
    "unavailable": unavailable,
    "internal": internal,
  };
  static const List<Error> values = const [
    ok,
    unknown,
    invalidArgument,
    permissionDenied,
    outOfRange,
    unimplemented,
    closed,
    unavailable,
    internal,
  ];

  static Error valueOf(String name) => valuesMap[name];

  factory Error(int v) {
    switch (v) {
      case 0:
        return ok;
      case 1:
        return unknown;
      case 2:
        return invalidArgument;
      case 3:
        return permissionDenied;
      case 4:
        return outOfRange;
      case 5:
        return unimplemented;
      case 6:
        return closed;
      case 7:
        return unavailable;
      case 8:
        return internal;
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
      case ok:
        return 'Error.ok';
      case unknown:
        return 'Error.unknown';
      case invalidArgument:
        return 'Error.invalidArgument';
      case permissionDenied:
        return 'Error.permissionDenied';
      case outOfRange:
        return 'Error.outOfRange';
      case unimplemented:
        return 'Error.unimplemented';
      case closed:
        return 'Error.closed';
      case unavailable:
        return 'Error.unavailable';
      case internal:
        return 'Error.internal';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}



class Whence extends bindings.MojoEnum {
  static const Whence fromCurrent = const Whence._(0);
  static const Whence fromStart = const Whence._(1);
  static const Whence fromEnd = const Whence._(2);

  const Whence._(int v) : super(v);

  static const Map<String, Whence> valuesMap = const {
    "fromCurrent": fromCurrent,
    "fromStart": fromStart,
    "fromEnd": fromEnd,
  };
  static const List<Whence> values = const [
    fromCurrent,
    fromStart,
    fromEnd,
  ];

  static Whence valueOf(String name) => valuesMap[name];

  factory Whence(int v) {
    switch (v) {
      case 0:
        return fromCurrent;
      case 1:
        return fromStart;
      case 2:
        return fromEnd;
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
      case fromCurrent:
        return 'Whence.fromCurrent';
      case fromStart:
        return 'Whence.fromStart';
      case fromEnd:
        return 'Whence.fromEnd';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}



class FileType extends bindings.MojoEnum {
  static const FileType unknown = const FileType._(0);
  static const FileType regularFile = const FileType._(1);
  static const FileType directory = const FileType._(2);

  const FileType._(int v) : super(v);

  static const Map<String, FileType> valuesMap = const {
    "unknown": unknown,
    "regularFile": regularFile,
    "directory": directory,
  };
  static const List<FileType> values = const [
    unknown,
    regularFile,
    directory,
  ];

  static FileType valueOf(String name) => valuesMap[name];

  factory FileType(int v) {
    switch (v) {
      case 0:
        return unknown;
      case 1:
        return regularFile;
      case 2:
        return directory;
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
      case unknown:
        return 'FileType.unknown';
      case regularFile:
        return 'FileType.regularFile';
      case directory:
        return 'FileType.directory';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
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






