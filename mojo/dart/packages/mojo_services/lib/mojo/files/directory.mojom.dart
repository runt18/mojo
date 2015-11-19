// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library directory_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo_services/mojo/files/file.mojom.dart' as file_mojom;
import 'package:mojo_services/mojo/files/types.mojom.dart' as types_mojom;



class DirectoryReadParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  DirectoryReadParams() : super(kVersions.last.size);

  static DirectoryReadParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static DirectoryReadParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    DirectoryReadParams result = new DirectoryReadParams();

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
    return "DirectoryReadParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class DirectoryReadResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  types_mojom.Error error = null;
  List<types_mojom.DirectoryEntry> directoryContents = null;

  DirectoryReadResponseParams() : super(kVersions.last.size);

  static DirectoryReadResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static DirectoryReadResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    DirectoryReadResponseParams result = new DirectoryReadResponseParams();

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
      if (decoder1 == null) {
        result.directoryContents = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.directoryContents = new List<types_mojom.DirectoryEntry>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.directoryContents[i1] = types_mojom.DirectoryEntry.decode(decoder2);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(error, 8);
    
    if (directoryContents == null) {
      encoder0.encodeNullPointer(16, true);
    } else {
      var encoder1 = encoder0.encodePointerArray(directoryContents.length, 16, bindings.kUnspecifiedArrayLength);
      for (int i0 = 0; i0 < directoryContents.length; ++i0) {
        
        encoder1.encodeStruct(directoryContents[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
      }
    }
  }

  String toString() {
    return "DirectoryReadResponseParams("
           "error: $error" ", "
           "directoryContents: $directoryContents" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    map["directoryContents"] = directoryContents;
    return map;
  }
}


class DirectoryStatParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  DirectoryStatParams() : super(kVersions.last.size);

  static DirectoryStatParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static DirectoryStatParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    DirectoryStatParams result = new DirectoryStatParams();

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
    return "DirectoryStatParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class DirectoryStatResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  types_mojom.Error error = null;
  types_mojom.FileInformation fileInformation = null;

  DirectoryStatResponseParams() : super(kVersions.last.size);

  static DirectoryStatResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static DirectoryStatResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    DirectoryStatResponseParams result = new DirectoryStatResponseParams();

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
    return "DirectoryStatResponseParams("
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


class DirectoryTouchParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  types_mojom.TimespecOrNow atime = null;
  types_mojom.TimespecOrNow mtime = null;

  DirectoryTouchParams() : super(kVersions.last.size);

  static DirectoryTouchParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static DirectoryTouchParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    DirectoryTouchParams result = new DirectoryTouchParams();

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
    return "DirectoryTouchParams("
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


class DirectoryTouchResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error error = null;

  DirectoryTouchResponseParams() : super(kVersions.last.size);

  static DirectoryTouchResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static DirectoryTouchResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    DirectoryTouchResponseParams result = new DirectoryTouchResponseParams();

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
    return "DirectoryTouchResponseParams("
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    return map;
  }
}


class DirectoryOpenFileParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String path = null;
  Object file = null;
  int openFlags = 0;

  DirectoryOpenFileParams() : super(kVersions.last.size);

  static DirectoryOpenFileParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static DirectoryOpenFileParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    DirectoryOpenFileParams result = new DirectoryOpenFileParams();

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
      
      result.path = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.file = decoder0.decodeInterfaceRequest(16, true, file_mojom.FileStub.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.openFlags = decoder0.decodeUint32(20);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeString(path, 8, false);
    
    encoder0.encodeInterfaceRequest(file, 16, true);
    
    encoder0.encodeUint32(openFlags, 20);
  }

  String toString() {
    return "DirectoryOpenFileParams("
           "path: $path" ", "
           "file: $file" ", "
           "openFlags: $openFlags" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class DirectoryOpenFileResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error error = null;

  DirectoryOpenFileResponseParams() : super(kVersions.last.size);

  static DirectoryOpenFileResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static DirectoryOpenFileResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    DirectoryOpenFileResponseParams result = new DirectoryOpenFileResponseParams();

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
    return "DirectoryOpenFileResponseParams("
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    return map;
  }
}


class DirectoryOpenDirectoryParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String path = null;
  Object directory = null;
  int openFlags = 0;

  DirectoryOpenDirectoryParams() : super(kVersions.last.size);

  static DirectoryOpenDirectoryParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static DirectoryOpenDirectoryParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    DirectoryOpenDirectoryParams result = new DirectoryOpenDirectoryParams();

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
      
      result.path = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.directory = decoder0.decodeInterfaceRequest(16, true, DirectoryStub.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.openFlags = decoder0.decodeUint32(20);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeString(path, 8, false);
    
    encoder0.encodeInterfaceRequest(directory, 16, true);
    
    encoder0.encodeUint32(openFlags, 20);
  }

  String toString() {
    return "DirectoryOpenDirectoryParams("
           "path: $path" ", "
           "directory: $directory" ", "
           "openFlags: $openFlags" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class DirectoryOpenDirectoryResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error error = null;

  DirectoryOpenDirectoryResponseParams() : super(kVersions.last.size);

  static DirectoryOpenDirectoryResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static DirectoryOpenDirectoryResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    DirectoryOpenDirectoryResponseParams result = new DirectoryOpenDirectoryResponseParams();

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
    return "DirectoryOpenDirectoryResponseParams("
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    return map;
  }
}


class DirectoryRenameParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String path = null;
  String newPath = null;

  DirectoryRenameParams() : super(kVersions.last.size);

  static DirectoryRenameParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static DirectoryRenameParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    DirectoryRenameParams result = new DirectoryRenameParams();

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
      
      result.path = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.newPath = decoder0.decodeString(16, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeString(path, 8, false);
    
    encoder0.encodeString(newPath, 16, false);
  }

  String toString() {
    return "DirectoryRenameParams("
           "path: $path" ", "
           "newPath: $newPath" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["path"] = path;
    map["newPath"] = newPath;
    return map;
  }
}


class DirectoryRenameResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error error = null;

  DirectoryRenameResponseParams() : super(kVersions.last.size);

  static DirectoryRenameResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static DirectoryRenameResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    DirectoryRenameResponseParams result = new DirectoryRenameResponseParams();

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
    return "DirectoryRenameResponseParams("
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    return map;
  }
}


class DirectoryDeleteParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String path = null;
  int deleteFlags = 0;

  DirectoryDeleteParams() : super(kVersions.last.size);

  static DirectoryDeleteParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static DirectoryDeleteParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    DirectoryDeleteParams result = new DirectoryDeleteParams();

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
      
      result.path = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.deleteFlags = decoder0.decodeUint32(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeString(path, 8, false);
    
    encoder0.encodeUint32(deleteFlags, 16);
  }

  String toString() {
    return "DirectoryDeleteParams("
           "path: $path" ", "
           "deleteFlags: $deleteFlags" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["path"] = path;
    map["deleteFlags"] = deleteFlags;
    return map;
  }
}


class DirectoryDeleteResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error error = null;

  DirectoryDeleteResponseParams() : super(kVersions.last.size);

  static DirectoryDeleteResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static DirectoryDeleteResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    DirectoryDeleteResponseParams result = new DirectoryDeleteResponseParams();

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
    return "DirectoryDeleteResponseParams("
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    return map;
  }
}

const int kDirectory_read_name = 0;
const int kDirectory_stat_name = 1;
const int kDirectory_touch_name = 2;
const int kDirectory_openFile_name = 3;
const int kDirectory_openDirectory_name = 4;
const int kDirectory_rename_name = 5;
const int kDirectory_delete_name = 6;

const String DirectoryName =
      'mojo::files::Directory';

abstract class Directory {
  dynamic read([Function responseFactory = null]);
  dynamic stat([Function responseFactory = null]);
  dynamic touch(types_mojom.TimespecOrNow atime,types_mojom.TimespecOrNow mtime,[Function responseFactory = null]);
  dynamic openFile(String path,Object file,int openFlags,[Function responseFactory = null]);
  dynamic openDirectory(String path,Object directory,int openFlags,[Function responseFactory = null]);
  dynamic rename(String path,String newPath,[Function responseFactory = null]);
  dynamic delete(String path,int deleteFlags,[Function responseFactory = null]);

}


