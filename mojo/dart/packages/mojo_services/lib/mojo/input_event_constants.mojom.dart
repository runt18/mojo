// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library input_event_constants_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
class EventType extends bindings.MojoEnum {
  static const UNKNOWN = const EventType._(0);
  static const KEY_PRESSED = const EventType._(1);
  static const KEY_RELEASED = const EventType._(2);
  static const POINTER_CANCEL = const EventType._(3);
  static const POINTER_DOWN = const EventType._(4);
  static const POINTER_MOVE = const EventType._(5);
  static const POINTER_UP = const EventType._(6);

  const EventType._(int v) : super(v);

  static const Map<String, EventType> valuesMap = const {
    "UNKNOWN": UNKNOWN,
    "KEY_PRESSED": KEY_PRESSED,
    "KEY_RELEASED": KEY_RELEASED,
    "POINTER_CANCEL": POINTER_CANCEL,
    "POINTER_DOWN": POINTER_DOWN,
    "POINTER_MOVE": POINTER_MOVE,
    "POINTER_UP": POINTER_UP,
  };
  static const List<EventType> values = const [
    UNKNOWN,
    KEY_PRESSED,
    KEY_RELEASED,
    POINTER_CANCEL,
    POINTER_DOWN,
    POINTER_MOVE,
    POINTER_UP,
  ];

  static EventType valueOf(String name) => valuesMap[name];

  factory EventType(int v) {
    switch (v) {
      case 0:
        return UNKNOWN;
      case 1:
        return KEY_PRESSED;
      case 2:
        return KEY_RELEASED;
      case 3:
        return POINTER_CANCEL;
      case 4:
        return POINTER_DOWN;
      case 5:
        return POINTER_MOVE;
      case 6:
        return POINTER_UP;
      default:
        return null;
    }
  }

  static EventType decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    EventType result = new EventType(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum EventType.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case UNKNOWN:
        return 'EventType.UNKNOWN';
      case KEY_PRESSED:
        return 'EventType.KEY_PRESSED';
      case KEY_RELEASED:
        return 'EventType.KEY_RELEASED';
      case POINTER_CANCEL:
        return 'EventType.POINTER_CANCEL';
      case POINTER_DOWN:
        return 'EventType.POINTER_DOWN';
      case POINTER_MOVE:
        return 'EventType.POINTER_MOVE';
      case POINTER_UP:
        return 'EventType.POINTER_UP';
    }
  }

  int toJson() => value;
}
class EventFlags extends bindings.MojoEnum {
  static const NONE = const EventFlags._(0);
  static const CAPS_LOCK_DOWN = const EventFlags._(1);
  static const SHIFT_DOWN = const EventFlags._(2);
  static const CONTROL_DOWN = const EventFlags._(4);
  static const ALT_DOWN = const EventFlags._(8);
  static const LEFT_MOUSE_BUTTON = const EventFlags._(16);
  static const MIDDLE_MOUSE_BUTTON = const EventFlags._(32);
  static const RIGHT_MOUSE_BUTTON = const EventFlags._(64);
  static const COMMAND_DOWN = const EventFlags._(128);
  static const EXTENDED = const EventFlags._(256);
  static const IS_SYNTHESIZED = const EventFlags._(512);
  static const ALTGR_DOWN = const EventFlags._(1024);
  static const MOD3_DOWN = const EventFlags._(2048);

  const EventFlags._(int v) : super(v);

  static const Map<String, EventFlags> valuesMap = const {
    "NONE": NONE,
    "CAPS_LOCK_DOWN": CAPS_LOCK_DOWN,
    "SHIFT_DOWN": SHIFT_DOWN,
    "CONTROL_DOWN": CONTROL_DOWN,
    "ALT_DOWN": ALT_DOWN,
    "LEFT_MOUSE_BUTTON": LEFT_MOUSE_BUTTON,
    "MIDDLE_MOUSE_BUTTON": MIDDLE_MOUSE_BUTTON,
    "RIGHT_MOUSE_BUTTON": RIGHT_MOUSE_BUTTON,
    "COMMAND_DOWN": COMMAND_DOWN,
    "EXTENDED": EXTENDED,
    "IS_SYNTHESIZED": IS_SYNTHESIZED,
    "ALTGR_DOWN": ALTGR_DOWN,
    "MOD3_DOWN": MOD3_DOWN,
  };
  static const List<EventFlags> values = const [
    NONE,
    CAPS_LOCK_DOWN,
    SHIFT_DOWN,
    CONTROL_DOWN,
    ALT_DOWN,
    LEFT_MOUSE_BUTTON,
    MIDDLE_MOUSE_BUTTON,
    RIGHT_MOUSE_BUTTON,
    COMMAND_DOWN,
    EXTENDED,
    IS_SYNTHESIZED,
    ALTGR_DOWN,
    MOD3_DOWN,
  ];

