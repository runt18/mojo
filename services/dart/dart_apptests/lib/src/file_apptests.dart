// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library file_apptests;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:mojo_apptest/apptest.dart';
import 'package:mojo/application.dart';
import 'package:mojo/bindings.dart';
import 'package:mojo/core.dart';

tests(Application application, String url) {
  group('File Apptests', () {
    test('Absolute path', () async {
      String current = Directory.current.path;
      for (String relative in ['abd', '..', '.', 'efg/hij', 'abc/']) {
        if (current.endsWith('/')) {
          expect(new File(relative).absolute.path, '$current$relative');
        } else {
          expect(new File(relative).absolute.path, '$current/$relative');
        }
        expect(new File(relative).absolute.isAbsolute, isTrue);
        expect(new Directory(relative).absolute.path,
               new Link(relative).absolute.path);
        expect(new File(relative).absolute is File, isTrue);
        expect(new Directory(relative).absolute is Directory, isTrue);
        expect(new Link(relative).absolute is Link, isTrue);
      }
      for (String absolute in ['/abd', '/', '/./..\\', '/efg/hij', '/abc/']) {
        expect(new File(absolute).absolute.path, absolute);
        expect(new File(absolute).absolute.isAbsolute, isTrue);
       }
    });
    test('File Constructor', () async {
      expect(new File('blåbærgrød'), isNotNull);
      expect(new File('foo.txt'), isNotNull);
    });
    test('Directory systemTemp', () async {
      expect(Directory.systemTemp, isNotNull);
    });
    test('Directory create', () async {
      Directory directory =
          await Directory.systemTemp.createTemp('dart_directory_test');
      Directory subDirectory = new Directory("${directory.path}/subdir");
      expect('$directory'.contains(directory.path), isTrue);
      expect(await subDirectory.exists(), isFalse);
      await subDirectory.create();
      expect(await subDirectory.exists(), isTrue);
      File f = new File('${subDirectory.path}/file.txt');
      File fLong = new File('${directory.path}/subdir/../subdir/file.txt');
      expect(await f.exists(), isFalse);
      await fLong.create();
      expect(await f.exists(), isTrue);
    });
  });
}
