// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/ui/gl_view.h"

#include "base/logging.h"

namespace mojo {
namespace ui {

GLView::GLView(
    mojo::ApplicationImpl* app_impl,
    const std::string& label,
    const mojo::ui::ViewProvider::CreateViewCallback& create_view_callback)
    : BaseView(app_impl, label, create_view_callback),
      gl_context_owner_(ApplicationConnectorPtr::Create(
                            app_impl->CreateApplicationConnector())
                            .get()),
      gl_renderer_(gl_context_owner_.context()) {}

GLView::~GLView() {}

}  // namespace ui
}  // namespace mojo
