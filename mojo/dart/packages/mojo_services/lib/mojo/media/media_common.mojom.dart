// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library media_common_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;

class MediaResult extends bindings.MojoEnum {
  static const MediaResult ok = const MediaResult._(0);
  static const MediaResult unknownError = const MediaResult._(-1);
  static const MediaResult internalError = const MediaResult._(-2);
  static const MediaResult notImplemented = const MediaResult._(-3);
  static const MediaResult unsupportedOperation = const MediaResult._(-4);
  static const MediaResult unsupportedConfig = const MediaResult._(-5);
  static const MediaResult invalidArgument = const MediaResult._(-6);
  static const MediaResult insufficientResources = const MediaResult._(-7);
  static const MediaResult badState = const MediaResult._(-8);
  static const MediaResult bufOverflow = const MediaResult._(-9);
  static const MediaResult flushed = const MediaResult._(-10);
  static const MediaResult busy = const MediaResult._(-11);
  static const MediaResult protocolError = const MediaResult._(-12);
  static const MediaResult alreadyExists = const MediaResult._(-13);
  static const MediaResult notFound = const MediaResult._(-14);
  static const MediaResult shuttingDown = const MediaResult._(-15);
  static const MediaResult connectionLost = const MediaResult._(-16);

  const MediaResult._(int v) : super(v);

  static const Map<String, MediaResult> valuesMap = const {
    "ok": ok,
    "unknownError": unknownError,
    "internalError": internalError,
    "notImplemented": notImplemented,
    "unsupportedOperation": unsupportedOperation,
    "unsupportedConfig": unsupportedConfig,
    "invalidArgument": invalidArgument,
    "insufficientResources": insufficientResources,
    "badState": badState,
    "bufOverflow": bufOverflow,
    "flushed": flushed,
    "busy": busy,
    "protocolError": protocolError,
    "alreadyExists": alreadyExists,
    "notFound": notFound,
    "shuttingDown": shuttingDown,
    "connectionLost": connectionLost,
  };
  static const List<MediaResult> values = const [
    ok,
    unknownError,
    internalError,
    notImplemented,
    unsupportedOperation,
    unsupportedConfig,
    invalidArgument,
    insufficientResources,
    badState,
    bufOverflow,
    flushed,
    busy,
    protocolError,
    alreadyExists,
    notFound,
    shuttingDown,
    connectionLost,
  ];

  static MediaResult valueOf(String name) => valuesMap[name];

  factory MediaResult(int v) {
    switch (v) {
      case 0:
        return ok;
      case -1:
        return unknownError;
      case -2:
        return internalError;
      case -3:
        return notImplemented;
      case -4:
        return unsupportedOperation;
      case -5:
        return unsupportedConfig;
      case -6:
        return invalidArgument;
      case -7:
        return insufficientResources;
      case -8:
        return badState;
      case -9:
        return bufOverflow;
      case -10:
        return flushed;
      case -11:
        return busy;
      case -12:
        return protocolError;
      case -13:
        return alreadyExists;
      case -14:
        return notFound;
      case -15:
        return shuttingDown;
      case -16:
        return connectionLost;
      default:
        return null;
    }
  }

  static MediaResult decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    MediaResult result = new MediaResult(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum MediaResult.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case ok:
        return 'MediaResult.ok';
      case unknownError:
        return 'MediaResult.unknownError';
      case internalError:
        return 'MediaResult.internalError';
      case notImplemented:
        return 'MediaResult.notImplemented';
      case unsupportedOperation:
        return 'MediaResult.unsupportedOperation';
      case unsupportedConfig:
        return 'MediaResult.unsupportedConfig';
      case invalidArgument:
        return 'MediaResult.invalidArgument';
      case insufficientResources:
        return 'MediaResult.insufficientResources';
      case badState:
        return 'MediaResult.badState';
      case bufOverflow:
        return 'MediaResult.bufOverflow';
      case flushed:
        return 'MediaResult.flushed';
      case busy:
        return 'MediaResult.busy';
      case protocolError:
        return 'MediaResult.protocolError';
      case alreadyExists:
        return 'MediaResult.alreadyExists';
      case notFound:
        return 'MediaResult.notFound';
      case shuttingDown:
        return 'MediaResult.shuttingDown';
      case connectionLost:
        return 'MediaResult.connectionLost';
    }
  }

  int toJson() => mojoEnumValue;
}



