// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// This example makes use of mojo:camera which is available only when
// running on Android. It repeatedly captures camera video frame images
// and displays it in a mojo view.
//
// Example usage:
//   pub get
//   pub run sky_tools build
//   pub run sky_tools run_mojo --mojo-path=../../.. --android

import 'dart:sky';
import 'dart:typed_data';

import 'package:mojo_services/mojo/camera.mojom.dart';
import 'package:sky/services.dart';

Image image = null;
final CameraServiceProxy camera = new CameraServiceProxy.unbound();

Picture paint(Rect paintBounds) {
  PictureRecorder recorder = new PictureRecorder();
  if (image != null) {
    Canvas canvas = new Canvas(recorder, paintBounds);
    canvas.translate(paintBounds.width / 2.0, paintBounds.height / 2.0);
    canvas.scale(0.3, 0.3);
    Paint paint = new Paint()..color = const Color.fromARGB(255, 0, 255, 0);
    canvas.drawImage(image, new Point(-image.width / 2.0, -image.height / 2.0), paint);
  }
  return recorder.endRecording();
}

Scene composite(Picture picture, Rect paintBounds) {
  final double devicePixelRatio = view.devicePixelRatio;
  Rect sceneBounds = new Rect.fromLTWH(
      0.0, 0.0, view.width * devicePixelRatio, view.height * devicePixelRatio);
  Float32List deviceTransform = new Float32List(16)
    ..[0] = devicePixelRatio
    ..[5] = devicePixelRatio
    ..[10] = 1.0
    ..[15] = 1.0;
  SceneBuilder sceneBuilder = new SceneBuilder(sceneBounds)
    ..pushTransform(deviceTransform)
    ..addPicture(Offset.zero, picture, paintBounds)
    ..pop();
  return sceneBuilder.build();
}

void beginFrame(double timeStamp) {
  Rect paintBounds = new Rect.fromLTWH(0.0, 0.0, view.width, view.height);
  Picture picture = paint(paintBounds);
  Scene scene = composite(picture, paintBounds);
  view.scene = scene;
}

void drawNextPhoto() {
  var future = camera.ptr.getLatestFrame();
  future.then((response) {
    if (response.content == null) {
      drawNextPhoto();
      return;
    }
    new ImageDecoder(response.content.handle.h, (frame) {
      if (frame != null) {
        image = frame;
        view.scheduleFrame();
        drawNextPhoto();
      }
    });
  });
}

void main() {
  view.setFrameCallback(beginFrame);
  embedder.connectToService("mojo:camera", camera);
  drawNextPhoto();
}