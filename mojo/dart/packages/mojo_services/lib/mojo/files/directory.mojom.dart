// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library directory_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/files/file.mojom.dart' as file_mojom;
import 'package:mojo_services/mojo/files/types.mojom.dart' as types_mojom;



class _DirectoryReadParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _DirectoryReadParams() : super(kVersions.last.size);

  static _DirectoryReadParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _DirectoryReadParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _DirectoryReadParams result = new _DirectoryReadParams();

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
    return "_DirectoryReadParams("")";
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
    try {
      encoder0.encodeEnum(error, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct DirectoryReadResponseParams: $e";
      rethrow;
    }
    try {
      if (directoryContents == null) {
        encoder0.encodeNullPointer(16, true);
      } else {
        var encoder1 = encoder0.encodePointerArray(directoryContents.length, 16, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < directoryContents.length; ++i0) {
          encoder1.encodeStruct(directoryContents[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "directoryContents of struct DirectoryReadResponseParams: $e";
      rethrow;
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




class _DirectoryStatParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _DirectoryStatParams() : super(kVersions.last.size);

  static _DirectoryStatParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _DirectoryStatParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _DirectoryStatParams result = new _DirectoryStatParams();

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
    return "_DirectoryStatParams("")";
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
    try {
      encoder0.encodeEnum(error, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct DirectoryStatResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(fileInformation, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fileInformation of struct DirectoryStatResponseParams: $e";
      rethrow;
    }
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




class _DirectoryTouchParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  types_mojom.TimespecOrNow atime = null;
  types_mojom.TimespecOrNow mtime = null;

  _DirectoryTouchParams() : super(kVersions.last.size);

  static _DirectoryTouchParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _DirectoryTouchParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _DirectoryTouchParams result = new _DirectoryTouchParams();

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
    try {
      encoder0.encodeStruct(atime, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "atime of struct _DirectoryTouchParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(mtime, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "mtime of struct _DirectoryTouchParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_DirectoryTouchParams("
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
    try {
      encoder0.encodeEnum(error, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct DirectoryTouchResponseParams: $e";
      rethrow;
    }
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




class _DirectoryOpenFileParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String path = null;
  Object file = null;
  int openFlags = 0;

  _DirectoryOpenFileParams() : super(kVersions.last.size);

  static _DirectoryOpenFileParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _DirectoryOpenFileParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _DirectoryOpenFileParams result = new _DirectoryOpenFileParams();

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
    try {
      encoder0.encodeString(path, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "path of struct _DirectoryOpenFileParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(file, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "file of struct _DirectoryOpenFileParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(openFlags, 20);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "openFlags of struct _DirectoryOpenFileParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_DirectoryOpenFileParams("
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
    try {
      encoder0.encodeEnum(error, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct DirectoryOpenFileResponseParams: $e";
      rethrow;
    }
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




class _DirectoryOpenDirectoryParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String path = null;
  Object directory = null;
  int openFlags = 0;

  _DirectoryOpenDirectoryParams() : super(kVersions.last.size);

  static _DirectoryOpenDirectoryParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _DirectoryOpenDirectoryParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _DirectoryOpenDirectoryParams result = new _DirectoryOpenDirectoryParams();

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
    try {
      encoder0.encodeString(path, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "path of struct _DirectoryOpenDirectoryParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(directory, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "directory of struct _DirectoryOpenDirectoryParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(openFlags, 20);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "openFlags of struct _DirectoryOpenDirectoryParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_DirectoryOpenDirectoryParams("
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
    try {
      encoder0.encodeEnum(error, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct DirectoryOpenDirectoryResponseParams: $e";
      rethrow;
    }
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




class _DirectoryRenameParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String path = null;
  String newPath = null;

  _DirectoryRenameParams() : super(kVersions.last.size);

  static _DirectoryRenameParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _DirectoryRenameParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _DirectoryRenameParams result = new _DirectoryRenameParams();

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
    try {
      encoder0.encodeString(path, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "path of struct _DirectoryRenameParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(newPath, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "newPath of struct _DirectoryRenameParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_DirectoryRenameParams("
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
    try {
      encoder0.encodeEnum(error, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct DirectoryRenameResponseParams: $e";
      rethrow;
    }
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




class _DirectoryDeleteParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String path = null;
  int deleteFlags = 0;

  _DirectoryDeleteParams() : super(kVersions.last.size);

  static _DirectoryDeleteParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _DirectoryDeleteParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _DirectoryDeleteParams result = new _DirectoryDeleteParams();

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
    try {
      encoder0.encodeString(path, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "path of struct _DirectoryDeleteParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(deleteFlags, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "deleteFlags of struct _DirectoryDeleteParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_DirectoryDeleteParams("
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
    try {
      encoder0.encodeEnum(error, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct DirectoryDeleteResponseParams: $e";
      rethrow;
    }
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




const int _Directory_readName = 0;
const int _Directory_statName = 1;
const int _Directory_touchName = 2;
const int _Directory_openFileName = 3;
const int _Directory_openDirectoryName = 4;
const int _Directory_renameName = 5;
const int _Directory_deleteName = 6;



class _DirectoryServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class Directory {
  static const String serviceName = null;
  dynamic read([Function responseFactory = null]);
  dynamic stat([Function responseFactory = null]);
  dynamic touch(types_mojom.TimespecOrNow atime,types_mojom.TimespecOrNow mtime,[Function responseFactory = null]);
  dynamic openFile(String path,Object file,int openFlags,[Function responseFactory = null]);
  dynamic openDirectory(String path,Object directory,int openFlags,[Function responseFactory = null]);
  dynamic rename(String path,String newPath,[Function responseFactory = null]);
  dynamic delete(String path,int deleteFlags,[Function responseFactory = null]);
}


class _DirectoryProxyImpl extends bindings.Proxy {
  _DirectoryProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _DirectoryProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _DirectoryProxyImpl.unbound() : super.unbound();

  static _DirectoryProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _DirectoryProxyImpl"));
    return new _DirectoryProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _DirectoryServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _Directory_readName:
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
      case _Directory_statName:
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
      case _Directory_touchName:
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
      case _Directory_openFileName:
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
      case _Directory_openDirectoryName:
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
      case _Directory_renameName:
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
      case _Directory_deleteName:
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
    return "_DirectoryProxyImpl($superString)";
  }
}


class _DirectoryProxyCalls implements Directory {
  _DirectoryProxyImpl _proxyImpl;

  _DirectoryProxyCalls(this._proxyImpl);
    dynamic read([Function responseFactory = null]) {
      var params = new _DirectoryReadParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _Directory_readName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic stat([Function responseFactory = null]) {
      var params = new _DirectoryStatParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _Directory_statName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic touch(types_mojom.TimespecOrNow atime,types_mojom.TimespecOrNow mtime,[Function responseFactory = null]) {
      var params = new _DirectoryTouchParams();
      params.atime = atime;
      params.mtime = mtime;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _Directory_touchName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic openFile(String path,Object file,int openFlags,[Function responseFactory = null]) {
      var params = new _DirectoryOpenFileParams();
      params.path = path;
      params.file = file;
      params.openFlags = openFlags;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _Directory_openFileName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic openDirectory(String path,Object directory,int openFlags,[Function responseFactory = null]) {
      var params = new _DirectoryOpenDirectoryParams();
      params.path = path;
      params.directory = directory;
      params.openFlags = openFlags;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _Directory_openDirectoryName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic rename(String path,String newPath,[Function responseFactory = null]) {
      var params = new _DirectoryRenameParams();
      params.path = path;
      params.newPath = newPath;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _Directory_renameName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic delete(String path,int deleteFlags,[Function responseFactory = null]) {
      var params = new _DirectoryDeleteParams();
      params.path = path;
      params.deleteFlags = deleteFlags;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _Directory_deleteName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class DirectoryProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  Directory ptr;

  DirectoryProxy(_DirectoryProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _DirectoryProxyCalls(proxyImpl);

  DirectoryProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _DirectoryProxyImpl.fromEndpoint(endpoint) {
    ptr = new _DirectoryProxyCalls(impl);
  }

  DirectoryProxy.fromHandle(core.MojoHandle handle) :
      impl = new _DirectoryProxyImpl.fromHandle(handle) {
    ptr = new _DirectoryProxyCalls(impl);
  }

  DirectoryProxy.unbound() :
      impl = new _DirectoryProxyImpl.unbound() {
    ptr = new _DirectoryProxyCalls(impl);
  }

  factory DirectoryProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    DirectoryProxy p = new DirectoryProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static DirectoryProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For DirectoryProxy"));
    return new DirectoryProxy.fromEndpoint(endpoint);
  }

  String get serviceName => Directory.serviceName;

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
      case _Directory_readName:
        var params = _DirectoryReadParams.deserialize(
            message.payload);
        var response = _impl.read(_DirectoryReadResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _Directory_readName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _Directory_readName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _Directory_statName:
        var params = _DirectoryStatParams.deserialize(
            message.payload);
        var response = _impl.stat(_DirectoryStatResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _Directory_statName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _Directory_statName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _Directory_touchName:
        var params = _DirectoryTouchParams.deserialize(
            message.payload);
        var response = _impl.touch(params.atime,params.mtime,_DirectoryTouchResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _Directory_touchName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _Directory_touchName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _Directory_openFileName:
        var params = _DirectoryOpenFileParams.deserialize(
            message.payload);
        var response = _impl.openFile(params.path,params.file,params.openFlags,_DirectoryOpenFileResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _Directory_openFileName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _Directory_openFileName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _Directory_openDirectoryName:
        var params = _DirectoryOpenDirectoryParams.deserialize(
            message.payload);
        var response = _impl.openDirectory(params.path,params.directory,params.openFlags,_DirectoryOpenDirectoryResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _Directory_openDirectoryName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _Directory_openDirectoryName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _Directory_renameName:
        var params = _DirectoryRenameParams.deserialize(
            message.payload);
        var response = _impl.rename(params.path,params.newPath,_DirectoryRenameResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _Directory_renameName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _Directory_renameName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _Directory_deleteName:
        var params = _DirectoryDeleteParams.deserialize(
            message.payload);
        var response = _impl.delete(params.path,params.deleteFlags,_DirectoryDeleteResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _Directory_deleteName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _Directory_deleteName,
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

  service_describer.ServiceDescription get serviceDescription =>
    new _DirectoryServiceDescription();
}



