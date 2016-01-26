// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_GFX_COMPOSITOR_BACKEND_GPU_RASTERIZER_H_
#define SERVICES_GFX_COMPOSITOR_BACKEND_GPU_RASTERIZER_H_

#include <memory>

#include "base/callback.h"
#include "base/macros.h"
#include "base/memory/ref_counted.h"
#include "base/memory/weak_ptr.h"
#include "base/task_runner.h"
#include "mojo/gpu/gl_context.h"
#include "mojo/public/cpp/bindings/binding.h"
#include "mojo/public/cpp/system/functions.h"
#include "mojo/services/gpu/interfaces/context_provider.mojom.h"
#include "mojo/skia/ganesh_context.h"
#include "mojo/skia/ganesh_framebuffer_surface.h"

namespace compositor {

class RenderFrame;
class VsyncScheduler;

// Ganesh-based rasterizer which runs on a separate thread from the compositor.
// Calls into this object, including its creation, must be posted to the
// correct message loop by the output.
class GpuRasterizer : public mojo::ViewportParameterListener,
                      public mojo::GLContext::Observer {
 public:
  GpuRasterizer(mojo::ContextProviderPtr context_provider,
                const std::shared_ptr<VsyncScheduler>& scheduler,
                const scoped_refptr<base::TaskRunner>& task_runner,
                const base::Closure& error_callback);
  ~GpuRasterizer() override;

  void SubmitFrame(const std::shared_ptr<RenderFrame>& frame);

 private:
  // |ViewportParameterListener|:
  void OnVSyncParametersUpdated(int64_t timebase, int64_t interval) override;

  // |GLContext::Observer|:
  void OnContextLost() override;

  void CreateContext();
  void InitContext(mojo::CommandBufferPtr command_buffer);
  void DestroyContext();
  void OnContextProviderConnectionError();

  void Draw();

  void PostErrorCallback();

  mojo::ContextProviderPtr context_provider_;
  std::shared_ptr<VsyncScheduler> scheduler_;
  scoped_refptr<base::TaskRunner> task_runner_;
  base::Closure error_callback_;

  base::WeakPtr<mojo::GLContext> gl_context_;
  std::unique_ptr<mojo::skia::GaneshContext> ganesh_context_;
  std::unique_ptr<mojo::skia::GaneshFramebufferSurface> ganesh_surface_;

  std::shared_ptr<RenderFrame> current_frame_;

  mojo::Binding<ViewportParameterListener> viewport_parameter_listener_binding_;

  DISALLOW_COPY_AND_ASSIGN(GpuRasterizer);
};

}  // namespace compositor

#endif  // SERVICES_GFX_COMPOSITOR_BACKEND_GPU_RASTERIZER_H_
