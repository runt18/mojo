// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library keyboard_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo_services/mojo/native_viewport.mojom.dart' as native_viewport_mojom;
class SubmitAction extends bindings.MojoEnum {
  static const DONE = const SubmitAction._(0);

  const SubmitAction._(int v) : super(v);

  static const Map<String, SubmitAction> valuesMap = const {
    "DONE": DONE,
  };
  static const List<SubmitAction> values = const [
    DONE,
  ];

  static SubmitAction valueOf(String name) => valuesMap[name];

  factory SubmitAction(int v) {
    switch (v) {
      case 0:
        return DONE;
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
      case DONE:
        return 'SubmitAction.DONE';
    }
  }

  int toJson() => value;
}
class KeyboardType extends bindings.MojoEnum {
  static const TEXT = const KeyboardType._(0);
  static const NUMBER = const KeyboardType._(1);
  static const PHONE = const KeyboardType._(2);
  static const DATETIME = const KeyboardType._(3);

  const KeyboardType._(int v) : super(v);

  static const Map<String, KeyboardType> valuesMap = const {
    "TEXT": TEXT,
    "NUMBER": NUMBER,
    "PHONE": PHONE,
    "DATETIME": DATETIME,
  };
  static const List<KeyboardType> values = const [
    TEXT,
    NUMBER,
    PHONE,
    DATETIME,
  ];

  static KeyboardType valueOf(String name) => valuesMap[name];

  factory KeyboardType(int v) {
    switch (v) {
      case 0:
        return TEXT;
      case 1:
        return NUMBER;
      case 2:
        return PHONE;
      case 3:
        return DATETIME;
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
      case TEXT:
        return 'KeyboardType.TEXT';
      case NUMBER:
        return 'KeyboardType.NUMBER';
      case PHONE:
        return 'KeyboardType.PHONE';
      case DATETIME:
        return 'KeyboardType.DATETIME';
    }
  }

  int toJson() => value;
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
    
    encoder0.encodeInt64(id, 8);
    
    encoder0.encodeInt32(position, 16);
    
    encoder0.encodeString(text, 24, false);
    
    encoder0.encodeString(label, 32, false);
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
    
    encoder0.encodeInt32(offset, 8);
    
    encoder0.encodeString(oldText, 16, false);
    
    encoder0.encodeString(newText, 24, false);
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


class KeyboardClientCommitCompletionParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  CompletionData completion = null;

  KeyboardClientCommitCompletionParams() : super(kVersions.last.size);

  static KeyboardClientCommitCompletionParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static KeyboardClientCommitCompletionParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    KeyboardClientCommitCompletionParams result = new KeyboardClientCommitCompletionParams();

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
    
    encoder0.encodeStruct(completion, 8, false);
  }

  String toString() {
    return "KeyboardClientCommitCompletionParams("
           "completion: $completion" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["completion"] = completion;
    return map;
  }
}


class KeyboardClientCommitCorrectionParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  CorrectionData correction = null;

  KeyboardClientCommitCorrectionParams() : super(kVersions.last.size);

  static KeyboardClientCommitCorrectionParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static KeyboardClientCommitCorrectionParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    KeyboardClientCommitCorrectionParams result = new KeyboardClientCommitCorrectionParams();

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
    
    encoder0.encodeStruct(correction, 8, false);
  }

  String toString() {
    return "KeyboardClientCommitCorrectionParams("
           "correction: $correction" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["correction"] = correction;
    return map;
  }
}


class KeyboardClientCommitTextParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String text = null;
  int newCursorPosition = 0;

  KeyboardClientCommitTextParams() : super(kVersions.last.size);

  static KeyboardClientCommitTextParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static KeyboardClientCommitTextParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    KeyboardClientCommitTextParams result = new KeyboardClientCommitTextParams();

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
    
    encoder0.encodeString(text, 8, false);
    
    encoder0.encodeInt32(newCursorPosition, 16);
  }

  String toString() {
    return "KeyboardClientCommitTextParams("
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


class KeyboardClientDeleteSurroundingTextParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int beforeLength = 0;
  int afterLength = 0;

  KeyboardClientDeleteSurroundingTextParams() : super(kVersions.last.size);

  static KeyboardClientDeleteSurroundingTextParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static KeyboardClientDeleteSurroundingTextParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    KeyboardClientDeleteSurroundingTextParams result = new KeyboardClientDeleteSurroundingTextParams();

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
    
    encoder0.encodeInt32(beforeLength, 8);
    
    encoder0.encodeInt32(afterLength, 12);
  }

  String toString() {
    return "KeyboardClientDeleteSurroundingTextParams("
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


class KeyboardClientSetComposingRegionParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int start = 0;
  int end = 0;

  KeyboardClientSetComposingRegionParams() : super(kVersions.last.size);

  static KeyboardClientSetComposingRegionParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static KeyboardClientSetComposingRegionParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    KeyboardClientSetComposingRegionParams result = new KeyboardClientSetComposingRegionParams();

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
    
    encoder0.encodeInt32(start, 8);
    
    encoder0.encodeInt32(end, 12);
  }

  String toString() {
    return "KeyboardClientSetComposingRegionParams("
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


class KeyboardClientSetComposingTextParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String text = null;
  int newCursorPosition = 0;

  KeyboardClientSetComposingTextParams() : super(kVersions.last.size);

  static KeyboardClientSetComposingTextParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static KeyboardClientSetComposingTextParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    KeyboardClientSetComposingTextParams result = new KeyboardClientSetComposingTextParams();

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
    
    encoder0.encodeString(text, 8, false);
    
    encoder0.encodeInt32(newCursorPosition, 16);
  }

  String toString() {
    return "KeyboardClientSetComposingTextParams("
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


class KeyboardClientSetSelectionParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int start = 0;
  int end = 0;

  KeyboardClientSetSelectionParams() : super(kVersions.last.size);

  static KeyboardClientSetSelectionParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static KeyboardClientSetSelectionParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    KeyboardClientSetSelectionParams result = new KeyboardClientSetSelectionParams();

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
    
    encoder0.encodeInt32(start, 8);
    
    encoder0.encodeInt32(end, 12);
  }

  String toString() {
    return "KeyboardClientSetSelectionParams("
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


class KeyboardClientSubmitParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  SubmitAction action = null;

  KeyboardClientSubmitParams() : super(kVersions.last.size);

  static KeyboardClientSubmitParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static KeyboardClientSubmitParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    KeyboardClientSubmitParams result = new KeyboardClientSubmitParams();

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
    
    encoder0.encodeEnum(action, 8);
  }

  String toString() {
    return "KeyboardClientSubmitParams("
           "action: $action" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["action"] = action;
    return map;
  }
}


class KeyboardServiceShowParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  Object client = null;
  KeyboardType type = null;

  KeyboardServiceShowParams() : super(kVersions.last.size);

  static KeyboardServiceShowParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static KeyboardServiceShowParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    KeyboardServiceShowParams result = new KeyboardServiceShowParams();

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
    
    encoder0.encodeInterface(client, 8, false);
    
    encoder0.encodeEnum(type, 16);
  }

  String toString() {
    return "KeyboardServiceShowParams("
           "client: $client" ", "
           "type: $type" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class KeyboardServiceShowByRequestParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  KeyboardServiceShowByRequestParams() : super(kVersions.last.size);

  static KeyboardServiceShowByRequestParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static KeyboardServiceShowByRequestParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    KeyboardServiceShowByRequestParams result = new KeyboardServiceShowByRequestParams();

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
    return "KeyboardServiceShowByRequestParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class KeyboardServiceHideParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  KeyboardServiceHideParams() : super(kVersions.last.size);

  static KeyboardServiceHideParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static KeyboardServiceHideParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    KeyboardServiceHideParams result = new KeyboardServiceHideParams();

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
    return "KeyboardServiceHideParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class KeyboardServiceSetTextParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String text = null;

  KeyboardServiceSetTextParams() : super(kVersions.last.size);

  static KeyboardServiceSetTextParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static KeyboardServiceSetTextParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    KeyboardServiceSetTextParams result = new KeyboardServiceSetTextParams();

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
    
    encoder0.encodeString(text, 8, false);
  }

  String toString() {
    return "KeyboardServiceSetTextParams("
           "text: $text" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["text"] = text;
    return map;
  }
}


class KeyboardServiceSetSelectionParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int start = 0;
  int end = 0;

  KeyboardServiceSetSelectionParams() : super(kVersions.last.size);

  static KeyboardServiceSetSelectionParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static KeyboardServiceSetSelectionParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    KeyboardServiceSetSelectionParams result = new KeyboardServiceSetSelectionParams();

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
    
    encoder0.encodeInt32(start, 8);
    
    encoder0.encodeInt32(end, 12);
  }

  String toString() {
    return "KeyboardServiceSetSelectionParams("
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


class KeyboardServiceFactoryCreateKeyboardServiceParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object keyEventDispatcher = null;
  Object serviceRequest = null;

  KeyboardServiceFactoryCreateKeyboardServiceParams() : super(kVersions.last.size);

  static KeyboardServiceFactoryCreateKeyboardServiceParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static KeyboardServiceFactoryCreateKeyboardServiceParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    KeyboardServiceFactoryCreateKeyboardServiceParams result = new KeyboardServiceFactoryCreateKeyboardServiceParams();

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
      
      result.keyEventDispatcher = decoder0.decodeInterfaceRequest(8, false, native_viewport_mojom.NativeViewportEventDispatcherStub.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.serviceRequest = decoder0.decodeInterfaceRequest(12, false, KeyboardServiceStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeInterfaceRequest(keyEventDispatcher, 8, false);
    
    encoder0.encodeInterfaceRequest(serviceRequest, 12, false);
  }

  String toString() {
    return "KeyboardServiceFactoryCreateKeyboardServiceParams("
           "keyEventDispatcher: $keyEventDispatcher" ", "
           "serviceRequest: $serviceRequest" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int kKeyboardClient_commitCompletion_name = 0;
const int kKeyboardClient_commitCorrection_name = 1;
const int kKeyboardClient_commitText_name = 2;
const int kKeyboardClient_deleteSurroundingText_name = 3;
const int kKeyboardClient_setComposingRegion_name = 4;
const int kKeyboardClient_setComposingText_name = 5;
const int kKeyboardClient_setSelection_name = 6;
const int kKeyboardClient_submit_name = 7;
const String KeyboardClientName = null;

abstract class KeyboardClient {
  void commitCompletion(CompletionData completion);
  void commitCorrection(CorrectionData correction);
  void commitText(String text, int newCursorPosition);
  void deleteSurroundingText(int beforeLength, int afterLength);
  void setComposingRegion(int start, int end);
  void setComposingText(String text, int newCursorPosition);
  void setSelection(int start, int end);
  void submit(SubmitAction action);

}


class KeyboardClientProxyImpl extends bindings.Proxy {
  KeyboardClientProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  KeyboardClientProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  KeyboardClientProxyImpl.unbound() : super.unbound();

  static KeyboardClientProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For KeyboardClientProxyImpl"));
    return new KeyboardClientProxyImpl.fromEndpoint(endpoint);
  }

  String get name => KeyboardClientName;

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
    return "KeyboardClientProxyImpl($superString)";
  }
}


class _KeyboardClientProxyCalls implements KeyboardClient {
  KeyboardClientProxyImpl _proxyImpl;

  _KeyboardClientProxyCalls(this._proxyImpl);
    void commitCompletion(CompletionData completion) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new KeyboardClientCommitCompletionParams();
      params.completion = completion;
      _proxyImpl.sendMessage(params, kKeyboardClient_commitCompletion_name);
    }
  
    void commitCorrection(CorrectionData correction) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new KeyboardClientCommitCorrectionParams();
      params.correction = correction;
      _proxyImpl.sendMessage(params, kKeyboardClient_commitCorrection_name);
    }
  
    void commitText(String text, int newCursorPosition) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new KeyboardClientCommitTextParams();
      params.text = text;
      params.newCursorPosition = newCursorPosition;
      _proxyImpl.sendMessage(params, kKeyboardClient_commitText_name);
    }
  
    void deleteSurroundingText(int beforeLength, int afterLength) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new KeyboardClientDeleteSurroundingTextParams();
      params.beforeLength = beforeLength;
      params.afterLength = afterLength;
      _proxyImpl.sendMessage(params, kKeyboardClient_deleteSurroundingText_name);
    }
  
    void setComposingRegion(int start, int end) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new KeyboardClientSetComposingRegionParams();
      params.start = start;
      params.end = end;
      _proxyImpl.sendMessage(params, kKeyboardClient_setComposingRegion_name);
    }
  
    void setComposingText(String text, int newCursorPosition) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new KeyboardClientSetComposingTextParams();
      params.text = text;
      params.newCursorPosition = newCursorPosition;
      _proxyImpl.sendMessage(params, kKeyboardClient_setComposingText_name);
    }
  
    void setSelection(int start, int end) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new KeyboardClientSetSelectionParams();
      params.start = start;
      params.end = end;
      _proxyImpl.sendMessage(params, kKeyboardClient_setSelection_name);
    }
  
    void submit(SubmitAction action) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new KeyboardClientSubmitParams();
      params.action = action;
      _proxyImpl.sendMessage(params, kKeyboardClient_submit_name);
    }
  
}


class KeyboardClientProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  KeyboardClient ptr;
  final String name = KeyboardClientName;

  KeyboardClientProxy(KeyboardClientProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _KeyboardClientProxyCalls(proxyImpl);

  KeyboardClientProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new KeyboardClientProxyImpl.fromEndpoint(endpoint) {
    ptr = new _KeyboardClientProxyCalls(impl);
  }

  KeyboardClientProxy.fromHandle(core.MojoHandle handle) :
      impl = new KeyboardClientProxyImpl.fromHandle(handle) {
    ptr = new _KeyboardClientProxyCalls(impl);
  }

  KeyboardClientProxy.unbound() :
      impl = new KeyboardClientProxyImpl.unbound() {
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

  static const String name = KeyboardClientName;



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case kKeyboardClient_commitCompletion_name:
        var params = KeyboardClientCommitCompletionParams.deserialize(
            message.payload);
        _impl.commitCompletion(params.completion);
        break;
      case kKeyboardClient_commitCorrection_name:
        var params = KeyboardClientCommitCorrectionParams.deserialize(
            message.payload);
        _impl.commitCorrection(params.correction);
        break;
      case kKeyboardClient_commitText_name:
        var params = KeyboardClientCommitTextParams.deserialize(
            message.payload);
        _impl.commitText(params.text, params.newCursorPosition);
        break;
      case kKeyboardClient_deleteSurroundingText_name:
        var params = KeyboardClientDeleteSurroundingTextParams.deserialize(
            message.payload);
        _impl.deleteSurroundingText(params.beforeLength, params.afterLength);
        break;
      case kKeyboardClient_setComposingRegion_name:
        var params = KeyboardClientSetComposingRegionParams.deserialize(
            message.payload);
        _impl.setComposingRegion(params.start, params.end);
        break;
      case kKeyboardClient_setComposingText_name:
        var params = KeyboardClientSetComposingTextParams.deserialize(
            message.payload);
        _impl.setComposingText(params.text, params.newCursorPosition);
        break;
      case kKeyboardClient_setSelection_name:
        var params = KeyboardClientSetSelectionParams.deserialize(
            message.payload);
        _impl.setSelection(params.start, params.end);
        break;
      case kKeyboardClient_submit_name:
        var params = KeyboardClientSubmitParams.deserialize(
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
}

const int kKeyboardService_show_name = 0;
const int kKeyboardService_showByRequest_name = 1;
const int kKeyboardService_hide_name = 2;
const int kKeyboardService_setText_name = 3;
const int kKeyboardService_setSelection_name = 4;
const String KeyboardServiceName = "keyboard::KeyboardService";

abstract class KeyboardService {
  void show(Object client, KeyboardType type);
  void showByRequest();
  void hide();
  void setText(String text);
  void setSelection(int start, int end);

}


class KeyboardServiceProxyImpl extends bindings.Proxy {
  KeyboardServiceProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  KeyboardServiceProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  KeyboardServiceProxyImpl.unbound() : super.unbound();

  static KeyboardServiceProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For KeyboardServiceProxyImpl"));
    return new KeyboardServiceProxyImpl.fromEndpoint(endpoint);
  }

  String get name => KeyboardServiceName;

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
    return "KeyboardServiceProxyImpl($superString)";
  }
}


class _KeyboardServiceProxyCalls implements KeyboardService {
  KeyboardServiceProxyImpl _proxyImpl;

  _KeyboardServiceProxyCalls(this._proxyImpl);
    void show(Object client, KeyboardType type) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new KeyboardServiceShowParams();
      params.client = client;
      params.type = type;
      _proxyImpl.sendMessage(params, kKeyboardService_show_name);
    }
  
    void showByRequest() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new KeyboardServiceShowByRequestParams();
      _proxyImpl.sendMessage(params, kKeyboardService_showByRequest_name);
    }
  
    void hide() {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new KeyboardServiceHideParams();
      _proxyImpl.sendMessage(params, kKeyboardService_hide_name);
    }
  
    void setText(String text) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new KeyboardServiceSetTextParams();
      params.text = text;
      _proxyImpl.sendMessage(params, kKeyboardService_setText_name);
    }
  
    void setSelection(int start, int end) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new KeyboardServiceSetSelectionParams();
      params.start = start;
      params.end = end;
      _proxyImpl.sendMessage(params, kKeyboardService_setSelection_name);
    }
  
}


class KeyboardServiceProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  KeyboardService ptr;
  final String name = KeyboardServiceName;

  KeyboardServiceProxy(KeyboardServiceProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _KeyboardServiceProxyCalls(proxyImpl);

  KeyboardServiceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new KeyboardServiceProxyImpl.fromEndpoint(endpoint) {
    ptr = new _KeyboardServiceProxyCalls(impl);
  }

  KeyboardServiceProxy.fromHandle(core.MojoHandle handle) :
      impl = new KeyboardServiceProxyImpl.fromHandle(handle) {
    ptr = new _KeyboardServiceProxyCalls(impl);
  }

  KeyboardServiceProxy.unbound() :
      impl = new KeyboardServiceProxyImpl.unbound() {
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

  static const String name = KeyboardServiceName;



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case kKeyboardService_show_name:
        var params = KeyboardServiceShowParams.deserialize(
            message.payload);
        _impl.show(params.client, params.type);
        break;
      case kKeyboardService_showByRequest_name:
        var params = KeyboardServiceShowByRequestParams.deserialize(
            message.payload);
        _impl.showByRequest();
        break;
      case kKeyboardService_hide_name:
        var params = KeyboardServiceHideParams.deserialize(
            message.payload);
        _impl.hide();
        break;
      case kKeyboardService_setText_name:
        var params = KeyboardServiceSetTextParams.deserialize(
            message.payload);
        _impl.setText(params.text);
        break;
      case kKeyboardService_setSelection_name:
        var params = KeyboardServiceSetSelectionParams.deserialize(
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
}

const int kKeyboardServiceFactory_createKeyboardService_name = 0;
const String KeyboardServiceFactoryName = "keyboard::KeyboardServiceFactory";

abstract class KeyboardServiceFactory {
  void createKeyboardService(Object keyEventDispatcher, Object serviceRequest);

}


class KeyboardServiceFactoryProxyImpl extends bindings.Proxy {
  KeyboardServiceFactoryProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  KeyboardServiceFactoryProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  KeyboardServiceFactoryProxyImpl.unbound() : super.unbound();

  static KeyboardServiceFactoryProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For KeyboardServiceFactoryProxyImpl"));
    return new KeyboardServiceFactoryProxyImpl.fromEndpoint(endpoint);
  }

  String get name => KeyboardServiceFactoryName;

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
    return "KeyboardServiceFactoryProxyImpl($superString)";
  }
}


class _KeyboardServiceFactoryProxyCalls implements KeyboardServiceFactory {
  KeyboardServiceFactoryProxyImpl _proxyImpl;

  _KeyboardServiceFactoryProxyCalls(this._proxyImpl);
    void createKeyboardService(Object keyEventDispatcher, Object serviceRequest) {
      if (!_proxyImpl.isBound) {
        _proxyImpl.proxyError("The Proxy is closed.");
        return;
      }
      var params = new KeyboardServiceFactoryCreateKeyboardServiceParams();
      params.keyEventDispatcher = keyEventDispatcher;
      params.serviceRequest = serviceRequest;
      _proxyImpl.sendMessage(params, kKeyboardServiceFactory_createKeyboardService_name);
    }
  
}


class KeyboardServiceFactoryProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  KeyboardServiceFactory ptr;
  final String name = KeyboardServiceFactoryName;

  KeyboardServiceFactoryProxy(KeyboardServiceFactoryProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _KeyboardServiceFactoryProxyCalls(proxyImpl);

  KeyboardServiceFactoryProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new KeyboardServiceFactoryProxyImpl.fromEndpoint(endpoint) {
    ptr = new _KeyboardServiceFactoryProxyCalls(impl);
  }

  KeyboardServiceFactoryProxy.fromHandle(core.MojoHandle handle) :
      impl = new KeyboardServiceFactoryProxyImpl.fromHandle(handle) {
    ptr = new _KeyboardServiceFactoryProxyCalls(impl);
  }

  KeyboardServiceFactoryProxy.unbound() :
      impl = new KeyboardServiceFactoryProxyImpl.unbound() {
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

  static const String name = KeyboardServiceFactoryName;



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    assert(_impl != null);
    switch (message.header.type) {
      case kKeyboardServiceFactory_createKeyboardService_name:
        var params = KeyboardServiceFactoryCreateKeyboardServiceParams.deserialize(
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
}


