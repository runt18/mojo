// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library media_metadata_mojom;

import 'dart:async';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;



class MediaMetadata extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(64, 0)
  ];
  int duration = 0;
  String title = null;
  String artist = null;
  String album = null;
  String publisher = null;
  String genre = null;
  String composer = null;

  MediaMetadata() : super(kVersions.last.size);

  static MediaMetadata deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaMetadata decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaMetadata result = new MediaMetadata();

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
      
      result.duration = decoder0.decodeUint64(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.title = decoder0.decodeString(16, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.artist = decoder0.decodeString(24, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.album = decoder0.decodeString(32, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.publisher = decoder0.decodeString(40, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.genre = decoder0.decodeString(48, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.composer = decoder0.decodeString(56, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    
    encoder0.encodeUint64(duration, 8);
    
    encoder0.encodeString(title, 16, true);
    
    encoder0.encodeString(artist, 24, true);
    
    encoder0.encodeString(album, 32, true);
    
    encoder0.encodeString(publisher, 40, true);
    
    encoder0.encodeString(genre, 48, true);
    
    encoder0.encodeString(composer, 56, true);
  }

  String toString() {
    return "MediaMetadata("
           "duration: $duration" ", "
           "title: $title" ", "
           "artist: $artist" ", "
           "album: $album" ", "
           "publisher: $publisher" ", "
           "genre: $genre" ", "
           "composer: $composer" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["duration"] = duration;
    map["title"] = title;
    map["artist"] = artist;
    map["album"] = album;
    map["publisher"] = publisher;
    map["genre"] = genre;
    map["composer"] = composer;
    return map;
  }
}


