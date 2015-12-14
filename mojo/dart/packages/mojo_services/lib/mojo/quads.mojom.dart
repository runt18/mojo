// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library quads_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo_services/mojo/geometry.mojom.dart' as geometry_mojom;
import 'package:mojo_services/mojo/surface_id.mojom.dart' as surface_id_mojom;

class YuvColorSpace extends bindings.MojoEnum {
  static const YuvColorSpace rec601 = const YuvColorSpace._(0);
  static const YuvColorSpace rec709 = const YuvColorSpace._(1);
  static const YuvColorSpace jpeg = const YuvColorSpace._(2);

  const YuvColorSpace._(int v) : super(v);

  static const Map<String, YuvColorSpace> valuesMap = const {
    "rec601": rec601,
    "rec709": rec709,
    "jpeg": jpeg,
  };
  static const List<YuvColorSpace> values = const [
    rec601,
    rec709,
    jpeg,
  ];

  static YuvColorSpace valueOf(String name) => valuesMap[name];

  factory YuvColorSpace(int v) {
    switch (v) {
      case 0:
        return rec601;
      case 1:
        return rec709;
      case 2:
        return jpeg;
      default:
        return null;
    }
  }

  static YuvColorSpace decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    YuvColorSpace result = new YuvColorSpace(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum YuvColorSpace.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case rec601:
        return 'YuvColorSpace.rec601';
      case rec709:
        return 'YuvColorSpace.rec709';
      case jpeg:
        return 'YuvColorSpace.jpeg';
    }
  }

  int toJson() => mojoEnumValue;
}

class Material extends bindings.MojoEnum {
  static const Material checkerboard = const Material._(1);
  static const Material debugBorder = const Material._(2);
  static const Material ioSurfaceContent = const Material._(3);
  static const Material pictureContent = const Material._(4);
  static const Material renderPass = const Material._(5);
  static const Material solidColor = const Material._(6);
  static const Material streamVideoContent = const Material._(7);
  static const Material surfaceContent = const Material._(8);
  static const Material textureContent = const Material._(9);
  static const Material tiledContent = const Material._(10);
  static const Material yuvVideoContent = const Material._(11);

  const Material._(int v) : super(v);

  static const Map<String, Material> valuesMap = const {
    "checkerboard": checkerboard,
    "debugBorder": debugBorder,
    "ioSurfaceContent": ioSurfaceContent,
    "pictureContent": pictureContent,
    "renderPass": renderPass,
    "solidColor": solidColor,
    "streamVideoContent": streamVideoContent,
    "surfaceContent": surfaceContent,
    "textureContent": textureContent,
    "tiledContent": tiledContent,
    "yuvVideoContent": yuvVideoContent,
  };
  static const List<Material> values = const [
    checkerboard,
    debugBorder,
    ioSurfaceContent,
    pictureContent,
    renderPass,
    solidColor,
    streamVideoContent,
    surfaceContent,
    textureContent,
    tiledContent,
    yuvVideoContent,
  ];

  static Material valueOf(String name) => valuesMap[name];

  factory Material(int v) {
    switch (v) {
      case 1:
        return checkerboard;
      case 2:
        return debugBorder;
      case 3:
        return ioSurfaceContent;
      case 4:
        return pictureContent;
      case 5:
        return renderPass;
      case 6:
        return solidColor;
      case 7:
        return streamVideoContent;
      case 8:
        return surfaceContent;
      case 9:
        return textureContent;
      case 10:
        return tiledContent;
      case 11:
        return yuvVideoContent;
      default:
        return null;
    }
  }

  static Material decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    Material result = new Material(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum Material.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case checkerboard:
        return 'Material.checkerboard';
      case debugBorder:
        return 'Material.debugBorder';
      case ioSurfaceContent:
        return 'Material.ioSurfaceContent';
      case pictureContent:
        return 'Material.pictureContent';
      case renderPass:
        return 'Material.renderPass';
      case solidColor:
        return 'Material.solidColor';
      case streamVideoContent:
        return 'Material.streamVideoContent';
      case surfaceContent:
        return 'Material.surfaceContent';
      case textureContent:
        return 'Material.textureContent';
      case tiledContent:
        return 'Material.tiledContent';
      case yuvVideoContent:
        return 'Material.yuvVideoContent';
    }
  }

  int toJson() => mojoEnumValue;
}

