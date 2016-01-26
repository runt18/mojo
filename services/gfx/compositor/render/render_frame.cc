// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/gfx/compositor/render/render_frame.h"

#include "base/logging.h"
#include "services/gfx/compositor/render/render_layer.h"
#include "skia/ext/refptr.h"
#include "third_party/skia/include/core/SkCanvas.h"
#include "third_party/skia/include/core/SkPicture.h"
#include "third_party/skia/include/core/SkPoint.h"

namespace compositor {

RenderFrame::RenderFrame(const std::shared_ptr<RenderLayer>& root_layer,
                         const SkRect& viewport,
                         const mojo::gfx::composition::FrameInfo& frame_info)
    : root_layer_(root_layer), viewport_(viewport), frame_info_(frame_info) {
  DCHECK(root_layer_);
}

RenderFrame::~RenderFrame() {}

void RenderFrame::Paint(SkCanvas* canvas) const {
  // TODO: Consider using GrDrawContext instead of SkCanvas.
  canvas->clear(SK_ColorBLACK);
  canvas->drawPicture(root_layer_->picture().get());
  canvas->flush();
}

mojo::gfx::composition::HitTestResultPtr RenderFrame::HitTest(
    const SkPoint& point) const {
  // TODO: implement me
  auto result = mojo::gfx::composition::HitTestResult::New();
  result->hits.resize(0u);
  return result.Pass();
}

}  // namespace compositor
