// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library udp_socket_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/network_error.mojom.dart' as network_error_mojom;
import 'package:mojo_services/mojo/net_address.mojom.dart' as net_address_mojom;



class UdpSocketAllowAddressReuseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  UdpSocketAllowAddressReuseParams() : super(kVersions.last.size);

  static UdpSocketAllowAddressReuseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UdpSocketAllowAddressReuseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UdpSocketAllowAddressReuseParams result = new UdpSocketAllowAddressReuseParams();

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
    return "UdpSocketAllowAddressReuseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class UdpSocketAllowAddressReuseResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  network_error_mojom.NetworkError result = null;

  UdpSocketAllowAddressReuseResponseParams() : super(kVersions.last.size);

  static UdpSocketAllowAddressReuseResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UdpSocketAllowAddressReuseResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UdpSocketAllowAddressReuseResponseParams result = new UdpSocketAllowAddressReuseResponseParams();

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
      result.result = network_error_mojom.NetworkError.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(result, 8, false);
  }

  String toString() {
    return "UdpSocketAllowAddressReuseResponseParams("
           "result: $result" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["result"] = result;
    return map;
  }
}


class UdpSocketBindParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  net_address_mojom.NetAddress addr = null;

  UdpSocketBindParams() : super(kVersions.last.size);

  static UdpSocketBindParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UdpSocketBindParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UdpSocketBindParams result = new UdpSocketBindParams();

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
      result.addr = net_address_mojom.NetAddress.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(addr, 8, false);
  }

  String toString() {
    return "UdpSocketBindParams("
           "addr: $addr" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["addr"] = addr;
    return map;
  }
}


class UdpSocketBindResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  network_error_mojom.NetworkError result = null;
  net_address_mojom.NetAddress boundAddr = null;
  Object receiver = null;

  UdpSocketBindResponseParams() : super(kVersions.last.size);

  static UdpSocketBindResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UdpSocketBindResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UdpSocketBindResponseParams result = new UdpSocketBindResponseParams();

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
      result.result = network_error_mojom.NetworkError.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.boundAddr = net_address_mojom.NetAddress.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.receiver = decoder0.decodeInterfaceRequest(24, true, UdpSocketReceiverStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(result, 8, false);
    
    encoder0.encodeStruct(boundAddr, 16, true);
    
    encoder0.encodeInterfaceRequest(receiver, 24, true);
  }

  String toString() {
    return "UdpSocketBindResponseParams("
           "result: $result" ", "
           "boundAddr: $boundAddr" ", "
           "receiver: $receiver" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class UdpSocketConnectParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  net_address_mojom.NetAddress remoteAddr = null;

  UdpSocketConnectParams() : super(kVersions.last.size);

  static UdpSocketConnectParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UdpSocketConnectParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UdpSocketConnectParams result = new UdpSocketConnectParams();

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
      result.remoteAddr = net_address_mojom.NetAddress.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(remoteAddr, 8, false);
  }

  String toString() {
    return "UdpSocketConnectParams("
           "remoteAddr: $remoteAddr" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["remoteAddr"] = remoteAddr;
    return map;
  }
}


class UdpSocketConnectResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  network_error_mojom.NetworkError result = null;
  net_address_mojom.NetAddress localAddr = null;
  Object receiver = null;

  UdpSocketConnectResponseParams() : super(kVersions.last.size);

  static UdpSocketConnectResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UdpSocketConnectResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UdpSocketConnectResponseParams result = new UdpSocketConnectResponseParams();

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
      result.result = network_error_mojom.NetworkError.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.localAddr = net_address_mojom.NetAddress.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.receiver = decoder0.decodeInterfaceRequest(24, true, UdpSocketReceiverStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(result, 8, false);
    
    encoder0.encodeStruct(localAddr, 16, true);
    
    encoder0.encodeInterfaceRequest(receiver, 24, true);
  }

  String toString() {
    return "UdpSocketConnectResponseParams("
           "result: $result" ", "
           "localAddr: $localAddr" ", "
           "receiver: $receiver" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class UdpSocketSetSendBufferSizeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int size = 0;

  UdpSocketSetSendBufferSizeParams() : super(kVersions.last.size);

  static UdpSocketSetSendBufferSizeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UdpSocketSetSendBufferSizeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UdpSocketSetSendBufferSizeParams result = new UdpSocketSetSendBufferSizeParams();

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
      
      result.size = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(size, 8);
  }

  String toString() {
    return "UdpSocketSetSendBufferSizeParams("
           "size: $size" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["size"] = size;
    return map;
  }
}


class UdpSocketSetSendBufferSizeResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  network_error_mojom.NetworkError result = null;

  UdpSocketSetSendBufferSizeResponseParams() : super(kVersions.last.size);

  static UdpSocketSetSendBufferSizeResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UdpSocketSetSendBufferSizeResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UdpSocketSetSendBufferSizeResponseParams result = new UdpSocketSetSendBufferSizeResponseParams();

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
      result.result = network_error_mojom.NetworkError.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(result, 8, false);
  }

  String toString() {
    return "UdpSocketSetSendBufferSizeResponseParams("
           "result: $result" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["result"] = result;
    return map;
  }
}


class UdpSocketSetReceiveBufferSizeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int size = 0;

  UdpSocketSetReceiveBufferSizeParams() : super(kVersions.last.size);

  static UdpSocketSetReceiveBufferSizeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UdpSocketSetReceiveBufferSizeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UdpSocketSetReceiveBufferSizeParams result = new UdpSocketSetReceiveBufferSizeParams();

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
      
      result.size = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(size, 8);
  }

  String toString() {
    return "UdpSocketSetReceiveBufferSizeParams("
           "size: $size" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["size"] = size;
    return map;
  }
}


class UdpSocketSetReceiveBufferSizeResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  network_error_mojom.NetworkError result = null;

  UdpSocketSetReceiveBufferSizeResponseParams() : super(kVersions.last.size);

  static UdpSocketSetReceiveBufferSizeResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UdpSocketSetReceiveBufferSizeResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UdpSocketSetReceiveBufferSizeResponseParams result = new UdpSocketSetReceiveBufferSizeResponseParams();

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
      result.result = network_error_mojom.NetworkError.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(result, 8, false);
  }

  String toString() {
    return "UdpSocketSetReceiveBufferSizeResponseParams("
           "result: $result" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["result"] = result;
    return map;
  }
}


class UdpSocketNegotiateMaxPendingSendRequestsParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int requestedSize = 0;

  UdpSocketNegotiateMaxPendingSendRequestsParams() : super(kVersions.last.size);

  static UdpSocketNegotiateMaxPendingSendRequestsParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UdpSocketNegotiateMaxPendingSendRequestsParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UdpSocketNegotiateMaxPendingSendRequestsParams result = new UdpSocketNegotiateMaxPendingSendRequestsParams();

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
      
      result.requestedSize = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(requestedSize, 8);
  }

  String toString() {
    return "UdpSocketNegotiateMaxPendingSendRequestsParams("
           "requestedSize: $requestedSize" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["requestedSize"] = requestedSize;
    return map;
  }
}


class UdpSocketNegotiateMaxPendingSendRequestsResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int actualSize = 0;

  UdpSocketNegotiateMaxPendingSendRequestsResponseParams() : super(kVersions.last.size);

  static UdpSocketNegotiateMaxPendingSendRequestsResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UdpSocketNegotiateMaxPendingSendRequestsResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UdpSocketNegotiateMaxPendingSendRequestsResponseParams result = new UdpSocketNegotiateMaxPendingSendRequestsResponseParams();

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
      
      result.actualSize = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(actualSize, 8);
  }

  String toString() {
    return "UdpSocketNegotiateMaxPendingSendRequestsResponseParams("
           "actualSize: $actualSize" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["actualSize"] = actualSize;
    return map;
  }
}


class UdpSocketReceiveMoreParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int datagramNumber = 0;

  UdpSocketReceiveMoreParams() : super(kVersions.last.size);

  static UdpSocketReceiveMoreParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UdpSocketReceiveMoreParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UdpSocketReceiveMoreParams result = new UdpSocketReceiveMoreParams();

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
      
      result.datagramNumber = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint32(datagramNumber, 8);
  }

  String toString() {
    return "UdpSocketReceiveMoreParams("
           "datagramNumber: $datagramNumber" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["datagramNumber"] = datagramNumber;
    return map;
  }
}


class UdpSocketSendToParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  net_address_mojom.NetAddress destAddr = null;
  List<int> data = null;

  UdpSocketSendToParams() : super(kVersions.last.size);

  static UdpSocketSendToParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UdpSocketSendToParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UdpSocketSendToParams result = new UdpSocketSendToParams();

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
      result.destAddr = net_address_mojom.NetAddress.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.data = decoder0.decodeUint8Array(16, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(destAddr, 8, true);
    
    encoder0.encodeUint8Array(data, 16, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
  }

  String toString() {
    return "UdpSocketSendToParams("
           "destAddr: $destAddr" ", "
           "data: $data" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["destAddr"] = destAddr;
    map["data"] = data;
    return map;
  }
}


class UdpSocketSendToResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  network_error_mojom.NetworkError result = null;

  UdpSocketSendToResponseParams() : super(kVersions.last.size);

  static UdpSocketSendToResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UdpSocketSendToResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UdpSocketSendToResponseParams result = new UdpSocketSendToResponseParams();

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
      result.result = network_error_mojom.NetworkError.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(result, 8, false);
  }

  String toString() {
    return "UdpSocketSendToResponseParams("
           "result: $result" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["result"] = result;
    return map;
  }
}


class UdpSocketReceiverOnReceivedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  network_error_mojom.NetworkError result = null;
  net_address_mojom.NetAddress srcAddr = null;
  List<int> data = null;

  UdpSocketReceiverOnReceivedParams() : super(kVersions.last.size);

  static UdpSocketReceiverOnReceivedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UdpSocketReceiverOnReceivedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UdpSocketReceiverOnReceivedParams result = new UdpSocketReceiverOnReceivedParams();

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
      result.result = network_error_mojom.NetworkError.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.srcAddr = net_address_mojom.NetAddress.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.data = decoder0.decodeUint8Array(24, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeStruct(result, 8, false);
    
    encoder0.encodeStruct(srcAddr, 16, true);
    
    encoder0.encodeUint8Array(data, 24, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
  }

  String toString() {
    return "UdpSocketReceiverOnReceivedParams("
           "result: $result" ", "
           "srcAddr: $srcAddr" ", "
           "data: $data" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["result"] = result;
    map["srcAddr"] = srcAddr;
    map["data"] = data;
    return map;
  }
}

const int kUdpSocket_allowAddressReuse_name = 0;
const int kUdpSocket_bind_name = 1;
const int kUdpSocket_connect_name = 2;
const int kUdpSocket_setSendBufferSize_name = 3;
const int kUdpSocket_setReceiveBufferSize_name = 4;
const int kUdpSocket_negotiateMaxPendingSendRequests_name = 5;
const int kUdpSocket_receiveMore_name = 6;
const int kUdpSocket_sendTo_name = 7;

const String UdpSocketName =
      'mojo::UDPSocket';

abstract class UdpSocket {
  dynamic allowAddressReuse([Function responseFactory = null]);
  dynamic bind(net_address_mojom.NetAddress addr,[Function responseFactory = null]);
  dynamic connect(net_address_mojom.NetAddress remoteAddr,[Function responseFactory = null]);
  dynamic setSendBufferSize(int size,[Function responseFactory = null]);
  dynamic setReceiveBufferSize(int size,[Function responseFactory = null]);
  dynamic negotiateMaxPendingSendRequests(int requestedSize,[Function responseFactory = null]);
  void receiveMore(int datagramNumber);
  dynamic sendTo(net_address_mojom.NetAddress destAddr,List<int> data,[Function responseFactory = null]);

}


class UdpSocketProxyImpl extends bindings.Proxy {
  UdpSocketProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  UdpSocketProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  UdpSocketProxyImpl.unbound() : super.unbound();

