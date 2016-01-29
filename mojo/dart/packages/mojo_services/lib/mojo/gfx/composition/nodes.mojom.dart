// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library nodes_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;

import 'package:mojo_services/mojo/geometry.mojom.dart' as geometry_mojom;
import 'package:mojo_services/mojo/gfx/composition/hit_tests.mojom.dart' as hit_tests_mojom;



class NodeCombinator extends bindings.MojoEnum {
  static const NodeCombinator merge = const NodeCombinator._(0);
  static const NodeCombinator prune = const NodeCombinator._(1);
  static const NodeCombinator fallback = const NodeCombinator._(2);

  const NodeCombinator._(int v) : super(v);

  static const Map<String, NodeCombinator> valuesMap = const {
    "merge": merge,
    "prune": prune,
    "fallback": fallback,
  };
  static const List<NodeCombinator> values = const [
    merge,
    prune,
    fallback,
  ];

  static NodeCombinator valueOf(String name) => valuesMap[name];

  factory NodeCombinator(int v) {
    switch (v) {
      case 0:
        return merge;
      case 1:
        return prune;
      case 2:
        return fallback;
      default:
        return null;
    }
  }

  static NodeCombinator decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    NodeCombinator result = new NodeCombinator(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum NodeCombinator.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case merge:
        return 'NodeCombinator.merge';
      case prune:
        return 'NodeCombinator.prune';
      case fallback:
        return 'NodeCombinator.fallback';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}



class Node extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(56, 0)
  ];
  geometry_mojom.Transform contentTransform = null;
  geometry_mojom.Rect contentClip = null;
  int hitId = 0;
  NodeCombinator combinator = new NodeCombinator(0);
  List<int> childNodeIds = null;
  NodeOp op = null;

  Node() : super(kVersions.last.size);

  static Node deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Node decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Node result = new Node();

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
      result.contentTransform = geometry_mojom.Transform.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.contentClip = geometry_mojom.Rect.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.hitId = decoder0.decodeUint32(24);
    }
    if (mainDataHeader.version >= 0) {
      
        result.combinator = NodeCombinator.decode(decoder0, 28);
        if (result.combinator == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable NodeCombinator.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.childNodeIds = decoder0.decodeUint32Array(32, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 0) {
      
        result.op = NodeOp.decode(decoder0, 40);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(contentTransform, 8, true);
    
    encoder0.encodeStruct(contentClip, 16, true);
    
    encoder0.encodeUint32(hitId, 24);
    
    encoder0.encodeEnum(combinator, 28);
    
    encoder0.encodeUint32Array(childNodeIds, 32, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    
    encoder0.encodeUnion(op, 40, true);
  }

  String toString() {
    return "Node("
           "contentTransform: $contentTransform" ", "
           "contentClip: $contentClip" ", "
           "hitId: $hitId" ", "
           "combinator: $combinator" ", "
           "childNodeIds: $childNodeIds" ", "
           "op: $op" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["contentTransform"] = contentTransform;
    map["contentClip"] = contentClip;
    map["hitId"] = hitId;
    map["combinator"] = combinator;
    map["childNodeIds"] = childNodeIds;
    map["op"] = op;
    return map;
  }
}




class RectNodeOp extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  geometry_mojom.Rect contentRect = null;
  Color color = null;

  RectNodeOp() : super(kVersions.last.size);

  static RectNodeOp deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static RectNodeOp decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    RectNodeOp result = new RectNodeOp();

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
      result.contentRect = geometry_mojom.Rect.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.color = Color.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(contentRect, 8, false);
    
    encoder0.encodeStruct(color, 16, false);
  }

  String toString() {
    return "RectNodeOp("
           "contentRect: $contentRect" ", "
           "color: $color" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["contentRect"] = contentRect;
    map["color"] = color;
    return map;
  }
}