class SkXfermode extends bindings.MojoEnum {
  static const SkXfermode kClearMode = const SkXfermode._(0);
  static const SkXfermode kSrcMode = const SkXfermode._(1);
  static const SkXfermode kDstMode = const SkXfermode._(2);
  static const SkXfermode kSrcOverMode = const SkXfermode._(3);
  static const SkXfermode kDstOverMode = const SkXfermode._(4);
  static const SkXfermode kSrcInMode = const SkXfermode._(5);
  static const SkXfermode kDstInMode = const SkXfermode._(6);
  static const SkXfermode kSrcOutMode = const SkXfermode._(7);
  static const SkXfermode kDstOutMode = const SkXfermode._(8);
  static const SkXfermode kSrcATopMode = const SkXfermode._(9);
  static const SkXfermode kDstATopMode = const SkXfermode._(10);
  static const SkXfermode kXorMode = const SkXfermode._(11);
  static const SkXfermode kPlusMode = const SkXfermode._(12);
  static const SkXfermode kModulateMode = const SkXfermode._(13);
  static const SkXfermode kScreenMode = const SkXfermode._(14);
  static const SkXfermode kLastCoeffMode = const SkXfermode._(14);
  static const SkXfermode kOverlayMode = const SkXfermode._(15);
  static const SkXfermode kDarkenMode = const SkXfermode._(16);
  static const SkXfermode kLightenMode = const SkXfermode._(17);
  static const SkXfermode kColorDodgeMode = const SkXfermode._(18);
  static const SkXfermode kColorBurnMode = const SkXfermode._(19);
  static const SkXfermode kHardLightMode = const SkXfermode._(20);
  static const SkXfermode kSoftLightMode = const SkXfermode._(21);
  static const SkXfermode kDifferenceMode = const SkXfermode._(22);
  static const SkXfermode kExclusionMode = const SkXfermode._(23);
  static const SkXfermode kMultiplyMode = const SkXfermode._(24);
  static const SkXfermode kLastSeparableMode = const SkXfermode._(24);
  static const SkXfermode kHueMode = const SkXfermode._(25);
  static const SkXfermode kSaturationMode = const SkXfermode._(26);
  static const SkXfermode kColorMode = const SkXfermode._(27);
  static const SkXfermode kLuminosityMode = const SkXfermode._(28);
  static const SkXfermode kLastMode = const SkXfermode._(28);

  const SkXfermode._(int v) : super(v);

  static const Map<String, SkXfermode> valuesMap = const {
    "kClearMode": kClearMode,
    "kSrcMode": kSrcMode,
    "kDstMode": kDstMode,
    "kSrcOverMode": kSrcOverMode,
    "kDstOverMode": kDstOverMode,
    "kSrcInMode": kSrcInMode,
    "kDstInMode": kDstInMode,
    "kSrcOutMode": kSrcOutMode,
    "kDstOutMode": kDstOutMode,
    "kSrcATopMode": kSrcATopMode,
    "kDstATopMode": kDstATopMode,
    "kXorMode": kXorMode,
    "kPlusMode": kPlusMode,
    "kModulateMode": kModulateMode,
    "kScreenMode": kScreenMode,
    "kLastCoeffMode": kLastCoeffMode,
    "kOverlayMode": kOverlayMode,
    "kDarkenMode": kDarkenMode,
    "kLightenMode": kLightenMode,
    "kColorDodgeMode": kColorDodgeMode,
    "kColorBurnMode": kColorBurnMode,
    "kHardLightMode": kHardLightMode,
    "kSoftLightMode": kSoftLightMode,
    "kDifferenceMode": kDifferenceMode,
    "kExclusionMode": kExclusionMode,
    "kMultiplyMode": kMultiplyMode,
    "kLastSeparableMode": kLastSeparableMode,
    "kHueMode": kHueMode,
    "kSaturationMode": kSaturationMode,
    "kColorMode": kColorMode,
    "kLuminosityMode": kLuminosityMode,
    "kLastMode": kLastMode,
  };
  static const List<SkXfermode> values = const [
    kClearMode,
    kSrcMode,
    kDstMode,
    kSrcOverMode,
    kDstOverMode,
    kSrcInMode,
    kDstInMode,
    kSrcOutMode,
    kDstOutMode,
    kSrcATopMode,
    kDstATopMode,
    kXorMode,
    kPlusMode,
    kModulateMode,
    kScreenMode,
    kLastCoeffMode,
    kOverlayMode,
    kDarkenMode,
    kLightenMode,
    kColorDodgeMode,
    kColorBurnMode,
    kHardLightMode,
    kSoftLightMode,
    kDifferenceMode,
    kExclusionMode,
    kMultiplyMode,
    kLastSeparableMode,
    kHueMode,
    kSaturationMode,
    kColorMode,
    kLuminosityMode,
    kLastMode,
  ];

