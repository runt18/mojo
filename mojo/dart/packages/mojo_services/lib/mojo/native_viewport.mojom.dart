// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library native_viewport_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo_services/mojo/geometry.mojom.dart' as geometry_mojom;
import 'package:mojo_services/mojo/context_provider.mojom.dart' as context_provider_mojom;
import 'package:mojo_services/mojo/input_events.mojom.dart' as input_events_mojom;



class ViewportMetrics extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  geometry_mojom.Size size = null;
  double devicePixelRatio = 1.0;

  ViewportMetrics() : super(kVersions.last.size);

  static ViewportMetrics deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewportMetrics decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewportMetrics result = new ViewportMetrics();

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
      result.size = geometry_mojom.Size.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.devicePixelRatio = decoder0.decodeFloat(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(size, 8, false);
    
    encoder0.encodeFloat(devicePixelRatio, 16);
  }

  String toString() {
    return "ViewportMetrics("
           "size: $size" ", "
           "devicePixelRatio: $devicePixelRatio" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["size"] = size;
    map["devicePixelRatio"] = devicePixelRatio;
    return map;
  }
}


class SurfaceConfiguration extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int redBits = 8;
  int greenBits = 8;
  int blueBits = 8;
  int alphaBits = 8;
  int depthBits = 0;
  int stencilBits = 0;

  SurfaceConfiguration() : super(kVersions.last.size);

  static SurfaceConfiguration deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SurfaceConfiguration decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SurfaceConfiguration result = new SurfaceConfiguration();

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
      
      result.redBits = decoder0.decodeUint8(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.greenBits = decoder0.decodeUint8(9);
    }
    if (mainDataHeader.version >= 0) {
      
      result.blueBits = decoder0.decodeUint8(10);
    }
    if (mainDataHeader.version >= 0) {
      
      result.alphaBits = decoder0.decodeUint8(11);
    }
    if (mainDataHeader.version >= 0) {
      
      result.depthBits = decoder0.decodeUint8(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.stencilBits = decoder0.decodeUint8(13);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint8(redBits, 8);
    
    encoder0.encodeUint8(greenBits, 9);
    
    encoder0.encodeUint8(blueBits, 10);
    
    encoder0.encodeUint8(alphaBits, 11);
    
    encoder0.encodeUint8(depthBits, 12);
    
    encoder0.encodeUint8(stencilBits, 13);
  }

  String toString() {
    return "SurfaceConfiguration("
           "redBits: $redBits" ", "
           "greenBits: $greenBits" ", "
           "blueBits: $blueBits" ", "
           "alphaBits: $alphaBits" ", "
           "depthBits: $depthBits" ", "
           "stencilBits: $stencilBits" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["redBits"] = redBits;
    map["greenBits"] = greenBits;
    map["blueBits"] = blueBits;
    map["alphaBits"] = alphaBits;
    map["depthBits"] = depthBits;
    map["stencilBits"] = stencilBits;
    return map;
  }
}


class NativeViewportCreateParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  geometry_mojom.Size size = null;
  SurfaceConfiguration requestedConfiguration = null;

  NativeViewportCreateParams() : super(kVersions.last.size);

  static NativeViewportCreateParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NativeViewportCreateParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NativeViewportCreateParams result = new NativeViewportCreateParams();

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
      result.size = geometry_mojom.Size.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.requestedConfiguration = SurfaceConfiguration.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(size, 8, false);
    
    encoder0.encodeStruct(requestedConfiguration, 16, true);
  }

  String toString() {
    return "NativeViewportCreateParams("
           "size: $size" ", "
           "requestedConfiguration: $requestedConfiguration" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["size"] = size;
    map["requestedConfiguration"] = requestedConfiguration;
    return map;
  }
}


class NativeViewportCreateResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  ViewportMetrics metrics = null;

  NativeViewportCreateResponseParams() : super(kVersions.last.size);

  static NativeViewportCreateResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NativeViewportCreateResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NativeViewportCreateResponseParams result = new NativeViewportCreateResponseParams();

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
      result.metrics = ViewportMetrics.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(metrics, 8, false);
  }

  String toString() {
    return "NativeViewportCreateResponseParams("
           "metrics: $metrics" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["metrics"] = metrics;
    return map;
  }
}


class NativeViewportShowParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  NativeViewportShowParams() : super(kVersions.last.size);

  static NativeViewportShowParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NativeViewportShowParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NativeViewportShowParams result = new NativeViewportShowParams();

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
    return "NativeViewportShowParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class NativeViewportHideParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  NativeViewportHideParams() : super(kVersions.last.size);

  static NativeViewportHideParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NativeViewportHideParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NativeViewportHideParams result = new NativeViewportHideParams();

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
    return "NativeViewportHideParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class NativeViewportCloseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  NativeViewportCloseParams() : super(kVersions.last.size);

  static NativeViewportCloseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NativeViewportCloseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NativeViewportCloseParams result = new NativeViewportCloseParams();

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
    return "NativeViewportCloseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class NativeViewportSetSizeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  geometry_mojom.Size size = null;

  NativeViewportSetSizeParams() : super(kVersions.last.size);

  static NativeViewportSetSizeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NativeViewportSetSizeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NativeViewportSetSizeParams result = new NativeViewportSetSizeParams();

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
      result.size = geometry_mojom.Size.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(size, 8, false);
  }

  String toString() {
    return "NativeViewportSetSizeParams("
           "size: $size" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["size"] = size;
    return map;
  }
}


class NativeViewportSetEventDispatcherParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object dispatcher = null;

  NativeViewportSetEventDispatcherParams() : super(kVersions.last.size);

  static NativeViewportSetEventDispatcherParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NativeViewportSetEventDispatcherParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NativeViewportSetEventDispatcherParams result = new NativeViewportSetEventDispatcherParams();

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
      
      result.dispatcher = decoder0.decodeServiceInterface(8, false, NativeViewportEventDispatcherProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInterface(dispatcher, 8, false);
  }

  String toString() {
    return "NativeViewportSetEventDispatcherParams("
           "dispatcher: $dispatcher" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class NativeViewportGetContextProviderParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object provider = null;

  NativeViewportGetContextProviderParams() : super(kVersions.last.size);

  static NativeViewportGetContextProviderParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NativeViewportGetContextProviderParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NativeViewportGetContextProviderParams result = new NativeViewportGetContextProviderParams();

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
      
      result.provider = decoder0.decodeInterfaceRequest(8, false, context_provider_mojom.ContextProviderStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInterfaceRequest(provider, 8, false);
  }

  String toString() {
    return "NativeViewportGetContextProviderParams("
           "provider: $provider" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class NativeViewportRequestMetricsParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  NativeViewportRequestMetricsParams() : super(kVersions.last.size);

  static NativeViewportRequestMetricsParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NativeViewportRequestMetricsParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NativeViewportRequestMetricsParams result = new NativeViewportRequestMetricsParams();

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
    return "NativeViewportRequestMetricsParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class NativeViewportRequestMetricsResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  ViewportMetrics metrics = null;

  NativeViewportRequestMetricsResponseParams() : super(kVersions.last.size);

  static NativeViewportRequestMetricsResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NativeViewportRequestMetricsResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NativeViewportRequestMetricsResponseParams result = new NativeViewportRequestMetricsResponseParams();

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
      result.metrics = ViewportMetrics.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(metrics, 8, false);
  }

  String toString() {
    return "NativeViewportRequestMetricsResponseParams("
           "metrics: $metrics" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["metrics"] = metrics;
    return map;
  }
}


class NativeViewportEventDispatcherOnEventParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  input_events_mojom.Event event = null;

  NativeViewportEventDispatcherOnEventParams() : super(kVersions.last.size);

  static NativeViewportEventDispatcherOnEventParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NativeViewportEventDispatcherOnEventParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NativeViewportEventDispatcherOnEventParams result = new NativeViewportEventDispatcherOnEventParams();

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
      result.event = input_events_mojom.Event.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(event, 8, false);
  }

  String toString() {
    return "NativeViewportEventDispatcherOnEventParams("
           "event: $event" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["event"] = event;
    return map;
  }
}


class NativeViewportEventDispatcherOnEventResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  NativeViewportEventDispatcherOnEventResponseParams() : super(kVersions.last.size);

  static NativeViewportEventDispatcherOnEventResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NativeViewportEventDispatcherOnEventResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NativeViewportEventDispatcherOnEventResponseParams result = new NativeViewportEventDispatcherOnEventResponseParams();

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
    return "NativeViewportEventDispatcherOnEventResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

const int kNativeViewport_create_name = 0;
const int kNativeViewport_show_name = 1;
const int kNativeViewport_hide_name = 2;
const int kNativeViewport_close_name = 3;
const int kNativeViewport_setSize_name = 4;
const int kNativeViewport_setEventDispatcher_name = 5;
const int kNativeViewport_getContextProvider_name = 6;
const int kNativeViewport_requestMetrics_name = 7;

const String NativeViewportName =
      'mojo::NativeViewport';

abstract class NativeViewport {
  dynamic create(geometry_mojom.Size size,SurfaceConfiguration requestedConfiguration,[Function responseFactory = null]);
  void show();
  void hide();
  void close();
  void setSize(geometry_mojom.Size size);
  void setEventDispatcher(Object dispatcher);
  void getContextProvider(Object provider);
  dynamic requestMetrics([Function responseFactory = null]);

}


class NativeViewportProxyImpl extends bindings.Proxy {
  NativeViewportProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  NativeViewportProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  NativeViewportProxyImpl.unbound() : super.unbound();

  static NativeViewportProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NativeViewportProxyImpl"));
    return new NativeViewportProxyImpl.fromEndpoint(endpoint);
  }

  String get name => NativeViewportName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case kNativeViewport_create_name:
        var r = NativeViewportCreateResponseParams.deserialize(
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
      case kNativeViewport_requestMetrics_name:
        var r = NativeViewportRequestMetricsResponseParams.deserialize(
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
    return "NativeViewportProxyImpl($superString)";
  }
}


class _NativeViewportProxyCalls implements NativeViewport {
  NativeViewportProxyImpl _proxyImpl;

  _NativeViewportProxyCalls(this._proxyImpl);
    dynamic create(geometry_mojom.Size size,SurfaceConfiguration requestedConfiguration,[Function responseFactory = null]) {
      var params = new NativeViewportCreateParams();
      params.size = size;
      params.requestedConfiguration = requestedConfiguration;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kNativeViewport_create_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    void show() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new NativeViewportShowParams();
      _proxyImpl.sendMessage(params, kNativeViewport_show_name);
    }
  
    void hide() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new NativeViewportHideParams();
      _proxyImpl.sendMessage(params, kNativeViewport_hide_name);
    }
  
    void close() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new NativeViewportCloseParams();
      _proxyImpl.sendMessage(params, kNativeViewport_close_name);
    }
  
    void setSize(geometry_mojom.Size size) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new NativeViewportSetSizeParams();
      params.size = size;
      _proxyImpl.sendMessage(params, kNativeViewport_setSize_name);
    }
  
    void setEventDispatcher(Object dispatcher) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new NativeViewportSetEventDispatcherParams();
      params.dispatcher = dispatcher;
      _proxyImpl.sendMessage(params, kNativeViewport_setEventDispatcher_name);
    }
  
    void getContextProvider(Object provider) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new NativeViewportGetContextProviderParams();
      params.provider = provider;
      _proxyImpl.sendMessage(params, kNativeViewport_getContextProvider_name);
    }
  
    dynamic requestMetrics([Function responseFactory = null]) {
      var params = new NativeViewportRequestMetricsParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kNativeViewport_requestMetrics_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class NativeViewportProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  NativeViewport ptr;
  final String name = NativeViewportName;

  NativeViewportProxy(NativeViewportProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _NativeViewportProxyCalls(proxyImpl);

  NativeViewportProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new NativeViewportProxyImpl.fromEndpoint(endpoint) {
    ptr = new _NativeViewportProxyCalls(impl);
  }

  NativeViewportProxy.fromHandle(core.MojoHandle handle) :
      impl = new NativeViewportProxyImpl.fromHandle(handle) {
    ptr = new _NativeViewportProxyCalls(impl);
  }

  NativeViewportProxy.unbound() :
      impl = new NativeViewportProxyImpl.unbound() {
    ptr = new _NativeViewportProxyCalls(impl);
  }

  factory NativeViewportProxy.connectToService(
      bindings.ServiceConnector s, String url) {
    NativeViewportProxy p = new NativeViewportProxy.unbound();
    s.connectToService(url, p);
    return p;
  }

  static NativeViewportProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NativeViewportProxy"));
    return new NativeViewportProxy.fromEndpoint(endpoint);
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
    return "NativeViewportProxy($impl)";
  }
}