class ImageNodeOp extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(40, 0)
  ];
  geometry_mojom.Rect contentRect = null;
  geometry_mojom.Rect imageRect = null;
  int imageResourceId = 0;
  Blend blend = null;

  ImageNodeOp() : super(kVersions.last.size);

  static ImageNodeOp deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ImageNodeOp decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ImageNodeOp result = new ImageNodeOp();

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
      result.contentRect = geometry_mojom.Rect.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.imageRect = geometry_mojom.Rect.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.imageResourceId = decoder0.decodeUint32(24);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(32, true);
      result.blend = Blend.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(contentRect, 8, false);
    
    encoder0.encodeStruct(imageRect, 16, true);
    
    encoder0.encodeUint32(imageResourceId, 24);
    
    encoder0.encodeStruct(blend, 32, true);
  }

  String toString() {
    return "ImageNodeOp("
           "contentRect: $contentRect" ", "
           "imageRect: $imageRect" ", "
           "imageResourceId: $imageResourceId" ", "
           "blend: $blend" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["contentRect"] = contentRect;
    map["imageRect"] = imageRect;
    map["imageResourceId"] = imageResourceId;
    map["blend"] = blend;
    return map;
  }
}




class SceneNodeOp extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int sceneResourceId = 0;
  int sceneVersion = 0;

  SceneNodeOp() : super(kVersions.last.size);

  static SceneNodeOp deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SceneNodeOp decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SceneNodeOp result = new SceneNodeOp();

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
      
      result.sceneResourceId = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.sceneVersion = decoder0.decodeUint32(12);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(sceneResourceId, 8);
    
    encoder0.encodeUint32(sceneVersion, 12);
  }

  String toString() {
    return "SceneNodeOp("
           "sceneResourceId: $sceneResourceId" ", "
           "sceneVersion: $sceneVersion" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["sceneResourceId"] = sceneResourceId;
    map["sceneVersion"] = sceneVersion;
    return map;
  }
}




class LayerNodeOp extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  geometry_mojom.Size layerSize = null;
  Blend blend = null;

  LayerNodeOp() : super(kVersions.last.size);

  static LayerNodeOp deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static LayerNodeOp decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    LayerNodeOp result = new LayerNodeOp();

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
      result.layerSize = geometry_mojom.Size.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.blend = Blend.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(layerSize, 8, false);
    
    encoder0.encodeStruct(blend, 16, true);
  }

  String toString() {
    return "LayerNodeOp("
           "layerSize: $layerSize" ", "
           "blend: $blend" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["layerSize"] = layerSize;
    map["blend"] = blend;
    return map;
  }
}




class Color extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int red = 0;
  int green = 0;
  int blue = 0;
  int alpha = 0;

  Color() : super(kVersions.last.size);

  static Color deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Color decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Color result = new Color();

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
      
      result.red = decoder0.decodeUint8(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.green = decoder0.decodeUint8(9);
    }
    if (mainDataHeader.version >= 0) {
      
      result.blue = decoder0.decodeUint8(10);
    }
    if (mainDataHeader.version >= 0) {
      
      result.alpha = decoder0.decodeUint8(11);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint8(red, 8);
    
    encoder0.encodeUint8(green, 9);
    
    encoder0.encodeUint8(blue, 10);
    
    encoder0.encodeUint8(alpha, 11);
  }

  String toString() {
    return "Color("
           "red: $red" ", "
           "green: $green" ", "
           "blue: $blue" ", "
           "alpha: $alpha" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["red"] = red;
    map["green"] = green;
    map["blue"] = blue;
    map["alpha"] = alpha;
    return map;
  }
}




class Blend extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int alpha = 255;

  Blend() : super(kVersions.last.size);

  static Blend deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Blend decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Blend result = new Blend();

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
      
      result.alpha = decoder0.decodeUint8(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint8(alpha, 8);
  }

  String toString() {
    return "Blend("
           "alpha: $alpha" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["alpha"] = alpha;
    return map;
  }
}





