// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/logging.h"
#include "mojo/skia/ganesh_texture_surface.h"

namespace mojo {

GaneshTextureSurface::GaneshTextureSurface(GaneshContext* context,
                                           std::unique_ptr<GLTexture> texture)
    : texture_(std::move(texture)) {
  DCHECK(context);
  DCHECK(texture_);
  DCHECK(texture_->texture_id());
  DCHECK(texture_->size().width > 0);
  DCHECK(texture_->size().height > 0);

  GrBackendTextureDesc desc;
  desc.fFlags = kRenderTarget_GrBackendTextureFlag;
  desc.fWidth = texture_->size().width;
  desc.fHeight = texture_->size().height;
  desc.fConfig = kSkia8888_GrPixelConfig;
  desc.fOrigin = kTopLeft_GrSurfaceOrigin;
  desc.fTextureHandle = texture_->texture_id();

  skia::RefPtr<GrTexture> gr_texture = skia::AdoptRef(
      context->gr()->textureProvider()->wrapBackendTexture(desc));
  DCHECK(gr_texture);

  surface_ = skia::AdoptRef(
      SkSurface::NewRenderTargetDirect(gr_texture->asRenderTarget()));
  DCHECK(surface_);
}

GaneshTextureSurface::~GaneshTextureSurface() {}

std::unique_ptr<GLTexture> GaneshTextureSurface::TakeTexture() {
  surface_.clear();
  return std::move(texture_);
}

}  // namespace mojo
