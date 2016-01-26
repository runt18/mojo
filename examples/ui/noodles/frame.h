// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef EXAMPLES_UI_NOODLES_FRAME_H_
#define EXAMPLES_UI_NOODLES_FRAME_H_

#include "base/macros.h"
#include "mojo/services/geometry/interfaces/geometry.mojom.h"
#include "mojo/services/gfx/composition/interfaces/scenes.mojom.h"
#include "skia/ext/refptr.h"

class SkCanvas;
class SkPicture;

namespace examples {

// A frame of content to be rasterized.
// Instances of this object are created by the view's thread and sent to
// the rasterizer's thread to be drawn.
class Frame {
 public:
  Frame(const mojo::Size& size,
        skia::RefPtr<SkPicture> picture,
        mojo::gfx::composition::SceneMetadataPtr scene_metadata);
  ~Frame();

  const mojo::Size& size() { return size_; }

  mojo::gfx::composition::SceneMetadataPtr TakeSceneMetadata() {
    return scene_metadata_.Pass();
  }

  void Paint(SkCanvas* canvas);

 private:
  mojo::Size size_;
  skia::RefPtr<SkPicture> picture_;
  mojo::gfx::composition::SceneMetadataPtr scene_metadata_;

  DISALLOW_COPY_AND_ASSIGN(Frame);
};

}  // namespace examples

#endif  // EXAMPLES_UI_NOODLES_FRAME_H_