  static SkXfermode valueOf(String name) => valuesMap[name];

  factory SkXfermode(int v) {
    switch (v) {
      case 0:
        return kClearMode;
      case 1:
        return kSrcMode;
      case 2:
        return kDstMode;
      case 3:
        return kSrcOverMode;
      case 4:
        return kDstOverMode;
      case 5:
        return kSrcInMode;
      case 6:
        return kDstInMode;
      case 7:
        return kSrcOutMode;
      case 8:
        return kDstOutMode;
      case 9:
        return kSrcATopMode;
      case 10:
        return kDstATopMode;
      case 11:
        return kXorMode;
      case 12:
        return kPlusMode;
      case 13:
        return kModulateMode;
      case 14:
        return kScreenMode;
      case 14:
        return kLastCoeffMode;
      case 15:
        return kOverlayMode;
      case 16:
        return kDarkenMode;
      case 17:
        return kLightenMode;
      case 18:
        return kColorDodgeMode;
      case 19:
        return kColorBurnMode;
      case 20:
        return kHardLightMode;
      case 21:
        return kSoftLightMode;
      case 22:
        return kDifferenceMode;
      case 23:
        return kExclusionMode;
      case 24:
        return kMultiplyMode;
      case 24:
        return kLastSeparableMode;
      case 25:
        return kHueMode;
      case 26:
        return kSaturationMode;
      case 27:
        return kColorMode;
      case 28:
        return kLuminosityMode;
      case 28:
        return kLastMode;
      default:
        return null;
    }
  }

  static SkXfermode decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    SkXfermode result = new SkXfermode(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum SkXfermode.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case kClearMode:
        return 'SkXfermode.kClearMode';
      case kSrcMode:
        return 'SkXfermode.kSrcMode';
      case kDstMode:
        return 'SkXfermode.kDstMode';
      case kSrcOverMode:
        return 'SkXfermode.kSrcOverMode';
      case kDstOverMode:
        return 'SkXfermode.kDstOverMode';
      case kSrcInMode:
        return 'SkXfermode.kSrcInMode';
      case kDstInMode:
        return 'SkXfermode.kDstInMode';
      case kSrcOutMode:
        return 'SkXfermode.kSrcOutMode';
      case kDstOutMode:
        return 'SkXfermode.kDstOutMode';
      case kSrcATopMode:
        return 'SkXfermode.kSrcATopMode';
      case kDstATopMode:
        return 'SkXfermode.kDstATopMode';
      case kXorMode:
        return 'SkXfermode.kXorMode';
      case kPlusMode:
        return 'SkXfermode.kPlusMode';
      case kModulateMode:
        return 'SkXfermode.kModulateMode';
      case kScreenMode:
        return 'SkXfermode.kScreenMode';
      case kLastCoeffMode:
        return 'SkXfermode.kLastCoeffMode';
      case kOverlayMode:
        return 'SkXfermode.kOverlayMode';
      case kDarkenMode:
        return 'SkXfermode.kDarkenMode';
      case kLightenMode:
        return 'SkXfermode.kLightenMode';
      case kColorDodgeMode:
        return 'SkXfermode.kColorDodgeMode';
      case kColorBurnMode:
        return 'SkXfermode.kColorBurnMode';
      case kHardLightMode:
        return 'SkXfermode.kHardLightMode';
      case kSoftLightMode:
        return 'SkXfermode.kSoftLightMode';
      case kDifferenceMode:
        return 'SkXfermode.kDifferenceMode';
      case kExclusionMode:
        return 'SkXfermode.kExclusionMode';
      case kMultiplyMode:
        return 'SkXfermode.kMultiplyMode';
      case kLastSeparableMode:
        return 'SkXfermode.kLastSeparableMode';
      case kHueMode:
        return 'SkXfermode.kHueMode';
      case kSaturationMode:
        return 'SkXfermode.kSaturationMode';
      case kColorMode:
        return 'SkXfermode.kColorMode';
      case kLuminosityMode:
        return 'SkXfermode.kLuminosityMode';
      case kLastMode:
        return 'SkXfermode.kLastMode';
    }
  }

  int toJson() => mojoEnumValue;
}



