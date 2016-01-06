// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library media_types_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;

class MediaTypeScheme extends bindings.MojoEnum {
  static const MediaTypeScheme unknown = const MediaTypeScheme._(0);
  static const MediaTypeScheme none = const MediaTypeScheme._(1);
  static const MediaTypeScheme anyElementary = const MediaTypeScheme._(2);
  static const MediaTypeScheme anyAudio = const MediaTypeScheme._(3);
  static const MediaTypeScheme anyVideo = const MediaTypeScheme._(4);
  static const MediaTypeScheme anySubpicture = const MediaTypeScheme._(5);
  static const MediaTypeScheme anyText = const MediaTypeScheme._(6);
  static const MediaTypeScheme anyMultiplexed = const MediaTypeScheme._(7);
  static const MediaTypeScheme any = const MediaTypeScheme._(8);
  static const MediaTypeScheme multiplexed = const MediaTypeScheme._(9);
  static const MediaTypeScheme lpcm = const MediaTypeScheme._(10);
  static const MediaTypeScheme compressedAudio = const MediaTypeScheme._(11);
  static const MediaTypeScheme video = const MediaTypeScheme._(12);

  const MediaTypeScheme._(int v) : super(v);

  static const Map<String, MediaTypeScheme> valuesMap = const {
    "unknown": unknown,
    "none": none,
    "anyElementary": anyElementary,
    "anyAudio": anyAudio,
    "anyVideo": anyVideo,
    "anySubpicture": anySubpicture,
    "anyText": anyText,
    "anyMultiplexed": anyMultiplexed,
    "any": any,
    "multiplexed": multiplexed,
    "lpcm": lpcm,
    "compressedAudio": compressedAudio,
    "video": video,
  };
  static const List<MediaTypeScheme> values = const [
    unknown,
    none,
    anyElementary,
    anyAudio,
    anyVideo,
    anySubpicture,
    anyText,
    anyMultiplexed,
    any,
    multiplexed,
    lpcm,
    compressedAudio,
    video,
  ];

  static MediaTypeScheme valueOf(String name) => valuesMap[name];

  factory MediaTypeScheme(int v) {
    switch (v) {
      case 0:
        return unknown;
      case 1:
        return none;
      case 2:
        return anyElementary;
      case 3:
        return anyAudio;
      case 4:
        return anyVideo;
      case 5:
        return anySubpicture;
      case 6:
        return anyText;
      case 7:
        return anyMultiplexed;
      case 8:
        return any;
      case 9:
        return multiplexed;
      case 10:
        return lpcm;
      case 11:
        return compressedAudio;
      case 12:
        return video;
      default:
        return null;
    }
  }

  static MediaTypeScheme decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    MediaTypeScheme result = new MediaTypeScheme(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum MediaTypeScheme.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case unknown:
        return 'MediaTypeScheme.unknown';
      case none:
        return 'MediaTypeScheme.none';
      case anyElementary:
        return 'MediaTypeScheme.anyElementary';
      case anyAudio:
        return 'MediaTypeScheme.anyAudio';
      case anyVideo:
        return 'MediaTypeScheme.anyVideo';
      case anySubpicture:
        return 'MediaTypeScheme.anySubpicture';
      case anyText:
        return 'MediaTypeScheme.anyText';
      case anyMultiplexed:
        return 'MediaTypeScheme.anyMultiplexed';
      case any:
        return 'MediaTypeScheme.any';
      case multiplexed:
        return 'MediaTypeScheme.multiplexed';
      case lpcm:
        return 'MediaTypeScheme.lpcm';
      case compressedAudio:
        return 'MediaTypeScheme.compressedAudio';
      case video:
        return 'MediaTypeScheme.video';
    }
  }

  int toJson() => mojoEnumValue;
}

class LpcmSampleFormat extends bindings.MojoEnum {
  static const LpcmSampleFormat unknown = const LpcmSampleFormat._(0);
  static const LpcmSampleFormat any = const LpcmSampleFormat._(1);
  static const LpcmSampleFormat unsigned8 = const LpcmSampleFormat._(2);
  static const LpcmSampleFormat signed16 = const LpcmSampleFormat._(3);
  static const LpcmSampleFormat signed24In32 = const LpcmSampleFormat._(4);
  static const LpcmSampleFormat float = const LpcmSampleFormat._(5);

  const LpcmSampleFormat._(int v) : super(v);

  static const Map<String, LpcmSampleFormat> valuesMap = const {
    "unknown": unknown,
    "any": any,
    "unsigned8": unsigned8,
    "signed16": signed16,
    "signed24In32": signed24In32,
    "float": float,
  };
  static const List<LpcmSampleFormat> values = const [
    unknown,
    any,
    unsigned8,
    signed16,
    signed24In32,
    float,
  ];

  static LpcmSampleFormat valueOf(String name) => valuesMap[name];

  factory LpcmSampleFormat(int v) {
    switch (v) {
      case 0:
        return unknown;
      case 1:
        return any;
      case 2:
        return unsigned8;
      case 3:
        return signed16;
      case 4:
        return signed24In32;
      case 5:
        return float;
      default:
        return null;
    }
  }

