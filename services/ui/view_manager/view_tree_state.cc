// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/logging.h"
#include "services/ui/view_manager/view_tree_state.h"

namespace view_manager {

ViewTreeState::ViewTreeState(mojo::ui::ViewTreePtr view_tree)
    : view_tree_(view_tree.Pass()),
      root_(nullptr),
      explicit_root_(false),
      layout_request_pending_(false),
      layout_request_issued_(false),
      weak_factory_(this) {
  DCHECK(view_tree_);
}

ViewTreeState::~ViewTreeState() {}

void ViewTreeState::SetRoot(ViewState* root, uint32_t key) {
  DCHECK(root);
  if (root_ != root) {
    ResetRoot();
    root->SetTree(this, key);
    root_ = root;
  }
}

void ViewTreeState::ResetRoot() {
  if (root_) {
    root_->ResetContainer();
  }
  root_ = nullptr;
}

}  // namespace view_manager