class Color extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int rgba = 0;

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
      
      result.rgba = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(rgba, 8);
  }

  String toString() {
    return "Color("
           "rgba: $rgba" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["rgba"] = rgba;
    return map;
  }
}


class CheckerboardQuadState extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  CheckerboardQuadState() : super(kVersions.last.size);

  static CheckerboardQuadState deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static CheckerboardQuadState decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    CheckerboardQuadState result = new CheckerboardQuadState();

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
    return "CheckerboardQuadState("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class DebugBorderQuadState extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  DebugBorderQuadState() : super(kVersions.last.size);

  static DebugBorderQuadState deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static DebugBorderQuadState decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    DebugBorderQuadState result = new DebugBorderQuadState();

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
    return "DebugBorderQuadState("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class IoSurfaceContentQuadState extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  IoSurfaceContentQuadState() : super(kVersions.last.size);

  static IoSurfaceContentQuadState deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static IoSurfaceContentQuadState decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    IoSurfaceContentQuadState result = new IoSurfaceContentQuadState();

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
    return "IoSurfaceContentQuadState("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class RenderPassId extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int layerId = 0;
  int index = 0;

  RenderPassId() : super(kVersions.last.size);

  static RenderPassId deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static RenderPassId decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    RenderPassId result = new RenderPassId();

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
      
      result.layerId = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.index = decoder0.decodeInt32(12);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInt32(layerId, 8);
    
    encoder0.encodeInt32(index, 12);
  }

  String toString() {
    return "RenderPassId("
           "layerId: $layerId" ", "
           "index: $index" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["layerId"] = layerId;
    map["index"] = index;
    return map;
  }
}


class RenderPassQuadState extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(48, 0)
  ];
  RenderPassId renderPassId = null;
  int maskResourceId = 0;
  geometry_mojom.PointF maskUvScale = null;
  geometry_mojom.Size maskTextureSize = null;
  geometry_mojom.PointF filtersScale = null;

  RenderPassQuadState() : super(kVersions.last.size);

  static RenderPassQuadState deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static RenderPassQuadState decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    RenderPassQuadState result = new RenderPassQuadState();

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
      result.renderPassId = RenderPassId.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.maskResourceId = decoder0.decodeUint32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, false);
      result.maskUvScale = geometry_mojom.PointF.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(32, false);
      result.maskTextureSize = geometry_mojom.Size.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(40, false);
      result.filtersScale = geometry_mojom.PointF.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(renderPassId, 8, false);
    
    encoder0.encodeUint32(maskResourceId, 16);
    
    encoder0.encodeStruct(maskUvScale, 24, false);
    
    encoder0.encodeStruct(maskTextureSize, 32, false);
    
    encoder0.encodeStruct(filtersScale, 40, false);
  }

  String toString() {
    return "RenderPassQuadState("
           "renderPassId: $renderPassId" ", "
           "maskResourceId: $maskResourceId" ", "
           "maskUvScale: $maskUvScale" ", "
           "maskTextureSize: $maskTextureSize" ", "
           "filtersScale: $filtersScale" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["renderPassId"] = renderPassId;
    map["maskResourceId"] = maskResourceId;
    map["maskUvScale"] = maskUvScale;
    map["maskTextureSize"] = maskTextureSize;
    map["filtersScale"] = filtersScale;
    return map;
  }
}


class SolidColorQuadState extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  Color color = null;
  bool forceAntiAliasingOff = false;

  SolidColorQuadState() : super(kVersions.last.size);

  static SolidColorQuadState deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SolidColorQuadState decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SolidColorQuadState result = new SolidColorQuadState();

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
      result.color = Color.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.forceAntiAliasingOff = decoder0.decodeBool(16, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(color, 8, false);
    
    encoder0.encodeBool(forceAntiAliasingOff, 16, 0);
  }

  String toString() {
    return "SolidColorQuadState("
           "color: $color" ", "
           "forceAntiAliasingOff: $forceAntiAliasingOff" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["color"] = color;
    map["forceAntiAliasingOff"] = forceAntiAliasingOff;
    return map;
  }
}


