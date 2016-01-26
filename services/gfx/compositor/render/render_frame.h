// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_GFX_COMPOSITOR_RENDER_RENDER_FRAME_H_
#define SERVICES_GFX_COMPOSITOR_RENDER_RENDER_FRAME_H_

#include <memory>

#include "base/macros.h"
#include "mojo/services/gfx/composition/interfaces/hit_tests.mojom.h"
#include "mojo/services/gfx/composition/interfaces/scheduling.mojom.h"
#include "third_party/skia/include/core/SkRect.h"

class SkCanvas;
struct SkPoint;

namespace compositor {

class RenderLayer;

// Describes a sequence of drawing commands to be evaluated as a single pass.
// Frames are introduced into the render frame at points where blending must
// occur or where portions of a scene graph may be drawn once into a temporary
// buffer and used many times.
//
// Render objects are thread-safe, immutable, and reference counted via
// std::shared_ptr.  They have no direct references to the scene graph.
class RenderFrame {
 public:
  RenderFrame(const std::shared_ptr<RenderLayer>& root_layer,
              const SkRect& viewport,
              const mojo::gfx::composition::FrameInfo& frame_info);
  ~RenderFrame();

  static std::shared_ptr<RenderFrame> Create(
      const std::shared_ptr<RenderLayer>& root_layer,
      const SkRect& viewport,
      const mojo::gfx::composition::FrameInfo& frame_info) {
    return std::make_shared<RenderFrame>(root_layer, viewport, frame_info);
  }

  // Gets the root layer of the frame.
  const std::shared_ptr<RenderLayer>& root_layer() const { return root_layer_; }

  // Gets the frame's viewport.
  const SkRect& viewport() const { return viewport_; }

  // Gets information about the frame to be rendered.
  const mojo::gfx::composition::FrameInfo& frame_info() const {
    return frame_info_;
  }

  // Paints the frame to a canvas.
  void Paint(SkCanvas* canvas) const;

  // Performs a hit test on the content of the frame.
  mojo::gfx::composition::HitTestResultPtr HitTest(const SkPoint& point) const;

 private:
  friend class RenderFrameBuilder;

  std::shared_ptr<RenderLayer> root_layer_;
  SkRect viewport_;
  mojo::gfx::composition::FrameInfo frame_info_;

  DISALLOW_COPY_AND_ASSIGN(RenderFrame);
};

}  // namespace compositor

#endif  // SERVICES_GFX_COMPOSITOR_RENDER_RENDER_FRAME_H_
