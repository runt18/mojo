// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library window_manager_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo_services/mojo/input_events.mojom.dart' as input_events_mojom;
import 'package:mojo/mojo/service_provider.mojom.dart' as service_provider_mojom;



class _WindowManagerEmbedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  String url = null;
  Object services = null;
  Object exposedServices = null;

  _WindowManagerEmbedParams() : super(kVersions.last.size);

  static _WindowManagerEmbedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _WindowManagerEmbedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _WindowManagerEmbedParams result = new _WindowManagerEmbedParams();

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
      
      result.url = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.services = decoder0.decodeInterfaceRequest(16, true, service_provider_mojom.ServiceProviderStub.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.exposedServices = decoder0.decodeServiceInterface(20, true, service_provider_mojom.ServiceProviderProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeString(url, 8, false);
    
    encoder0.encodeInterfaceRequest(services, 16, true);
    
    encoder0.encodeInterface(exposedServices, 20, true);
  }

  String toString() {
    return "_WindowManagerEmbedParams("
           "url: $url" ", "
           "services: $services" ", "
           "exposedServices: $exposedServices" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _WindowManagerSetCaptureParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int viewId = 0;

  _WindowManagerSetCaptureParams() : super(kVersions.last.size);

  static _WindowManagerSetCaptureParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _WindowManagerSetCaptureParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _WindowManagerSetCaptureParams result = new _WindowManagerSetCaptureParams();

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
      
      result.viewId = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(viewId, 8);
  }

  String toString() {
    return "_WindowManagerSetCaptureParams("
           "viewId: $viewId" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["viewId"] = viewId;
    return map;
  }
}


class WindowManagerSetCaptureResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool success = false;

  WindowManagerSetCaptureResponseParams() : super(kVersions.last.size);

  static WindowManagerSetCaptureResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static WindowManagerSetCaptureResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    WindowManagerSetCaptureResponseParams result = new WindowManagerSetCaptureResponseParams();

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
      
      result.success = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeBool(success, 8, 0);
  }

  String toString() {
    return "WindowManagerSetCaptureResponseParams("
           "success: $success" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["success"] = success;
    return map;
  }
}


class _WindowManagerFocusWindowParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int viewId = 0;

  _WindowManagerFocusWindowParams() : super(kVersions.last.size);

  static _WindowManagerFocusWindowParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _WindowManagerFocusWindowParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _WindowManagerFocusWindowParams result = new _WindowManagerFocusWindowParams();

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
      
      result.viewId = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(viewId, 8);
  }

  String toString() {
    return "_WindowManagerFocusWindowParams("
           "viewId: $viewId" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["viewId"] = viewId;
    return map;
  }
}


class WindowManagerFocusWindowResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool success = false;

  WindowManagerFocusWindowResponseParams() : super(kVersions.last.size);

  static WindowManagerFocusWindowResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static WindowManagerFocusWindowResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    WindowManagerFocusWindowResponseParams result = new WindowManagerFocusWindowResponseParams();

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
      
      result.success = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeBool(success, 8, 0);
  }

  String toString() {
    return "WindowManagerFocusWindowResponseParams("
           "success: $success" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["success"] = success;
    return map;
  }
}


class _WindowManagerActivateWindowParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int viewId = 0;

  _WindowManagerActivateWindowParams() : super(kVersions.last.size);

  static _WindowManagerActivateWindowParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _WindowManagerActivateWindowParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _WindowManagerActivateWindowParams result = new _WindowManagerActivateWindowParams();

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
      
      result.viewId = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(viewId, 8);
  }

  String toString() {
    return "_WindowManagerActivateWindowParams("
           "viewId: $viewId" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["viewId"] = viewId;
    return map;
  }
}


class WindowManagerActivateWindowResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool success = false;

  WindowManagerActivateWindowResponseParams() : super(kVersions.last.size);

  static WindowManagerActivateWindowResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static WindowManagerActivateWindowResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    WindowManagerActivateWindowResponseParams result = new WindowManagerActivateWindowResponseParams();

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
      
      result.success = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeBool(success, 8, 0);
  }

  String toString() {
    return "WindowManagerActivateWindowResponseParams("
           "success: $success" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["success"] = success;
    return map;
  }
}


class _WindowManagerGetFocusedAndActiveViewsParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object observer = null;

  _WindowManagerGetFocusedAndActiveViewsParams() : super(kVersions.last.size);

  static _WindowManagerGetFocusedAndActiveViewsParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _WindowManagerGetFocusedAndActiveViewsParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _WindowManagerGetFocusedAndActiveViewsParams result = new _WindowManagerGetFocusedAndActiveViewsParams();

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
      
      result.observer = decoder0.decodeServiceInterface(8, true, WindowManagerObserverProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInterface(observer, 8, true);
  }

  String toString() {
    return "_WindowManagerGetFocusedAndActiveViewsParams("
           "observer: $observer" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class WindowManagerGetFocusedAndActiveViewsResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int captureViewId = 0;
  int focusedViewId = 0;
  int activeViewId = 0;

  WindowManagerGetFocusedAndActiveViewsResponseParams() : super(kVersions.last.size);

  static WindowManagerGetFocusedAndActiveViewsResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static WindowManagerGetFocusedAndActiveViewsResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    WindowManagerGetFocusedAndActiveViewsResponseParams result = new WindowManagerGetFocusedAndActiveViewsResponseParams();

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
      
      result.captureViewId = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.focusedViewId = decoder0.decodeUint32(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.activeViewId = decoder0.decodeUint32(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(captureViewId, 8);
    
    encoder0.encodeUint32(focusedViewId, 12);
    
    encoder0.encodeUint32(activeViewId, 16);
  }

  String toString() {
    return "WindowManagerGetFocusedAndActiveViewsResponseParams("
           "captureViewId: $captureViewId" ", "
           "focusedViewId: $focusedViewId" ", "
           "activeViewId: $activeViewId" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["captureViewId"] = captureViewId;
    map["focusedViewId"] = focusedViewId;
    map["activeViewId"] = activeViewId;
    return map;
  }
}


class _WindowManagerObserverOnCaptureChangedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int captureViewId = 0;

  _WindowManagerObserverOnCaptureChangedParams() : super(kVersions.last.size);

  static _WindowManagerObserverOnCaptureChangedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _WindowManagerObserverOnCaptureChangedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _WindowManagerObserverOnCaptureChangedParams result = new _WindowManagerObserverOnCaptureChangedParams();

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
      
      result.captureViewId = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(captureViewId, 8);
  }

  String toString() {
    return "_WindowManagerObserverOnCaptureChangedParams("
           "captureViewId: $captureViewId" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["captureViewId"] = captureViewId;
    return map;
  }
}


class _WindowManagerObserverOnFocusChangedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int focusedViewId = 0;

  _WindowManagerObserverOnFocusChangedParams() : super(kVersions.last.size);

  static _WindowManagerObserverOnFocusChangedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _WindowManagerObserverOnFocusChangedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _WindowManagerObserverOnFocusChangedParams result = new _WindowManagerObserverOnFocusChangedParams();

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
      
      result.focusedViewId = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(focusedViewId, 8);
  }

  String toString() {
    return "_WindowManagerObserverOnFocusChangedParams("
           "focusedViewId: $focusedViewId" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["focusedViewId"] = focusedViewId;
    return map;
  }
}


