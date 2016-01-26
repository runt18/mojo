// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/ui/base_view.h"

#include "base/logging.h"

namespace mojo {
namespace ui {

BaseView::BaseView(
    mojo::ApplicationImpl* app_impl,
    const std::string& label,
    const mojo::ui::ViewProvider::CreateViewCallback& create_view_callback)
    : app_impl_(app_impl), view_binding_(this) {
  DCHECK(app_impl_);
  app_impl_->ConnectToService("mojo:view_manager_service", &view_manager_);

  mojo::ui::ViewPtr view;
  view_binding_.Bind(mojo::GetProxy(&view));
  view_manager_->RegisterView(view.Pass(), mojo::GetProxy(&view_host_), label,
                              create_view_callback);
  view_host_->CreateScene(mojo::GetProxy(&scene_));
  view_host_->GetServiceProvider(mojo::GetProxy(&view_service_provider_));
}

BaseView::~BaseView() {}

void BaseView::OnChildUnavailable(uint32_t child_key,
                                  const OnChildUnavailableCallback& callback) {
  callback.Run();
}

}  // namespace ui
}  // namespace mojo