class SurfaceQuadState extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  surface_id_mojom.SurfaceId surface = null;

  SurfaceQuadState() : super(kVersions.last.size);

  static SurfaceQuadState deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SurfaceQuadState decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SurfaceQuadState result = new SurfaceQuadState();

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
      result.surface = surface_id_mojom.SurfaceId.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(surface, 8, false);
  }

  String toString() {
    return "SurfaceQuadState("
           "surface: $surface" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["surface"] = surface;
    return map;
  }
}


class TextureQuadState extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(48, 0)
  ];
  int resourceId = 0;
  bool premultipliedAlpha = false;
  bool flipped = false;
  bool nearestNeighbor = false;
  geometry_mojom.PointF uvTopLeft = null;
  geometry_mojom.PointF uvBottomRight = null;
  Color backgroundColor = null;
  List<double> vertexOpacity = null;

  TextureQuadState() : super(kVersions.last.size);

  static TextureQuadState deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TextureQuadState decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TextureQuadState result = new TextureQuadState();

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
      
      result.resourceId = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.premultipliedAlpha = decoder0.decodeBool(12, 0);
    }
    if (mainDataHeader.version >= 0) {
      
      result.flipped = decoder0.decodeBool(12, 1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.nearestNeighbor = decoder0.decodeBool(12, 2);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.uvTopLeft = geometry_mojom.PointF.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, false);
      result.uvBottomRight = geometry_mojom.PointF.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(32, false);
      result.backgroundColor = Color.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.vertexOpacity = decoder0.decodeFloatArray(40, bindings.kNothingNullable, 4);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(resourceId, 8);
    
    encoder0.encodeBool(premultipliedAlpha, 12, 0);
    
    encoder0.encodeBool(flipped, 12, 1);
    
    encoder0.encodeBool(nearestNeighbor, 12, 2);
    
    encoder0.encodeStruct(uvTopLeft, 16, false);
    
    encoder0.encodeStruct(uvBottomRight, 24, false);
    
    encoder0.encodeStruct(backgroundColor, 32, false);
    
    encoder0.encodeFloatArray(vertexOpacity, 40, bindings.kNothingNullable, 4);
  }

  String toString() {
    return "TextureQuadState("
           "resourceId: $resourceId" ", "
           "premultipliedAlpha: $premultipliedAlpha" ", "
           "flipped: $flipped" ", "
           "nearestNeighbor: $nearestNeighbor" ", "
           "uvTopLeft: $uvTopLeft" ", "
           "uvBottomRight: $uvBottomRight" ", "
           "backgroundColor: $backgroundColor" ", "
           "vertexOpacity: $vertexOpacity" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["resourceId"] = resourceId;
    map["premultipliedAlpha"] = premultipliedAlpha;
    map["flipped"] = flipped;
    map["nearestNeighbor"] = nearestNeighbor;
    map["uvTopLeft"] = uvTopLeft;
    map["uvBottomRight"] = uvBottomRight;
    map["backgroundColor"] = backgroundColor;
    map["vertexOpacity"] = vertexOpacity;
    return map;
  }
}


class TileQuadState extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  geometry_mojom.RectF texCoordRect = null;
  geometry_mojom.Size textureSize = null;
  bool swizzleContents = false;
  bool nearestNeighbor = false;
  int resourceId = 0;

  TileQuadState() : super(kVersions.last.size);

  static TileQuadState deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TileQuadState decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TileQuadState result = new TileQuadState();

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
      result.texCoordRect = geometry_mojom.RectF.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.textureSize = geometry_mojom.Size.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.swizzleContents = decoder0.decodeBool(24, 0);
    }
    if (mainDataHeader.version >= 0) {
      
      result.nearestNeighbor = decoder0.decodeBool(24, 1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.resourceId = decoder0.decodeUint32(28);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(texCoordRect, 8, false);
    
    encoder0.encodeStruct(textureSize, 16, false);
    
    encoder0.encodeBool(swizzleContents, 24, 0);
    
    encoder0.encodeBool(nearestNeighbor, 24, 1);
    
    encoder0.encodeUint32(resourceId, 28);
  }

  String toString() {
    return "TileQuadState("
           "texCoordRect: $texCoordRect" ", "
           "textureSize: $textureSize" ", "
           "swizzleContents: $swizzleContents" ", "
           "nearestNeighbor: $nearestNeighbor" ", "
           "resourceId: $resourceId" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["texCoordRect"] = texCoordRect;
    map["textureSize"] = textureSize;
    map["swizzleContents"] = swizzleContents;
    map["nearestNeighbor"] = nearestNeighbor;
    map["resourceId"] = resourceId;
    return map;
  }
}


