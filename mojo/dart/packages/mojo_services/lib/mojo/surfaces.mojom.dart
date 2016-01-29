// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library surfaces_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/geometry.mojom.dart' as geometry_mojom;
import 'package:mojo_services/mojo/quads.mojom.dart' as quads_mojom;
import 'package:mojo_services/mojo/surface_id.mojom.dart' as surface_id_mojom;

class ResourceFormat extends bindings.MojoEnum {
  static const ResourceFormat rgba8888 = const ResourceFormat._(0);
  static const ResourceFormat rgba4444 = const ResourceFormat._(1);
  static const ResourceFormat bgra8888 = const ResourceFormat._(2);
  static const ResourceFormat alpha8 = const ResourceFormat._(3);
  static const ResourceFormat luminance8 = const ResourceFormat._(4);
  static const ResourceFormat rgb565 = const ResourceFormat._(5);
  static const ResourceFormat etc1 = const ResourceFormat._(6);

  const ResourceFormat._(int v) : super(v);

  static const Map<String, ResourceFormat> valuesMap = const {
    "rgba8888": rgba8888,
    "rgba4444": rgba4444,
    "bgra8888": bgra8888,
    "alpha8": alpha8,
    "luminance8": luminance8,
    "rgb565": rgb565,
    "etc1": etc1,
  };
  static const List<ResourceFormat> values = const [
    rgba8888,
    rgba4444,
    bgra8888,
    alpha8,
    luminance8,
    rgb565,
    etc1,
  ];

  static ResourceFormat valueOf(String name) => valuesMap[name];

  factory ResourceFormat(int v) {
    switch (v) {
      case 0:
        return rgba8888;
      case 1:
        return rgba4444;
      case 2:
        return bgra8888;
      case 3:
        return alpha8;
      case 4:
        return luminance8;
      case 5:
        return rgb565;
      case 6:
        return etc1;
      default:
        return null;
    }
  }

  static ResourceFormat decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    ResourceFormat result = new ResourceFormat(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum ResourceFormat.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case rgba8888:
        return 'ResourceFormat.rgba8888';
      case rgba4444:
        return 'ResourceFormat.rgba4444';
      case bgra8888:
        return 'ResourceFormat.bgra8888';
      case alpha8:
        return 'ResourceFormat.alpha8';
      case luminance8:
        return 'ResourceFormat.luminance8';
      case rgb565:
        return 'ResourceFormat.rgb565';
      case etc1:
        return 'ResourceFormat.etc1';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}





class Mailbox extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<int> name = null;

  Mailbox() : super(kVersions.last.size);

  static Mailbox deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Mailbox decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Mailbox result = new Mailbox();

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
      
      result.name = decoder0.decodeInt8Array(8, bindings.kNothingNullable, 64);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInt8Array(name, 8, bindings.kNothingNullable, 64);
  }

  String toString() {
    return "Mailbox("
           "name: $name" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["name"] = name;
    return map;
  }
}




class MailboxHolder extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  Mailbox mailbox = null;
  int textureTarget = 0;
  int syncPoint = 0;

  MailboxHolder() : super(kVersions.last.size);

  static MailboxHolder deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MailboxHolder decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MailboxHolder result = new MailboxHolder();

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
      result.mailbox = Mailbox.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.textureTarget = decoder0.decodeUint32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.syncPoint = decoder0.decodeUint32(20);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(mailbox, 8, false);
    
    encoder0.encodeUint32(textureTarget, 16);
    
    encoder0.encodeUint32(syncPoint, 20);
  }

  String toString() {
    return "MailboxHolder("
           "mailbox: $mailbox" ", "
           "textureTarget: $textureTarget" ", "
           "syncPoint: $syncPoint" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["mailbox"] = mailbox;
    map["textureTarget"] = textureTarget;
    map["syncPoint"] = syncPoint;
    return map;
  }
}




