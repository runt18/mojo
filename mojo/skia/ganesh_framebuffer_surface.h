// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_SKIA_GANESH_FRAMEBUFFER_SURFACE_H_
#define MOJO_SKIA_GANESH_FRAMEBUFFER_SURFACE_H_

#include <memory>

#include "mojo/gpu/gl_texture.h"
#include "mojo/skia/ganesh_context.h"
#include "skia/ext/refptr.h"
#include "third_party/skia/include/core/SkSurface.h"

namespace mojo {

// This class represents an SkSurface backed by a GL framebuffer, which is
// appropriate for use with Ganesh.  This is useful for rendering Skia
// commands directly to the display framebuffer.
class GaneshFramebufferSurface {
 public:
  // Creates a surface that wraps the currently bound GL framebuffer.
  // The size of the surface is determined by querying the current viewport.
  explicit GaneshFramebufferSurface(GaneshContext* context);
  ~GaneshFramebufferSurface();

  SkSurface* surface() const { return surface_.get(); }
  SkCanvas* canvas() const { return surface_->getCanvas(); }

 private:
  skia::RefPtr<SkSurface> surface_;

  DISALLOW_COPY_AND_ASSIGN(GaneshFramebufferSurface);
};

}  // namespace mojo

#endif  // MOJO_SKIA_GANESH_FRAMEBUFFER_SURFACE_H_
