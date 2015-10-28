// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_UI_VIEW_MANAGER_VIEW_TREE_STATE_H_
#define SERVICES_UI_VIEW_MANAGER_VIEW_TREE_STATE_H_

#include <memory>
#include <set>
#include <unordered_map>

#include "base/callback.h"
#include "base/macros.h"
#include "base/memory/weak_ptr.h"
#include "mojo/public/cpp/bindings/binding.h"
#include "mojo/services/ui/views/interfaces/view_trees.mojom.h"
#include "services/ui/view_manager/view_state.h"

namespace view_manager {

// Describes the state of a particular view tree.
// This object is owned by the ViewRegistry that created it.
class ViewTreeState {
 public:
  explicit ViewTreeState(mojo::ui::ViewTreePtr view_tree);
  ~ViewTreeState();

  base::WeakPtr<ViewTreeState> GetWeakPtr() {
    return weak_factory_.GetWeakPtr();
  }

  // Gets the view tree interface, never null.
  // Caller does not obtain ownership of the view.
  mojo::ui::ViewTree* view_tree() const { return view_tree_.get(); }

  // Sets the associated host implementation and takes ownership of it.
  void set_view_tree_host(mojo::ui::ViewTreeHost* host) {
    view_tree_host_.reset(host);
  }

  // Sets the connection error handler for the view.
  void set_view_tree_connection_error_handler(const base::Closure& handler) {
    view_tree_.set_connection_error_handler(handler);
  }

  // Gets the root of the view tree, or null if it is unavailable.
  ViewState* root() const { return root_; }

  // Sets the root of the view tree.  Must not be null.
  // The view specified as the new root must not have any parents.
  void SetRoot(ViewState* root, uint32_t key);

  // Resets the root view to null.
  void ResetRoot();

  // True if the client previously set but has not yet explicitly unset
  // the root, independent of whether it is currently available.
  bool explicit_root() const { return explicit_root_; }
  void set_explicit_root(bool value) { explicit_root_ = value; }

  // True if there is a pending layout request.
  bool layout_request_pending() const { return layout_request_pending_; }
  void set_layout_request_pending(bool value) {
    layout_request_pending_ = value;
  }

  // True if a layout request has been issued.
  bool layout_request_issued() const { return layout_request_issued_; }
  void set_layout_request_issued(bool value) { layout_request_issued_ = value; }

 private:
  mojo::ui::ViewTreePtr view_tree_;

  std::unique_ptr<mojo::ui::ViewTreeHost> view_tree_host_;
  ViewState* root_;
  bool explicit_root_;
  bool layout_request_pending_;
  bool layout_request_issued_;

  base::WeakPtrFactory<ViewTreeState> weak_factory_;  // must be last

  DISALLOW_COPY_AND_ASSIGN(ViewTreeState);
};

}  // namespace view_manager

#endif  // SERVICES_UI_VIEW_MANAGER_VIEW_TREE_STATE_H_