class TransferableResource extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(40, 0)
  ];
  int id = 0;
  ResourceFormat format = null;
  int filter = 0;
  bool isRepeated = false;
  bool isSoftware = false;
  geometry_mojom.Size size = null;
  MailboxHolder mailboxHolder = null;

  TransferableResource() : super(kVersions.last.size);

  static TransferableResource deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TransferableResource decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TransferableResource result = new TransferableResource();

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
      
      result.id = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
        result.format = ResourceFormat.decode(decoder0, 12);
        if (result.format == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable ResourceFormat.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.filter = decoder0.decodeUint32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.isRepeated = decoder0.decodeBool(20, 0);
    }
    if (mainDataHeader.version >= 0) {
      
      result.isSoftware = decoder0.decodeBool(20, 1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, false);
      result.size = geometry_mojom.Size.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(32, false);
      result.mailboxHolder = MailboxHolder.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(id, 8);
    
    encoder0.encodeEnum(format, 12);
    
    encoder0.encodeUint32(filter, 16);
    
    encoder0.encodeBool(isRepeated, 20, 0);
    
    encoder0.encodeBool(isSoftware, 20, 1);
    
    encoder0.encodeStruct(size, 24, false);
    
    encoder0.encodeStruct(mailboxHolder, 32, false);
  }

  String toString() {
    return "TransferableResource("
           "id: $id" ", "
           "format: $format" ", "
           "filter: $filter" ", "
           "isRepeated: $isRepeated" ", "
           "isSoftware: $isSoftware" ", "
           "size: $size" ", "
           "mailboxHolder: $mailboxHolder" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["id"] = id;
    map["format"] = format;
    map["filter"] = filter;
    map["isRepeated"] = isRepeated;
    map["isSoftware"] = isSoftware;
    map["size"] = size;
    map["mailboxHolder"] = mailboxHolder;
    return map;
  }
}




class ReturnedResource extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int id = 0;
  int syncPoint = 0;
  int count = 0;
  bool lost = false;

  ReturnedResource() : super(kVersions.last.size);

  static ReturnedResource deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ReturnedResource decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ReturnedResource result = new ReturnedResource();

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
      
      result.id = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.syncPoint = decoder0.decodeUint32(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.count = decoder0.decodeInt32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.lost = decoder0.decodeBool(20, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(id, 8);
    
    encoder0.encodeUint32(syncPoint, 12);
    
    encoder0.encodeInt32(count, 16);
    
    encoder0.encodeBool(lost, 20, 0);
  }

  String toString() {
    return "ReturnedResource("
           "id: $id" ", "
           "syncPoint: $syncPoint" ", "
           "count: $count" ", "
           "lost: $lost" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["id"] = id;
    map["syncPoint"] = syncPoint;
    map["count"] = count;
    map["lost"] = lost;
    return map;
  }
}




