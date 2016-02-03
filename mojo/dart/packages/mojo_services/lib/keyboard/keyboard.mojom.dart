// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library keyboard_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/native_viewport_event_dispatcher.mojom.dart' as native_viewport_event_dispatcher_mojom;

class SubmitAction extends bindings.MojoEnum {
  static const SubmitAction done = const SubmitAction._(0);

  const SubmitAction._(int v) : super(v);

  static const Map<String, SubmitAction> valuesMap = const {
    "done": done,
  };
  static const List<SubmitAction> values = const [
    done,
  ];

  static SubmitAction valueOf(String name) => valuesMap[name];

  factory SubmitAction(int v) {
    switch (v) {
      case 0:
        return done;
      default:
        return null;
    }
  }

  static SubmitAction decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    SubmitAction result = new SubmitAction(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum SubmitAction.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case done:
        return 'SubmitAction.done';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}



class KeyboardType extends bindings.MojoEnum {
  static const KeyboardType text = const KeyboardType._(0);
  static const KeyboardType number = const KeyboardType._(1);
  static const KeyboardType phone = const KeyboardType._(2);
  static const KeyboardType datetime = const KeyboardType._(3);

  const KeyboardType._(int v) : super(v);

  static const Map<String, KeyboardType> valuesMap = const {
    "text": text,
    "number": number,
    "phone": phone,
    "datetime": datetime,
  };
  static const List<KeyboardType> values = const [
    text,
    number,
    phone,
    datetime,
  ];

  static KeyboardType valueOf(String name) => valuesMap[name];

  factory KeyboardType(int v) {
    switch (v) {
      case 0:
        return text;
      case 1:
        return number;
      case 2:
        return phone;
      case 3:
        return datetime;
      default:
        return null;
    }
  }

  static KeyboardType decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    KeyboardType result = new KeyboardType(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum KeyboardType.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case text:
        return 'KeyboardType.text';
      case number:
        return 'KeyboardType.number';
      case phone:
        return 'KeyboardType.phone';
      case datetime:
        return 'KeyboardType.datetime';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}





class CompletionData extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(40, 0)
  ];
  int id = 0;
  int position = 0;
  String text = null;
  String label = null;

  CompletionData() : super(kVersions.last.size);

  static CompletionData deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static CompletionData decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    CompletionData result = new CompletionData();

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
      
