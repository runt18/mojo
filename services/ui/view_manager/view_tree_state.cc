// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/ui/view_manager/view_tree_state.h"

#include "base/logging.h"
#include "base/strings/stringprintf.h"

namespace view_manager {

ViewTreeState::ViewTreeState(mojo::ui::ViewTreePtr view_tree,
                             mojo::ui::ViewTreeTokenPtr view_tree_token,
                             const std::string& label)
    : view_tree_(view_tree.Pass()),
      view_tree_token_(view_tree_token.Pass()),
      label_(label),
      weak_factory_(this) {
  DCHECK(view_tree_);
  DCHECK(view_tree_token_);
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

const std::string& ViewTreeState::FormattedLabel() {
  if (formatted_label_cache_.empty()) {
    formatted_label_cache_ =
        label_.empty() ? base::StringPrintf("<%d>", view_tree_token_->value)
                       : base::StringPrintf("<%d:%s>", view_tree_token_->value,
                                            label_.c_str());
  }
  return formatted_label_cache_;
}

std::ostream& operator<<(std::ostream& os, ViewTreeState* view_tree_state) {
  if (!view_tree_state)
    return os << "null";
  return os << view_tree_state->FormattedLabel();
}

}  // namespace view_manager