class StreamVideoQuadState extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  StreamVideoQuadState() : super(kVersions.last.size);

  static StreamVideoQuadState deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static StreamVideoQuadState decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    StreamVideoQuadState result = new StreamVideoQuadState();

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
    return "StreamVideoQuadState("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class YuvVideoQuadState extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(40, 0)
  ];
  geometry_mojom.RectF texCoordRect = null;
  int yPlaneResourceId = 0;
  int uPlaneResourceId = 0;
  int vPlaneResourceId = 0;
  int aPlaneResourceId = 0;
  YuvColorSpace colorSpace = null;

  YuvVideoQuadState() : super(kVersions.last.size);

  static YuvVideoQuadState deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static YuvVideoQuadState decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    YuvVideoQuadState result = new YuvVideoQuadState();

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
      result.texCoordRect = geometry_mojom.RectF.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.yPlaneResourceId = decoder0.decodeUint32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.uPlaneResourceId = decoder0.decodeUint32(20);
    }
    if (mainDataHeader.version >= 0) {
      
      result.vPlaneResourceId = decoder0.decodeUint32(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.aPlaneResourceId = decoder0.decodeUint32(28);
    }
    if (mainDataHeader.version >= 0) {
      
        result.colorSpace = YuvColorSpace.decode(decoder0, 32);
        if (result.colorSpace == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable YuvColorSpace.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(texCoordRect, 8, false);
    
    encoder0.encodeUint32(yPlaneResourceId, 16);
    
    encoder0.encodeUint32(uPlaneResourceId, 20);
    
    encoder0.encodeUint32(vPlaneResourceId, 24);
    
    encoder0.encodeUint32(aPlaneResourceId, 28);
    
    encoder0.encodeEnum(colorSpace, 32);
  }

  String toString() {
    return "YuvVideoQuadState("
           "texCoordRect: $texCoordRect" ", "
           "yPlaneResourceId: $yPlaneResourceId" ", "
           "uPlaneResourceId: $uPlaneResourceId" ", "
           "vPlaneResourceId: $vPlaneResourceId" ", "
           "aPlaneResourceId: $aPlaneResourceId" ", "
           "colorSpace: $colorSpace" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["texCoordRect"] = texCoordRect;
    map["yPlaneResourceId"] = yPlaneResourceId;
    map["uPlaneResourceId"] = uPlaneResourceId;
    map["vPlaneResourceId"] = vPlaneResourceId;
    map["aPlaneResourceId"] = aPlaneResourceId;
    map["colorSpace"] = colorSpace;
    return map;
  }
}


class Quad extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(128, 0)
  ];
  Material material = null;
  bool needsBlending = false;
  geometry_mojom.Rect rect = null;
  geometry_mojom.Rect opaqueRect = null;
  geometry_mojom.Rect visibleRect = null;
  int sharedQuadStateIndex = 0;
  CheckerboardQuadState checkerboardQuadState = null;
  DebugBorderQuadState debugBorderQuadState = null;
  IoSurfaceContentQuadState ioSurfaceQuadState = null;
  RenderPassQuadState renderPassQuadState = null;
  SolidColorQuadState solidColorQuadState = null;
  SurfaceQuadState surfaceQuadState = null;
  TextureQuadState textureQuadState = null;
  TileQuadState tileQuadState = null;
  StreamVideoQuadState streamVideoQuadState = null;
  YuvVideoQuadState yuvVideoQuadState = null;

  Quad() : super(kVersions.last.size);

  static Quad deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Quad decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Quad result = new Quad();

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
      
        result.material = Material.decode(decoder0, 8);
        if (result.material == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable Material.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.needsBlending = decoder0.decodeBool(12, 0);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.rect = geometry_mojom.Rect.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, false);
      result.opaqueRect = geometry_mojom.Rect.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(32, false);
      result.visibleRect = geometry_mojom.Rect.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.sharedQuadStateIndex = decoder0.decodeUint32(40);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(48, true);
      result.checkerboardQuadState = CheckerboardQuadState.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(56, true);
      result.debugBorderQuadState = DebugBorderQuadState.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(64, true);
      result.ioSurfaceQuadState = IoSurfaceContentQuadState.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(72, true);
      result.renderPassQuadState = RenderPassQuadState.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(80, true);
      result.solidColorQuadState = SolidColorQuadState.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(88, true);
      result.surfaceQuadState = SurfaceQuadState.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(96, true);
      result.textureQuadState = TextureQuadState.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(104, true);
      result.tileQuadState = TileQuadState.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(112, true);
      result.streamVideoQuadState = StreamVideoQuadState.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(120, true);
      result.yuvVideoQuadState = YuvVideoQuadState.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(material, 8);
    
    encoder0.encodeBool(needsBlending, 12, 0);
    
    encoder0.encodeStruct(rect, 16, false);
    
    encoder0.encodeStruct(opaqueRect, 24, false);
    
    encoder0.encodeStruct(visibleRect, 32, false);
    
    encoder0.encodeUint32(sharedQuadStateIndex, 40);
    
    encoder0.encodeStruct(checkerboardQuadState, 48, true);
    
    encoder0.encodeStruct(debugBorderQuadState, 56, true);
    
    encoder0.encodeStruct(ioSurfaceQuadState, 64, true);
    
    encoder0.encodeStruct(renderPassQuadState, 72, true);
    
    encoder0.encodeStruct(solidColorQuadState, 80, true);
    
    encoder0.encodeStruct(surfaceQuadState, 88, true);
    
    encoder0.encodeStruct(textureQuadState, 96, true);
    
    encoder0.encodeStruct(tileQuadState, 104, true);
    
    encoder0.encodeStruct(streamVideoQuadState, 112, true);
    
    encoder0.encodeStruct(yuvVideoQuadState, 120, true);
  }

  String toString() {
    return "Quad("
           "material: $material" ", "
           "needsBlending: $needsBlending" ", "
           "rect: $rect" ", "
           "opaqueRect: $opaqueRect" ", "
           "visibleRect: $visibleRect" ", "
           "sharedQuadStateIndex: $sharedQuadStateIndex" ", "
           "checkerboardQuadState: $checkerboardQuadState" ", "
           "debugBorderQuadState: $debugBorderQuadState" ", "
           "ioSurfaceQuadState: $ioSurfaceQuadState" ", "
           "renderPassQuadState: $renderPassQuadState" ", "
           "solidColorQuadState: $solidColorQuadState" ", "
           "surfaceQuadState: $surfaceQuadState" ", "
           "textureQuadState: $textureQuadState" ", "
           "tileQuadState: $tileQuadState" ", "
           "streamVideoQuadState: $streamVideoQuadState" ", "
           "yuvVideoQuadState: $yuvVideoQuadState" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["material"] = material;
    map["needsBlending"] = needsBlending;
    map["rect"] = rect;
    map["opaqueRect"] = opaqueRect;
    map["visibleRect"] = visibleRect;
    map["sharedQuadStateIndex"] = sharedQuadStateIndex;
    map["checkerboardQuadState"] = checkerboardQuadState;
    map["debugBorderQuadState"] = debugBorderQuadState;
    map["ioSurfaceQuadState"] = ioSurfaceQuadState;
    map["renderPassQuadState"] = renderPassQuadState;
    map["solidColorQuadState"] = solidColorQuadState;
    map["surfaceQuadState"] = surfaceQuadState;
    map["textureQuadState"] = textureQuadState;
    map["tileQuadState"] = tileQuadState;
    map["streamVideoQuadState"] = streamVideoQuadState;
    map["yuvVideoQuadState"] = yuvVideoQuadState;
    return map;
  }
}