      result.id = decoder0.decodeInt64(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.position = decoder0.decodeInt32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.text = decoder0.decodeString(24, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.label = decoder0.decodeString(32, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt64(id, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "id of struct CompletionData: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(position, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "position of struct CompletionData: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(text, 24, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "text of struct CompletionData: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(label, 32, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "label of struct CompletionData: $e";
      rethrow;
    }
  }

  String toString() {
    return "CompletionData("
           "id: $id" ", "
           "position: $position" ", "
           "text: $text" ", "
           "label: $label" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["id"] = id;
    map["position"] = position;
    map["text"] = text;
    map["label"] = label;
    return map;
  }
}




class CorrectionData extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  int offset = 0;
  String oldText = null;
  String newText = null;

  CorrectionData() : super(kVersions.last.size);

  static CorrectionData deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static CorrectionData decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    CorrectionData result = new CorrectionData();

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
      
      result.offset = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.oldText = decoder0.decodeString(16, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.newText = decoder0.decodeString(24, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(offset, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "offset of struct CorrectionData: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(oldText, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "oldText of struct CorrectionData: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(newText, 24, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "newText of struct CorrectionData: $e";
      rethrow;
    }
  }

  String toString() {
    return "CorrectionData("
           "offset: $offset" ", "
           "oldText: $oldText" ", "
           "newText: $newText" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["offset"] = offset;
    map["oldText"] = oldText;
    map["newText"] = newText;
    return map;
  }
}




class _KeyboardClientCommitCompletionParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  CompletionData completion = null;

  _KeyboardClientCommitCompletionParams() : super(kVersions.last.size);

  static _KeyboardClientCommitCompletionParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _KeyboardClientCommitCompletionParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _KeyboardClientCommitCompletionParams result = new _KeyboardClientCommitCompletionParams();

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
      result.completion = CompletionData.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(completion, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "completion of struct _KeyboardClientCommitCompletionParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_KeyboardClientCommitCompletionParams("
           "completion: $completion" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["completion"] = completion;
    return map;
  }
}




class _KeyboardClientCommitCorrectionParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  CorrectionData correction = null;

  _KeyboardClientCommitCorrectionParams() : super(kVersions.last.size);

  static _KeyboardClientCommitCorrectionParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _KeyboardClientCommitCorrectionParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _KeyboardClientCommitCorrectionParams result = new _KeyboardClientCommitCorrectionParams();

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
      result.correction = CorrectionData.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(correction, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "correction of struct _KeyboardClientCommitCorrectionParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_KeyboardClientCommitCorrectionParams("
           "correction: $correction" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["correction"] = correction;
    return map;
  }
}




class _KeyboardClientCommitTextParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String text = null;
  int newCursorPosition = 0;

  _KeyboardClientCommitTextParams() : super(kVersions.last.size);

  static _KeyboardClientCommitTextParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _KeyboardClientCommitTextParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _KeyboardClientCommitTextParams result = new _KeyboardClientCommitTextParams();

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
      
      result.text = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.newCursorPosition = decoder0.decodeInt32(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(text, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "text of struct _KeyboardClientCommitTextParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(newCursorPosition, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "newCursorPosition of struct _KeyboardClientCommitTextParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_KeyboardClientCommitTextParams("
           "text: $text" ", "
           "newCursorPosition: $newCursorPosition" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["text"] = text;
    map["newCursorPosition"] = newCursorPosition;
    return map;
  }
}




class _KeyboardClientDeleteSurroundingTextParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int beforeLength = 0;
  int afterLength = 0;

  _KeyboardClientDeleteSurroundingTextParams() : super(kVersions.last.size);

  static _KeyboardClientDeleteSurroundingTextParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _KeyboardClientDeleteSurroundingTextParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _KeyboardClientDeleteSurroundingTextParams result = new _KeyboardClientDeleteSurroundingTextParams();

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
      
      result.beforeLength = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.afterLength = decoder0.decodeInt32(12);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(beforeLength, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "beforeLength of struct _KeyboardClientDeleteSurroundingTextParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(afterLength, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "afterLength of struct _KeyboardClientDeleteSurroundingTextParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_KeyboardClientDeleteSurroundingTextParams("
           "beforeLength: $beforeLength" ", "
           "afterLength: $afterLength" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["beforeLength"] = beforeLength;
    map["afterLength"] = afterLength;
    return map;
  }
}




class _KeyboardClientSetComposingRegionParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int start = 0;
  int end = 0;

  _KeyboardClientSetComposingRegionParams() : super(kVersions.last.size);

  static _KeyboardClientSetComposingRegionParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _KeyboardClientSetComposingRegionParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _KeyboardClientSetComposingRegionParams result = new _KeyboardClientSetComposingRegionParams();

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
      
      result.start = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.end = decoder0.decodeInt32(12);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(start, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "start of struct _KeyboardClientSetComposingRegionParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(end, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "end of struct _KeyboardClientSetComposingRegionParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_KeyboardClientSetComposingRegionParams("
           "start: $start" ", "
           "end: $end" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["start"] = start;
    map["end"] = end;
    return map;
  }
}




class _KeyboardClientSetComposingTextParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String text = null;
  int newCursorPosition = 0;

  _KeyboardClientSetComposingTextParams() : super(kVersions.last.size);

  static _KeyboardClientSetComposingTextParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _KeyboardClientSetComposingTextParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _KeyboardClientSetComposingTextParams result = new _KeyboardClientSetComposingTextParams();

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
      
      result.text = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.newCursorPosition = decoder0.decodeInt32(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(text, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "text of struct _KeyboardClientSetComposingTextParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(newCursorPosition, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "newCursorPosition of struct _KeyboardClientSetComposingTextParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_KeyboardClientSetComposingTextParams("
           "text: $text" ", "
           "newCursorPosition: $newCursorPosition" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["text"] = text;
    map["newCursorPosition"] = newCursorPosition;
    return map;
  }
}




class _KeyboardClientSetSelectionParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int start = 0;
  int end = 0;

  _KeyboardClientSetSelectionParams() : super(kVersions.last.size);

  static _KeyboardClientSetSelectionParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _KeyboardClientSetSelectionParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _KeyboardClientSetSelectionParams result = new _KeyboardClientSetSelectionParams();

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
      
      result.start = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.end = decoder0.decodeInt32(12);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(start, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "start of struct _KeyboardClientSetSelectionParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(end, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "end of struct _KeyboardClientSetSelectionParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_KeyboardClientSetSelectionParams("
           "start: $start" ", "
           "end: $end" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["start"] = start;
    map["end"] = end;
    return map;
  }
}




class _KeyboardClientSubmitParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  SubmitAction action = null;

  _KeyboardClientSubmitParams() : super(kVersions.last.size);

  static _KeyboardClientSubmitParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _KeyboardClientSubmitParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _KeyboardClientSubmitParams result = new _KeyboardClientSubmitParams();

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
      
        result.action = SubmitAction.decode(decoder0, 8);
        if (result.action == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable SubmitAction.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(action, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "action of struct _KeyboardClientSubmitParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_KeyboardClientSubmitParams("
           "action: $action" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["action"] = action;
    return map;
  }
}




class _KeyboardServiceShowParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  Object client = null;
  KeyboardType type = null;

  _KeyboardServiceShowParams() : super(kVersions.last.size);

  static _KeyboardServiceShowParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _KeyboardServiceShowParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _KeyboardServiceShowParams result = new _KeyboardServiceShowParams();

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
      
      result.client = decoder0.decodeServiceInterface(8, false, KeyboardClientProxy.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
        result.type = KeyboardType.decode(decoder0, 16);
        if (result.type == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable KeyboardType.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(client, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "client of struct _KeyboardServiceShowParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(type, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "type of struct _KeyboardServiceShowParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_KeyboardServiceShowParams("
           "client: $client" ", "
           "type: $type" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




class _KeyboardServiceShowByRequestParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _KeyboardServiceShowByRequestParams() : super(kVersions.last.size);

  static _KeyboardServiceShowByRequestParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _KeyboardServiceShowByRequestParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _KeyboardServiceShowByRequestParams result = new _KeyboardServiceShowByRequestParams();

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
    return "_KeyboardServiceShowByRequestParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}




class _KeyboardServiceHideParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _KeyboardServiceHideParams() : super(kVersions.last.size);

  static _KeyboardServiceHideParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _KeyboardServiceHideParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _KeyboardServiceHideParams result = new _KeyboardServiceHideParams();

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
    return "_KeyboardServiceHideParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}




class _KeyboardServiceSetTextParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String text = null;

  _KeyboardServiceSetTextParams() : super(kVersions.last.size);

  static _KeyboardServiceSetTextParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _KeyboardServiceSetTextParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _KeyboardServiceSetTextParams result = new _KeyboardServiceSetTextParams();

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
      
      result.text = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(text, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "text of struct _KeyboardServiceSetTextParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_KeyboardServiceSetTextParams("
           "text: $text" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["text"] = text;
    return map;
  }
}




class _KeyboardServiceSetSelectionParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int start = 0;
  int end = 0;

  _KeyboardServiceSetSelectionParams() : super(kVersions.last.size);

  static _KeyboardServiceSetSelectionParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _KeyboardServiceSetSelectionParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _KeyboardServiceSetSelectionParams result = new _KeyboardServiceSetSelectionParams();

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
      
      result.start = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.end = decoder0.decodeInt32(12);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(start, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "start of struct _KeyboardServiceSetSelectionParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(end, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "end of struct _KeyboardServiceSetSelectionParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_KeyboardServiceSetSelectionParams("
           "start: $start" ", "
           "end: $end" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["start"] = start;
    map["end"] = end;
    return map;
  }
}




class _KeyboardServiceFactoryCreateKeyboardServiceParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object keyEventDispatcher = null;
  Object serviceRequest = null;

  _KeyboardServiceFactoryCreateKeyboardServiceParams() : super(kVersions.last.size);

  static _KeyboardServiceFactoryCreateKeyboardServiceParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _KeyboardServiceFactoryCreateKeyboardServiceParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _KeyboardServiceFactoryCreateKeyboardServiceParams result = new _KeyboardServiceFactoryCreateKeyboardServiceParams();

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
      
      result.keyEventDispatcher = decoder0.decodeInterfaceRequest(8, false, native_viewport_event_dispatcher_mojom.NativeViewportEventDispatcherStub.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.serviceRequest = decoder0.decodeInterfaceRequest(12, false, KeyboardServiceStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(keyEventDispatcher, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "keyEventDispatcher of struct _KeyboardServiceFactoryCreateKeyboardServiceParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(serviceRequest, 12, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "serviceRequest of struct _KeyboardServiceFactoryCreateKeyboardServiceParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_KeyboardServiceFactoryCreateKeyboardServiceParams("
           "keyEventDispatcher: $keyEventDispatcher" ", "
           "serviceRequest: $serviceRequest" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}




const int _KeyboardClient_commitCompletionName = 0;
const int _KeyboardClient_commitCorrectionName = 1;
const int _KeyboardClient_commitTextName = 2;
const int _KeyboardClient_deleteSurroundingTextName = 3;
const int _KeyboardClient_setComposingRegionName = 4;
const int _KeyboardClient_setComposingTextName = 5;
const int _KeyboardClient_setSelectionName = 6;
const int _KeyboardClient_submitName = 7;



class _KeyboardClientServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class KeyboardClient {
  static const String serviceName = null;
  void commitCompletion(CompletionData completion);
  void commitCorrection(CorrectionData correction);
  void commitText(String text, int newCursorPosition);
  void deleteSurroundingText(int beforeLength, int afterLength);
  void setComposingRegion(int start, int end);
  void setComposingText(String text, int newCursorPosition);
  void setSelection(int start, int end);
  void submit(SubmitAction action);
}


class _KeyboardClientProxyImpl extends bindings.Proxy {
  _KeyboardClientProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _KeyboardClientProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _KeyboardClientProxyImpl.unbound() : super.unbound();

  static _KeyboardClientProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _KeyboardClientProxyImpl"));
    return new _KeyboardClientProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _KeyboardClientServiceDescription();

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
    return "_KeyboardClientProxyImpl($superString)";
  }
}


class _KeyboardClientProxyCalls implements KeyboardClient {
  _KeyboardClientProxyImpl _proxyImpl;

  _KeyboardClientProxyCalls(this._proxyImpl);
    void commitCompletion(CompletionData completion) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _KeyboardClientCommitCompletionParams();
      params.completion = completion;
      _proxyImpl.sendMessage(params, _KeyboardClient_commitCompletionName);
    }
    void commitCorrection(CorrectionData correction) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _KeyboardClientCommitCorrectionParams();
      params.correction = correction;
      _proxyImpl.sendMessage(params, _KeyboardClient_commitCorrectionName);
    }
    void commitText(String text, int newCursorPosition) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _KeyboardClientCommitTextParams();
      params.text = text;
      params.newCursorPosition = newCursorPosition;
      _proxyImpl.sendMessage(params, _KeyboardClient_commitTextName);
    }
    void deleteSurroundingText(int beforeLength, int afterLength) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _KeyboardClientDeleteSurroundingTextParams();
      params.beforeLength = beforeLength;
      params.afterLength = afterLength;
      _proxyImpl.sendMessage(params, _KeyboardClient_deleteSurroundingTextName);
    }
    void setComposingRegion(int start, int end) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _KeyboardClientSetComposingRegionParams();
      params.start = start;
      params.end = end;
      _proxyImpl.sendMessage(params, _KeyboardClient_setComposingRegionName);
    }
    void setComposingText(String text, int newCursorPosition) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _KeyboardClientSetComposingTextParams();
      params.text = text;
      params.newCursorPosition = newCursorPosition;
      _proxyImpl.sendMessage(params, _KeyboardClient_setComposingTextName);
    }
    void setSelection(int start, int end) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _KeyboardClientSetSelectionParams();
      params.start = start;
      params.end = end;
      _proxyImpl.sendMessage(params, _KeyboardClient_setSelectionName);
    }
    void submit(SubmitAction action) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _KeyboardClientSubmitParams();
      params.action = action;
      _proxyImpl.sendMessage(params, _KeyboardClient_submitName);
    }
}


class KeyboardClientProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  KeyboardClient ptr;

