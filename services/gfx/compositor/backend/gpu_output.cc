// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/gfx/compositor/backend/gpu_output.h"

#include "base/bind.h"
#include "base/location.h"
#include "base/logging.h"
#include "base/message_loop/message_loop.h"
#include "services/gfx/compositor/backend/gpu_rasterizer.h"

namespace compositor {

template <typename T>
static void Drop(scoped_ptr<T> ptr) {}

static scoped_ptr<base::MessagePump> CreateMessagePumpMojo() {
  return base::MessageLoop::CreateMessagePumpForType(
      base::MessageLoop::TYPE_DEFAULT);
}

GpuOutput::GpuOutput(mojo::ContextProviderPtr context_provider,
                     const SchedulerCallbacks& scheduler_callbacks,
                     const base::Closure& error_callback)
    : frame_queue_(std::make_shared<FrameQueue>()),
      scheduler_(std::make_shared<VsyncScheduler>(base::MessageLoop::current()
                                                      ->task_runner(),
                                                  scheduler_callbacks)),
      rasterizer_delegate_(
          make_scoped_ptr(new RasterizerDelegate(frame_queue_))) {
  DCHECK(context_provider);

  base::Thread::Options options;
  options.message_pump_factory = base::Bind(&CreateMessagePumpMojo);

  rasterizer_thread_.reset(new base::Thread("gpu_rasterizer"));
  rasterizer_thread_->StartWithOptions(options);
  rasterizer_task_runner_ = rasterizer_thread_->message_loop()->task_runner();

  rasterizer_task_runner_->PostTask(
      FROM_HERE,
      base::Bind(&RasterizerDelegate::CreateRasterizer,
                 base::Unretained(rasterizer_delegate_.get()),
                 base::Passed(context_provider.PassInterface()), scheduler_,
                 base::MessageLoop::current()->task_runner(), error_callback));
}

GpuOutput::~GpuOutput() {
  // Ensure destruction happens on the correct thread.
  rasterizer_task_runner_->PostTask(
      FROM_HERE, base::Bind(&Drop<RasterizerDelegate>,
                            base::Passed(&rasterizer_delegate_)));
}

Scheduler* GpuOutput::GetScheduler() {
  return scheduler_.get();
}

void GpuOutput::SubmitFrame(const std::shared_ptr<RenderFrame>& frame) {
  if (frame_queue_->PutFrame(frame)) {
    rasterizer_task_runner_->PostTask(
        FROM_HERE, base::Bind(&RasterizerDelegate::SubmitNextFrame,
                              base::Unretained(rasterizer_delegate_.get())));
  }
}

GpuOutput::FrameQueue::FrameQueue() {}

GpuOutput::FrameQueue::~FrameQueue() {}

bool GpuOutput::FrameQueue::PutFrame(
    const std::shared_ptr<RenderFrame>& frame) {
  std::lock_guard<std::mutex> lock(mutex_);
  bool was_empty = !next_frame_.get();
  next_frame_ = frame;
  return was_empty;
}

std::shared_ptr<RenderFrame> GpuOutput::FrameQueue::TakeFrame() {
  std::lock_guard<std::mutex> lock(mutex_);
  return std::move(next_frame_);
}

GpuOutput::RasterizerDelegate::RasterizerDelegate(
    const std::shared_ptr<FrameQueue>& frame_queue)
    : frame_queue_(frame_queue) {
  DCHECK(frame_queue_);
}

GpuOutput::RasterizerDelegate::~RasterizerDelegate() {}

void GpuOutput::RasterizerDelegate::CreateRasterizer(
    mojo::InterfacePtrInfo<mojo::ContextProvider> context_provider_info,
    const std::shared_ptr<VsyncScheduler>& scheduler,
    const scoped_refptr<base::TaskRunner>& task_runner,
    const base::Closure& error_callback) {
  rasterizer_.reset(
      new GpuRasterizer(mojo::MakeProxy(context_provider_info.Pass()).Pass(),
                        scheduler, task_runner, error_callback));
}

void GpuOutput::RasterizerDelegate::SubmitNextFrame() {
  std::shared_ptr<RenderFrame> frame(frame_queue_->TakeFrame());
  DCHECK(frame);
  rasterizer_->SubmitFrame(frame);
}

}  // namespace compositor