class SharedQuadState extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(56, 0)
  ];
  geometry_mojom.Transform contentToTargetTransform = null;
  geometry_mojom.Size contentBounds = null;
  geometry_mojom.Rect visibleContentRect = null;
  geometry_mojom.Rect clipRect = null;
  bool isClipped = false;
  double opacity = 0.0;
  SkXfermode blendMode = null;
  int sortingContextId = 0;

  SharedQuadState() : super(kVersions.last.size);

  static SharedQuadState deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SharedQuadState decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SharedQuadState result = new SharedQuadState();

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
      result.contentToTargetTransform = geometry_mojom.Transform.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.contentBounds = geometry_mojom.Size.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, false);
      result.visibleContentRect = geometry_mojom.Rect.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(32, false);
      result.clipRect = geometry_mojom.Rect.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.isClipped = decoder0.decodeBool(40, 0);
    }
    if (mainDataHeader.version >= 0) {
      
      result.opacity = decoder0.decodeFloat(44);
    }
    if (mainDataHeader.version >= 0) {
      
        result.blendMode = SkXfermode.decode(decoder0, 48);
        if (result.blendMode == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable SkXfermode.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.sortingContextId = decoder0.decodeInt32(52);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(contentToTargetTransform, 8, false);
    
    encoder0.encodeStruct(contentBounds, 16, false);
    
    encoder0.encodeStruct(visibleContentRect, 24, false);
    
    encoder0.encodeStruct(clipRect, 32, false);
    
    encoder0.encodeBool(isClipped, 40, 0);
    
    encoder0.encodeFloat(opacity, 44);
    
    encoder0.encodeEnum(blendMode, 48);
    
    encoder0.encodeInt32(sortingContextId, 52);
  }

  String toString() {
    return "SharedQuadState("
           "contentToTargetTransform: $contentToTargetTransform" ", "
           "contentBounds: $contentBounds" ", "
           "visibleContentRect: $visibleContentRect" ", "
           "clipRect: $clipRect" ", "
           "isClipped: $isClipped" ", "
           "opacity: $opacity" ", "
           "blendMode: $blendMode" ", "
           "sortingContextId: $sortingContextId" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["contentToTargetTransform"] = contentToTargetTransform;
    map["contentBounds"] = contentBounds;
    map["visibleContentRect"] = visibleContentRect;
    map["clipRect"] = clipRect;
    map["isClipped"] = isClipped;
    map["opacity"] = opacity;
    map["blendMode"] = blendMode;
    map["sortingContextId"] = sortingContextId;
    return map;
  }
}