  KeyboardClientProxy(_KeyboardClientProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _KeyboardClientProxyCalls(proxyImpl);

  KeyboardClientProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _KeyboardClientProxyImpl.fromEndpoint(endpoint) {
    ptr = new _KeyboardClientProxyCalls(impl);
  }

  KeyboardClientProxy.fromHandle(core.MojoHandle handle) :
      impl = new _KeyboardClientProxyImpl.fromHandle(handle) {
    ptr = new _KeyboardClientProxyCalls(impl);
  }

  KeyboardClientProxy.unbound() :
      impl = new _KeyboardClientProxyImpl.unbound() {
    ptr = new _KeyboardClientProxyCalls(impl);
  }

  factory KeyboardClientProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    KeyboardClientProxy p = new KeyboardClientProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static KeyboardClientProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For KeyboardClientProxy"));
    return new KeyboardClientProxy.fromEndpoint(endpoint);
  }

  String get serviceName => KeyboardClient.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "KeyboardClientProxy($impl)";
  }
}


class KeyboardClientStub extends bindings.Stub {
  KeyboardClient _impl = null;

  KeyboardClientStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  KeyboardClientStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  KeyboardClientStub.unbound() : super.unbound();

  static KeyboardClientStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For KeyboardClientStub"));
    return new KeyboardClientStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _KeyboardClient_commitCompletionName:
        var params = _KeyboardClientCommitCompletionParams.deserialize(
            message.payload);
        _impl.commitCompletion(params.completion);
        break;
      case _KeyboardClient_commitCorrectionName:
        var params = _KeyboardClientCommitCorrectionParams.deserialize(
            message.payload);
        _impl.commitCorrection(params.correction);
        break;
      case _KeyboardClient_commitTextName:
        var params = _KeyboardClientCommitTextParams.deserialize(
            message.payload);
        _impl.commitText(params.text, params.newCursorPosition);
        break;
      case _KeyboardClient_deleteSurroundingTextName:
        var params = _KeyboardClientDeleteSurroundingTextParams.deserialize(
            message.payload);
        _impl.deleteSurroundingText(params.beforeLength, params.afterLength);
        break;
      case _KeyboardClient_setComposingRegionName:
        var params = _KeyboardClientSetComposingRegionParams.deserialize(
            message.payload);
        _impl.setComposingRegion(params.start, params.end);
        break;
      case _KeyboardClient_setComposingTextName:
        var params = _KeyboardClientSetComposingTextParams.deserialize(
            message.payload);
        _impl.setComposingText(params.text, params.newCursorPosition);
        break;
      case _KeyboardClient_setSelectionName:
        var params = _KeyboardClientSetSelectionParams.deserialize(
            message.payload);
        _impl.setSelection(params.start, params.end);
        break;
      case _KeyboardClient_submitName:
        var params = _KeyboardClientSubmitParams.deserialize(
            message.payload);
        _impl.submit(params.action);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  KeyboardClient get impl => _impl;
  set impl(KeyboardClient d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "KeyboardClientStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _KeyboardClientServiceDescription();
}

const int _KeyboardService_showName = 0;
const int _KeyboardService_showByRequestName = 1;
const int _KeyboardService_hideName = 2;
const int _KeyboardService_setTextName = 3;
const int _KeyboardService_setSelectionName = 4;



class _KeyboardServiceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class KeyboardService {
  static const String serviceName = "keyboard::KeyboardService";
  void show(Object client, KeyboardType type);
  void showByRequest();
  void hide();
  void setText(String text);
  void setSelection(int start, int end);
}


class _KeyboardServiceProxyImpl extends bindings.Proxy {
  _KeyboardServiceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _KeyboardServiceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _KeyboardServiceProxyImpl.unbound() : super.unbound();

