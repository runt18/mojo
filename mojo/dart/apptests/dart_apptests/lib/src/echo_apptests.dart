// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library echo_apptests;

import 'dart:async';

import 'package:mojo_apptest/apptest.dart';
import 'package:mojo/application.dart';
import 'package:mojo/bindings.dart';
import 'package:mojo/core.dart';
import 'package:_mojo_for_test_only/test/echo_service.mojom.dart';

echoApptests(Application application, String url) {
  group('Echo Service Apptests', () {
    test('String', () async {
      var echoProxy =
          new EchoServiceProxy.connectToService(application, "mojo:dart_echo");

      var v = await echoProxy.ptr.echoString("foo");
      expect(v.value, equals("foo"));

      var q = await echoProxy.ptr.echoString("quit");
      expect(q.value, equals("quit"));

      await echoProxy.close();
    });

    test('Empty String', () async {
      var echoProxy =
          new EchoServiceProxy.connectToService(application, "mojo:dart_echo");

      var v = await echoProxy.ptr.echoString("");
      expect(v.value, equals(""));

      var q = await echoProxy.ptr.echoString("quit");
      expect(q.value, equals("quit"));

      await echoProxy.close();
    });

    test('Null String', () async {
      var echoProxy =
          new EchoServiceProxy.connectToService(application, "mojo:dart_echo");

      var v = await echoProxy.ptr.echoString(null);
      expect(v.value, equals(null));

      var q = await echoProxy.ptr.echoString("quit");
      expect(q.value, equals("quit"));

      await echoProxy.close();
    });

    test('Delayed Success', () async {
      var echoProxy =
          new EchoServiceProxy.connectToService(application, "mojo:dart_echo");

      var milliseconds = 100;
      var watch = new Stopwatch()..start();
      var v = await echoProxy.ptr.delayedEchoString("foo", milliseconds);
      var elapsed = watch.elapsedMilliseconds;
      expect(v.value, equals("foo"));
      expect(elapsed, greaterThanOrEqualTo(milliseconds));

      var q = await echoProxy.ptr.echoString("quit");
      expect(q.value, equals("quit"));

      await echoProxy.close();
    });

    test('Delayed Close', () {
      var echoProxy =
          new EchoServiceProxy.connectToService(application, "mojo:dart_echo");

      var milliseconds = 100;
      echoProxy.responseOrError(echoProxy.ptr.delayedEchoString(
          "quit", milliseconds)).then((result) {
        fail('This future should not complete.');
      }, onError: (e) {
        expect(e is ProxyError, isTrue);
      });

      return new Future.delayed(
          new Duration(milliseconds: 10), () => echoProxy.close());
    });

    test('Multiple Error Checks Success', () {
      var echoProxy =
          new EchoServiceProxy.connectToService(application, "mojo:dart_echo");

      List<Future> futures = [];
      for (int i = 0; i < 100; i++) {
        var f = echoProxy.responseOrError(echoProxy.ptr.echoString("foo"))
                         .then((r) {
          expect(r.value, equals("foo"));
        }, onError: (e) {
          fail('There should be no errors');
        });
        futures.add(f);
      }
      return Future.wait(futures).whenComplete(() => echoProxy.close());
    });

    test('Multiple Error Checks Fail', () {
      var echoProxy =
          new EchoServiceProxy.connectToService(application, "mojo:dart_echo");

      List<Future> futures = [];
      var milliseconds = 100;
      for (int i = 0; i < 100; i++) {
        var f = echoProxy.responseOrError(
            echoProxy.ptr.delayedEchoString("foo", milliseconds)).then((_) {
          fail('This call should fail');
        }, onError: (e) {
          expect(e is ProxyError, isTrue);
        });
        futures.add(f);
      }
      return echoProxy.close().then((_) => Future.wait(futures));
    });

    test('Uncaught Call Closed', () async {
      var echoProxy =
          new EchoServiceProxy.connectToService(application, "mojo:dart_echo");

      // Do a normal call.
      var v = await echoProxy.ptr.echoString("foo");
      expect(v.value, equals("foo"));

      // Close the proxy.
      await echoProxy.close();

      // Try to do another call, which should not return.
      echoProxy.ptr.echoString("foo").then((_) {
        fail('This should be unreachable');
      });
    });

    test('Catch Call Closed', () async {
      var echoProxy =
          new EchoServiceProxy.connectToService(application, "mojo:dart_echo");

      // Do a normal call.
      var v = await echoProxy.ptr.echoString("foo");
      expect(v.value, equals("foo"));

      // Close the proxy.
      await echoProxy.close();

      // Try to do another call, which should fail.
      bool caughtException = false;
      try {
        v = await echoProxy.responseOrError(echoProxy.ptr.echoString("foo"));
        fail('This should be unreachable');
      } on ProxyError catch (e) {
        caughtException = true;
      }
      expect(caughtException, isTrue);
    });

    test('Catch Call Sequence Closed Twice', () async {
      var echoProxy =
          new EchoServiceProxy.connectToService(application, "mojo:dart_echo");

      // Do a normal call.
      var v = await echoProxy.ptr.echoString("foo");
      expect(v.value, equals("foo"));

      // Close the proxy.
      await echoProxy.close();

      // Try to do another call, which should fail.
      bool caughtException = false;
      try {
        v = await echoProxy.responseOrError(echoProxy.ptr.echoString("foo"));
        fail('This should be unreachable');
      } on ProxyError catch (e) {
        caughtException = true;
      }
      expect(caughtException, isTrue);

      // Make sure we can catch an error more than once.
      caughtException = false;
      try {
        v = await echoProxy.responseOrError(echoProxy.ptr.echoString("foo"));
        fail('This should be unreachable');
      } on ProxyError catch (e) {
        caughtException = true;
      }
      expect(caughtException, isTrue);
    });

    test('Catch Call Parallel Closed Twice', () async {
      var echoProxy =
          new EchoServiceProxy.connectToService(application, "mojo:dart_echo");

      // Do a normal call.
      var v = await echoProxy.ptr.echoString("foo");
      expect(v.value, equals("foo"));

      // Close the proxy.
      await echoProxy.close();

      // Queue up two calls after the close, and make sure they both fail.
      var f1 = echoProxy.responseOrError(echoProxy.ptr.echoString("foo"))
                        .then((_) {
        fail('This should be unreachable');
      }, onError: (e) {
        expect(e is ProxyError, isTrue);
      });

      var f2 = echoProxy.responseOrError(echoProxy.ptr.echoString("foo"))
                        .then((_) {
        fail('This should be unreachable');
      }, onError: (e) {
        expect(e is ProxyError, isTrue);
      });

      return Future.wait([f1, f2]);
    });

    test('Unbind, close', () async {
      var echoProxy =
          new EchoServiceProxy.connectToService(application, "mojo:dart_echo");

      var r = await echoProxy.responseOrError(echoProxy.ptr.echoString("foo"));
      expect(r.value, equals("foo"));

      var endpoint = echoProxy.impl.unbind();
      await echoProxy.close();
      endpoint.close();
    });

    test('Unbind, rebind to same', () async {
      var echoProxy =
          new EchoServiceProxy.connectToService(application, "mojo:dart_echo");

      var r = await echoProxy.responseOrError(echoProxy.ptr.echoString("foo"));
      expect(r.value, equals("foo"));

      var endpoint = echoProxy.impl.unbind();
      echoProxy.impl.bind(endpoint);

      r = await echoProxy.responseOrError(echoProxy.ptr.echoString("foo"));
      expect(r.value, equals("foo"));

      await echoProxy.close();
    });

    test('Unbind, rebind to different', () async {
      var echoProxy =
          new EchoServiceProxy.connectToService(application, "mojo:dart_echo");

      var r = await echoProxy.responseOrError(echoProxy.ptr.echoString("foo"));
      expect(r.value, equals("foo"));

      var endpoint = echoProxy.impl.unbind();
      var differentEchoProxy = new EchoServiceProxy.fromEndpoint(endpoint);

      r = await differentEchoProxy.responseOrError(
          differentEchoProxy.ptr.echoString("foo"));
      expect(r.value, equals("foo"));

      await differentEchoProxy.close();
    });

    test('Unbind, rebind to different, close original', () async {
      var echoProxy =
          new EchoServiceProxy.connectToService(application, "mojo:dart_echo");

      var r = await echoProxy.responseOrError(echoProxy.ptr.echoString("foo"));
      expect(r.value, equals("foo"));

      var endpoint = echoProxy.impl.unbind();
      var differentEchoProxy = new EchoServiceProxy.fromEndpoint(endpoint);
      await echoProxy.close();

      r = await differentEchoProxy.responseOrError(
          differentEchoProxy.ptr.echoString("foo"));
      expect(r.value, equals("foo"));

      await differentEchoProxy.close();
    });
  });
}