class Frame extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  List<TransferableResource> resources = null;
  List<quads_mojom.Pass> passes = null;

  Frame() : super(kVersions.last.size);

  static Frame deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Frame decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Frame result = new Frame();

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
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.resources = new List<TransferableResource>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.resources[i1] = TransferableResource.decode(decoder2);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.passes = new List<quads_mojom.Pass>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.passes[i1] = quads_mojom.Pass.decode(decoder2);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    if (resources == null) {
      encoder0.encodeNullPointer(8, false);
    } else {
      var encoder1 = encoder0.encodePointerArray(resources.length, 8, bindings.kUnspecifiedArrayLength);
      for (int i0 = 0; i0 < resources.length; ++i0) {
        
        encoder1.encodeStruct(resources[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
      }
    }
    
    if (passes == null) {
      encoder0.encodeNullPointer(16, false);
    } else {
      var encoder1 = encoder0.encodePointerArray(passes.length, 16, bindings.kUnspecifiedArrayLength);
      for (int i0 = 0; i0 < passes.length; ++i0) {
        
        encoder1.encodeStruct(passes[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
      }
    }
  }

  String toString() {
    return "Frame("
           "resources: $resources" ", "
           "passes: $passes" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["resources"] = resources;
    map["passes"] = passes;
    return map;
  }
}




class _ResourceReturnerReturnResourcesParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<ReturnedResource> resources = null;

  _ResourceReturnerReturnResourcesParams() : super(kVersions.last.size);

  static _ResourceReturnerReturnResourcesParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ResourceReturnerReturnResourcesParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ResourceReturnerReturnResourcesParams result = new _ResourceReturnerReturnResourcesParams();

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
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.resources = new List<ReturnedResource>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.resources[i1] = ReturnedResource.decode(decoder2);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    if (resources == null) {
      encoder0.encodeNullPointer(8, false);
    } else {
      var encoder1 = encoder0.encodePointerArray(resources.length, 8, bindings.kUnspecifiedArrayLength);
      for (int i0 = 0; i0 < resources.length; ++i0) {
        
        encoder1.encodeStruct(resources[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
      }
    }
  }

  String toString() {
    return "_ResourceReturnerReturnResourcesParams("
           "resources: $resources" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["resources"] = resources;
    return map;
  }
}




class _SurfaceGetIdNamespaceParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _SurfaceGetIdNamespaceParams() : super(kVersions.last.size);

  static _SurfaceGetIdNamespaceParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SurfaceGetIdNamespaceParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SurfaceGetIdNamespaceParams result = new _SurfaceGetIdNamespaceParams();

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
    return "_SurfaceGetIdNamespaceParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}




class SurfaceGetIdNamespaceResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int idNamespace = 0;

  SurfaceGetIdNamespaceResponseParams() : super(kVersions.last.size);

  static SurfaceGetIdNamespaceResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SurfaceGetIdNamespaceResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SurfaceGetIdNamespaceResponseParams result = new SurfaceGetIdNamespaceResponseParams();

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
      
      result.idNamespace = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(idNamespace, 8);
  }

  String toString() {
    return "SurfaceGetIdNamespaceResponseParams("
           "idNamespace: $idNamespace" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["idNamespace"] = idNamespace;
    return map;
  }
}




class _SurfaceSetResourceReturnerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object returner = null;

  _SurfaceSetResourceReturnerParams() : super(kVersions.last.size);

  static _SurfaceSetResourceReturnerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SurfaceSetResourceReturnerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SurfaceSetResourceReturnerParams result = new _SurfaceSetResourceReturnerParams();

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
      
      result.returner = decoder0.decodeServiceInterface(8, false, ResourceReturnerProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInterface(returner, 8, false);
  }

  String toString() {
    return "_SurfaceSetResourceReturnerParams("
           "returner: $returner" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




class _SurfaceCreateSurfaceParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int idLocal = 0;

  _SurfaceCreateSurfaceParams() : super(kVersions.last.size);

  static _SurfaceCreateSurfaceParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SurfaceCreateSurfaceParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SurfaceCreateSurfaceParams result = new _SurfaceCreateSurfaceParams();

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
      
      result.idLocal = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(idLocal, 8);
  }

  String toString() {
    return "_SurfaceCreateSurfaceParams("
           "idLocal: $idLocal" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["idLocal"] = idLocal;
    return map;
  }
}




class _SurfaceSubmitFrameParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int idLocal = 0;
  Frame frame = null;

  _SurfaceSubmitFrameParams() : super(kVersions.last.size);

  static _SurfaceSubmitFrameParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SurfaceSubmitFrameParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SurfaceSubmitFrameParams result = new _SurfaceSubmitFrameParams();

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
      
      result.idLocal = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.frame = Frame.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(idLocal, 8);
    
    encoder0.encodeStruct(frame, 16, false);
  }

  String toString() {
    return "_SurfaceSubmitFrameParams("
           "idLocal: $idLocal" ", "
           "frame: $frame" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["idLocal"] = idLocal;
    map["frame"] = frame;
    return map;
  }
}




class SurfaceSubmitFrameResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  SurfaceSubmitFrameResponseParams() : super(kVersions.last.size);

  static SurfaceSubmitFrameResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SurfaceSubmitFrameResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SurfaceSubmitFrameResponseParams result = new SurfaceSubmitFrameResponseParams();

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
    return "SurfaceSubmitFrameResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}




class _SurfaceDestroySurfaceParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int idLocal = 0;

  _SurfaceDestroySurfaceParams() : super(kVersions.last.size);

  static _SurfaceDestroySurfaceParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SurfaceDestroySurfaceParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SurfaceDestroySurfaceParams result = new _SurfaceDestroySurfaceParams();

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
      
      result.idLocal = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(idLocal, 8);
  }

  String toString() {
    return "_SurfaceDestroySurfaceParams("
           "idLocal: $idLocal" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["idLocal"] = idLocal;
    return map;
  }
}




