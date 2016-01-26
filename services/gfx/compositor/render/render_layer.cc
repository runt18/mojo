// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/gfx/compositor/render/render_layer.h"

#include "base/logging.h"
#include "third_party/skia/include/core/SkCanvas.h"
#include "third_party/skia/include/core/SkPicture.h"
#include "third_party/skia/include/core/SkPictureRecorder.h"

namespace compositor {

RenderLayer::RenderLayer(const skia::RefPtr<SkPicture>& picture)
    : picture_(picture) {}

RenderLayer::~RenderLayer() {}

RenderLayerBuilder::RenderLayerBuilder() : RenderLayerBuilder(nullptr) {}

RenderLayerBuilder::RenderLayerBuilder(const SkRect* cull_rect) {
  recorder_.beginRecording(cull_rect ? *cull_rect : SkRect::MakeLargest());
  canvas_ = recorder_.getRecordingCanvas();
}

RenderLayerBuilder::~RenderLayerBuilder() {}

void RenderLayerBuilder::PushScene(uint32_t scene_token, uint32_t version) {
  DCHECK(canvas_);
  // TODO: remember scene information for hit testing
}

void RenderLayerBuilder::PopScene() {
  DCHECK(canvas_);
}

void RenderLayerBuilder::PushNode(uint32_t node_id, uint32_t hit_id) {
  DCHECK(canvas_);
  // TODO: remember scene information for hit testing
  // TODO: optimize save() / restore() commands
  canvas_->save();
}

void RenderLayerBuilder::PopNode() {
  DCHECK(canvas_);
  // TODO: optimize save() / restore() commands
  canvas_->restore();
}

void RenderLayerBuilder::ApplyTransform(const SkMatrix& content_transform) {
  DCHECK(canvas_);
  canvas_->concat(content_transform);
}

void RenderLayerBuilder::ApplyClip(const SkRect& content_clip) {
  DCHECK(canvas_);
  canvas_->clipRect(content_clip);
}

void RenderLayerBuilder::DrawRect(const SkRect& content_rect,
                                  const SkPaint& paint) {
  DCHECK(canvas_);
  canvas_->drawRect(content_rect, paint);
}

void RenderLayerBuilder::DrawImage(const std::shared_ptr<RenderImage>& image,
                                   const SkRect& content_rect,
                                   const SkRect& image_rect,
                                   const SkPaint& paint) {
  DCHECK(image);
  DCHECK(canvas_);
  canvas_->drawImageRect(image->image().get(), image_rect, content_rect,
                         &paint);
}

void RenderLayerBuilder::DrawLayer(const std::shared_ptr<RenderLayer>& layer) {
  DCHECK(canvas_);
  canvas_->drawPicture(layer->picture().get());
}

void RenderLayerBuilder::DrawSavedLayer(
    const std::shared_ptr<RenderLayer>& layer,
    const SkRect& content_rect,
    const SkPaint& paint) {
  DCHECK(layer);
  DCHECK(canvas_);
  canvas_->saveLayer(content_rect, &paint);
  canvas_->drawPicture(layer->picture().get());
  canvas_->restore();
}

std::shared_ptr<RenderLayer> RenderLayerBuilder::Build() {
  DCHECK(canvas_);
  canvas_ = nullptr;
  return std::make_shared<RenderLayer>(
      skia::AdoptRef(recorder_.endRecordingAsPicture()));
}

}  // namespace compositor
