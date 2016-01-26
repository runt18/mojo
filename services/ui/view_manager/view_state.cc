// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/ui/view_manager/view_state.h"

#include "base/logging.h"
#include "base/strings/stringprintf.h"
#include "services/ui/view_manager/view_tree_state.h"

namespace view_manager {

ViewState::ViewState(mojo::ui::ViewPtr view,
                     mojo::ui::ViewTokenPtr view_token,
                     const std::string& label)
    : view_(view.Pass()),
      view_token_(view_token.Pass()),
      label_(label),
      weak_factory_(this) {
  DCHECK(view_);
  DCHECK(view_token_);
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

mojo::ui::ViewLayoutInfoPtr ViewState::CreateLayoutInfo() {
  if (!layout_result_ || !scene_token_)
    return nullptr;

  auto info = mojo::ui::ViewLayoutInfo::New();
  info->size = layout_result_->size.Clone();
  info->scene_token = scene_token_.Clone();
  return info;
}

const std::string& ViewState::FormattedLabel() {
  if (formatted_label_cache_.empty()) {
    formatted_label_cache_ =
        label_.empty()
            ? base::StringPrintf("<%d>", view_token_->value)
            : base::StringPrintf("<%d:%s>", view_token_->value, label_.c_str());
  }
  return formatted_label_cache_;
}

std::ostream& operator<<(std::ostream& os, ViewState* view_state) {
  if (!view_state)
    return os << "null";
  return os << view_state->FormattedLabel();
}

}  // namespace view_manager