const int _ResourceReturner_returnResourcesName = 0;



class _ResourceReturnerServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class ResourceReturner {
  static const String serviceName = null;
  void returnResources(List<ReturnedResource> resources);
}


class _ResourceReturnerProxyImpl extends bindings.Proxy {
  _ResourceReturnerProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ResourceReturnerProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _ResourceReturnerProxyImpl.unbound() : super.unbound();

  static _ResourceReturnerProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _ResourceReturnerProxyImpl"));
    return new _ResourceReturnerProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _ResourceReturnerServiceDescription();

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
    return "_ResourceReturnerProxyImpl($superString)";
  }
}


class _ResourceReturnerProxyCalls implements ResourceReturner {
  _ResourceReturnerProxyImpl _proxyImpl;

  _ResourceReturnerProxyCalls(this._proxyImpl);
    void returnResources(List<ReturnedResource> resources) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _ResourceReturnerReturnResourcesParams();
      params.resources = resources;
      _proxyImpl.sendMessage(params, _ResourceReturner_returnResourcesName);
    }
}


class ResourceReturnerProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  ResourceReturner ptr;

  ResourceReturnerProxy(_ResourceReturnerProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _ResourceReturnerProxyCalls(proxyImpl);

  ResourceReturnerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _ResourceReturnerProxyImpl.fromEndpoint(endpoint) {
    ptr = new _ResourceReturnerProxyCalls(impl);
  }

  ResourceReturnerProxy.fromHandle(core.MojoHandle handle) :
      impl = new _ResourceReturnerProxyImpl.fromHandle(handle) {
    ptr = new _ResourceReturnerProxyCalls(impl);
  }

  ResourceReturnerProxy.unbound() :
      impl = new _ResourceReturnerProxyImpl.unbound() {
    ptr = new _ResourceReturnerProxyCalls(impl);
  }

  factory ResourceReturnerProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ResourceReturnerProxy p = new ResourceReturnerProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static ResourceReturnerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ResourceReturnerProxy"));
    return new ResourceReturnerProxy.fromEndpoint(endpoint);
  }

  String get serviceName => ResourceReturner.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "ResourceReturnerProxy($impl)";
  }
}


class ResourceReturnerStub extends bindings.Stub {
  ResourceReturner _impl = null;

  ResourceReturnerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  ResourceReturnerStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  ResourceReturnerStub.unbound() : super.unbound();

  static ResourceReturnerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ResourceReturnerStub"));
    return new ResourceReturnerStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _ResourceReturner_returnResourcesName:
        var params = _ResourceReturnerReturnResourcesParams.deserialize(
            message.payload);
        _impl.returnResources(params.resources);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  ResourceReturner get impl => _impl;
  set impl(ResourceReturner d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "ResourceReturnerStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _ResourceReturnerServiceDescription();
}

const int _Surface_getIdNamespaceName = 0;
const int _Surface_setResourceReturnerName = 1;
const int _Surface_createSurfaceName = 2;
const int _Surface_submitFrameName = 3;
const int _Surface_destroySurfaceName = 4;



class _SurfaceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class Surface {
  static const String serviceName = "mojo::Surface";
  dynamic getIdNamespace([Function responseFactory = null]);
  void setResourceReturner(Object returner);
  void createSurface(int idLocal);
  dynamic submitFrame(int idLocal,Frame frame,[Function responseFactory = null]);
  void destroySurface(int idLocal);
}


class _SurfaceProxyImpl extends bindings.Proxy {
  _SurfaceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _SurfaceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _SurfaceProxyImpl.unbound() : super.unbound();

  static _SurfaceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _SurfaceProxyImpl"));
    return new _SurfaceProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _SurfaceServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _Surface_getIdNamespaceName:
        var r = SurfaceGetIdNamespaceResponseParams.deserialize(
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
      case _Surface_submitFrameName:
        var r = SurfaceSubmitFrameResponseParams.deserialize(
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
    return "_SurfaceProxyImpl($superString)";
  }
}


class _SurfaceProxyCalls implements Surface {
  _SurfaceProxyImpl _proxyImpl;