class NativeViewportStub extends bindings.Stub {
  NativeViewport _impl = null;

  NativeViewportStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  NativeViewportStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  NativeViewportStub.unbound() : super.unbound();

  static NativeViewportStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NativeViewportStub"));
    return new NativeViewportStub.fromEndpoint(endpoint);
  }

  static const String name = NativeViewportName;


  NativeViewportCreateResponseParams _NativeViewportCreateResponseParamsFactory(ViewportMetrics metrics) {
    var result = new NativeViewportCreateResponseParams();
    result.metrics = metrics;
    return result;
  }
  NativeViewportRequestMetricsResponseParams _NativeViewportRequestMetricsResponseParamsFactory(ViewportMetrics metrics) {
    var result = new NativeViewportRequestMetricsResponseParams();
    result.metrics = metrics;
    return result;
  }

  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case kNativeViewport_create_name:
        var params = NativeViewportCreateParams.deserialize(
            message.payload);
        var response = _impl.create(params.size,params.requestedConfiguration,_NativeViewportCreateResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kNativeViewport_create_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kNativeViewport_create_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kNativeViewport_show_name:
        var params = NativeViewportShowParams.deserialize(
            message.payload);
        _impl.show();
        break;
      case kNativeViewport_hide_name:
        var params = NativeViewportHideParams.deserialize(
            message.payload);
        _impl.hide();
        break;
      case kNativeViewport_close_name:
        var params = NativeViewportCloseParams.deserialize(
            message.payload);
        _impl.close();
        break;
      case kNativeViewport_setSize_name:
        var params = NativeViewportSetSizeParams.deserialize(
            message.payload);
        _impl.setSize(params.size);
        break;
      case kNativeViewport_setEventDispatcher_name:
        var params = NativeViewportSetEventDispatcherParams.deserialize(
            message.payload);
        _impl.setEventDispatcher(params.dispatcher);
        break;
      case kNativeViewport_getContextProvider_name:
        var params = NativeViewportGetContextProviderParams.deserialize(
            message.payload);
        _impl.getContextProvider(params.provider);
        break;
      case kNativeViewport_requestMetrics_name:
        var params = NativeViewportRequestMetricsParams.deserialize(
            message.payload);
        var response = _impl.requestMetrics(_NativeViewportRequestMetricsResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kNativeViewport_requestMetrics_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kNativeViewport_requestMetrics_name,
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

  NativeViewport get impl => _impl;
  set impl(NativeViewport d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "NativeViewportStub($superString)";
  }

  int get version => 0;
}

const int kNativeViewportEventDispatcher_onEvent_name = 0;

const String NativeViewportEventDispatcherName =
      'mojo::NativeViewportEventDispatcher';

abstract class NativeViewportEventDispatcher {
  dynamic onEvent(input_events_mojom.Event event,[Function responseFactory = null]);

}


class NativeViewportEventDispatcherProxyImpl extends bindings.Proxy {
  NativeViewportEventDispatcherProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  NativeViewportEventDispatcherProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  NativeViewportEventDispatcherProxyImpl.unbound() : super.unbound();

  static NativeViewportEventDispatcherProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NativeViewportEventDispatcherProxyImpl"));
    return new NativeViewportEventDispatcherProxyImpl.fromEndpoint(endpoint);
  }

  String get name => NativeViewportEventDispatcherName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case kNativeViewportEventDispatcher_onEvent_name:
        var r = NativeViewportEventDispatcherOnEventResponseParams.deserialize(
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
    return "NativeViewportEventDispatcherProxyImpl($superString)";
  }
}


