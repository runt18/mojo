// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library input_event_constants_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;


class EventType extends bindings.MojoEnum {
  static const EventType unknown = const EventType._(0);
  static const EventType keyPressed = const EventType._(1);
  static const EventType keyReleased = const EventType._(2);
  static const EventType pointerCancel = const EventType._(3);
  static const EventType pointerDown = const EventType._(4);
  static const EventType pointerMove = const EventType._(5);
  static const EventType pointerUp = const EventType._(6);

  const EventType._(int v) : super(v);

  static const Map<String, EventType> valuesMap = const {
    "unknown": unknown,
    "keyPressed": keyPressed,
    "keyReleased": keyReleased,
    "pointerCancel": pointerCancel,
    "pointerDown": pointerDown,
    "pointerMove": pointerMove,
    "pointerUp": pointerUp,
  };
  static const List<EventType> values = const [
    unknown,
    keyPressed,
    keyReleased,
    pointerCancel,
    pointerDown,
    pointerMove,
    pointerUp,
  ];

  static EventType valueOf(String name) => valuesMap[name];

  factory EventType(int v) {
    switch (v) {
      case 0:
        return unknown;
      case 1:
        return keyPressed;
      case 2:
        return keyReleased;
      case 3:
        return pointerCancel;
      case 4:
        return pointerDown;
      case 5:
        return pointerMove;
      case 6:
        return pointerUp;
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
      case unknown:
        return 'EventType.unknown';
      case keyPressed:
        return 'EventType.keyPressed';
      case keyReleased:
        return 'EventType.keyReleased';
      case pointerCancel:
        return 'EventType.pointerCancel';
      case pointerDown:
        return 'EventType.pointerDown';
      case pointerMove:
        return 'EventType.pointerMove';
      case pointerUp:
        return 'EventType.pointerUp';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}



class EventFlags extends bindings.MojoEnum {
  static const EventFlags none = const EventFlags._(0);
  static const EventFlags capsLockDown = const EventFlags._(1);
  static const EventFlags shiftDown = const EventFlags._(2);
  static const EventFlags controlDown = const EventFlags._(4);
  static const EventFlags altDown = const EventFlags._(8);
  static const EventFlags leftMouseButton = const EventFlags._(16);
  static const EventFlags middleMouseButton = const EventFlags._(32);
  static const EventFlags rightMouseButton = const EventFlags._(64);
  static const EventFlags commandDown = const EventFlags._(128);
  static const EventFlags extended = const EventFlags._(256);
  static const EventFlags isSynthesized = const EventFlags._(512);
  static const EventFlags altgrDown = const EventFlags._(1024);
  static const EventFlags mod3Down = const EventFlags._(2048);

  const EventFlags._(int v) : super(v);

  static const Map<String, EventFlags> valuesMap = const {
    "none": none,
    "capsLockDown": capsLockDown,
    "shiftDown": shiftDown,
    "controlDown": controlDown,
    "altDown": altDown,
    "leftMouseButton": leftMouseButton,
    "middleMouseButton": middleMouseButton,
    "rightMouseButton": rightMouseButton,
    "commandDown": commandDown,
    "extended": extended,
    "isSynthesized": isSynthesized,
    "altgrDown": altgrDown,
    "mod3Down": mod3Down,
  };
  static const List<EventFlags> values = const [
    none,
    capsLockDown,
    shiftDown,
    controlDown,
    altDown,
    leftMouseButton,
    middleMouseButton,
    rightMouseButton,
    commandDown,
    extended,
    isSynthesized,
    altgrDown,
    mod3Down,
  ];

  static EventFlags valueOf(String name) => valuesMap[name];

  factory EventFlags(int v) {
    switch (v) {
      case 0:
        return none;
      case 1:
        return capsLockDown;
      case 2:
        return shiftDown;
      case 4:
        return controlDown;
      case 8:
        return altDown;
      case 16:
        return leftMouseButton;
      case 32:
        return middleMouseButton;
      case 64:
        return rightMouseButton;
      case 128:
        return commandDown;
      case 256:
        return extended;
      case 512:
        return isSynthesized;
      case 1024:
        return altgrDown;
      case 2048:
        return mod3Down;
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
      case none:
        return 'EventFlags.none';
      case capsLockDown:
        return 'EventFlags.capsLockDown';
      case shiftDown:
        return 'EventFlags.shiftDown';
      case controlDown:
        return 'EventFlags.controlDown';
      case altDown:
        return 'EventFlags.altDown';
      case leftMouseButton:
        return 'EventFlags.leftMouseButton';
      case middleMouseButton:
        return 'EventFlags.middleMouseButton';
      case rightMouseButton:
        return 'EventFlags.rightMouseButton';
      case commandDown:
        return 'EventFlags.commandDown';
      case extended:
        return 'EventFlags.extended';
      case isSynthesized:
        return 'EventFlags.isSynthesized';
      case altgrDown:
        return 'EventFlags.altgrDown';
      case mod3Down:
        return 'EventFlags.mod3Down';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}



class MouseEventFlags extends bindings.MojoEnum {
  static const MouseEventFlags isDoubleClick = const MouseEventFlags._(65536);
  static const MouseEventFlags isTripleClick = const MouseEventFlags._(131072);
  static const MouseEventFlags isNonClient = const MouseEventFlags._(262144);

  const MouseEventFlags._(int v) : super(v);

  static const Map<String, MouseEventFlags> valuesMap = const {
    "isDoubleClick": isDoubleClick,
    "isTripleClick": isTripleClick,
    "isNonClient": isNonClient,
  };
  static const List<MouseEventFlags> values = const [
    isDoubleClick,
    isTripleClick,
    isNonClient,
  ];

  static MouseEventFlags valueOf(String name) => valuesMap[name];

  factory MouseEventFlags(int v) {
    switch (v) {
      case 65536:
        return isDoubleClick;
      case 131072:
        return isTripleClick;
      case 262144:
        return isNonClient;
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
      case isDoubleClick:
        return 'MouseEventFlags.isDoubleClick';
      case isTripleClick:
        return 'MouseEventFlags.isTripleClick';
      case isNonClient:
        return 'MouseEventFlags.isNonClient';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}



class PointerKind extends bindings.MojoEnum {
  static const PointerKind touch = const PointerKind._(0);
  static const PointerKind mouse = const PointerKind._(1);

  const PointerKind._(int v) : super(v);

  static const Map<String, PointerKind> valuesMap = const {
    "touch": touch,
    "mouse": mouse,
  };
  static const List<PointerKind> values = const [
    touch,
    mouse,
  ];

  static PointerKind valueOf(String name) => valuesMap[name];

  factory PointerKind(int v) {
    switch (v) {
      case 0:
        return touch;
      case 1:
        return mouse;
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
      case touch:
        return 'PointerKind.touch';
      case mouse:
        return 'PointerKind.mouse';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}







