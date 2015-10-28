// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_UI_VIEW_MANAGER_VIEW_STATE_H_
#define SERVICES_UI_VIEW_MANAGER_VIEW_STATE_H_

#include <memory>
#include <set>
#include <unordered_map>

#include "base/callback.h"
#include "base/macros.h"
#include "base/memory/weak_ptr.h"
#include "mojo/services/ui/views/interfaces/views.mojom.h"
#include "services/ui/view_manager/view_layout_request.h"

namespace view_manager {

class ViewTreeState;

// Describes the state of a particular view.
// This object is owned by the ViewRegistry that created it.
class ViewState {
 public:
  using ChildrenMap = std::unordered_map<uint32_t, ViewState*>;

  ViewState(mojo::ui::ViewPtr view, uint32_t view_token_value);
  ~ViewState();

  base::WeakPtr<ViewState> GetWeakPtr() { return weak_factory_.GetWeakPtr(); }

  // Gets the view interface, never null.
  // Caller does not obtain ownership of the view.
  mojo::ui::View* view() const { return view_.get(); }

  // Gets the view token value used to refer to this view globally.
  uint32_t view_token_value() const { return view_token_value_; }

  // Sets the associated host implementation and takes ownership of it.
  void set_view_host(mojo::ui::ViewHost* host) { view_host_.reset(host); }

  // Sets the connection error handler for the view.
  void set_view_connection_error_handler(const base::Closure& handler) {
    view_.set_connection_error_handler(handler);
  }

  // Gets the view tree to which this view belongs, or null if none.
  ViewTreeState* tree() const { return tree_; }

  // Gets the parent view state, or null if none.
  ViewState* parent() const { return parent_; }

  // Gets the key that this child has in its container, or 0 if none.
  uint32_t key() const { return key_; }

  // Recursively sets the view tree to which this view and all of its
  // descendents belongs.  Must not be null.  This method must only be called
  // on root views.
  void SetTree(ViewTreeState* tree, uint32_t key);

  // Sets the parent view state pointer, the child's key in its parent,
  // and set its view tree to that of its parent.  Must not be null.
  void SetParent(ViewState* parent, uint32_t key);

  // Resets the parent view state and tree pointers to null.
  void ResetContainer();

  // Gets the view's service provider.
  void GetServiceProvider(
      mojo::InterfaceRequest<mojo::ServiceProvider> service_provider);

  // The map of children, indexed by child key.
  // Child view state may be null if the child with the given key has
  // become unavailable but not yet removed.
  ChildrenMap& children() { return children_; }

  // The set of children needing layout.
  // This set must never contain non-existent or unavailable children.
  std::set<uint32_t>& children_needing_layout() {
    return children_needing_layout_;
  }

  // The list of pending layout requests.
  std::vector<std::unique_ptr<ViewLayoutRequest>>& pending_layout_requests() {
    return pending_layout_requests_;
  }

  // The layout parameters most recently processed by the view,
  // or null if none.  These parameters are preserved across reparenting.
  mojo::ui::ViewLayoutParamsPtr& layout_params() { return layout_params_; }

  // The layout information most recently provided by the view in
  // response to the value of |layout_params|, or null if none.  These
  // results are preserved across reparenting.
  mojo::ui::ViewLayoutInfoPtr& layout_info() { return layout_info_; }

  // The id of the Surface which the view manager itself created to wrap the
  // view's own Surface, or null if none.  The wrapped Surface is destroyed
  // when the view is reparented so that the old parent can no longer embed
  // the view's actual content.
  mojo::SurfaceIdPtr& wrapped_surface() { return wrapped_surface_; }

 private:
  void SetTreeUnchecked(ViewTreeState* tree);

  mojo::ui::ViewPtr view_;
  const uint32_t view_token_value_;

  std::unique_ptr<mojo::ui::ViewHost> view_host_;
  ViewTreeState* tree_;
  ViewState* parent_;
  uint32_t key_;
  ChildrenMap children_;
  std::set<uint32_t> children_needing_layout_;
  std::vector<std::unique_ptr<ViewLayoutRequest>> pending_layout_requests_;
  mojo::ui::ViewLayoutParamsPtr layout_params_;
  mojo::ui::ViewLayoutInfoPtr layout_info_;
  mojo::SurfaceIdPtr wrapped_surface_;

  base::WeakPtrFactory<ViewState> weak_factory_;  // must be last

  DISALLOW_COPY_AND_ASSIGN(ViewState);
};

}  // namespace view_manager

#endif  // SERVICES_UI_VIEW_MANAGER_VIEW_STATE_H_