class _WindowManagerObserverOnActiveWindowChangedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int focusedViewId = 0;

  _WindowManagerObserverOnActiveWindowChangedParams() : super(kVersions.last.size);

  static _WindowManagerObserverOnActiveWindowChangedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _WindowManagerObserverOnActiveWindowChangedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _WindowManagerObserverOnActiveWindowChangedParams result = new _WindowManagerObserverOnActiveWindowChangedParams();

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
      
      result.focusedViewId = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(focusedViewId, 8);
  }

  String toString() {
    return "_WindowManagerObserverOnActiveWindowChangedParams("
           "focusedViewId: $focusedViewId" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["focusedViewId"] = focusedViewId;
    return map;
  }
}

const int _WindowManager_embedName = 0;
const int _WindowManager_setCaptureName = 1;
const int _WindowManager_focusWindowName = 2;
const int _WindowManager_activateWindowName = 3;
const int _WindowManager_getFocusedAndActiveViewsName = 4;

abstract class WindowManager {
  static const String serviceName = "mojo::WindowManager";
  void embed(String url, Object services, Object exposedServices);
  dynamic setCapture(int viewId,[Function responseFactory = null]);
  dynamic focusWindow(int viewId,[Function responseFactory = null]);
  dynamic activateWindow(int viewId,[Function responseFactory = null]);
  dynamic getFocusedAndActiveViews(Object observer,[Function responseFactory = null]);
}


class _WindowManagerProxyImpl extends bindings.Proxy {
  _WindowManagerProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _WindowManagerProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _WindowManagerProxyImpl.unbound() : super.unbound();

