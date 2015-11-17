// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library view_manager_constants_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
class OrderDirection extends bindings.MojoEnum {
  static const ABOVE = const OrderDirection._(1);
  static const BELOW = const OrderDirection._(2);

  const OrderDirection._(int v) : super(v);

  static const Map<String, OrderDirection> valuesMap = const {
    "ABOVE": ABOVE,
    "BELOW": BELOW,
  };
  static const List<OrderDirection> values = const [
    ABOVE,
    BELOW,
  ];

  static OrderDirection valueOf(String name) => valuesMap[name];

  factory OrderDirection(int v) {
    switch (v) {
      case 1:
        return ABOVE;
      case 2:
        return BELOW;
      default:
        return null;
    }
  }

  static OrderDirection decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    OrderDirection result = new OrderDirection(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum OrderDirection.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case ABOVE:
        return 'OrderDirection.ABOVE';
      case BELOW:
        return 'OrderDirection.BELOW';
    }
  }

  int toJson() => value;
}