enum NodeOpTag {
  rect,
  image,
  scene,
  layer,
  unknown
}

class NodeOp extends bindings.Union {
  static final _tag_to_int = const {
    NodeOpTag.rect: 0,
    NodeOpTag.image: 1,
    NodeOpTag.scene: 2,
    NodeOpTag.layer: 3,
  };

  static final _int_to_tag = const {
    0: NodeOpTag.rect,
    1: NodeOpTag.image,
    2: NodeOpTag.scene,
    3: NodeOpTag.layer,
  };

  var _data;
  NodeOpTag _tag = NodeOpTag.unknown;

  NodeOpTag get tag => _tag;
  RectNodeOp get rect {
    if (_tag != NodeOpTag.rect) {
      throw new bindings.UnsetUnionTagError(_tag, NodeOpTag.rect);
    }
    return _data;
  }

  set rect(RectNodeOp value) {
    _tag = NodeOpTag.rect;
    _data = value;
  }
  ImageNodeOp get image {
    if (_tag != NodeOpTag.image) {
      throw new bindings.UnsetUnionTagError(_tag, NodeOpTag.image);
    }
    return _data;
  }

  set image(ImageNodeOp value) {
    _tag = NodeOpTag.image;
    _data = value;
  }
  SceneNodeOp get scene {
    if (_tag != NodeOpTag.scene) {
      throw new bindings.UnsetUnionTagError(_tag, NodeOpTag.scene);
    }
    return _data;
  }

  set scene(SceneNodeOp value) {
    _tag = NodeOpTag.scene;
    _data = value;
  }
  LayerNodeOp get layer {
    if (_tag != NodeOpTag.layer) {
      throw new bindings.UnsetUnionTagError(_tag, NodeOpTag.layer);
    }
    return _data;
  }

  set layer(LayerNodeOp value) {
    _tag = NodeOpTag.layer;
    _data = value;
  }

  static NodeOp decode(bindings.Decoder decoder0, int offset) {
    int size = decoder0.decodeUint32(offset);
    if (size == 0) {
      return null;
    }
    NodeOp result = new NodeOp();

    // TODO(azani): Handle unknown union member.
    NodeOpTag tag = _int_to_tag[decoder0.decodeUint32(offset + 4)];
    switch (tag) {
      case NodeOpTag.rect:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        result.rect = RectNodeOp.decode(decoder1);
        break;
      case NodeOpTag.image:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        result.image = ImageNodeOp.decode(decoder1);
        break;
      case NodeOpTag.scene:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        result.scene = SceneNodeOp.decode(decoder1);
        break;
      case NodeOpTag.layer:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        result.layer = LayerNodeOp.decode(decoder1);
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $tag");
    }

    return result;
  }

  void encode(bindings.Encoder encoder0, int offset) {
    // TODO(azani): Error when trying to encode an unknown member.
    encoder0.encodeUint32(16, offset);
    encoder0.encodeUint32(_tag_to_int[_tag], offset + 4);
    switch (_tag) {
      case NodeOpTag.rect:
        
        encoder0.encodeStruct(rect, offset + 8, false);
        break;
      case NodeOpTag.image:
        
        encoder0.encodeStruct(image, offset + 8, false);
        break;
      case NodeOpTag.scene:
        
        encoder0.encodeStruct(scene, offset + 8, false);
        break;
      case NodeOpTag.layer:
        
        encoder0.encodeStruct(layer, offset + 8, false);
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $_tag");
    }
  }

  String toString() {
    String result = "NodeOp(";
    switch (_tag) {
      case NodeOpTag.rect:
        result += "rect";
        break;
      case NodeOpTag.image:
        result += "image";
        break;
      case NodeOpTag.scene:
        result += "scene";
        break;
      case NodeOpTag.layer:
        result += "layer";
        break;
      default:
        result += "unknown";
    }
    result += ": $_data)";
    return result;
  }
}





