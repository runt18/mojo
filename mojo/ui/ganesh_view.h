// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_UI_GANESH_VIEW_H_
#define MOJO_UI_GANESH_VIEW_H_

#include "mojo/gpu/gl_context.h"
#include "mojo/gpu/gl_context_owner.h"
#include "mojo/skia/ganesh_context.h"
#include "mojo/ui/base_view.h"
#include "mojo/ui/ganesh_renderer.h"

class SkSurface;

namespace mojo {
namespace ui {

// Abstract base implementation of the View interface for simple applications
// which use Ganesh for rendering.  Subclasses must handle layout and provide
// content for the scene.
class GaneshView : public BaseView {
 public:
  GaneshView(
      mojo::ApplicationImpl* app_impl,
      const std::string& label,
      const mojo::ui::ViewProvider::CreateViewCallback& create_view_callback);

  ~GaneshView() override;

  // Gets the GL context, or null if none.
  const base::WeakPtr<mojo::GLContext>& gl_context() const {
    return gl_context_owner_.context();
  }

  // Gets the Ganesh context.
  mojo::skia::GaneshContext* ganesh_context() { return &ganesh_context_; }

  // Gets the Ganesh renderer.
  mojo::ui::GaneshRenderer* ganesh_renderer() { return &ganesh_renderer_; }

 private:
  mojo::GLContextOwner gl_context_owner_;
  mojo::skia::GaneshContext ganesh_context_;
  mojo::ui::GaneshRenderer ganesh_renderer_;

  DISALLOW_COPY_AND_ASSIGN(GaneshView);
};

}  // namespace ui
}  // namespace mojo

#endif  // MOJO_UI_GANESH_VIEW_H_
