// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/ui/ganesh_view.h"

#include "base/logging.h"
#include "mojo/skia/ganesh_texture_surface.h"
#include "third_party/skia/include/core/SkCanvas.h"

namespace mojo {
namespace ui {

GaneshView::GaneshView(
    mojo::ApplicationImpl* app_impl,
    const std::string& label,
    const mojo::ui::ViewProvider::CreateViewCallback& create_view_callback)
    : BaseView(app_impl, label, create_view_callback),
      gl_context_owner_(mojo::MakeProxy(app_impl->CreateApplicationConnector())
                            .get()),
      ganesh_context_(gl_context()),
      ganesh_renderer_(&ganesh_context_) {}

GaneshView::~GaneshView() {}

}  // namespace ui
}  // namespace mojo
