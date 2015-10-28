// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <GLES2/gl2.h>
#include <GLES2/gl2extmojo.h>
#include <MGL/mgl.h>

#include "base/message_loop/message_loop.h"
#include "examples/ui/spinning_cube/spinning_cube_view.h"

namespace examples {

SpinningCubeView::SpinningCubeView(
    mojo::ApplicationImpl* app,
    const mojo::ui::ViewProvider::CreateViewCallback& callback)
    : callback_(callback),
      binding_(this),
      context_owner_(app->shell()),
      texture_cache_(context_owner_.context(), &resource_returner_),
      surface_id_namespace_(0),
      draw_scheduled_(false),
      weak_ptr_factory_(this) {
  app->ConnectToService("mojo:surfaces_service", &surfaces_);
  app->ConnectToService("mojo:view_manager_service", &view_manager_);

  surfaces_->SetResourceReturner(resource_returner_.Pass());
  surfaces_->GetIdNamespace(
      base::Bind(&SpinningCubeView::OnSurfaceIdNamespaceAvailable,
                 base::Unretained(this)));

  InitCube();
}

SpinningCubeView::~SpinningCubeView() {}

void SpinningCubeView::OnSurfaceIdNamespaceAvailable(uint32_t id_namespace) {
  surface_id_namespace_ = id_namespace;
  InitView();
}

void SpinningCubeView::InitView() {
  mojo::ui::ViewPtr view;
  binding_.Bind(mojo::GetProxy(&view));
  view_manager_->RegisterView(view.Pass(), mojo::GetProxy(&view_host_),
                              callback_);

  view_host_->GetServiceProvider(mojo::GetProxy(&view_service_provider_));
}

void SpinningCubeView::OnLayout(mojo::ui::ViewLayoutParamsPtr layout_params,
                                mojo::Array<uint32_t> children_needing_layout,
                                const OnLayoutCallback& callback) {
  // Create a new surface the first time or if the size has changed.
  mojo::Size new_size;
  new_size.width = layout_params->constraints->max_width;
  new_size.height = layout_params->constraints->max_height;
  if (!surface_id_ || !size_.Equals(new_size)) {
    if (!surface_id_) {
      surface_id_ = mojo::SurfaceId::New();
      surface_id_->id_namespace = surface_id_namespace_;
    } else {
      surfaces_->DestroySurface(surface_id_->local);
    }
    surface_id_->local++;
    size_ = new_size;
    surfaces_->CreateSurface(surface_id_->local);
  }

  // Submit the new layout information.
  auto info = mojo::ui::ViewLayoutInfo::New();
  info->size = size_.Clone();
  info->surface_id = surface_id_->Clone();
  callback.Run(info.Pass());

  // Draw!
  ScheduleDraw();
}

void SpinningCubeView::OnChildUnavailable(
    uint32_t child_key,
    const OnChildUnavailableCallback& callback) {
  callback.Run();
}

void SpinningCubeView::InitCube() {
  context_owner_.context()->MakeCurrent();
  cube_.Init();
  last_draw_ = mojo::GetTimeTicksNow();
}

void SpinningCubeView::DrawCube() {
  draw_scheduled_ = false;

  scoped_ptr<mojo::TextureCache::TextureInfo> texture_info =
      texture_cache_.GetTexture(size_);
  if (!texture_info) {
    LOG(ERROR) << "Could not allocate texture of size " << size_.width << "x"
               << size_.height;
    return;
  }

  context_owner_.context()->MakeCurrent();
  scoped_ptr<mojo::GLTexture> texture = texture_info->TakeTexture();

  GLuint fbo = 0u;
  glGenFramebuffers(1, &fbo);
  glBindFramebuffer(GL_FRAMEBUFFER, fbo);
  GLuint depth_buffer = 0u;
  glGenRenderbuffers(1, &depth_buffer);
  glBindRenderbuffer(GL_RENDERBUFFER, depth_buffer);
  glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, size_.width,
                        size_.height);
  glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D,
                         texture->texture_id(), 0);
  glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT,
                            GL_RENDERBUFFER, depth_buffer);
  DCHECK_EQ(static_cast<GLenum>(GL_FRAMEBUFFER_COMPLETE),
            glCheckFramebufferStatus(GL_FRAMEBUFFER));
  glClearColor(1, 0, 0, 0.5);

  cube_.set_size(size_.width, size_.height);

  MojoTimeTicks now = mojo::GetTimeTicksNow();
  MojoTimeTicks offset = now - last_draw_;
  cube_.UpdateForTimeDelta(offset * 0.000001f);
  last_draw_ = now;

  cube_.Draw();

  glDeleteFramebuffers(1, &fbo);
  glDeleteRenderbuffers(1, &depth_buffer);

  mojo::FramePtr frame = mojo::TextureUploader::GetUploadFrame(
      context_owner_.context(), texture_info->resource_id(), texture);
  surfaces_->SubmitFrame(surface_id_->local, frame.Pass(),
                         base::Bind(&SpinningCubeView::OnSurfaceSubmitted,
                                    base::Unretained(this)));

  texture_cache_.NotifyPendingResourceReturn(texture_info->resource_id(),
                                             texture.Pass());
}

void SpinningCubeView::OnSurfaceSubmitted() {
  ScheduleDraw();
}

void SpinningCubeView::ScheduleDraw() {
  if (!draw_scheduled_) {
    draw_scheduled_ = true;

    // TODO(jeffbrown): For now, we need to throttle this down because
    // drawing as fast as we can appears to cause starvation of the
    // Mojo message loop and makes X11 unhappy.
    base::MessageLoop::current()->PostDelayedTask(
        FROM_HERE,
        base::Bind(&SpinningCubeView::DrawCube, weak_ptr_factory_.GetWeakPtr()),
        base::TimeDelta::FromMilliseconds(30));
  }
}

}  // namespace examples
