// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/ui/choreographer.h"

#include "base/bind.h"
#include "base/logging.h"
#include "mojo/public/cpp/system/functions.h"

namespace mojo {
namespace ui {

Choreographer::Choreographer(mojo::gfx::composition::Scene* scene,
                             ChoreographerDelegate* delegate)
    : delegate_(delegate) {
  DCHECK(delegate_);
  scene->GetScheduler(mojo::GetProxy(&scene_scheduler_));
}

Choreographer::Choreographer(
    mojo::gfx::composition::SceneSchedulerPtr scene_scheduler,
    ChoreographerDelegate* delegate)
    : scene_scheduler_(scene_scheduler.Pass()), delegate_(delegate) {
  DCHECK(scene_scheduler_);
  DCHECK(delegate_);
}

Choreographer::~Choreographer() {}

void Choreographer::ScheduleDraw() {
  if (!draw_scheduled_) {
    draw_scheduled_ = true;
    ScheduleFrame();
  }
}

void Choreographer::ScheduleFrame() {
  if (!frame_scheduled_) {
    frame_scheduled_ = true;
    scene_scheduler_->ScheduleFrame(
        base::Bind(&Choreographer::DoFrame, base::Unretained(this)));
  }
}

void Choreographer::DoFrame(mojo::gfx::composition::FrameInfoPtr frame_info) {
  DCHECK(frame_info);
  DCHECK(frame_scheduled_);
  frame_scheduled_ = false;

  if (draw_scheduled_) {
    draw_scheduled_ = false;

    // To reduce latency and jank, anticipate the next frame to be drawn by
    // scheduling it early.
    //
    // TODO(jeffbrown): Reenable this once issue #604 is fixed.  Unfortunately
    // this exacerbates starvation issues in the Mojo message pump.
    // ScheduleFrame();

    // Ensure frame info is sane since it comes from another service.
    // TODO(jeffbrown): Would be better to report an error to the client
    // who can shut things down if needed.
    MojoTimeTicks now = MojoGetTimeTicksNow();
    if (frame_info->frame_time > now) {
      LOG(WARNING) << "Frame time is in the future: frame_time="
                   << frame_info->frame_time << ", now=" << now;
      frame_info->frame_time = now;
    }
    if (frame_info->frame_deadline < frame_info->frame_time) {
      LOG(WARNING)
          << "Frame deadline is earlier than frame time: frame_deadline="
          << frame_info->frame_deadline
          << ", frame_time=" << frame_info->frame_time << ", now=" << now;
      frame_info->frame_deadline = frame_info->frame_time;
    }
    if (frame_info->presentation_time < frame_info->frame_deadline) {
      LOG(WARNING) << "Presentation time is earlier than frame deadline: "
                      "presentation_time="
                   << frame_info->presentation_time
                   << ", frame_deadline=" << frame_info->frame_deadline
                   << ", now=" << now;
      frame_info->presentation_time = frame_info->frame_deadline;
    }

    // Compensate for significant lag by adjusting the frame time if needed
    // to step past skipped frames.
    uint64_t lag = now - frame_info->frame_time;
    if (frame_info->frame_interval > 0u && lag > frame_info->frame_interval) {
      uint64_t offset = lag % frame_info->frame_interval;
      uint64_t adjustment = now - offset - frame_info->frame_time;
      frame_info->frame_time = now - offset;
      frame_info->frame_deadline += adjustment;
      frame_info->presentation_time += adjustment;

      // Jank warning.
      // TODO(jeffbrown): Suppress this once we're happy with things.
      LOG(WARNING) << "Missed " << frame_info->frame_interval
                   << " us frame deadline by " << lag << " us, skipping "
                   << (lag / frame_info->frame_interval) << " frames";
    }

    // Ensure frame time isn't going backwards, just in case the compositor's
    // timing is seriously broken.
    base::TimeDelta time_delta;
    if (last_frame_info_) {
      DCHECK(frame_info->frame_time >= last_frame_info_->frame_time);
      time_delta = base::TimeDelta::FromMicroseconds(
          frame_info->frame_time - last_frame_info_->frame_time);
    }

    // Invoke the callback.
    last_frame_info_ = frame_info.Pass();
    delegate_->OnDraw(*last_frame_info_, time_delta);
  }
}

}  // namespace ui
}  // namespace mojo