  static _WindowManagerProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _WindowManagerProxyImpl"));
    return new _WindowManagerProxyImpl.fromEndpoint(endpoint);
  }

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _WindowManager_setCaptureName:
        var r = WindowManagerSetCaptureResponseParams.deserialize(
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
      case _WindowManager_focusWindowName:
        var r = WindowManagerFocusWindowResponseParams.deserialize(
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
      case _WindowManager_activateWindowName:
        var r = WindowManagerActivateWindowResponseParams.deserialize(
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
      case _WindowManager_getFocusedAndActiveViewsName:
        var r = WindowManagerGetFocusedAndActiveViewsResponseParams.deserialize(
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
    return "_WindowManagerProxyImpl($superString)";
  }
}


class _WindowManagerProxyCalls implements WindowManager {
  _WindowManagerProxyImpl _proxyImpl;

  _WindowManagerProxyCalls(this._proxyImpl);
    void embed(String url, Object services, Object exposedServices) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _WindowManagerEmbedParams();
      params.url = url;
      params.services = services;
      params.exposedServices = exposedServices;
      _proxyImpl.sendMessage(params, _WindowManager_embedName);
    }
    dynamic setCapture(int viewId,[Function responseFactory = null]) {
      var params = new _WindowManagerSetCaptureParams();
      params.viewId = viewId;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _WindowManager_setCaptureName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic focusWindow(int viewId,[Function responseFactory = null]) {
      var params = new _WindowManagerFocusWindowParams();
      params.viewId = viewId;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _WindowManager_focusWindowName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic activateWindow(int viewId,[Function responseFactory = null]) {
      var params = new _WindowManagerActivateWindowParams();
      params.viewId = viewId;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _WindowManager_activateWindowName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic getFocusedAndActiveViews(Object observer,[Function responseFactory = null]) {
      var params = new _WindowManagerGetFocusedAndActiveViewsParams();
      params.observer = observer;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _WindowManager_getFocusedAndActiveViewsName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class WindowManagerProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  WindowManager ptr;

  WindowManagerProxy(_WindowManagerProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _WindowManagerProxyCalls(proxyImpl);

  WindowManagerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _WindowManagerProxyImpl.fromEndpoint(endpoint) {
    ptr = new _WindowManagerProxyCalls(impl);
  }

  WindowManagerProxy.fromHandle(core.MojoHandle handle) :
      impl = new _WindowManagerProxyImpl.fromHandle(handle) {
    ptr = new _WindowManagerProxyCalls(impl);
  }

  WindowManagerProxy.unbound() :
      impl = new _WindowManagerProxyImpl.unbound() {
    ptr = new _WindowManagerProxyCalls(impl);
  }

  factory WindowManagerProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    WindowManagerProxy p = new WindowManagerProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static WindowManagerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For WindowManagerProxy"));
    return new WindowManagerProxy.fromEndpoint(endpoint);
  }

  String get serviceName => WindowManager.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "WindowManagerProxy($impl)";
  }
}


class WindowManagerStub extends bindings.Stub {
  WindowManager _impl = null;

  WindowManagerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  WindowManagerStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  WindowManagerStub.unbound() : super.unbound();

  static WindowManagerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For WindowManagerStub"));
    return new WindowManagerStub.fromEndpoint(endpoint);
  }


  WindowManagerSetCaptureResponseParams _WindowManagerSetCaptureResponseParamsFactory(bool success) {
    var mojo_factory_result = new WindowManagerSetCaptureResponseParams();
    mojo_factory_result.success = success;
    return mojo_factory_result;
  }
  WindowManagerFocusWindowResponseParams _WindowManagerFocusWindowResponseParamsFactory(bool success) {
    var mojo_factory_result = new WindowManagerFocusWindowResponseParams();
    mojo_factory_result.success = success;
    return mojo_factory_result;
  }
  WindowManagerActivateWindowResponseParams _WindowManagerActivateWindowResponseParamsFactory(bool success) {
    var mojo_factory_result = new WindowManagerActivateWindowResponseParams();
    mojo_factory_result.success = success;
    return mojo_factory_result;
  }
  WindowManagerGetFocusedAndActiveViewsResponseParams _WindowManagerGetFocusedAndActiveViewsResponseParamsFactory(int captureViewId, int focusedViewId, int activeViewId) {
    var mojo_factory_result = new WindowManagerGetFocusedAndActiveViewsResponseParams();
    mojo_factory_result.captureViewId = captureViewId;
    mojo_factory_result.focusedViewId = focusedViewId;
    mojo_factory_result.activeViewId = activeViewId;
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
      case _WindowManager_embedName:
        var params = _WindowManagerEmbedParams.deserialize(
            message.payload);
        _impl.embed(params.url, params.services, params.exposedServices);
        break;
      case _WindowManager_setCaptureName:
        var params = _WindowManagerSetCaptureParams.deserialize(
            message.payload);
        var response = _impl.setCapture(params.viewId,_WindowManagerSetCaptureResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _WindowManager_setCaptureName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _WindowManager_setCaptureName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _WindowManager_focusWindowName:
        var params = _WindowManagerFocusWindowParams.deserialize(
            message.payload);
        var response = _impl.focusWindow(params.viewId,_WindowManagerFocusWindowResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _WindowManager_focusWindowName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _WindowManager_focusWindowName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _WindowManager_activateWindowName:
        var params = _WindowManagerActivateWindowParams.deserialize(
            message.payload);
        var response = _impl.activateWindow(params.viewId,_WindowManagerActivateWindowResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _WindowManager_activateWindowName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _WindowManager_activateWindowName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _WindowManager_getFocusedAndActiveViewsName:
        var params = _WindowManagerGetFocusedAndActiveViewsParams.deserialize(
            message.payload);
        var response = _impl.getFocusedAndActiveViews(params.observer,_WindowManagerGetFocusedAndActiveViewsResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _WindowManager_getFocusedAndActiveViewsName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _WindowManager_getFocusedAndActiveViewsName,
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

  WindowManager get impl => _impl;
  set impl(WindowManager d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "WindowManagerStub($superString)";
  }

  int get version => 0;
}

const int _WindowManagerObserver_onCaptureChangedName = 0;
const int _WindowManagerObserver_onFocusChangedName = 1;
const int _WindowManagerObserver_onActiveWindowChangedName = 2;

abstract class WindowManagerObserver {
  static const String serviceName = null;
  void onCaptureChanged(int captureViewId);
  void onFocusChanged(int focusedViewId);
  void onActiveWindowChanged(int focusedViewId);
}


class _WindowManagerObserverProxyImpl extends bindings.Proxy {
  _WindowManagerObserverProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _WindowManagerObserverProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _WindowManagerObserverProxyImpl.unbound() : super.unbound();

  static _WindowManagerObserverProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _WindowManagerObserverProxyImpl"));
    return new _WindowManagerObserverProxyImpl.fromEndpoint(endpoint);
  }

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
    return "_WindowManagerObserverProxyImpl($superString)";
  }
}


class _WindowManagerObserverProxyCalls implements WindowManagerObserver {
  _WindowManagerObserverProxyImpl _proxyImpl;

  _WindowManagerObserverProxyCalls(this._proxyImpl);
    void onCaptureChanged(int captureViewId) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _WindowManagerObserverOnCaptureChangedParams();
      params.captureViewId = captureViewId;
      _proxyImpl.sendMessage(params, _WindowManagerObserver_onCaptureChangedName);
    }
    void onFocusChanged(int focusedViewId) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _WindowManagerObserverOnFocusChangedParams();
      params.focusedViewId = focusedViewId;
      _proxyImpl.sendMessage(params, _WindowManagerObserver_onFocusChangedName);
    }
    void onActiveWindowChanged(int focusedViewId) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _WindowManagerObserverOnActiveWindowChangedParams();
      params.focusedViewId = focusedViewId;
      _proxyImpl.sendMessage(params, _WindowManagerObserver_onActiveWindowChangedName);
    }
}


class WindowManagerObserverProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  WindowManagerObserver ptr;

  WindowManagerObserverProxy(_WindowManagerObserverProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _WindowManagerObserverProxyCalls(proxyImpl);

  WindowManagerObserverProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _WindowManagerObserverProxyImpl.fromEndpoint(endpoint) {
    ptr = new _WindowManagerObserverProxyCalls(impl);
  }

  WindowManagerObserverProxy.fromHandle(core.MojoHandle handle) :
      impl = new _WindowManagerObserverProxyImpl.fromHandle(handle) {
    ptr = new _WindowManagerObserverProxyCalls(impl);
  }

  WindowManagerObserverProxy.unbound() :
      impl = new _WindowManagerObserverProxyImpl.unbound() {
    ptr = new _WindowManagerObserverProxyCalls(impl);
  }

  factory WindowManagerObserverProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    WindowManagerObserverProxy p = new WindowManagerObserverProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static WindowManagerObserverProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For WindowManagerObserverProxy"));
    return new WindowManagerObserverProxy.fromEndpoint(endpoint);
  }

  String get serviceName => WindowManagerObserver.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "WindowManagerObserverProxy($impl)";
  }
}


class WindowManagerObserverStub extends bindings.Stub {
  WindowManagerObserver _impl = null;

  WindowManagerObserverStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  WindowManagerObserverStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  WindowManagerObserverStub.unbound() : super.unbound();

  static WindowManagerObserverStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For WindowManagerObserverStub"));
    return new WindowManagerObserverStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _WindowManagerObserver_onCaptureChangedName:
        var params = _WindowManagerObserverOnCaptureChangedParams.deserialize(
            message.payload);
        _impl.onCaptureChanged(params.captureViewId);
        break;
      case _WindowManagerObserver_onFocusChangedName:
        var params = _WindowManagerObserverOnFocusChangedParams.deserialize(
            message.payload);
        _impl.onFocusChanged(params.focusedViewId);
        break;
      case _WindowManagerObserver_onActiveWindowChangedName:
        var params = _WindowManagerObserverOnActiveWindowChangedParams.deserialize(
            message.payload);
        _impl.onActiveWindowChanged(params.focusedViewId);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  WindowManagerObserver get impl => _impl;
  set impl(WindowManagerObserver d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "WindowManagerObserverStub($superString)";
  }

  int get version => 0;
}