class Pass extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(56, 0)
  ];
  int id = 0;
  bool hasTransparentBackground = false;
  geometry_mojom.Rect outputRect = null;
  geometry_mojom.Rect damageRect = null;
  geometry_mojom.Transform transformToRootTarget = null;
  List<Quad> quads = null;
  List<SharedQuadState> sharedQuadStates = null;

  Pass() : super(kVersions.last.size);

  static Pass deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Pass decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Pass result = new Pass();

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
      
      result.hasTransparentBackground = decoder0.decodeBool(12, 0);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.outputRect = geometry_mojom.Rect.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, false);
      result.damageRect = geometry_mojom.Rect.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(32, false);
      result.transformToRootTarget = geometry_mojom.Transform.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(40, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.quads = new List<Quad>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.quads[i1] = Quad.decode(decoder2);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(48, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.sharedQuadStates = new List<SharedQuadState>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.sharedQuadStates[i1] = SharedQuadState.decode(decoder2);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInt32(id, 8);
    
    encoder0.encodeBool(hasTransparentBackground, 12, 0);
    
    encoder0.encodeStruct(outputRect, 16, false);
    
    encoder0.encodeStruct(damageRect, 24, false);
    
    encoder0.encodeStruct(transformToRootTarget, 32, false);
    
    if (quads == null) {
      encoder0.encodeNullPointer(40, false);
    } else {
      var encoder1 = encoder0.encodePointerArray(quads.length, 40, bindings.kUnspecifiedArrayLength);
      for (int i0 = 0; i0 < quads.length; ++i0) {
        
        encoder1.encodeStruct(quads[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
      }
    }
    
    if (sharedQuadStates == null) {
      encoder0.encodeNullPointer(48, false);
    } else {
      var encoder1 = encoder0.encodePointerArray(sharedQuadStates.length, 48, bindings.kUnspecifiedArrayLength);
      for (int i0 = 0; i0 < sharedQuadStates.length; ++i0) {
        
        encoder1.encodeStruct(sharedQuadStates[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
      }
    }
  }

  String toString() {
    return "Pass("
           "id: $id" ", "
           "hasTransparentBackground: $hasTransparentBackground" ", "
           "outputRect: $outputRect" ", "
           "damageRect: $damageRect" ", "
           "transformToRootTarget: $transformToRootTarget" ", "
           "quads: $quads" ", "
           "sharedQuadStates: $sharedQuadStates" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["id"] = id;
    map["hasTransparentBackground"] = hasTransparentBackground;
    map["outputRect"] = outputRect;
    map["damageRect"] = damageRect;
    map["transformToRootTarget"] = transformToRootTarget;
    map["quads"] = quads;
    map["sharedQuadStates"] = sharedQuadStates;
    return map;
  }
}


