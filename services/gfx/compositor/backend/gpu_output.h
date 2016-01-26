// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_GFX_COMPOSITOR_BACKEND_GPU_OUTPUT_H_
#define SERVICES_GFX_COMPOSITOR_BACKEND_GPU_OUTPUT_H_

#include <memory>
#include <mutex>

#include "base/callback.h"
#include "base/macros.h"
#include "base/memory/ref_counted.h"
#include "base/memory/scoped_ptr.h"
#include "base/task_runner.h"
#include "base/threading/thread.h"
#include "mojo/services/gpu/interfaces/context_provider.mojom.h"
#include "services/gfx/compositor/backend/output.h"
#include "services/gfx/compositor/backend/vsync_scheduler.h"

namespace compositor {

class GpuRasterizer;

// Renderer backed by a ContextProvider.
class GpuOutput : public Output {
 public:
  GpuOutput(mojo::ContextProviderPtr context_provider,
            const SchedulerCallbacks& scheduler_callbacks,
            const base::Closure& error_callback);
  ~GpuOutput() override;

  Scheduler* GetScheduler() override;
  void SubmitFrame(const std::shared_ptr<RenderFrame>& frame) override;

 private:
  // Frame queue, held by a std::shared_ptr.
  // This object acts as a shared fifo between both threads.
  class FrameQueue {
   public:
    FrameQueue();
    ~FrameQueue();

    // Puts a pending frame into the queue, drops existing frames if needed.
    // Returns true if the queue was previously empty.
    bool PutFrame(const std::shared_ptr<RenderFrame>& frame);

    // Takes a pending frame from the queue.
    std::shared_ptr<RenderFrame> TakeFrame();

   private:
    std::mutex mutex_;
    std::shared_ptr<RenderFrame> next_frame_;  // guarded by |mutex_|

    DISALLOW_COPY_AND_ASSIGN(FrameQueue);
  };

  // Wrapper around state which is only accessible by the rasterizer thread.
  class RasterizerDelegate {
   public:
    explicit RasterizerDelegate(const std::shared_ptr<FrameQueue>& frame_queue);
    ~RasterizerDelegate();

    void CreateRasterizer(
        mojo::InterfacePtrInfo<mojo::ContextProvider> context_provider_info,
        const std::shared_ptr<VsyncScheduler>& scheduler,
        const scoped_refptr<base::TaskRunner>& task_runner,
        const base::Closure& error_callback);

    void SubmitNextFrame();

   private:
    std::shared_ptr<FrameQueue> frame_queue_;
    std::unique_ptr<GpuRasterizer> rasterizer_;

    DISALLOW_COPY_AND_ASSIGN(RasterizerDelegate);
  };

  std::shared_ptr<FrameQueue> frame_queue_;
  std::shared_ptr<VsyncScheduler> scheduler_;
  scoped_ptr<RasterizerDelegate> rasterizer_delegate_;  // can't use unique_ptr
                                                        // here due to
                                                        // base::Bind (sadness)
  std::unique_ptr<base::Thread> rasterizer_thread_;
  scoped_refptr<base::SingleThreadTaskRunner> rasterizer_task_runner_;

  DISALLOW_COPY_AND_ASSIGN(GpuOutput);
};

}  // namespace compositor

#endif  // SERVICES_GFX_COMPOSITOR_BACKEND_GPU_OUTPUT_H_
