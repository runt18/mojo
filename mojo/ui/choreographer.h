// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_UI_CHOREOGRAPHER_H_
#define MOJO_UI_CHOREOGRAPHER_H_

#include "base/time/time.h"
#include "mojo/public/cpp/system/macros.h"
#include "mojo/services/gfx/composition/interfaces/scenes.mojom.h"
#include "mojo/services/gfx/composition/interfaces/scheduling.mojom.h"

namespace mojo {
namespace ui {

class ChoreographerDelegate;

// Coordinates drawing a frame of a scene.
//
// This class is intended to be included as a member of a View that wants to
// schedule drawing using the following pattern.
//
// class MyView : public mojo::ui::BaseView,
//                public mojo::ui::ChoreographerDelegate {
//  public:
//   MyView(mojo::ApplicationImpl* app_impl,
//          const mojo::ui::ViewProvider::CreateViewCallback&
//              create_view_callback)
//          : BaseView(app_impl, "MyView", create_view_callback),
//            choreographer_(scene_scheduler(), this) {}
//   ~MyView() override {}
//
//  private:
//   // |ChoreographerDelegate|:
//   void OnDraw(const mojo::gfx::composition::FrameInfo& frame_info) override;
//
//   mojo::ui::Choreographer choreographer_;
//
//   MOJO_DISALLOW_COPY_AND_ASSIGN(MyView);
// };
class Choreographer {
 public:
  Choreographer(mojo::gfx::composition::Scene* scene,
                ChoreographerDelegate* delegate);
  Choreographer(mojo::gfx::composition::SceneSchedulerPtr scene_scheduler,
                ChoreographerDelegate* delegate);
  ~Choreographer();

  // Gets the scene scheduler.
  mojo::gfx::composition::SceneScheduler* scene_scheduler() {
    return scene_scheduler_.get();
  }

  // Gets the most recent frame info, or null if none.
  mojo::gfx::composition::FrameInfo* last_frame_info() {
    return last_frame_info_.get();
  }

  // Schedules a call to the delegate's |OnDraw| using the scene scheduler.
  void ScheduleDraw();

 private:
  mojo::gfx::composition::SceneSchedulerPtr scene_scheduler_;
  ChoreographerDelegate* delegate_;
  mojo::gfx::composition::FrameInfoPtr last_frame_info_;

  void ScheduleFrame();
  void DoFrame(mojo::gfx::composition::FrameInfoPtr frame_info);

  bool draw_scheduled_ = false;
  bool frame_scheduled_ = false;

  MOJO_DISALLOW_COPY_AND_ASSIGN(Choreographer);
};

// An abstract class that the view may subclass to handle choreographer events.
class ChoreographerDelegate {
 public:
  ChoreographerDelegate() = default;
  virtual ~ChoreographerDelegate() = default;

  // Called when it is time to draw the next frame and provides timing
  // information for the frame.
  //
  // The |frame_info| provides information about the frame timing.
  // The |time_delta| is the time interval since the last draw occurred,
  // guaranteed to be non-negative.  Always zero for the first draw.
  virtual void OnDraw(const mojo::gfx::composition::FrameInfo& frame_info,
                      const base::TimeDelta& time_delta) = 0;

 private:
  MOJO_DISALLOW_COPY_AND_ASSIGN(ChoreographerDelegate);
};

}  // namespace ui
}  // namespace mojo

#endif  // MOJO_UI_CHOREOGRAPHER_H_
