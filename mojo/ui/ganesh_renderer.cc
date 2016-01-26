// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/ui/ganesh_renderer.h"

#include "base/bind.h"
#include "base/logging.h"
#include "mojo/gpu/gl_texture.h"
#include "mojo/skia/ganesh_context.h"
#include "mojo/skia/ganesh_texture_surface.h"
#include "third_party/skia/include/core/SkCanvas.h"
#include "third_party/skia/include/core/SkSurface.h"

namespace mojo {
namespace ui {

GaneshRenderer::GaneshRenderer(mojo::skia::GaneshContext* ganesh_context)
    : ganesh_context_(ganesh_context),
      gl_renderer_(ganesh_context_->gl_context()) {
  DCHECK(ganesh_context_);
}

GaneshRenderer::~GaneshRenderer() {}

mojo::gfx::composition::ResourcePtr GaneshRenderer::DrawSurface(
    const mojo::Size& size,
    const DrawSurfaceCallback& callback) {
  std::unique_ptr<mojo::GLTexture> texture = gl_renderer_.GetTexture(size);
  DCHECK(texture);

  {
    mojo::skia::GaneshContext::Scope scope(ganesh_context_);
    mojo::skia::GaneshTextureSurface texture_surface(scope, std::move(texture));

    callback.Run(texture_surface.surface());

    texture = texture_surface.TakeTexture();
  }

  return gl_renderer_.BindTextureResource(std::move(texture));
}

static void RunCanvasCallback(
    const mojo::ui::GaneshRenderer::DrawCanvasCallback& callback,
    SkSurface* surface) {
  callback.Run(surface->getCanvas());
}

mojo::gfx::composition::ResourcePtr GaneshRenderer::DrawCanvas(
    const mojo::Size& size,
    const DrawCanvasCallback& callback) {
  return DrawSurface(size, base::Bind(&RunCanvasCallback, callback));
}

}  // namespace ui
}  // namespace mojo