  _SurfaceProxyCalls(this._proxyImpl);
    dynamic getIdNamespace([Function responseFactory = null]) {
      var params = new _SurfaceGetIdNamespaceParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _Surface_getIdNamespaceName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    void setResourceReturner(Object returner) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _SurfaceSetResourceReturnerParams();
      params.returner = returner;
      _proxyImpl.sendMessage(params, _Surface_setResourceReturnerName);
    }
    void createSurface(int idLocal) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _SurfaceCreateSurfaceParams();
      params.idLocal = idLocal;
      _proxyImpl.sendMessage(params, _Surface_createSurfaceName);
    }
    dynamic submitFrame(int idLocal,Frame frame,[Function responseFactory = null]) {
      var params = new _SurfaceSubmitFrameParams();
      params.idLocal = idLocal;
      params.frame = frame;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _Surface_submitFrameName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    void destroySurface(int idLocal) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _SurfaceDestroySurfaceParams();
      params.idLocal = idLocal;
      _proxyImpl.sendMessage(params, _Surface_destroySurfaceName);
    }
}


class SurfaceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  Surface ptr;

  SurfaceProxy(_SurfaceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _SurfaceProxyCalls(proxyImpl);

  SurfaceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _SurfaceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _SurfaceProxyCalls(impl);
  }

  SurfaceProxy.fromHandle(core.MojoHandle handle) :
      impl = new _SurfaceProxyImpl.fromHandle(handle) {
    ptr = new _SurfaceProxyCalls(impl);
  }

  SurfaceProxy.unbound() :
      impl = new _SurfaceProxyImpl.unbound() {
    ptr = new _SurfaceProxyCalls(impl);
  }

  factory SurfaceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    SurfaceProxy p = new SurfaceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static SurfaceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SurfaceProxy"));
    return new SurfaceProxy.fromEndpoint(endpoint);
  }

  String get serviceName => Surface.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "SurfaceProxy($impl)";
  }
}


class SurfaceStub extends bindings.Stub {
  Surface _impl = null;

  SurfaceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  SurfaceStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  SurfaceStub.unbound() : super.unbound();

  static SurfaceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SurfaceStub"));
    return new SurfaceStub.fromEndpoint(endpoint);
  }


  SurfaceGetIdNamespaceResponseParams _SurfaceGetIdNamespaceResponseParamsFactory(int idNamespace) {
    var mojo_factory_result = new SurfaceGetIdNamespaceResponseParams();
    mojo_factory_result.idNamespace = idNamespace;
    return mojo_factory_result;
  }
  SurfaceSubmitFrameResponseParams _SurfaceSubmitFrameResponseParamsFactory() {
    var mojo_factory_result = new SurfaceSubmitFrameResponseParams();
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
      case _Surface_getIdNamespaceName:
        var params = _SurfaceGetIdNamespaceParams.deserialize(
            message.payload);
        var response = _impl.getIdNamespace(_SurfaceGetIdNamespaceResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _Surface_getIdNamespaceName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _Surface_getIdNamespaceName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _Surface_setResourceReturnerName:
        var params = _SurfaceSetResourceReturnerParams.deserialize(
            message.payload);
        _impl.setResourceReturner(params.returner);
        break;
      case _Surface_createSurfaceName:
        var params = _SurfaceCreateSurfaceParams.deserialize(
            message.payload);
        _impl.createSurface(params.idLocal);
        break;
      case _Surface_submitFrameName:
        var params = _SurfaceSubmitFrameParams.deserialize(
            message.payload);
        var response = _impl.submitFrame(params.idLocal,params.frame,_SurfaceSubmitFrameResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _Surface_submitFrameName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _Surface_submitFrameName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _Surface_destroySurfaceName:
        var params = _SurfaceDestroySurfaceParams.deserialize(
            message.payload);
        _impl.destroySurface(params.idLocal);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  Surface get impl => _impl;
  set impl(Surface d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "SurfaceStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _SurfaceServiceDescription();
}



