// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <GLES2/gl2.h>

#include "base/logging.h"
#include "mojo/skia/ganesh_framebuffer_surface.h"

namespace mojo {

GaneshFramebufferSurface::GaneshFramebufferSurface(GaneshContext* context) {
  DCHECK(context);
  GaneshContext::Scope scope(context);

  GLint samples = 0;
  glGetIntegerv(GL_SAMPLES, &samples);
  GLint stencil_bits = 0;
  glGetIntegerv(GL_STENCIL_BITS, &stencil_bits);
  GLint framebuffer_binding = 0;
  glGetIntegerv(GL_FRAMEBUFFER_BINDING, &framebuffer_binding);
  GLint viewport[4] = {0, 0, 0, 0};
  glGetIntegerv(GL_VIEWPORT, viewport);
  DCHECK(viewport[2] > 0);
  DCHECK(viewport[3] > 0);

  GrBackendRenderTargetDesc desc;
  desc.fWidth = viewport[2];
  desc.fHeight = viewport[3];
  desc.fConfig = kSkia8888_GrPixelConfig;
  desc.fOrigin = kBottomLeft_GrSurfaceOrigin;
  desc.fSampleCnt = samples;
  desc.fStencilBits = stencil_bits;
  desc.fRenderTargetHandle = framebuffer_binding;
  GrRenderTarget* render_target =
      context->gr()->textureProvider()->wrapBackendRenderTarget(desc);
  DCHECK(render_target);

  surface_ = skia::AdoptRef(SkSurface::NewRenderTargetDirect(render_target));
  DCHECK(surface_);
}

GaneshFramebufferSurface::~GaneshFramebufferSurface() {}

}  // namespace mojo
