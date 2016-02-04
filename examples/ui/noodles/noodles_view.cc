// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "examples/ui/noodles/noodles_view.h"

#include <math.h>

#include <cstdlib>
#include <utility>

#include "base/bind.h"
#include "base/logging.h"
#include "base/message_loop/message_loop.h"
#include "examples/ui/noodles/frame.h"
#include "examples/ui/noodles/rasterizer.h"
#include "third_party/skia/include/core/SkCanvas.h"
#include "third_party/skia/include/core/SkColor.h"
#include "third_party/skia/include/core/SkPath.h"
#include "third_party/skia/include/core/SkPicture.h"
#include "third_party/skia/include/core/SkPictureRecorder.h"

namespace examples {

namespace {
constexpr double kSecondsBetweenChanges = 10.0;

template <typename T>
void Drop(scoped_ptr<T> ptr) {}

scoped_ptr<base::MessagePump> CreateMessagePumpMojo() {
  return base::MessageLoop::CreateMessagePumpForType(
      base::MessageLoop::TYPE_DEFAULT);
}

void Lissajous(SkPath* path, double ax, double ay, int wx, int wy, double p) {
  uint32_t segments = ceil(fabs(ax) + fabs(ay)) / 2u + 1u;
  for (uint32_t i = 0; i < segments; ++i) {
    double t = M_PI * 2.0 * i / segments;
    double x = ax * sin(t * wx);
    double y = ay * sin(t * wy + p);
    if (i == 0u)
      path->moveTo(x, y);
    else
      path->lineTo(x, y);
  }
  path->close();
}
}  // namespace

NoodlesView::NoodlesView(
    mojo::ApplicationImpl* app_impl,
    const mojo::ui::ViewProvider::CreateViewCallback& create_view_callback)
    : BaseView(app_impl, "Noodles", create_view_callback),
      choreographer_(scene(), this),
      frame_queue_(std::make_shared<FrameQueue>()),
      rasterizer_delegate_(
          make_scoped_ptr(new RasterizerDelegate(frame_queue_))) {
  base::Thread::Options options;
  options.message_pump_factory = base::Bind(&CreateMessagePumpMojo);

  rasterizer_thread_.reset(new base::Thread("noodles_rasterizer"));
  rasterizer_thread_->StartWithOptions(options);
  rasterizer_task_runner_ = rasterizer_thread_->message_loop()->task_runner();

  rasterizer_task_runner_->PostTask(
      FROM_HERE,
      base::Bind(&RasterizerDelegate::CreateRasterizer,
                 base::Unretained(rasterizer_delegate_.get()),
                 base::Passed(app_impl->CreateApplicationConnector()),
                 base::Passed(TakeScene().PassInterface())));
}

NoodlesView::~NoodlesView() {
  // Ensure destruction happens on the correct thread.
  rasterizer_task_runner_->PostTask(
      FROM_HERE, base::Bind(&Drop<RasterizerDelegate>,
                            base::Passed(&rasterizer_delegate_)));
}

void NoodlesView::OnLayout(mojo::ui::ViewLayoutParamsPtr layout_params,
                           mojo::Array<uint32_t> children_needing_layout,
                           const OnLayoutCallback& callback) {
  size_.width = layout_params->constraints->max_width;
  size_.height = layout_params->constraints->max_height;

  // Submit the new layout information.
  auto info = mojo::ui::ViewLayoutResult::New();
  info->size = size_.Clone();
  callback.Run(info.Pass());

  choreographer_.ScheduleDraw();
}

void NoodlesView::OnDraw(const mojo::gfx::composition::FrameInfo& frame_info,
                         const base::TimeDelta& time_delta) {
  choreographer_.ScheduleDraw();

  // Update the animation.
  alpha_ += time_delta.InSecondsF();

  // Create and post a new frame to the renderer.
  auto metadata = mojo::gfx::composition::SceneMetadata::New();
  metadata->presentation_time = frame_info.presentation_time;
  std::unique_ptr<Frame> frame(
      new Frame(size_, CreatePicture(), metadata.Pass()));
  if (frame_queue_->PutFrame(std::move(frame))) {
    rasterizer_task_runner_->PostTask(
        FROM_HERE, base::Bind(&RasterizerDelegate::PublishNextFrame,
                              base::Unretained(rasterizer_delegate_.get())));
  }
}

skia::RefPtr<SkPicture> NoodlesView::CreatePicture() {
  constexpr int count = 4;
  constexpr int padding = 1;

  if (alpha_ > kSecondsBetweenChanges) {
    alpha_ = 0.0;
    wx_ = rand() % 9 + 1;
    wy_ = rand() % 9 + 1;
  }

  SkPictureRecorder recorder;
  SkCanvas* canvas = recorder.beginRecording(size_.width, size_.height);

  double cx = size_.width * 0.5;
  double cy = size_.height * 0.5;
  canvas->translate(cx, cy);

  double phase = alpha_;
  for (int i = 0; i < count; i++, phase += 0.1) {
    SkPaint paint;
    SkScalar hsv[3] = {fmod(phase * 120, 360), 1, 1};
    paint.setColor(SkHSVToColor(hsv));
    paint.setStyle(SkPaint::kStroke_Style);
    paint.setAntiAlias(true);

    SkPath path;
    Lissajous(&path, cx - padding, cy - padding, wx_, wy_, phase);
    canvas->drawPath(path, paint);
  }

  return skia::AdoptRef(recorder.endRecordingAsPicture());
}

NoodlesView::FrameQueue::FrameQueue() {}

NoodlesView::FrameQueue::~FrameQueue() {}

bool NoodlesView::FrameQueue::PutFrame(std::unique_ptr<Frame> frame) {
  std::lock_guard<std::mutex> lock(mutex_);
  bool was_empty = !next_frame_.get();
  next_frame_.swap(frame);
  return was_empty;
}

std::unique_ptr<Frame> NoodlesView::FrameQueue::TakeFrame() {
  std::lock_guard<std::mutex> lock(mutex_);
  return std::move(next_frame_);
}

NoodlesView::RasterizerDelegate::RasterizerDelegate(
    const std::shared_ptr<FrameQueue>& frame_queue)
    : frame_queue_(frame_queue) {
  DCHECK(frame_queue_);
}

NoodlesView::RasterizerDelegate::~RasterizerDelegate() {}

void NoodlesView::RasterizerDelegate::CreateRasterizer(
    mojo::InterfaceHandle<mojo::ApplicationConnector> connector_info,
    mojo::InterfaceHandle<mojo::gfx::composition::Scene> scene_info) {
  rasterizer_.reset(new Rasterizer(
      mojo::ApplicationConnectorPtr::Create(std::move(connector_info)),
      mojo::gfx::composition::ScenePtr::Create(std::move(scene_info))));
}

void NoodlesView::RasterizerDelegate::PublishNextFrame() {
  std::unique_ptr<Frame> frame(frame_queue_->TakeFrame());
  DCHECK(frame);
  rasterizer_->PublishFrame(std::move(frame));
}

}  // namespace examples
