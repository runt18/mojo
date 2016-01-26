// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_UI_GL_VIEW_H_
#define MOJO_UI_GL_VIEW_H_

#include "mojo/gpu/gl_context.h"
#include "mojo/gpu/gl_context_owner.h"
#include "mojo/ui/base_view.h"
#include "mojo/ui/gl_renderer.h"

namespace mojo {
namespace ui {

// Abstract base implementation of the View interface for simple applications
// which use GL for rendering.  Subclasses must handle layout and provide
// content for the scene.
class GLView : public BaseView {
 public:
  GLView(
      mojo::ApplicationImpl* app_impl,
      const std::string& label,
      const mojo::ui::ViewProvider::CreateViewCallback& create_view_callback);

  ~GLView() override;

  // Gets the GL context, or null if none.
  const base::WeakPtr<mojo::GLContext>& gl_context() const {
    return gl_context_owner_.context();
  }

  // Gets the GL renderer.
  mojo::ui::GLRenderer* gl_renderer() { return &gl_renderer_; }

 private:
  mojo::GLContextOwner gl_context_owner_;
  mojo::ui::GLRenderer gl_renderer_;

  MOJO_DISALLOW_COPY_AND_ASSIGN(GLView);
};

}  // namespace ui
}  // namespace mojo

#endif  // MOJO_UI_GL_VIEW_H_
