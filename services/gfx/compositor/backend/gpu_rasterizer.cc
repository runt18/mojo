// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/gfx/compositor/backend/gpu_rasterizer.h"

#ifndef GL_GLEXT_PROTOTYPES
#define GL_GLEXT_PROTOTYPES
#endif

#include <GLES2/gl2.h>
#include <GLES2/gl2extmojo.h>
#include <MGL/mgl.h>
#include <MGL/mgl_onscreen.h>

#include "base/bind.h"
#include "base/location.h"
#include "base/logging.h"
#include "services/gfx/compositor/backend/vsync_scheduler.h"
#include "services/gfx/compositor/render/render_frame.h"

namespace compositor {

GpuRasterizer::GpuRasterizer(mojo::ContextProviderPtr context_provider,
                             const std::shared_ptr<VsyncScheduler>& scheduler,
                             const scoped_refptr<base::TaskRunner>& task_runner,
                             const base::Closure& error_callback)
    : context_provider_(context_provider.Pass()),
      scheduler_(scheduler),
      task_runner_(task_runner),
      error_callback_(error_callback),
      viewport_parameter_listener_binding_(this) {
  DCHECK(context_provider_);
  context_provider_.set_connection_error_handler(
      base::Bind(&GpuRasterizer::OnContextProviderConnectionError,
                 base::Unretained(this)));
  CreateContext();
}

GpuRasterizer::~GpuRasterizer() {
  DestroyContext();
}

void GpuRasterizer::CreateContext() {
  mojo::ViewportParameterListenerPtr viewport_parameter_listener;
  viewport_parameter_listener_binding_.Bind(
      GetProxy(&viewport_parameter_listener));
  context_provider_->Create(
      viewport_parameter_listener.Pass(),
      base::Bind(&GpuRasterizer::InitContext, base::Unretained(this)));
}

void GpuRasterizer::InitContext(mojo::CommandBufferPtr command_buffer) {
  DCHECK(!gl_context_);
  DCHECK(!ganesh_context_);
  DCHECK(!ganesh_surface_);

  if (!command_buffer) {
    LOG(ERROR) << "Could not create GL context.";
    PostErrorCallback();
    return;
  }

  gl_context_ = mojo::GLContext::CreateFromCommandBuffer(command_buffer.Pass());
  gl_context_->AddObserver(this);
  ganesh_context_.reset(new mojo::skia::GaneshContext(gl_context_));

  if (current_frame_)
    Draw();
}

void GpuRasterizer::DestroyContext() {
  if (gl_context_) {
    scheduler_->Stop();

    // Release objects that belong to special scopes.
    {
      mojo::skia::GaneshContext::Scope ganesh_scope(ganesh_context_.get());
      ganesh_surface_.reset();
    }

    // Release the ganesh context before the GL context.
    ganesh_context_.reset();

    // Now release the GL context.
    gl_context_->Destroy();
    gl_context_.reset();
  }
}

void GpuRasterizer::OnContextProviderConnectionError() {
  LOG(ERROR) << "Context provider connection lost.";
  PostErrorCallback();
}

void GpuRasterizer::OnContextLost() {
  LOG(WARNING) << "GL context lost, recreating it.";
  DestroyContext();
  CreateContext();
}

void GpuRasterizer::OnVSyncParametersUpdated(int64_t timebase,
                                             int64_t interval) {
  DVLOG(1) << "Vsync parameters: timebase=" << timebase
           << ", interval=" << interval;

  if (!gl_context_)
    return;

  // TODO(jeffbrown): This shouldn't be hardcoded.
  // Need to do some real tuning and possibly determine values adaptively.
  int64_t update_phase = -interval;
  int64_t snapshot_phase = -interval / 8;
  int64_t presentation_phase = interval;
  if (!scheduler_->Start(timebase, interval, update_phase, snapshot_phase,
                         presentation_phase)) {
    LOG(ERROR) << "Received invalid vsync parameters: timebase=" << timebase
               << ", interval=" << interval;
    PostErrorCallback();
  }
}

void GpuRasterizer::SubmitFrame(const std::shared_ptr<RenderFrame>& frame) {
  DCHECK(frame);

  if (current_frame_ == frame)
    return;

  current_frame_ = frame;
  if (gl_context_)
    Draw();
}

void GpuRasterizer::Draw() {
  DCHECK(gl_context_);
  DCHECK(ganesh_context_);
  DCHECK(current_frame_);

  gl_context_->MakeCurrent();

  // Update the viewport.
  const SkRect& viewport = current_frame_->viewport();
  bool stale_surface = false;
  if (!ganesh_surface_ ||
      ganesh_surface_->surface()->width() != viewport.width() ||
      ganesh_surface_->surface()->height() != viewport.height()) {
    glViewport(viewport.x(), viewport.y(), viewport.width(), viewport.height());
    glResizeCHROMIUM(viewport.width(), viewport.height(), 1.0f);
    stale_surface = true;
  }

  // Paint the frame.
  {
    mojo::skia::GaneshContext::Scope ganesh_scope(ganesh_context_.get());

    if (stale_surface)
      ganesh_surface_.reset(
          new mojo::skia::GaneshFramebufferSurface(ganesh_scope));

    current_frame_->Paint(ganesh_surface_->canvas());
  }

  // Swap buffers.
  MGLSwapBuffers();
}

void GpuRasterizer::PostErrorCallback() {
  task_runner_->PostTask(FROM_HERE, error_callback_);
}

}  // namespace compositor
