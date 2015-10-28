// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/logging.h"
#include "services/ui/view_manager/view_state.h"
#include "services/ui/view_manager/view_tree_state.h"

namespace view_manager {

ViewState::ViewState(mojo::ui::ViewPtr view, uint32_t view_token_value)
    : view_(view.Pass()),
      view_token_value_(view_token_value),
      tree_(nullptr),
      parent_(nullptr),
      key_(0),
      weak_factory_(this) {
  DCHECK(view_);
}

ViewState::~ViewState() {}

void ViewState::SetTree(ViewTreeState* tree, uint32_t key) {
  DCHECK(tree);
  DCHECK(!parent_);  // must be the root
  if (tree_ != tree) {
    SetTreeUnchecked(tree);
  }
  key_ = key;
}

void ViewState::SetTreeUnchecked(ViewTreeState* tree) {
  tree_ = tree;
  for (const auto& pair : children_) {
    pair.second->SetTreeUnchecked(tree);
  }
}

void ViewState::SetParent(ViewState* parent, uint32_t key) {
  DCHECK(parent);
  parent_ = parent;
  key_ = key;
  SetTreeUnchecked(parent->tree_);
}

void ViewState::ResetContainer() {
  parent_ = nullptr;
  key_ = 0;
  SetTreeUnchecked(nullptr);
}

void ViewState::GetServiceProvider(
    mojo::InterfaceRequest<mojo::ServiceProvider> service_provider) {}

}  // namespace view_manager
