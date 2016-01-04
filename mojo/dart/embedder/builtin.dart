// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library mojo_builtin;

import 'dart:async';
import 'dart:convert';
import 'dart:mojo.internal';

// Corelib 'print' implementation.
void _print(arg) {
  _Logger._printString(arg.toString());
}

class _Logger {
  static void _printString(String s) native "Logger_PrintString";
}

String _rawUriBase;
Uri _cachedUriBase;
Uri _uriBase() {
  if (_cachedUriBase != null) {
    return _cachedUriBase;
  }
  _cachedUriBase = Uri.parse(_rawUriBase);
  return _cachedUriBase;
}

_setupHooks() {
  VMLibraryHooks.eventHandlerSendData = MojoHandleWatcher.timer;
  VMLibraryHooks.timerMillisecondClock = MojoCoreNatives.timerMillisecondClock;
}

_getUriBaseClosure() => _uriBase;
_getPrintClosure() => _print;

// import 'root_library'; happens here from C Code
// The root library (aka the script) is imported into this library. The
// embedder uses this to lookup the main entrypoint in the root library's
// namespace.
Function _getMainClosure() => main;