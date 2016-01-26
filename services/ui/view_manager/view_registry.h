// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_UI_VIEW_MANAGER_VIEW_REGISTRY_H_
#define SERVICES_UI_VIEW_MANAGER_VIEW_REGISTRY_H_

#include <unordered_map>

#include "base/macros.h"
#include "mojo/services/gfx/composition/interfaces/compositor.mojom.h"
#include "mojo/services/ui/views/interfaces/view_associates.mojom.h"
#include "mojo/services/ui/views/interfaces/view_trees.mojom.h"
#include "mojo/services/ui/views/interfaces/views.mojom.h"
#include "services/ui/view_manager/view_associate_table.h"
#include "services/ui/view_manager/view_layout_request.h"
#include "services/ui/view_manager/view_state.h"
#include "services/ui/view_manager/view_tree_state.h"

namespace view_manager {

// Maintains a registry of the state of all views.
// All ViewState objects are owned by the registry.
class ViewRegistry : public mojo::ui::ViewInspector {
 public:
  using AssociateConnectionErrorCallback =
      ViewAssociateTable::AssociateConnectionErrorCallback;

  explicit ViewRegistry(mojo::gfx::composition::CompositorPtr compositor);
  ~ViewRegistry() override;

  // Begins connecting to the view associates.
  // Invokes |connection_error_callback| if an associate connection fails
  // and provides the associate's url.
  void ConnectAssociates(
      mojo::ApplicationImpl* app_impl,
      const std::vector<std::string>& urls,
      const AssociateConnectionErrorCallback& connection_error_callback);

  // VIEW MANAGER REQUESTS

  // Registers a view and returns its ViewToken.
  mojo::ui::ViewTokenPtr RegisterView(
      mojo::ui::ViewPtr view,
      mojo::InterfaceRequest<mojo::ui::ViewHost> view_host_request,
      const mojo::String& label);

  // Registers a view tree.
  mojo::ui::ViewTreeTokenPtr RegisterViewTree(
      mojo::ui::ViewTreePtr view_tree,
      mojo::InterfaceRequest<mojo::ui::ViewTreeHost> view_tree_host_request,
      const mojo::String& label);

  // VIEW HOST REQUESTS

  // Creates a scene for the view, replacing its current scene.
  // Destroys |view_state| if an error occurs.
  void CreateScene(ViewState* view_state,
                   mojo::InterfaceRequest<mojo::gfx::composition::Scene> scene);

  // Requests layout.
  // Destroys |view_state| if an error occurs.
  void RequestLayout(ViewState* view_state);

  // Adds a child, reparenting it if necessary.
  // Destroys |parent_state| if an error occurs.
  void AddChild(ViewState* parent_state,
                uint32_t child_key,
                mojo::ui::ViewTokenPtr child_view_token);

  // Removes a child.
  // Destroys |parent_state| if an error occurs.
  void RemoveChild(ViewState* parent_state, uint32_t child_key);

  // Lays out a child and optionally provides its size.
  // Destroys |parent_state| if an error occurs.
  void LayoutChild(ViewState* parent_state,
                   uint32_t child_key,
                   mojo::ui::ViewLayoutParamsPtr child_layout_params,
                   const ViewLayoutCallback& callback);

  // Connects to a view service.
  // Destroys |view_state| if an error occurs.
  void ConnectToViewService(ViewState* view_state,
                            const mojo::String& service_name,
                            mojo::ScopedMessagePipeHandle client_handle);

  // VIEW TREE HOST REQUESTS

  // Requests layout.
  // Destroys |tree_state| if an error occurs.
  void RequestLayout(ViewTreeState* tree_state);

  // Sets the root of the view tree.
  // Destroys |tree_state| if an error occurs.
  void SetRoot(ViewTreeState* tree_state,
               uint32_t root_key,
               mojo::ui::ViewTokenPtr root_view_token);

  // Resets the root of the view tree.
  // Destroys |tree_state| if an error occurs.
  void ResetRoot(ViewTreeState* tree_state);

