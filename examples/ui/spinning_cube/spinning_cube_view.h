// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef EXAMPLES_UI_SPINNING_CUBE_SPINNING_CUBE_VIEW_H_
#define EXAMPLES_UI_SPINNING_CUBE_SPINNING_CUBE_VIEW_H_

#include <memory>

#include "examples/spinning_cube/spinning_cube.h"
#include "mojo/ui/choreographer.h"
#include "mojo/ui/gl_view.h"
#include "mojo/ui/input_handler.h"

namespace examples {

class SpinningCubeView : public mojo::ui::GLView,
                         public mojo::ui::ChoreographerDelegate,
                         public mojo::ui::InputListener {
 public:
  SpinningCubeView(
      mojo::ApplicationImpl* app_impl,
      const mojo::ui::ViewProvider::CreateViewCallback& create_view_callback);

  ~SpinningCubeView() override;

 private:
  // |GLView|:
  void OnLayout(mojo::ui::ViewLayoutParamsPtr layout_params,
                mojo::Array<uint32_t> children_needing_layout,
                const OnLayoutCallback& callback) override;

  // |ChoreographerDelegate|:
  void OnDraw(const mojo::gfx::composition::FrameInfo& frame_info,
              const base::TimeDelta& time_delta) override;

  // |InputListener|:
  void OnEvent(mojo::EventPtr event, const OnEventCallback& callback) override;

  void DrawCubeWithGL();

  mojo::ui::Choreographer choreographer_;
  mojo::ui::InputHandler input_handler_;

  mojo::Size size_;

  SpinningCube cube_;

  mojo::PointF capture_point_;
  mojo::PointF last_drag_point_;
  MojoTimeTicks drag_start_time_ = 0u;

  base::WeakPtrFactory<SpinningCubeView> weak_ptr_factory_;

  DISALLOW_COPY_AND_ASSIGN(SpinningCubeView);
};

}  // namespace examples

#endif  // EXAMPLES_UI_SPINNING_CUBE_SPINNING_CUBE_VIEW_H_