  static _KeyboardServiceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _KeyboardServiceProxyImpl"));
    return new _KeyboardServiceProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _KeyboardServiceServiceDescription();

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
    return "_KeyboardServiceProxyImpl($superString)";
  }
}


class _KeyboardServiceProxyCalls implements KeyboardService {
  _KeyboardServiceProxyImpl _proxyImpl;

  _KeyboardServiceProxyCalls(this._proxyImpl);
    void show(Object client, KeyboardType type) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _KeyboardServiceShowParams();
      params.client = client;
      params.type = type;
      _proxyImpl.sendMessage(params, _KeyboardService_showName);
    }
    void showByRequest() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _KeyboardServiceShowByRequestParams();
      _proxyImpl.sendMessage(params, _KeyboardService_showByRequestName);
    }
    void hide() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _KeyboardServiceHideParams();
      _proxyImpl.sendMessage(params, _KeyboardService_hideName);
    }
    void setText(String text) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _KeyboardServiceSetTextParams();
      params.text = text;
      _proxyImpl.sendMessage(params, _KeyboardService_setTextName);
    }
    void setSelection(int start, int end) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _KeyboardServiceSetSelectionParams();
      params.start = start;
      params.end = end;
      _proxyImpl.sendMessage(params, _KeyboardService_setSelectionName);
    }
}


class KeyboardServiceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  KeyboardService ptr;

  KeyboardServiceProxy(_KeyboardServiceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _KeyboardServiceProxyCalls(proxyImpl);

  KeyboardServiceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _KeyboardServiceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _KeyboardServiceProxyCalls(impl);
  }

  KeyboardServiceProxy.fromHandle(core.MojoHandle handle) :
      impl = new _KeyboardServiceProxyImpl.fromHandle(handle) {
    ptr = new _KeyboardServiceProxyCalls(impl);
  }

  KeyboardServiceProxy.unbound() :
      impl = new _KeyboardServiceProxyImpl.unbound() {
    ptr = new _KeyboardServiceProxyCalls(impl);
  }

  factory KeyboardServiceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    KeyboardServiceProxy p = new KeyboardServiceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static KeyboardServiceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For KeyboardServiceProxy"));
    return new KeyboardServiceProxy.fromEndpoint(endpoint);
  }

  String get serviceName => KeyboardService.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "KeyboardServiceProxy($impl)";
  }
}


class KeyboardServiceStub extends bindings.Stub {
  KeyboardService _impl = null;

  KeyboardServiceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  KeyboardServiceStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  KeyboardServiceStub.unbound() : super.unbound();

  static KeyboardServiceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For KeyboardServiceStub"));
    return new KeyboardServiceStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _KeyboardService_showName:
        var params = _KeyboardServiceShowParams.deserialize(
            message.payload);
        _impl.show(params.client, params.type);
        break;
      case _KeyboardService_showByRequestName:
        var params = _KeyboardServiceShowByRequestParams.deserialize(
            message.payload);
        _impl.showByRequest();
        break;
      case _KeyboardService_hideName:
        var params = _KeyboardServiceHideParams.deserialize(
            message.payload);
        _impl.hide();
        break;
      case _KeyboardService_setTextName:
        var params = _KeyboardServiceSetTextParams.deserialize(
            message.payload);
        _impl.setText(params.text);
        break;
      case _KeyboardService_setSelectionName:
        var params = _KeyboardServiceSetSelectionParams.deserialize(
            message.payload);
        _impl.setSelection(params.start, params.end);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  KeyboardService get impl => _impl;
  set impl(KeyboardService d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "KeyboardServiceStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _KeyboardServiceServiceDescription();
}

const int _KeyboardServiceFactory_createKeyboardServiceName = 0;



class _KeyboardServiceFactoryServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) => null;

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) => null;

  dynamic getAllTypeDefinitions([Function responseFactory]) => null;
}