  static LpcmSampleFormat decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    LpcmSampleFormat result = new LpcmSampleFormat(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum LpcmSampleFormat.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case unknown:
        return 'LpcmSampleFormat.unknown';
      case any:
        return 'LpcmSampleFormat.any';
      case unsigned8:
        return 'LpcmSampleFormat.unsigned8';
      case signed16:
        return 'LpcmSampleFormat.signed16';
      case signed24In32:
        return 'LpcmSampleFormat.signed24In32';
      case float:
        return 'LpcmSampleFormat.float';
    }
  }

  int toJson() => mojoEnumValue;
}

class AudioEncoding extends bindings.MojoEnum {
  static const AudioEncoding unknown = const AudioEncoding._(0);
  static const AudioEncoding any = const AudioEncoding._(1);
  static const AudioEncoding vorbis = const AudioEncoding._(2);

  const AudioEncoding._(int v) : super(v);

  static const Map<String, AudioEncoding> valuesMap = const {
    "unknown": unknown,
    "any": any,
    "vorbis": vorbis,
  };
  static const List<AudioEncoding> values = const [
    unknown,
    any,
    vorbis,
  ];

  static AudioEncoding valueOf(String name) => valuesMap[name];

  factory AudioEncoding(int v) {
    switch (v) {
      case 0:
        return unknown;
      case 1:
        return any;
      case 2:
        return vorbis;
      default:
        return null;
    }
  }

  static AudioEncoding decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    AudioEncoding result = new AudioEncoding(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum AudioEncoding.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case unknown:
        return 'AudioEncoding.unknown';
      case any:
        return 'AudioEncoding.any';
      case vorbis:
        return 'AudioEncoding.vorbis';
    }
  }

  int toJson() => mojoEnumValue;
}

class VideoEncoding extends bindings.MojoEnum {
  static const VideoEncoding unknown = const VideoEncoding._(0);
  static const VideoEncoding any = const VideoEncoding._(1);
  static const VideoEncoding theora = const VideoEncoding._(2);
  static const VideoEncoding vp8 = const VideoEncoding._(3);

  const VideoEncoding._(int v) : super(v);

  static const Map<String, VideoEncoding> valuesMap = const {
    "unknown": unknown,
    "any": any,
    "theora": theora,
    "vp8": vp8,
  };
  static const List<VideoEncoding> values = const [
    unknown,
    any,
    theora,
    vp8,
  ];

  static VideoEncoding valueOf(String name) => valuesMap[name];

  factory VideoEncoding(int v) {
    switch (v) {
      case 0:
        return unknown;
      case 1:
        return any;
      case 2:
        return theora;
      case 3:
        return vp8;
      default:
        return null;
    }
  }

  static VideoEncoding decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    VideoEncoding result = new VideoEncoding(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum VideoEncoding.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case unknown:
        return 'VideoEncoding.unknown';
      case any:
        return 'VideoEncoding.any';
      case theora:
        return 'VideoEncoding.theora';
      case vp8:
        return 'VideoEncoding.vp8';
    }
  }

  int toJson() => mojoEnumValue;
}

class VideoProfile extends bindings.MojoEnum {
  static const VideoProfile unknown = const VideoProfile._(0);
  static const VideoProfile notApplicable = const VideoProfile._(1);
  static const VideoProfile h264Baseline = const VideoProfile._(2);
  static const VideoProfile h264Main = const VideoProfile._(3);
  static const VideoProfile h264Extended = const VideoProfile._(4);
  static const VideoProfile h264High = const VideoProfile._(5);
  static const VideoProfile h264High10 = const VideoProfile._(6);
  static const VideoProfile h264High422 = const VideoProfile._(7);
  static const VideoProfile h264High444Predictive = const VideoProfile._(8);
  static const VideoProfile h264ScalableBaseline = const VideoProfile._(9);
  static const VideoProfile h264ScalableHigh = const VideoProfile._(10);
  static const VideoProfile h264StereoHigh = const VideoProfile._(11);
  static const VideoProfile h264MultiviewHigh = const VideoProfile._(12);

  const VideoProfile._(int v) : super(v);

  static const Map<String, VideoProfile> valuesMap = const {
    "unknown": unknown,
    "notApplicable": notApplicable,
    "h264Baseline": h264Baseline,
    "h264Main": h264Main,
    "h264Extended": h264Extended,
    "h264High": h264High,
    "h264High10": h264High10,
    "h264High422": h264High422,
    "h264High444Predictive": h264High444Predictive,
    "h264ScalableBaseline": h264ScalableBaseline,
    "h264ScalableHigh": h264ScalableHigh,
    "h264StereoHigh": h264StereoHigh,
    "h264MultiviewHigh": h264MultiviewHigh,
  };
  static const List<VideoProfile> values = const [
    unknown,
    notApplicable,
    h264Baseline,
    h264Main,
    h264Extended,
    h264High,
    h264High10,
    h264High422,
    h264High444Predictive,
    h264ScalableBaseline,
    h264ScalableHigh,
    h264StereoHigh,
    h264MultiviewHigh,
  ];

  static VideoProfile valueOf(String name) => valuesMap[name];

  factory VideoProfile(int v) {
    switch (v) {
      case 0:
        return unknown;
      case 1:
        return notApplicable;
      case 2:
        return h264Baseline;
      case 3:
        return h264Main;
      case 4:
        return h264Extended;
      case 5:
        return h264High;
      case 6:
        return h264High10;
      case 7:
        return h264High422;
      case 8:
        return h264High444Predictive;
      case 9:
        return h264ScalableBaseline;
      case 10:
        return h264ScalableHigh;
      case 11:
        return h264StereoHigh;
      case 12:
        return h264MultiviewHigh;
      default:
        return null;
    }
  }

