// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef EXAMPLES_UI_SHAPES_SHAPES_VIEW_H_
#define EXAMPLES_UI_SHAPES_SHAPES_VIEW_H_

#include "mojo/ui/ganesh_view.h"

class SkCanvas;

namespace examples {

class ShapesView : public mojo::ui::GaneshView {
 public:
  ShapesView(
      mojo::ApplicationImpl* app_impl,
      const mojo::ui::ViewProvider::CreateViewCallback& create_view_callback);

  ~ShapesView() override;

 private:
  // |GaneshView|:
  void OnLayout(mojo::ui::ViewLayoutParamsPtr layout_params,
                mojo::Array<uint32_t> children_needing_layout,
                const OnLayoutCallback& callback) override;

  void UpdateScene();
  void DrawContent(SkCanvas* canvas);

  mojo::Size size_;

  DISALLOW_COPY_AND_ASSIGN(ShapesView);
};

}  // namespace examples

#endif  // EXAMPLES_UI_SHAPES_SHAPES_VIEW_H_
