// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_UI_VIEW_MANAGER_VIEW_LAYOUT_REQUEST_H_
#define SERVICES_UI_VIEW_MANAGER_VIEW_LAYOUT_REQUEST_H_

#include <memory>
#include <vector>

#include "base/callback.h"
#include "base/macros.h"
#include "mojo/services/ui/views/interfaces/layouts.mojom.h"

namespace view_manager {

using ViewLayoutCallback = base::Callback<void(mojo::ui::ViewLayoutInfoPtr)>;

// Describes a pending layout request for a view.
class ViewLayoutRequest {
 public:
  explicit ViewLayoutRequest(mojo::ui::ViewLayoutParamsPtr layout_params);

  // Dispatches null layout info automatically if DispatchLayoutInfo was not
  // called.
  ~ViewLayoutRequest();

  // Gets the layout parameters for this request.
  // Does not confer ownership.
  const mojo::ui::ViewLayoutParams* layout_params() const {
    return layout_params_.get();
  }

  // Gets the layout parameters for this request and takes ownership.
  mojo::ui::ViewLayoutParamsPtr TakeLayoutParams() {
    return layout_params_.Pass();
  }

  // Adds a callback to this layout request.
  // Must be called before dispatching.
  void AddCallback(const ViewLayoutCallback& callback);

  // Returns true if the request has callbacks.
  bool has_callbacks() { return !callbacks_.empty(); }

  // Sends the layout information to each client.
  // Must be invoked exactly once before destroying the request to prevent
  // dangling callbacks.
  void DispatchLayoutInfo(mojo::ui::ViewLayoutInfoPtr info);

  // True if the request has been issued to the view.
  // False if it is still pending in the queue.
  bool issued() const { return issued_; }
  void set_issued(bool value) { issued_ = value; }

 private:
  mojo::ui::ViewLayoutParamsPtr layout_params_;
  std::vector<ViewLayoutCallback> callbacks_;
  bool was_dispatched_;
  bool issued_;

  DISALLOW_COPY_AND_ASSIGN(ViewLayoutRequest);
};

}  // namespace view_manager

#endif  // SERVICES_UI_VIEW_MANAGER_VIEW_LAYOUT_REQUEST_H_
