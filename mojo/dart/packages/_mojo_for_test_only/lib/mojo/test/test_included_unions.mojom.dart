// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library test_included_unions_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;




enum IncludedUnionTag {
  a,
  unknown
}

class IncludedUnion extends bindings.Union {
  static final _tag_to_int = const {
    IncludedUnionTag.a: 0,
  };

  static final _int_to_tag = const {
    0: IncludedUnionTag.a,
  };

  var _data;
  IncludedUnionTag _tag = IncludedUnionTag.unknown;

  IncludedUnionTag get tag => _tag;
  int get a {
    if (_tag != IncludedUnionTag.a) {
      throw new bindings.UnsetUnionTagError(_tag, IncludedUnionTag.a);
    }
    return _data;
  }

  set a(int value) {
    _tag = IncludedUnionTag.a;
    _data = value;
  }

  static IncludedUnion decode(bindings.Decoder decoder0, int offset) {
    int size = decoder0.decodeUint32(offset);
    if (size == 0) {
      return null;
    }
    IncludedUnion result = new IncludedUnion();

    // TODO(azani): Handle unknown union member.
    IncludedUnionTag tag = _int_to_tag[decoder0.decodeUint32(offset + 4)];
    switch (tag) {
      case IncludedUnionTag.a:
        
        result.a = decoder0.decodeInt8(offset + 8);
        break;
    }

    return result;
  }

  void encode(bindings.Encoder encoder0, int offset) {
    // TODO(azani): Error when trying to encode an unknown member.
    encoder0.encodeUint32(16, offset);
    encoder0.encodeUint32(_tag_to_int[_tag], offset + 4);
    switch (_tag) {
      case IncludedUnionTag.a:
        
        encoder0.encodeInt8(a, offset + 8);
        break;
    }
  }

  String toString() {
    String result = "IncludedUnion(";
    switch (_tag) {
      case IncludedUnionTag.a:
        result += "a";
        break;
      default:
        result += "unknown";
    }
    result += ": $_data)";
    return result;
  }
}