class DirectoryProxyImpl extends bindings.Proxy {
  DirectoryProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  DirectoryProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  DirectoryProxyImpl.unbound() : super.unbound();

  static DirectoryProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For DirectoryProxyImpl"));
    return new DirectoryProxyImpl.fromEndpoint(endpoint);
  }

  String get name => DirectoryName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case kDirectory_read_name:
        var r = DirectoryReadResponseParams.deserialize(
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
      case kDirectory_stat_name:
        var r = DirectoryStatResponseParams.deserialize(
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
      case kDirectory_touch_name:
        var r = DirectoryTouchResponseParams.deserialize(
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
      case kDirectory_openFile_name:
        var r = DirectoryOpenFileResponseParams.deserialize(
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
      case kDirectory_openDirectory_name:
        var r = DirectoryOpenDirectoryResponseParams.deserialize(
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
      case kDirectory_rename_name:
        var r = DirectoryRenameResponseParams.deserialize(
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
      case kDirectory_delete_name:
        var r = DirectoryDeleteResponseParams.deserialize(
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
    return "DirectoryProxyImpl($superString)";
  }
}


class _DirectoryProxyCalls implements Directory {
  DirectoryProxyImpl _proxyImpl;

  _DirectoryProxyCalls(this._proxyImpl);
    dynamic read([Function responseFactory = null]) {
      var params = new DirectoryReadParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kDirectory_read_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic stat([Function responseFactory = null]) {
      var params = new DirectoryStatParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kDirectory_stat_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic touch(types_mojom.TimespecOrNow atime,types_mojom.TimespecOrNow mtime,[Function responseFactory = null]) {
      var params = new DirectoryTouchParams();
      params.atime = atime;
      params.mtime = mtime;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kDirectory_touch_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic openFile(String path,Object file,int openFlags,[Function responseFactory = null]) {
      var params = new DirectoryOpenFileParams();
      params.path = path;
      params.file = file;
      params.openFlags = openFlags;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kDirectory_openFile_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic openDirectory(String path,Object directory,int openFlags,[Function responseFactory = null]) {
      var params = new DirectoryOpenDirectoryParams();
      params.path = path;
      params.directory = directory;
      params.openFlags = openFlags;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kDirectory_openDirectory_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic rename(String path,String newPath,[Function responseFactory = null]) {
      var params = new DirectoryRenameParams();
      params.path = path;
      params.newPath = newPath;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kDirectory_rename_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic delete(String path,int deleteFlags,[Function responseFactory = null]) {
      var params = new DirectoryDeleteParams();
      params.path = path;
      params.deleteFlags = deleteFlags;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kDirectory_delete_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class DirectoryProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  Directory ptr;
  final String name = DirectoryName;

  DirectoryProxy(DirectoryProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _DirectoryProxyCalls(proxyImpl);

  DirectoryProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new DirectoryProxyImpl.fromEndpoint(endpoint) {
    ptr = new _DirectoryProxyCalls(impl);
  }

  DirectoryProxy.fromHandle(core.MojoHandle handle) :
      impl = new DirectoryProxyImpl.fromHandle(handle) {
    ptr = new _DirectoryProxyCalls(impl);
  }

  DirectoryProxy.unbound() :
      impl = new DirectoryProxyImpl.unbound() {
    ptr = new _DirectoryProxyCalls(impl);
  }

  factory DirectoryProxy.connectToService(
      bindings.ServiceConnector s, String url) {
    DirectoryProxy p = new DirectoryProxy.unbound();
    s.connectToService(url, p);
    return p;
  }

  static DirectoryProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For DirectoryProxy"));
    return new DirectoryProxy.fromEndpoint(endpoint);
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
    return "DirectoryProxy($impl)";
  }
}


class DirectoryStub extends bindings.Stub {
  Directory _impl = null;

  DirectoryStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  DirectoryStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  DirectoryStub.unbound() : super.unbound();

  static DirectoryStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For DirectoryStub"));
    return new DirectoryStub.fromEndpoint(endpoint);
  }

  static const String name = DirectoryName;


  DirectoryReadResponseParams _DirectoryReadResponseParamsFactory(types_mojom.Error error, List<types_mojom.DirectoryEntry> directoryContents) {
    var mojo_factory_result = new DirectoryReadResponseParams();
    mojo_factory_result.error = error;
    mojo_factory_result.directoryContents = directoryContents;
    return mojo_factory_result;
  }
  DirectoryStatResponseParams _DirectoryStatResponseParamsFactory(types_mojom.Error error, types_mojom.FileInformation fileInformation) {
    var mojo_factory_result = new DirectoryStatResponseParams();
    mojo_factory_result.error = error;
    mojo_factory_result.fileInformation = fileInformation;
    return mojo_factory_result;
  }
  DirectoryTouchResponseParams _DirectoryTouchResponseParamsFactory(types_mojom.Error error) {
    var mojo_factory_result = new DirectoryTouchResponseParams();
    mojo_factory_result.error = error;
    return mojo_factory_result;
  }
  DirectoryOpenFileResponseParams _DirectoryOpenFileResponseParamsFactory(types_mojom.Error error) {
    var mojo_factory_result = new DirectoryOpenFileResponseParams();
    mojo_factory_result.error = error;
    return mojo_factory_result;
  }
  DirectoryOpenDirectoryResponseParams _DirectoryOpenDirectoryResponseParamsFactory(types_mojom.Error error) {
    var mojo_factory_result = new DirectoryOpenDirectoryResponseParams();
    mojo_factory_result.error = error;
    return mojo_factory_result;
  }
  DirectoryRenameResponseParams _DirectoryRenameResponseParamsFactory(types_mojom.Error error) {
    var mojo_factory_result = new DirectoryRenameResponseParams();
    mojo_factory_result.error = error;
    return mojo_factory_result;
  }
  DirectoryDeleteResponseParams _DirectoryDeleteResponseParamsFactory(types_mojom.Error error) {
    var mojo_factory_result = new DirectoryDeleteResponseParams();
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
      case kDirectory_read_name:
        var params = DirectoryReadParams.deserialize(
            message.payload);
        var response = _impl.read(_DirectoryReadResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kDirectory_read_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kDirectory_read_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kDirectory_stat_name:
        var params = DirectoryStatParams.deserialize(
            message.payload);
        var response = _impl.stat(_DirectoryStatResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kDirectory_stat_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kDirectory_stat_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kDirectory_touch_name:
        var params = DirectoryTouchParams.deserialize(
            message.payload);
        var response = _impl.touch(params.atime,params.mtime,_DirectoryTouchResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kDirectory_touch_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kDirectory_touch_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kDirectory_openFile_name:
        var params = DirectoryOpenFileParams.deserialize(
            message.payload);
        var response = _impl.openFile(params.path,params.file,params.openFlags,_DirectoryOpenFileResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kDirectory_openFile_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kDirectory_openFile_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kDirectory_openDirectory_name:
        var params = DirectoryOpenDirectoryParams.deserialize(
            message.payload);
        var response = _impl.openDirectory(params.path,params.directory,params.openFlags,_DirectoryOpenDirectoryResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kDirectory_openDirectory_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kDirectory_openDirectory_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kDirectory_rename_name:
        var params = DirectoryRenameParams.deserialize(
            message.payload);
        var response = _impl.rename(params.path,params.newPath,_DirectoryRenameResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kDirectory_rename_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kDirectory_rename_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kDirectory_delete_name:
        var params = DirectoryDeleteParams.deserialize(
            message.payload);
        var response = _impl.delete(params.path,params.deleteFlags,_DirectoryDeleteResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kDirectory_delete_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kDirectory_delete_name,
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

  Directory get impl => _impl;
  set impl(Directory d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "DirectoryStub($superString)";
  }

  int get version => 0;
}