  static EventFlags valueOf(String name) => valuesMap[name];

  factory EventFlags(int v) {
    switch (v) {
      case 0:
        return NONE;
      case 1:
        return CAPS_LOCK_DOWN;
      case 2:
        return SHIFT_DOWN;
      case 4:
        return CONTROL_DOWN;
      case 8:
        return ALT_DOWN;
      case 16:
        return LEFT_MOUSE_BUTTON;
      case 32:
        return MIDDLE_MOUSE_BUTTON;
      case 64:
        return RIGHT_MOUSE_BUTTON;
      case 128:
        return COMMAND_DOWN;
      case 256:
        return EXTENDED;
      case 512:
        return IS_SYNTHESIZED;
      case 1024:
        return ALTGR_DOWN;
      case 2048:
        return MOD3_DOWN;
      default:
        return null;
    }
  }

  static EventFlags decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    EventFlags result = new EventFlags(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum EventFlags.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case NONE:
        return 'EventFlags.NONE';
      case CAPS_LOCK_DOWN:
        return 'EventFlags.CAPS_LOCK_DOWN';
      case SHIFT_DOWN:
        return 'EventFlags.SHIFT_DOWN';
      case CONTROL_DOWN:
        return 'EventFlags.CONTROL_DOWN';
      case ALT_DOWN:
        return 'EventFlags.ALT_DOWN';
      case LEFT_MOUSE_BUTTON:
        return 'EventFlags.LEFT_MOUSE_BUTTON';
      case MIDDLE_MOUSE_BUTTON:
        return 'EventFlags.MIDDLE_MOUSE_BUTTON';
      case RIGHT_MOUSE_BUTTON:
        return 'EventFlags.RIGHT_MOUSE_BUTTON';
      case COMMAND_DOWN:
        return 'EventFlags.COMMAND_DOWN';
      case EXTENDED:
        return 'EventFlags.EXTENDED';
      case IS_SYNTHESIZED:
        return 'EventFlags.IS_SYNTHESIZED';
      case ALTGR_DOWN:
        return 'EventFlags.ALTGR_DOWN';
      case MOD3_DOWN:
        return 'EventFlags.MOD3_DOWN';
    }
  }

  int toJson() => value;
}
class MouseEventFlags extends bindings.MojoEnum {
  static const IS_DOUBLE_CLICK = const MouseEventFlags._(65536);
  static const IS_TRIPLE_CLICK = const MouseEventFlags._(131072);
  static const IS_NON_CLIENT = const MouseEventFlags._(262144);

  const MouseEventFlags._(int v) : super(v);

  static const Map<String, MouseEventFlags> valuesMap = const {
    "IS_DOUBLE_CLICK": IS_DOUBLE_CLICK,
    "IS_TRIPLE_CLICK": IS_TRIPLE_CLICK,
    "IS_NON_CLIENT": IS_NON_CLIENT,
  };
  static const List<MouseEventFlags> values = const [
    IS_DOUBLE_CLICK,
    IS_TRIPLE_CLICK,
    IS_NON_CLIENT,
  ];

  static MouseEventFlags valueOf(String name) => valuesMap[name];

  factory MouseEventFlags(int v) {
    switch (v) {
      case 65536:
        return IS_DOUBLE_CLICK;
      case 131072:
        return IS_TRIPLE_CLICK;
      case 262144:
        return IS_NON_CLIENT;
      default:
        return null;
    }
  }

  static MouseEventFlags decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    MouseEventFlags result = new MouseEventFlags(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum MouseEventFlags.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case IS_DOUBLE_CLICK:
        return 'MouseEventFlags.IS_DOUBLE_CLICK';
      case IS_TRIPLE_CLICK:
        return 'MouseEventFlags.IS_TRIPLE_CLICK';
      case IS_NON_CLIENT:
        return 'MouseEventFlags.IS_NON_CLIENT';
    }
  }

  int toJson() => value;
}
class PointerKind extends bindings.MojoEnum {
  static const TOUCH = const PointerKind._(0);
  static const MOUSE = const PointerKind._(1);

  const PointerKind._(int v) : super(v);

  static const Map<String, PointerKind> valuesMap = const {
    "TOUCH": TOUCH,
    "MOUSE": MOUSE,
  };
  static const List<PointerKind> values = const [
    TOUCH,
    MOUSE,
  ];

  static PointerKind valueOf(String name) => valuesMap[name];

  factory PointerKind(int v) {
    switch (v) {
      case 0:
        return TOUCH;
      case 1:
        return MOUSE;
      default:
        return null;
    }
  }

  static PointerKind decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    PointerKind result = new PointerKind(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum PointerKind.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case TOUCH:
        return 'PointerKind.TOUCH';
      case MOUSE:
        return 'PointerKind.MOUSE';
    }
  }

  int toJson() => value;
}