  static VideoProfile decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    VideoProfile result = new VideoProfile(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum VideoProfile.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case unknown:
        return 'VideoProfile.unknown';
      case notApplicable:
        return 'VideoProfile.notApplicable';
      case h264Baseline:
        return 'VideoProfile.h264Baseline';
      case h264Main:
        return 'VideoProfile.h264Main';
      case h264Extended:
        return 'VideoProfile.h264Extended';
      case h264High:
        return 'VideoProfile.h264High';
      case h264High10:
        return 'VideoProfile.h264High10';
      case h264High422:
        return 'VideoProfile.h264High422';
      case h264High444Predictive:
        return 'VideoProfile.h264High444Predictive';
      case h264ScalableBaseline:
        return 'VideoProfile.h264ScalableBaseline';
      case h264ScalableHigh:
        return 'VideoProfile.h264ScalableHigh';
      case h264StereoHigh:
        return 'VideoProfile.h264StereoHigh';
      case h264MultiviewHigh:
        return 'VideoProfile.h264MultiviewHigh';
    }
  }

  int toJson() => mojoEnumValue;
}

class PixelFormat extends bindings.MojoEnum {
  static const PixelFormat unknown = const PixelFormat._(0);
  static const PixelFormat i420 = const PixelFormat._(1);
  static const PixelFormat yv12 = const PixelFormat._(2);
  static const PixelFormat yv16 = const PixelFormat._(3);
  static const PixelFormat yv12A = const PixelFormat._(4);
  static const PixelFormat yv24 = const PixelFormat._(5);
  static const PixelFormat nv12 = const PixelFormat._(6);
  static const PixelFormat nv21 = const PixelFormat._(7);
  static const PixelFormat uyvy = const PixelFormat._(8);
  static const PixelFormat yuy2 = const PixelFormat._(9);
  static const PixelFormat argb = const PixelFormat._(10);
  static const PixelFormat xrgb = const PixelFormat._(11);
  static const PixelFormat rgb24 = const PixelFormat._(12);
  static const PixelFormat rgb32 = const PixelFormat._(13);
  static const PixelFormat mjpeg = const PixelFormat._(14);
  static const PixelFormat mt21 = const PixelFormat._(15);

  const PixelFormat._(int v) : super(v);

  static const Map<String, PixelFormat> valuesMap = const {
    "unknown": unknown,
    "i420": i420,
    "yv12": yv12,
    "yv16": yv16,
    "yv12A": yv12A,
    "yv24": yv24,
    "nv12": nv12,
    "nv21": nv21,
    "uyvy": uyvy,
    "yuy2": yuy2,
    "argb": argb,
    "xrgb": xrgb,
    "rgb24": rgb24,
    "rgb32": rgb32,
    "mjpeg": mjpeg,
    "mt21": mt21,
  };
  static const List<PixelFormat> values = const [
    unknown,
    i420,
    yv12,
    yv16,
    yv12A,
    yv24,
    nv12,
    nv21,
    uyvy,
    yuy2,
    argb,
    xrgb,
    rgb24,
    rgb32,
    mjpeg,
    mt21,
  ];

  static PixelFormat valueOf(String name) => valuesMap[name];

  factory PixelFormat(int v) {
    switch (v) {
      case 0:
        return unknown;
      case 1:
        return i420;
      case 2:
        return yv12;
      case 3:
        return yv16;
      case 4:
        return yv12A;
      case 5:
        return yv24;
      case 6:
        return nv12;
      case 7:
        return nv21;
      case 8:
        return uyvy;
      case 9:
        return yuy2;
      case 10:
        return argb;
      case 11:
        return xrgb;
      case 12:
        return rgb24;
      case 13:
        return rgb32;
      case 14:
        return mjpeg;
      case 15:
        return mt21;
      default:
        return null;
    }
  }

  static PixelFormat decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    PixelFormat result = new PixelFormat(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum PixelFormat.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case unknown:
        return 'PixelFormat.unknown';
      case i420:
        return 'PixelFormat.i420';
      case yv12:
        return 'PixelFormat.yv12';
      case yv16:
        return 'PixelFormat.yv16';
      case yv12A:
        return 'PixelFormat.yv12A';
      case yv24:
        return 'PixelFormat.yv24';
      case nv12:
        return 'PixelFormat.nv12';
      case nv21:
        return 'PixelFormat.nv21';
      case uyvy:
        return 'PixelFormat.uyvy';
      case yuy2:
        return 'PixelFormat.yuy2';
      case argb:
        return 'PixelFormat.argb';
      case xrgb:
        return 'PixelFormat.xrgb';
      case rgb24:
        return 'PixelFormat.rgb24';
      case rgb32:
        return 'PixelFormat.rgb32';
      case mjpeg:
        return 'PixelFormat.mjpeg';
      case mt21:
        return 'PixelFormat.mt21';
    }
  }

  int toJson() => mojoEnumValue;
}