  static UdpSocketProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For UdpSocketProxyImpl"));
    return new UdpSocketProxyImpl.fromEndpoint(endpoint);
  }

  String get name => UdpSocketName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case kUdpSocket_allowAddressReuse_name:
        var r = UdpSocketAllowAddressReuseResponseParams.deserialize(
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
      case kUdpSocket_bind_name:
        var r = UdpSocketBindResponseParams.deserialize(
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
      case kUdpSocket_connect_name:
        var r = UdpSocketConnectResponseParams.deserialize(
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
      case kUdpSocket_setSendBufferSize_name:
        var r = UdpSocketSetSendBufferSizeResponseParams.deserialize(
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
      case kUdpSocket_setReceiveBufferSize_name:
        var r = UdpSocketSetReceiveBufferSizeResponseParams.deserialize(
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
      case kUdpSocket_negotiateMaxPendingSendRequests_name:
        var r = UdpSocketNegotiateMaxPendingSendRequestsResponseParams.deserialize(
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
      case kUdpSocket_sendTo_name:
        var r = UdpSocketSendToResponseParams.deserialize(
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
    return "UdpSocketProxyImpl($superString)";
  }
}


class _UdpSocketProxyCalls implements UdpSocket {
  UdpSocketProxyImpl _proxyImpl;

  _UdpSocketProxyCalls(this._proxyImpl);
    dynamic allowAddressReuse([Function responseFactory = null]) {
      var params = new UdpSocketAllowAddressReuseParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kUdpSocket_allowAddressReuse_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic bind(net_address_mojom.NetAddress addr,[Function responseFactory = null]) {
      var params = new UdpSocketBindParams();
      params.addr = addr;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kUdpSocket_bind_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic connect(net_address_mojom.NetAddress remoteAddr,[Function responseFactory = null]) {
      var params = new UdpSocketConnectParams();
      params.remoteAddr = remoteAddr;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kUdpSocket_connect_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic setSendBufferSize(int size,[Function responseFactory = null]) {
      var params = new UdpSocketSetSendBufferSizeParams();
      params.size = size;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kUdpSocket_setSendBufferSize_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic setReceiveBufferSize(int size,[Function responseFactory = null]) {
      var params = new UdpSocketSetReceiveBufferSizeParams();
      params.size = size;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kUdpSocket_setReceiveBufferSize_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic negotiateMaxPendingSendRequests(int requestedSize,[Function responseFactory = null]) {
      var params = new UdpSocketNegotiateMaxPendingSendRequestsParams();
      params.requestedSize = requestedSize;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kUdpSocket_negotiateMaxPendingSendRequests_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    void receiveMore(int datagramNumber) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new UdpSocketReceiveMoreParams();
      params.datagramNumber = datagramNumber;
      _proxyImpl.sendMessage(params, kUdpSocket_receiveMore_name);
    }
  
    dynamic sendTo(net_address_mojom.NetAddress destAddr,List<int> data,[Function responseFactory = null]) {
      var params = new UdpSocketSendToParams();
      params.destAddr = destAddr;
      params.data = data;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          kUdpSocket_sendTo_name,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class UdpSocketProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  UdpSocket ptr;
  final String name = UdpSocketName;

  UdpSocketProxy(UdpSocketProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _UdpSocketProxyCalls(proxyImpl);

  UdpSocketProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new UdpSocketProxyImpl.fromEndpoint(endpoint) {
    ptr = new _UdpSocketProxyCalls(impl);
  }

  UdpSocketProxy.fromHandle(core.MojoHandle handle) :
      impl = new UdpSocketProxyImpl.fromHandle(handle) {
    ptr = new _UdpSocketProxyCalls(impl);
  }

  UdpSocketProxy.unbound() :
      impl = new UdpSocketProxyImpl.unbound() {
    ptr = new _UdpSocketProxyCalls(impl);
  }

  factory UdpSocketProxy.connectToService(
      bindings.ServiceConnector s, String url) {
    UdpSocketProxy p = new UdpSocketProxy.unbound();
    s.connectToService(url, p);
    return p;
  }

  static UdpSocketProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For UdpSocketProxy"));
    return new UdpSocketProxy.fromEndpoint(endpoint);
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
    return "UdpSocketProxy($impl)";
  }
}


class UdpSocketStub extends bindings.Stub {
  UdpSocket _impl = null;

  UdpSocketStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  UdpSocketStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  UdpSocketStub.unbound() : super.unbound();

  static UdpSocketStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For UdpSocketStub"));
    return new UdpSocketStub.fromEndpoint(endpoint);
  }

  static const String name = UdpSocketName;


  UdpSocketAllowAddressReuseResponseParams _UdpSocketAllowAddressReuseResponseParamsFactory(network_error_mojom.NetworkError result) {
    var mojo_factory_result = new UdpSocketAllowAddressReuseResponseParams();
    mojo_factory_result.result = result;
    return mojo_factory_result;
  }
  UdpSocketBindResponseParams _UdpSocketBindResponseParamsFactory(network_error_mojom.NetworkError result, net_address_mojom.NetAddress boundAddr, Object receiver) {
    var mojo_factory_result = new UdpSocketBindResponseParams();
    mojo_factory_result.result = result;
    mojo_factory_result.boundAddr = boundAddr;
    mojo_factory_result.receiver = receiver;
    return mojo_factory_result;
  }
  UdpSocketConnectResponseParams _UdpSocketConnectResponseParamsFactory(network_error_mojom.NetworkError result, net_address_mojom.NetAddress localAddr, Object receiver) {
    var mojo_factory_result = new UdpSocketConnectResponseParams();
    mojo_factory_result.result = result;
    mojo_factory_result.localAddr = localAddr;
    mojo_factory_result.receiver = receiver;
    return mojo_factory_result;
  }
  UdpSocketSetSendBufferSizeResponseParams _UdpSocketSetSendBufferSizeResponseParamsFactory(network_error_mojom.NetworkError result) {
    var mojo_factory_result = new UdpSocketSetSendBufferSizeResponseParams();
    mojo_factory_result.result = result;
    return mojo_factory_result;
  }
  UdpSocketSetReceiveBufferSizeResponseParams _UdpSocketSetReceiveBufferSizeResponseParamsFactory(network_error_mojom.NetworkError result) {
    var mojo_factory_result = new UdpSocketSetReceiveBufferSizeResponseParams();
    mojo_factory_result.result = result;
    return mojo_factory_result;
  }
  UdpSocketNegotiateMaxPendingSendRequestsResponseParams _UdpSocketNegotiateMaxPendingSendRequestsResponseParamsFactory(int actualSize) {
    var mojo_factory_result = new UdpSocketNegotiateMaxPendingSendRequestsResponseParams();
    mojo_factory_result.actualSize = actualSize;
    return mojo_factory_result;
  }
  UdpSocketSendToResponseParams _UdpSocketSendToResponseParamsFactory(network_error_mojom.NetworkError result) {
    var mojo_factory_result = new UdpSocketSendToResponseParams();
    mojo_factory_result.result = result;
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
      case kUdpSocket_allowAddressReuse_name:
        var params = UdpSocketAllowAddressReuseParams.deserialize(
            message.payload);
        var response = _impl.allowAddressReuse(_UdpSocketAllowAddressReuseResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kUdpSocket_allowAddressReuse_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kUdpSocket_allowAddressReuse_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kUdpSocket_bind_name:
        var params = UdpSocketBindParams.deserialize(
            message.payload);
        var response = _impl.bind(params.addr,_UdpSocketBindResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kUdpSocket_bind_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kUdpSocket_bind_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kUdpSocket_connect_name:
        var params = UdpSocketConnectParams.deserialize(
            message.payload);
        var response = _impl.connect(params.remoteAddr,_UdpSocketConnectResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kUdpSocket_connect_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kUdpSocket_connect_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kUdpSocket_setSendBufferSize_name:
        var params = UdpSocketSetSendBufferSizeParams.deserialize(
            message.payload);
        var response = _impl.setSendBufferSize(params.size,_UdpSocketSetSendBufferSizeResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kUdpSocket_setSendBufferSize_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kUdpSocket_setSendBufferSize_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kUdpSocket_setReceiveBufferSize_name:
        var params = UdpSocketSetReceiveBufferSizeParams.deserialize(
            message.payload);
        var response = _impl.setReceiveBufferSize(params.size,_UdpSocketSetReceiveBufferSizeResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kUdpSocket_setReceiveBufferSize_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kUdpSocket_setReceiveBufferSize_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kUdpSocket_negotiateMaxPendingSendRequests_name:
        var params = UdpSocketNegotiateMaxPendingSendRequestsParams.deserialize(
            message.payload);
        var response = _impl.negotiateMaxPendingSendRequests(params.requestedSize,_UdpSocketNegotiateMaxPendingSendRequestsResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kUdpSocket_negotiateMaxPendingSendRequests_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kUdpSocket_negotiateMaxPendingSendRequests_name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case kUdpSocket_receiveMore_name:
        var params = UdpSocketReceiveMoreParams.deserialize(
            message.payload);
        _impl.receiveMore(params.datagramNumber);
        break;
      case kUdpSocket_sendTo_name:
        var params = UdpSocketSendToParams.deserialize(
            message.payload);
        var response = _impl.sendTo(params.destAddr,params.data,_UdpSocketSendToResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  kUdpSocket_sendTo_name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              kUdpSocket_sendTo_name,
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

  UdpSocket get impl => _impl;
  set impl(UdpSocket d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "UdpSocketStub($superString)";
  }

  int get version => 0;
}

const int kUdpSocketReceiver_onReceived_name = 0;

const String UdpSocketReceiverName =
      'mojo::UDPSocketReceiver';

abstract class UdpSocketReceiver {
  void onReceived(network_error_mojom.NetworkError result, net_address_mojom.NetAddress srcAddr, List<int> data);

}


class UdpSocketReceiverProxyImpl extends bindings.Proxy {
  UdpSocketReceiverProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  UdpSocketReceiverProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  UdpSocketReceiverProxyImpl.unbound() : super.unbound();

  static UdpSocketReceiverProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For UdpSocketReceiverProxyImpl"));
    return new UdpSocketReceiverProxyImpl.fromEndpoint(endpoint);
  }

  String get name => UdpSocketReceiverName;

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
    return "UdpSocketReceiverProxyImpl($superString)";
  }
}


class _UdpSocketReceiverProxyCalls implements UdpSocketReceiver {
  UdpSocketReceiverProxyImpl _proxyImpl;

  _UdpSocketReceiverProxyCalls(this._proxyImpl);
    void onReceived(network_error_mojom.NetworkError result, net_address_mojom.NetAddress srcAddr, List<int> data) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new UdpSocketReceiverOnReceivedParams();
      params.result = result;
      params.srcAddr = srcAddr;
      params.data = data;
      _proxyImpl.sendMessage(params, kUdpSocketReceiver_onReceived_name);
    }
  
}


class UdpSocketReceiverProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  UdpSocketReceiver ptr;
  final String name = UdpSocketReceiverName;

  UdpSocketReceiverProxy(UdpSocketReceiverProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _UdpSocketReceiverProxyCalls(proxyImpl);

  UdpSocketReceiverProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new UdpSocketReceiverProxyImpl.fromEndpoint(endpoint) {
    ptr = new _UdpSocketReceiverProxyCalls(impl);
  }

  UdpSocketReceiverProxy.fromHandle(core.MojoHandle handle) :
      impl = new UdpSocketReceiverProxyImpl.fromHandle(handle) {
    ptr = new _UdpSocketReceiverProxyCalls(impl);
  }

  UdpSocketReceiverProxy.unbound() :
      impl = new UdpSocketReceiverProxyImpl.unbound() {
    ptr = new _UdpSocketReceiverProxyCalls(impl);
  }

  factory UdpSocketReceiverProxy.connectToService(
      bindings.ServiceConnector s, String url) {
    UdpSocketReceiverProxy p = new UdpSocketReceiverProxy.unbound();
    s.connectToService(url, p);
    return p;
  }

  static UdpSocketReceiverProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For UdpSocketReceiverProxy"));
    return new UdpSocketReceiverProxy.fromEndpoint(endpoint);
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
    return "UdpSocketReceiverProxy($impl)";
  }
}


class UdpSocketReceiverStub extends bindings.Stub {
  UdpSocketReceiver _impl = null;

  UdpSocketReceiverStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  UdpSocketReceiverStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  UdpSocketReceiverStub.unbound() : super.unbound();

  static UdpSocketReceiverStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For UdpSocketReceiverStub"));
    return new UdpSocketReceiverStub.fromEndpoint(endpoint);
  }

  static const String name = UdpSocketReceiverName;



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case kUdpSocketReceiver_onReceived_name:
        var params = UdpSocketReceiverOnReceivedParams.deserialize(
            message.payload);
        _impl.onReceived(params.result, params.srcAddr, params.data);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  UdpSocketReceiver get impl => _impl;
  set impl(UdpSocketReceiver d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "UdpSocketReceiverStub($superString)";
  }

  int get version => 0;
}