class _NativeViewportEventDispatcherProxyCalls implements NativeViewportEventDispatcher {
  NativeViewportEventDispatcherProxyImpl _proxyImpl;

  _NativeViewportEventDispatcherProxyCalls(this._proxyImpl);
    dynamic onEvent(input_events_mojom.Event event,[Function responseFactory = null]) {
      var params = new NativeViewportEventDispatcherOnEventParams();
      params.event = event;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kNativeViewportEventDispatcher_onEvent_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class NativeViewportEventDispatcherProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  NativeViewportEventDispatcher ptr;
  final String name = NativeViewportEventDispatcherName;

  NativeViewportEventDispatcherProxy(NativeViewportEventDispatcherProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _NativeViewportEventDispatcherProxyCalls(proxyImpl);

  NativeViewportEventDispatcherProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new NativeViewportEventDispatcherProxyImpl.fromEndpoint(endpoint) {
    ptr = new _NativeViewportEventDispatcherProxyCalls(impl);
  }

  NativeViewportEventDispatcherProxy.fromHandle(core.MojoHandle handle) :
      impl = new NativeViewportEventDispatcherProxyImpl.fromHandle(handle) {
    ptr = new _NativeViewportEventDispatcherProxyCalls(impl);
  }

  NativeViewportEventDispatcherProxy.unbound() :
      impl = new NativeViewportEventDispatcherProxyImpl.unbound() {
    ptr = new _NativeViewportEventDispatcherProxyCalls(impl);
  }

  factory NativeViewportEventDispatcherProxy.connectToService(
      bindings.ServiceConnector s, String url) {
    NativeViewportEventDispatcherProxy p = new NativeViewportEventDispatcherProxy.unbound();
    s.connectToService(url, p);
    return p;
  }

  static NativeViewportEventDispatcherProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NativeViewportEventDispatcherProxy"));
    return new NativeViewportEventDispatcherProxy.fromEndpoint(endpoint);
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
    return "NativeViewportEventDispatcherProxy($impl)";
  }
}


class NativeViewportEventDispatcherStub extends bindings.Stub {
  NativeViewportEventDispatcher _impl = null;

  NativeViewportEventDispatcherStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  NativeViewportEventDispatcherStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  NativeViewportEventDispatcherStub.unbound() : super.unbound();

  static NativeViewportEventDispatcherStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NativeViewportEventDispatcherStub"));
    return new NativeViewportEventDispatcherStub.fromEndpoint(endpoint);
  }

  static const String name = NativeViewportEventDispatcherName;


  NativeViewportEventDispatcherOnEventResponseParams _NativeViewportEventDispatcherOnEventResponseParamsFactory() {
    var result = new NativeViewportEventDispatcherOnEventResponseParams();
    return result;
  }

  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case kNativeViewportEventDispatcher_onEvent_name:
        var params = NativeViewportEventDispatcherOnEventParams.deserialize(
            message.payload);
        var response = _impl.onEvent(params.event,_NativeViewportEventDispatcherOnEventResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kNativeViewportEventDispatcher_onEvent_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kNativeViewportEventDispatcher_onEvent_name,
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

  NativeViewportEventDispatcher get impl => _impl;
  set impl(NativeViewportEventDispatcher d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "NativeViewportEventDispatcherStub($superString)";
  }

  int get version => 0;
}


