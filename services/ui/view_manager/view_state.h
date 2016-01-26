// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_UI_VIEW_MANAGER_VIEW_STATE_H_
#define SERVICES_UI_VIEW_MANAGER_VIEW_STATE_H_

#include <memory>
#include <set>
#include <string>
#include <unordered_map>

#include "base/callback.h"
#include "base/macros.h"
#include "base/memory/weak_ptr.h"
#include "mojo/services/ui/views/cpp/formatting.h"
#include "mojo/services/ui/views/interfaces/views.mojom.h"
#include "services/ui/view_manager/view_layout_request.h"

namespace view_manager {

class ViewTreeState;

// Describes the state of a particular view.
// This object is owned by the ViewRegistry that created it.
class ViewState {
 public:
  using ChildrenMap = std::unordered_map<uint32_t, ViewState*>;

  ViewState(mojo::ui::ViewPtr view,
            mojo::ui::ViewTokenPtr view_token,
            const std::string& label);
  ~ViewState();

  base::WeakPtr<ViewState> GetWeakPtr() { return weak_factory_.GetWeakPtr(); }

  // Gets the view interface, never null.
  // Caller does not obtain ownership of the view.
  mojo::ui::View* view() const { return view_.get(); }

  // Gets the token used to refer to this view globally.
  // Caller does not obtain ownership of the token.
  mojo::ui::ViewToken* view_token() const { return view_token_.get(); }

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
  mojo::ui::ViewLayoutParams* layout_params() { return layout_params_.get(); }
  void set_layout_params(mojo::ui::ViewLayoutParamsPtr layout_params) {
    layout_params_ = layout_params.Pass();
  }

  // The layout result most recently provided by the view in
  // response to the value of |layout_params|, or null if none.  These
  // results are preserved across reparenting.
  mojo::ui::ViewLayoutResult* layout_result() { return layout_result_.get(); }
  void set_layout_result(mojo::ui::ViewLayoutResultPtr layout_result) {
    layout_result_ = layout_result.Pass();
  }

  // The current scene token, or null if none.
  mojo::gfx::composition::SceneToken* scene_token() {
    return scene_token_.get();
  }
  void set_scene_token(mojo::gfx::composition::SceneTokenPtr scene_token) {
    scene_token_ = scene_token.Pass();
  }

  // True if the scene changed since the last time the layout was reported
  // to the parent or tree.
  bool scene_changed_since_last_report() {
    return scene_changed_since_last_report_;
  }
  void set_scene_changed_since_last_report(bool value) {
    scene_changed_since_last_report_ = value;
  }

  // Creates layout information to return to the parent or tree.
  // Returns null if unavailable.
  mojo::ui::ViewLayoutInfoPtr CreateLayoutInfo();

  const std::string& label() { return label_; }
  const std::string& FormattedLabel();

 private:
  void SetTreeUnchecked(ViewTreeState* tree);

  mojo::ui::ViewPtr view_;
  mojo::ui::ViewTokenPtr view_token_;
  const std::string label_;
  std::string formatted_label_cache_;

  std::unique_ptr<mojo::ui::ViewHost> view_host_;
  ViewTreeState* tree_ = nullptr;
  ViewState* parent_ = nullptr;
  uint32_t key_ = 0u;
  ChildrenMap children_;
  std::set<uint32_t> children_needing_layout_;
  std::vector<std::unique_ptr<ViewLayoutRequest>> pending_layout_requests_;
  mojo::ui::ViewLayoutParamsPtr layout_params_;
  mojo::ui::ViewLayoutResultPtr layout_result_;
  mojo::gfx::composition::SceneTokenPtr scene_token_;
  bool scene_changed_since_last_report_ = false;

  base::WeakPtrFactory<ViewState> weak_factory_;  // must be last

  DISALLOW_COPY_AND_ASSIGN(ViewState);
};

std::ostream& operator<<(std::ostream& os, ViewState* view_state);

}  // namespace view_manager

#endif  // SERVICES_UI_VIEW_MANAGER_VIEW_STATE_H_