  // Lays out a view tree's root and optionally provides its size.
  // Destroys |tree_state| if an error occurs.
  void LayoutRoot(ViewTreeState* tree_state,
                  mojo::ui::ViewLayoutParamsPtr root_layout_params,
                  const ViewLayoutCallback& callback);

  // Connects to a view service.
  // Destroys |view_state| if an error occurs.
  void ConnectToViewTreeService(ViewTreeState* tree_state,
                                const mojo::String& service_name,
                                mojo::ScopedMessagePipeHandle client_handle);

 private:
  // LIFETIME

  void OnViewConnectionError(ViewState* view_state);
  void UnregisterView(ViewState* view_state);
  void OnViewTreeConnectionError(ViewTreeState* tree_state);
  void UnregisterViewTree(ViewTreeState* tree_state);

  // TREE MANIPULATION

  ViewState* FindView(uint32_t view_token_value);
  void LinkChild(ViewState* parent_state,
                 uint32_t child_key,
                 ViewState* child_state);
  void LinkChildAsUnavailable(ViewState* parent_state, uint32_t child_key);
  void MarkChildAsUnavailable(ViewState* parent_state, uint32_t child_key);
  void UnlinkChild(ViewState* parent_state,
                   ViewState::ChildrenMap::iterator child_it);

  ViewTreeState* FindViewTree(uint32_t view_tree_token_value);
  void LinkRoot(ViewTreeState* tree_state,
                ViewState* root_state,
                uint32_t root_key);
  void UnlinkRoot(ViewTreeState* tree_state);
  void HijackView(ViewState* view_state);

  // Must be called before the view is actually unlinked from the tree.
  // Caller is still responsible for actually unlinking the view.
  void ResetStateWhenUnlinking(ViewState* view_state);

  // LAYOUT

  void InvalidateLayout(ViewState* view_state);
  void InvalidateLayoutForChild(ViewState* parent_state, uint32_t child_key);
  void InvalidateLayoutForRoot(ViewTreeState* tree_state);
  void SetLayout(ViewState* view_state,
                 mojo::ui::ViewLayoutParamsPtr layout_params,
                 const ViewLayoutCallback& callback);
  void EnqueueLayoutRequest(ViewState* view_state,
                            mojo::ui::ViewLayoutParamsPtr layout_params);
  void IssueNextViewLayoutRequest(ViewState* view_state);
  void IssueNextViewTreeLayoutRequest(ViewTreeState* tree_state);

  // SCENE MANAGEMENT

  void OnSceneCreated(base::WeakPtr<ViewState> view_state_weak,
                      mojo::gfx::composition::SceneTokenPtr scene_token);

  // SIGNALING

  void SendChildUnavailable(ViewState* parent_state, uint32_t child_key);
  void SendRootUnavailable(ViewTreeState* tree_state, uint32_t root_key);
  void SendViewLayoutRequest(ViewState* view_state);
  void SendViewTreeLayoutRequest(ViewTreeState* tree_state);
  void OnViewLayoutResult(base::WeakPtr<ViewState> view_state_weak,
                          mojo::ui::ViewLayoutResultPtr result);
  void OnViewTreeLayoutResult(base::WeakPtr<ViewTreeState> tree_state_weak);

  bool IsViewStateRegisteredDebug(ViewState* view_state) {
    return view_state && FindView(view_state->view_token()->value);
  }

  bool IsViewTreeStateRegisteredDebug(ViewTreeState* tree_state) {
    return tree_state && FindViewTree(tree_state->view_tree_token()->value);
  }

  mojo::gfx::composition::CompositorPtr compositor_;
  ViewAssociateTable associate_table_;

  uint32_t next_view_token_value_ = 1u;
  uint32_t next_view_tree_token_value_ = 1u;
  std::unordered_map<uint32_t, ViewState*> views_by_token_;
  std::unordered_map<uint32_t, ViewTreeState*> view_trees_by_token_;

  DISALLOW_COPY_AND_ASSIGN(ViewRegistry);
};

}  // namespace view_manager

#endif  // SERVICES_UI_VIEW_MANAGER_VIEW_REGISTRY_H_