class ColorSpace extends bindings.MojoEnum {
  static const ColorSpace unknown = const ColorSpace._(0);
  static const ColorSpace notApplicable = const ColorSpace._(1);
  static const ColorSpace jpeg = const ColorSpace._(2);
  static const ColorSpace hdRec709 = const ColorSpace._(3);
  static const ColorSpace sdRec601 = const ColorSpace._(4);

  const ColorSpace._(int v) : super(v);

  static const Map<String, ColorSpace> valuesMap = const {
    "unknown": unknown,
    "notApplicable": notApplicable,
    "jpeg": jpeg,
    "hdRec709": hdRec709,
    "sdRec601": sdRec601,
  };
  static const List<ColorSpace> values = const [
    unknown,
    notApplicable,
    jpeg,
    hdRec709,
    sdRec601,
  ];

  static ColorSpace valueOf(String name) => valuesMap[name];

  factory ColorSpace(int v) {
    switch (v) {
      case 0:
        return unknown;
      case 1:
        return notApplicable;
      case 2:
        return jpeg;
      case 3:
        return hdRec709;
      case 4:
        return sdRec601;
      default:
        return null;
    }
  }

  static ColorSpace decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    ColorSpace result = new ColorSpace(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum ColorSpace.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case unknown:
        return 'ColorSpace.unknown';
      case notApplicable:
        return 'ColorSpace.notApplicable';
      case jpeg:
        return 'ColorSpace.jpeg';
      case hdRec709:
        return 'ColorSpace.hdRec709';
      case sdRec601:
        return 'ColorSpace.sdRec601';
    }
  }

  int toJson() => mojoEnumValue;
}



class MediaType extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  MediaTypeScheme scheme = null;
  MediaTypeDetails details = null;

  MediaType() : super(kVersions.last.size);

  static MediaType deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaType decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaType result = new MediaType();

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
      
        result.scheme = MediaTypeScheme.decode(decoder0, 8);
        if (result.scheme == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable MediaTypeScheme.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
        result.details = MediaTypeDetails.decode(decoder0, 16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(scheme, 8);
    
    encoder0.encodeUnion(details, 16, true);
  }

  String toString() {
    return "MediaType("
           "scheme: $scheme" ", "
           "details: $details" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["scheme"] = scheme;
    map["details"] = details;
    return map;
  }
}


class MediaTypeSet extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  MediaTypeScheme scheme = null;
  MediaTypeSetDetails details = null;

  MediaTypeSet() : super(kVersions.last.size);

  static MediaTypeSet deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaTypeSet decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaTypeSet result = new MediaTypeSet();

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
      
        result.scheme = MediaTypeScheme.decode(decoder0, 8);
        if (result.scheme == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable MediaTypeScheme.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
        result.details = MediaTypeSetDetails.decode(decoder0, 16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(scheme, 8);
    
    encoder0.encodeUnion(details, 16, true);
  }

  String toString() {
    return "MediaTypeSet("
           "scheme: $scheme" ", "
           "details: $details" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["scheme"] = scheme;
    map["details"] = details;
    return map;
  }
}