abstract class KeyboardServiceFactory {
  static const String serviceName = "keyboard::KeyboardServiceFactory";
  void createKeyboardService(Object keyEventDispatcher, Object serviceRequest);
}


class _KeyboardServiceFactoryProxyImpl extends bindings.Proxy {
  _KeyboardServiceFactoryProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _KeyboardServiceFactoryProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _KeyboardServiceFactoryProxyImpl.unbound() : super.unbound();

  static _KeyboardServiceFactoryProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _KeyboardServiceFactoryProxyImpl"));
    return new _KeyboardServiceFactoryProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _KeyboardServiceFactoryServiceDescription();

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
    return "_KeyboardServiceFactoryProxyImpl($superString)";
  }
}


class _KeyboardServiceFactoryProxyCalls implements KeyboardServiceFactory {
  _KeyboardServiceFactoryProxyImpl _proxyImpl;

  _KeyboardServiceFactoryProxyCalls(this._proxyImpl);
    void createKeyboardService(Object keyEventDispatcher, Object serviceRequest) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new _KeyboardServiceFactoryCreateKeyboardServiceParams();
      params.keyEventDispatcher = keyEventDispatcher;
      params.serviceRequest = serviceRequest;
      _proxyImpl.sendMessage(params, _KeyboardServiceFactory_createKeyboardServiceName);
    }
}


class KeyboardServiceFactoryProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  KeyboardServiceFactory ptr;

  KeyboardServiceFactoryProxy(_KeyboardServiceFactoryProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _KeyboardServiceFactoryProxyCalls(proxyImpl);

  KeyboardServiceFactoryProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _KeyboardServiceFactoryProxyImpl.fromEndpoint(endpoint) {
    ptr = new _KeyboardServiceFactoryProxyCalls(impl);
  }

  KeyboardServiceFactoryProxy.fromHandle(core.MojoHandle handle) :
      impl = new _KeyboardServiceFactoryProxyImpl.fromHandle(handle) {
    ptr = new _KeyboardServiceFactoryProxyCalls(impl);
  }

  KeyboardServiceFactoryProxy.unbound() :
      impl = new _KeyboardServiceFactoryProxyImpl.unbound() {
    ptr = new _KeyboardServiceFactoryProxyCalls(impl);
  }

  factory KeyboardServiceFactoryProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    KeyboardServiceFactoryProxy p = new KeyboardServiceFactoryProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static KeyboardServiceFactoryProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For KeyboardServiceFactoryProxy"));
    return new KeyboardServiceFactoryProxy.fromEndpoint(endpoint);
  }

  String get serviceName => KeyboardServiceFactory.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "KeyboardServiceFactoryProxy($impl)";
  }
}


class KeyboardServiceFactoryStub extends bindings.Stub {
  KeyboardServiceFactory _impl = null;

  KeyboardServiceFactoryStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [this._impl])
      : super.fromEndpoint(endpoint);

  KeyboardServiceFactoryStub.fromHandle(core.MojoHandle handle, [this._impl])
      : super.fromHandle(handle);

  KeyboardServiceFactoryStub.unbound() : super.unbound();

  static KeyboardServiceFactoryStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For KeyboardServiceFactoryStub"));
    return new KeyboardServiceFactoryStub.fromEndpoint(endpoint);
  }



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case _KeyboardServiceFactory_createKeyboardServiceName:
        var params = _KeyboardServiceFactoryCreateKeyboardServiceParams.deserialize(
            message.payload);
        _impl.createKeyboardService(params.keyEventDispatcher, params.serviceRequest);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  KeyboardServiceFactory get impl => _impl;
  set impl(KeyboardServiceFactory d) {
    assert(_impl == null);
    _impl = d;
  }

  String toString() {
    var superString = super.toString();
    return "KeyboardServiceFactoryStub($superString)";
  }

  int get version => 0;

  service_describer.ServiceDescription get serviceDescription =>
    new _KeyboardServiceFactoryServiceDescription();
}



