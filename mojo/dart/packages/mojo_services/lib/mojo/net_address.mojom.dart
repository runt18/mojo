// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library net_address_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;


class NetAddressFamily extends bindings.MojoEnum {
  static const NetAddressFamily unspecified = const NetAddressFamily._(0);
  static const NetAddressFamily ipv4 = const NetAddressFamily._(1);
  static const NetAddressFamily ipv6 = const NetAddressFamily._(2);

  const NetAddressFamily._(int v) : super(v);

  static const Map<String, NetAddressFamily> valuesMap = const {
    "unspecified": unspecified,
    "ipv4": ipv4,
    "ipv6": ipv6,
  };
  static const List<NetAddressFamily> values = const [
    unspecified,
    ipv4,
    ipv6,
  ];

  static NetAddressFamily valueOf(String name) => valuesMap[name];

  factory NetAddressFamily(int v) {
    switch (v) {
      case 0:
        return unspecified;
      case 1:
        return ipv4;
      case 2:
        return ipv6;
      default:
        return null;
    }
  }

  static NetAddressFamily decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    NetAddressFamily result = new NetAddressFamily(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum NetAddressFamily.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case unspecified:
        return 'NetAddressFamily.unspecified';
      case ipv4:
        return 'NetAddressFamily.ipv4';
      case ipv6:
        return 'NetAddressFamily.ipv6';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}





class NetAddressIPv4 extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int port = 0;
  List<int> addr = null;

  NetAddressIPv4() : super(kVersions.last.size);

  static NetAddressIPv4 deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NetAddressIPv4 decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NetAddressIPv4 result = new NetAddressIPv4();

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
      
      result.port = decoder0.decodeUint16(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.addr = decoder0.decodeUint8Array(16, bindings.kNothingNullable, 4);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint16(port, 8);
    
    encoder0.encodeUint8Array(addr, 16, bindings.kNothingNullable, 4);
  }

  String toString() {
    return "NetAddressIPv4("
           "port: $port" ", "
           "addr: $addr" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["port"] = port;
    map["addr"] = addr;
    return map;
  }
}




class NetAddressIPv6 extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int port = 0;
  List<int> addr = null;

  NetAddressIPv6() : super(kVersions.last.size);

  static NetAddressIPv6 deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NetAddressIPv6 decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NetAddressIPv6 result = new NetAddressIPv6();

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
      
      result.port = decoder0.decodeUint16(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.addr = decoder0.decodeUint8Array(16, bindings.kNothingNullable, 16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint16(port, 8);
    
    encoder0.encodeUint8Array(addr, 16, bindings.kNothingNullable, 16);
  }

  String toString() {
    return "NetAddressIPv6("
           "port: $port" ", "
           "addr: $addr" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["port"] = port;
    map["addr"] = addr;
    return map;
  }
}




class NetAddress extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  NetAddressFamily family = new NetAddressFamily(0);
  NetAddressIPv4 ipv4 = null;
  NetAddressIPv6 ipv6 = null;

  NetAddress() : super(kVersions.last.size);

  static NetAddress deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NetAddress decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NetAddress result = new NetAddress();

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
      
        result.family = NetAddressFamily.decode(decoder0, 8);
        if (result.family == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable NetAddressFamily.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.ipv4 = NetAddressIPv4.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, true);
      result.ipv6 = NetAddressIPv6.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeEnum(family, 8);
    
    encoder0.encodeStruct(ipv4, 16, true);
    
    encoder0.encodeStruct(ipv6, 24, true);
  }

  String toString() {
    return "NetAddress("
           "family: $family" ", "
           "ipv4: $ipv4" ", "
           "ipv6: $ipv6" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["family"] = family;
    map["ipv4"] = ipv4;
    map["ipv6"] = ipv6;
    return map;
  }
}