class LpcmMediaTypeDetails extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  LpcmSampleFormat sampleFormat = null;
  int channels = 0;
  int framesPerSecond = 0;

  LpcmMediaTypeDetails() : super(kVersions.last.size);

  static LpcmMediaTypeDetails deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static LpcmMediaTypeDetails decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    LpcmMediaTypeDetails result = new LpcmMediaTypeDetails();

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
      
        result.sampleFormat = LpcmSampleFormat.decode(decoder0, 8);
        if (result.sampleFormat == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable LpcmSampleFormat.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.channels = decoder0.decodeUint32(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.framesPerSecond = decoder0.decodeUint32(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(sampleFormat, 8);
    
    encoder0.encodeUint32(channels, 12);
    
    encoder0.encodeUint32(framesPerSecond, 16);
  }

  String toString() {
    return "LpcmMediaTypeDetails("
           "sampleFormat: $sampleFormat" ", "
           "channels: $channels" ", "
           "framesPerSecond: $framesPerSecond" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["sampleFormat"] = sampleFormat;
    map["channels"] = channels;
    map["framesPerSecond"] = framesPerSecond;
    return map;
  }
}


class LpcmMediaTypeSetDetails extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  LpcmSampleFormat sampleFormat = null;
  int minChannels = 0;
  int maxChannels = 0;
  int minFramesPerSecond = 0;
  int maxFramesPerSecond = 0;

  LpcmMediaTypeSetDetails() : super(kVersions.last.size);

  static LpcmMediaTypeSetDetails deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static LpcmMediaTypeSetDetails decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    LpcmMediaTypeSetDetails result = new LpcmMediaTypeSetDetails();

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
      
        result.sampleFormat = LpcmSampleFormat.decode(decoder0, 8);
        if (result.sampleFormat == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable LpcmSampleFormat.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.minChannels = decoder0.decodeUint32(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.maxChannels = decoder0.decodeUint32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.minFramesPerSecond = decoder0.decodeUint32(20);
    }
    if (mainDataHeader.version >= 0) {
      
      result.maxFramesPerSecond = decoder0.decodeUint32(24);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(sampleFormat, 8);
    
    encoder0.encodeUint32(minChannels, 12);
    
    encoder0.encodeUint32(maxChannels, 16);
    
    encoder0.encodeUint32(minFramesPerSecond, 20);
    
    encoder0.encodeUint32(maxFramesPerSecond, 24);
  }

  String toString() {
    return "LpcmMediaTypeSetDetails("
           "sampleFormat: $sampleFormat" ", "
           "minChannels: $minChannels" ", "
           "maxChannels: $maxChannels" ", "
           "minFramesPerSecond: $minFramesPerSecond" ", "
           "maxFramesPerSecond: $maxFramesPerSecond" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["sampleFormat"] = sampleFormat;
    map["minChannels"] = minChannels;
    map["maxChannels"] = maxChannels;
    map["minFramesPerSecond"] = minFramesPerSecond;
    map["maxFramesPerSecond"] = maxFramesPerSecond;
    return map;
  }
}


class MultiplexedMediaTypeDetails extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  MediaType multiplexType = null;
  List<MediaType> substreamTypes = null;

  MultiplexedMediaTypeDetails() : super(kVersions.last.size);

  static MultiplexedMediaTypeDetails deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MultiplexedMediaTypeDetails decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MultiplexedMediaTypeDetails result = new MultiplexedMediaTypeDetails();

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
      result.multiplexType = MediaType.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.substreamTypes = new List<MediaType>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.substreamTypes[i1] = MediaType.decode(decoder2);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(multiplexType, 8, false);
    
    if (substreamTypes == null) {
      encoder0.encodeNullPointer(16, false);
    } else {
      var encoder1 = encoder0.encodePointerArray(substreamTypes.length, 16, bindings.kUnspecifiedArrayLength);
      for (int i0 = 0; i0 < substreamTypes.length; ++i0) {
        
        encoder1.encodeStruct(substreamTypes[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
      }
    }
  }

  String toString() {
    return "MultiplexedMediaTypeDetails("
           "multiplexType: $multiplexType" ", "
           "substreamTypes: $substreamTypes" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["multiplexType"] = multiplexType;
    map["substreamTypes"] = substreamTypes;
    return map;
  }
}


class MultiplexedMediaTypeSetDetails extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  MediaTypeSet multiplexTypeSet = null;
  List<MediaTypeSet> substreamTypeSets = null;

  MultiplexedMediaTypeSetDetails() : super(kVersions.last.size);

  static MultiplexedMediaTypeSetDetails deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MultiplexedMediaTypeSetDetails decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MultiplexedMediaTypeSetDetails result = new MultiplexedMediaTypeSetDetails();

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
      result.multiplexTypeSet = MediaTypeSet.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.substreamTypeSets = new List<MediaTypeSet>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.substreamTypeSets[i1] = MediaTypeSet.decode(decoder2);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(multiplexTypeSet, 8, false);
    
    if (substreamTypeSets == null) {
      encoder0.encodeNullPointer(16, false);
    } else {
      var encoder1 = encoder0.encodePointerArray(substreamTypeSets.length, 16, bindings.kUnspecifiedArrayLength);
      for (int i0 = 0; i0 < substreamTypeSets.length; ++i0) {
        
        encoder1.encodeStruct(substreamTypeSets[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
      }
    }
  }

  String toString() {
    return "MultiplexedMediaTypeSetDetails("
           "multiplexTypeSet: $multiplexTypeSet" ", "
           "substreamTypeSets: $substreamTypeSets" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["multiplexTypeSet"] = multiplexTypeSet;
    map["substreamTypeSets"] = substreamTypeSets;
    return map;
  }
}


class CompressedAudioMediaTypeDetails extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  AudioEncoding encoding = null;
  LpcmSampleFormat sampleFormat = null;
  int channels = 0;
  int framesPerSecond = 0;
  String extraDataBase64 = null;

  CompressedAudioMediaTypeDetails() : super(kVersions.last.size);

  static CompressedAudioMediaTypeDetails deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static CompressedAudioMediaTypeDetails decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    CompressedAudioMediaTypeDetails result = new CompressedAudioMediaTypeDetails();

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
      
        result.encoding = AudioEncoding.decode(decoder0, 8);
        if (result.encoding == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable AudioEncoding.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
        result.sampleFormat = LpcmSampleFormat.decode(decoder0, 12);
        if (result.sampleFormat == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable LpcmSampleFormat.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.channels = decoder0.decodeUint32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.framesPerSecond = decoder0.decodeUint32(20);
    }
    if (mainDataHeader.version >= 0) {
      
      result.extraDataBase64 = decoder0.decodeString(24, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(encoding, 8);
    
    encoder0.encodeEnum(sampleFormat, 12);
    
    encoder0.encodeUint32(channels, 16);
    
    encoder0.encodeUint32(framesPerSecond, 20);
    
    encoder0.encodeString(extraDataBase64, 24, false);
  }

  String toString() {
    return "CompressedAudioMediaTypeDetails("
           "encoding: $encoding" ", "
           "sampleFormat: $sampleFormat" ", "
           "channels: $channels" ", "
           "framesPerSecond: $framesPerSecond" ", "
           "extraDataBase64: $extraDataBase64" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["encoding"] = encoding;
    map["sampleFormat"] = sampleFormat;
    map["channels"] = channels;
    map["framesPerSecond"] = framesPerSecond;
    map["extraDataBase64"] = extraDataBase64;
    return map;
  }
}


class CompressedAudioMediaTypeSetDetails extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  AudioEncoding encoding = null;
  LpcmSampleFormat sampleFormat = null;
  int minChannels = 0;
  int maxChannels = 0;
  int minFramesPerSecond = 0;
  int maxFramesPerSecond = 0;

  CompressedAudioMediaTypeSetDetails() : super(kVersions.last.size);

  static CompressedAudioMediaTypeSetDetails deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static CompressedAudioMediaTypeSetDetails decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    CompressedAudioMediaTypeSetDetails result = new CompressedAudioMediaTypeSetDetails();

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
      
        result.encoding = AudioEncoding.decode(decoder0, 8);
        if (result.encoding == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable AudioEncoding.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
        result.sampleFormat = LpcmSampleFormat.decode(decoder0, 12);
        if (result.sampleFormat == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable LpcmSampleFormat.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.minChannels = decoder0.decodeUint32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.maxChannels = decoder0.decodeUint32(20);
    }
    if (mainDataHeader.version >= 0) {
      
      result.minFramesPerSecond = decoder0.decodeUint32(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.maxFramesPerSecond = decoder0.decodeUint32(28);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(encoding, 8);
    
    encoder0.encodeEnum(sampleFormat, 12);
    
    encoder0.encodeUint32(minChannels, 16);
    
    encoder0.encodeUint32(maxChannels, 20);
    
    encoder0.encodeUint32(minFramesPerSecond, 24);
    
    encoder0.encodeUint32(maxFramesPerSecond, 28);
  }

  String toString() {
    return "CompressedAudioMediaTypeSetDetails("
           "encoding: $encoding" ", "
           "sampleFormat: $sampleFormat" ", "
           "minChannels: $minChannels" ", "
           "maxChannels: $maxChannels" ", "
           "minFramesPerSecond: $minFramesPerSecond" ", "
           "maxFramesPerSecond: $maxFramesPerSecond" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["encoding"] = encoding;
    map["sampleFormat"] = sampleFormat;
    map["minChannels"] = minChannels;
    map["maxChannels"] = maxChannels;
    map["minFramesPerSecond"] = minFramesPerSecond;
    map["maxFramesPerSecond"] = maxFramesPerSecond;
    return map;
  }
}


class VideoMediaTypeDetails extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(48, 0)
  ];
  VideoEncoding encoding = null;
  VideoProfile profile = null;
  PixelFormat pixelFormat = null;
  ColorSpace colorSpace = null;
  int width = 0;
  int height = 0;
  int codedWidth = 0;
  int codedHeight = 0;
  String extraDataBase64 = null;

  VideoMediaTypeDetails() : super(kVersions.last.size);

  static VideoMediaTypeDetails deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static VideoMediaTypeDetails decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    VideoMediaTypeDetails result = new VideoMediaTypeDetails();

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
      
        result.encoding = VideoEncoding.decode(decoder0, 8);
        if (result.encoding == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable VideoEncoding.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
        result.profile = VideoProfile.decode(decoder0, 12);
        if (result.profile == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable VideoProfile.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
        result.pixelFormat = PixelFormat.decode(decoder0, 16);
        if (result.pixelFormat == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable PixelFormat.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
        result.colorSpace = ColorSpace.decode(decoder0, 20);
        if (result.colorSpace == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable ColorSpace.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.width = decoder0.decodeUint32(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.height = decoder0.decodeUint32(28);
    }
    if (mainDataHeader.version >= 0) {
      
      result.codedWidth = decoder0.decodeUint32(32);
    }
    if (mainDataHeader.version >= 0) {
      
      result.codedHeight = decoder0.decodeUint32(36);
    }
    if (mainDataHeader.version >= 0) {
      
      result.extraDataBase64 = decoder0.decodeString(40, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(encoding, 8);
    
    encoder0.encodeEnum(profile, 12);
    
    encoder0.encodeEnum(pixelFormat, 16);
    
    encoder0.encodeEnum(colorSpace, 20);
    
    encoder0.encodeUint32(width, 24);
    
    encoder0.encodeUint32(height, 28);
    
    encoder0.encodeUint32(codedWidth, 32);
    
    encoder0.encodeUint32(codedHeight, 36);
    
    encoder0.encodeString(extraDataBase64, 40, false);
  }

  String toString() {
    return "VideoMediaTypeDetails("
           "encoding: $encoding" ", "
           "profile: $profile" ", "
           "pixelFormat: $pixelFormat" ", "
           "colorSpace: $colorSpace" ", "
           "width: $width" ", "
           "height: $height" ", "
           "codedWidth: $codedWidth" ", "
           "codedHeight: $codedHeight" ", "
           "extraDataBase64: $extraDataBase64" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["encoding"] = encoding;
    map["profile"] = profile;
    map["pixelFormat"] = pixelFormat;
    map["colorSpace"] = colorSpace;
    map["width"] = width;
    map["height"] = height;
    map["codedWidth"] = codedWidth;
    map["codedHeight"] = codedHeight;
    map["extraDataBase64"] = extraDataBase64;
    return map;
  }
}


class VideoMediaTypeSetDetails extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  VideoEncoding encoding = null;
  int minWidth = 0;
  int maxWidth = 0;
  int minHeight = 0;
  int maxHeight = 0;

  VideoMediaTypeSetDetails() : super(kVersions.last.size);

  static VideoMediaTypeSetDetails deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static VideoMediaTypeSetDetails decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    VideoMediaTypeSetDetails result = new VideoMediaTypeSetDetails();

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
      
        result.encoding = VideoEncoding.decode(decoder0, 8);
        if (result.encoding == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable VideoEncoding.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.minWidth = decoder0.decodeUint32(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.maxWidth = decoder0.decodeUint32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.minHeight = decoder0.decodeUint32(20);
    }
    if (mainDataHeader.version >= 0) {
      
      result.maxHeight = decoder0.decodeUint32(24);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(encoding, 8);
    
    encoder0.encodeUint32(minWidth, 12);
    
    encoder0.encodeUint32(maxWidth, 16);
    
    encoder0.encodeUint32(minHeight, 20);
    
    encoder0.encodeUint32(maxHeight, 24);
  }

  String toString() {
    return "VideoMediaTypeSetDetails("
           "encoding: $encoding" ", "
           "minWidth: $minWidth" ", "
           "maxWidth: $maxWidth" ", "
           "minHeight: $minHeight" ", "
           "maxHeight: $maxHeight" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["encoding"] = encoding;
    map["minWidth"] = minWidth;
    map["maxWidth"] = maxWidth;
    map["minHeight"] = minHeight;
    map["maxHeight"] = maxHeight;
    return map;
  }
}



enum MediaTypeDetailsTag {
  multiplexed,
  lpcm,
  compressedAudio,
  video,
  unknown
}

class MediaTypeDetails extends bindings.Union {
  static final _tag_to_int = const {
    MediaTypeDetailsTag.multiplexed: 0,
    MediaTypeDetailsTag.lpcm: 1,
    MediaTypeDetailsTag.compressedAudio: 2,
    MediaTypeDetailsTag.video: 3,
  };

  static final _int_to_tag = const {
    0: MediaTypeDetailsTag.multiplexed,
    1: MediaTypeDetailsTag.lpcm,
    2: MediaTypeDetailsTag.compressedAudio,
    3: MediaTypeDetailsTag.video,
  };

  var _data;
  MediaTypeDetailsTag _tag = MediaTypeDetailsTag.unknown;

  MediaTypeDetailsTag get tag => _tag;
  MultiplexedMediaTypeDetails get multiplexed {
    if (_tag != MediaTypeDetailsTag.multiplexed) {
      throw new bindings.UnsetUnionTagError(_tag, MediaTypeDetailsTag.multiplexed);
    }
    return _data;
  }

  set multiplexed(MultiplexedMediaTypeDetails value) {
    _tag = MediaTypeDetailsTag.multiplexed;
    _data = value;
  }
  LpcmMediaTypeDetails get lpcm {
    if (_tag != MediaTypeDetailsTag.lpcm) {
      throw new bindings.UnsetUnionTagError(_tag, MediaTypeDetailsTag.lpcm);
    }
    return _data;
  }

  set lpcm(LpcmMediaTypeDetails value) {
    _tag = MediaTypeDetailsTag.lpcm;
    _data = value;
  }
  CompressedAudioMediaTypeDetails get compressedAudio {
    if (_tag != MediaTypeDetailsTag.compressedAudio) {
      throw new bindings.UnsetUnionTagError(_tag, MediaTypeDetailsTag.compressedAudio);
    }
    return _data;
  }

  set compressedAudio(CompressedAudioMediaTypeDetails value) {
    _tag = MediaTypeDetailsTag.compressedAudio;
    _data = value;
  }
  VideoMediaTypeDetails get video {
    if (_tag != MediaTypeDetailsTag.video) {
      throw new bindings.UnsetUnionTagError(_tag, MediaTypeDetailsTag.video);
    }
    return _data;
  }

  set video(VideoMediaTypeDetails value) {
    _tag = MediaTypeDetailsTag.video;
    _data = value;
  }

  static MediaTypeDetails decode(bindings.Decoder decoder0, int offset) {
    int size = decoder0.decodeUint32(offset);
    if (size == 0) {
      return null;
    }
    MediaTypeDetails result = new MediaTypeDetails();

    // TODO(azani): Handle unknown union member.
    MediaTypeDetailsTag tag = _int_to_tag[decoder0.decodeUint32(offset + 4)];
    switch (tag) {
      case MediaTypeDetailsTag.multiplexed:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        result.multiplexed = MultiplexedMediaTypeDetails.decode(decoder1);
        break;
      case MediaTypeDetailsTag.lpcm:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        result.lpcm = LpcmMediaTypeDetails.decode(decoder1);
        break;
      case MediaTypeDetailsTag.compressedAudio:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        result.compressedAudio = CompressedAudioMediaTypeDetails.decode(decoder1);
        break;
      case MediaTypeDetailsTag.video:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        result.video = VideoMediaTypeDetails.decode(decoder1);
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
      case MediaTypeDetailsTag.multiplexed:
        
        encoder0.encodeStruct(multiplexed, offset + 8, false);
        break;
      case MediaTypeDetailsTag.lpcm:
        
        encoder0.encodeStruct(lpcm, offset + 8, false);
        break;
      case MediaTypeDetailsTag.compressedAudio:
        
        encoder0.encodeStruct(compressedAudio, offset + 8, false);
        break;
      case MediaTypeDetailsTag.video:
        
        encoder0.encodeStruct(video, offset + 8, false);
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $_tag");
    }
  }

  String toString() {
    String result = "MediaTypeDetails(";
    switch (_tag) {
      case MediaTypeDetailsTag.multiplexed:
        result += "multiplexed";
        break;
      case MediaTypeDetailsTag.lpcm:
        result += "lpcm";
        break;
      case MediaTypeDetailsTag.compressedAudio:
        result += "compressedAudio";
        break;
      case MediaTypeDetailsTag.video:
        result += "video";
        break;
      default:
        result += "unknown";
    }
    result += ": $_data)";
    return result;
  }
}


enum MediaTypeSetDetailsTag {
  multiplexed,
  lpcm,
  compressedAudio,
  video,
  unknown
}

class MediaTypeSetDetails extends bindings.Union {
  static final _tag_to_int = const {
    MediaTypeSetDetailsTag.multiplexed: 0,
    MediaTypeSetDetailsTag.lpcm: 1,
    MediaTypeSetDetailsTag.compressedAudio: 2,
    MediaTypeSetDetailsTag.video: 3,
  };

  static final _int_to_tag = const {
    0: MediaTypeSetDetailsTag.multiplexed,
    1: MediaTypeSetDetailsTag.lpcm,
    2: MediaTypeSetDetailsTag.compressedAudio,
    3: MediaTypeSetDetailsTag.video,
  };

  var _data;
  MediaTypeSetDetailsTag _tag = MediaTypeSetDetailsTag.unknown;

  MediaTypeSetDetailsTag get tag => _tag;
  MultiplexedMediaTypeSetDetails get multiplexed {
    if (_tag != MediaTypeSetDetailsTag.multiplexed) {
      throw new bindings.UnsetUnionTagError(_tag, MediaTypeSetDetailsTag.multiplexed);
    }
    return _data;
  }

  set multiplexed(MultiplexedMediaTypeSetDetails value) {
    _tag = MediaTypeSetDetailsTag.multiplexed;
    _data = value;
  }
  LpcmMediaTypeSetDetails get lpcm {
    if (_tag != MediaTypeSetDetailsTag.lpcm) {
      throw new bindings.UnsetUnionTagError(_tag, MediaTypeSetDetailsTag.lpcm);
    }
    return _data;
  }

  set lpcm(LpcmMediaTypeSetDetails value) {
    _tag = MediaTypeSetDetailsTag.lpcm;
    _data = value;
  }
  CompressedAudioMediaTypeSetDetails get compressedAudio {
    if (_tag != MediaTypeSetDetailsTag.compressedAudio) {
      throw new bindings.UnsetUnionTagError(_tag, MediaTypeSetDetailsTag.compressedAudio);
    }
    return _data;
  }

  set compressedAudio(CompressedAudioMediaTypeSetDetails value) {
    _tag = MediaTypeSetDetailsTag.compressedAudio;
    _data = value;
  }
  VideoMediaTypeSetDetails get video {
    if (_tag != MediaTypeSetDetailsTag.video) {
      throw new bindings.UnsetUnionTagError(_tag, MediaTypeSetDetailsTag.video);
    }
    return _data;
  }

  set video(VideoMediaTypeSetDetails value) {
    _tag = MediaTypeSetDetailsTag.video;
    _data = value;
  }

  static MediaTypeSetDetails decode(bindings.Decoder decoder0, int offset) {
    int size = decoder0.decodeUint32(offset);
    if (size == 0) {
      return null;
    }
    MediaTypeSetDetails result = new MediaTypeSetDetails();

    // TODO(azani): Handle unknown union member.
    MediaTypeSetDetailsTag tag = _int_to_tag[decoder0.decodeUint32(offset + 4)];
    switch (tag) {
      case MediaTypeSetDetailsTag.multiplexed:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        result.multiplexed = MultiplexedMediaTypeSetDetails.decode(decoder1);
        break;
      case MediaTypeSetDetailsTag.lpcm:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        result.lpcm = LpcmMediaTypeSetDetails.decode(decoder1);
        break;
      case MediaTypeSetDetailsTag.compressedAudio:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        result.compressedAudio = CompressedAudioMediaTypeSetDetails.decode(decoder1);
        break;
      case MediaTypeSetDetailsTag.video:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        result.video = VideoMediaTypeSetDetails.decode(decoder1);
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
      case MediaTypeSetDetailsTag.multiplexed:
        
        encoder0.encodeStruct(multiplexed, offset + 8, false);
        break;
      case MediaTypeSetDetailsTag.lpcm:
        
        encoder0.encodeStruct(lpcm, offset + 8, false);
        break;
      case MediaTypeSetDetailsTag.compressedAudio:
        
        encoder0.encodeStruct(compressedAudio, offset + 8, false);
        break;
      case MediaTypeSetDetailsTag.video:
        
        encoder0.encodeStruct(video, offset + 8, false);
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $_tag");
    }
  }

  String toString() {
    String result = "MediaTypeSetDetails(";
    switch (_tag) {
      case MediaTypeSetDetailsTag.multiplexed:
        result += "multiplexed";
        break;
      case MediaTypeSetDetailsTag.lpcm:
        result += "lpcm";
        break;
      case MediaTypeSetDetailsTag.compressedAudio:
        result += "compressedAudio";
        break;
      case MediaTypeSetDetailsTag.video:
        result += "video";
        break;
      default:
        result += "unknown";
    }
    result += ": $_data)";
    return result;
  }
}

