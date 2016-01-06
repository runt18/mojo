// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library media_state_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;

class MediaState extends bindings.MojoEnum {
  static const MediaState fault = const MediaState._(0);
  static const MediaState unprepared = const MediaState._(1);
  static const MediaState paused = const MediaState._(2);
  static const MediaState playing = const MediaState._(3);
  static const MediaState ended = const MediaState._(4);

  const MediaState._(int v) : super(v);

  static const Map<String, MediaState> valuesMap = const {
    "fault": fault,
    "unprepared": unprepared,
    "paused": paused,
    "playing": playing,
    "ended": ended,
  };
  static const List<MediaState> values = const [
    fault,
    unprepared,
    paused,
    playing,
    ended,
  ];

  static MediaState valueOf(String name) => valuesMap[name];

  factory MediaState(int v) {
    switch (v) {
      case 0:
        return fault;
      case 1:
        return unprepared;
      case 2:
        return paused;
      case 3:
        return playing;
      case 4:
        return ended;
      default:
        return null;
    }
  }

  static MediaState decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    MediaState result = new MediaState(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum MediaState.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case fault:
        return 'MediaState.fault';
      case unprepared:
        return 'MediaState.unprepared';
      case paused:
        return 'MediaState.paused';
      case playing:
        return 'MediaState.playing';
      case ended:
        return 'MediaState.ended';
    }
  }

  int toJson() => mojoEnumValue;
}



