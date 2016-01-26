// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/ui/view_manager/view_layout_request.h"

#include "base/logging.h"

namespace view_manager {

ViewLayoutRequest::ViewLayoutRequest(
    mojo::ui::ViewLayoutParamsPtr layout_params)
    : layout_params_(layout_params.Pass()),
      was_dispatched_(false),
      issued_(false) {}

ViewLayoutRequest::~ViewLayoutRequest() {
  if (!was_dispatched_)
    DispatchLayoutInfo(nullptr);
}

void ViewLayoutRequest::AddCallback(const ViewLayoutCallback& callback) {
  DCHECK(!was_dispatched_);
  callbacks_.emplace_back(callback);
}

void ViewLayoutRequest::DispatchLayoutInfo(mojo::ui::ViewLayoutInfoPtr info) {
  DCHECK(!was_dispatched_);
  was_dispatched_ = true;
  for (const auto& callback : callbacks_)
    callback.Run(info ? info.Clone() : nullptr);
}

}  // namespace view_manager
