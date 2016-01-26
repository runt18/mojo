// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_GFX_COMPOSITOR_RENDER_RENDER_LAYER_H_
#define SERVICES_GFX_COMPOSITOR_RENDER_RENDER_LAYER_H_

#include <memory>
#include <vector>

#include "base/macros.h"
#include "services/gfx/compositor/render/render_image.h"
#include "skia/ext/refptr.h"
#include "third_party/skia/include/core/SkMatrix.h"
#include "third_party/skia/include/core/SkPaint.h"
#include "third_party/skia/include/core/SkPath.h"
#include "third_party/skia/include/core/SkPictureRecorder.h"
#include "third_party/skia/include/core/SkRRect.h"
#include "third_party/skia/include/core/SkRect.h"

class SkCanvas;
class SkPicture;

namespace compositor {

class RenderCommand;

// Describes a sequence of drawing commands to be evaluated as a single pass.
// Layers are introduced into the render frame at points where blending must
// occur or where portions of a scene graph may be drawn once into a temporary
// buffer and used many times.
//
// Render objects are thread-safe, immutable, and reference counted via
// std::shared_ptr.  They have no direct references to the scene graph.
class RenderLayer {
 public:
  ~RenderLayer();
  explicit RenderLayer(const skia::RefPtr<SkPicture>& picture);

  // Gets the underlying picture to rasterize.
  const skia::RefPtr<SkPicture>& picture() const { return picture_; }

 private:
  friend class RenderLayerBuilder;

  // TODO: store auxiliary information required for hit testing
  skia::RefPtr<SkPicture> picture_;

  DISALLOW_COPY_AND_ASSIGN(RenderLayer);
};

// Builder for render layers.
class RenderLayerBuilder {
 public:
  // Creates a layer builder with an optional |cull_rect| to cull recorded
  // geometry information.
  RenderLayerBuilder();
  explicit RenderLayerBuilder(const SkRect* cull_rect);
  ~RenderLayerBuilder();

  // Pushes information about a scene onto the stack.
  void PushScene(uint32_t scene_token, uint32_t version);

  // Pops a scene off the stack.
  void PopScene();

  // Pushes information about a node onto the stack.
  void PushNode(uint32_t node_id, uint32_t hit_id);

  // Pops a node off the stack.
  void PopNode();

  // Applies a transformation matrix to the node.
  void ApplyTransform(const SkMatrix& content_transform);

  // Applies a clip to the node.
  void ApplyClip(const SkRect& content_clip);

  // Inserts a command to draw a rectangle.
  void DrawRect(const SkRect& content_rect, const SkPaint& paint);

  // Inserts a command to draw an image.
  void DrawImage(const std::shared_ptr<RenderImage>& image,
                 const SkRect& content_rect,
                 const SkRect& image_rect,
                 const SkPaint& paint);

  // Inserts a command to draw an in-place layer.
  void DrawLayer(const std::shared_ptr<RenderLayer>& layer);

  // Inserts a command to draw a saved layer.
  void DrawSavedLayer(const std::shared_ptr<RenderLayer>& layer,
                      const SkRect& content_rect,
                      const SkPaint& paint);

  // Returns the layer which was built.
  std::shared_ptr<RenderLayer> Build();

 private:
  SkPictureRecorder recorder_;
  SkCanvas* canvas_;

  DISALLOW_COPY_AND_ASSIGN(RenderLayerBuilder);
};

}  // namespace compositor

#endif  // SERVICES_GFX_COMPOSITOR_RENDER_RENDER_LAYER_H_
