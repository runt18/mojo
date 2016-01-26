// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_UI_LAUNCHER_VIEW_TREE_IMPL_H_
#define SERVICES_UI_LAUNCHER_VIEW_TREE_IMPL_H_

#include "base/callback.h"
#include "base/macros.h"
#include "mojo/public/cpp/bindings/binding.h"
#include "mojo/services/gfx/composition/interfaces/compositor.mojom.h"
#include "mojo/services/native_viewport/interfaces/native_viewport.mojom.h"
#include "mojo/services/ui/input/interfaces/input_dispatcher.mojom.h"
#include "mojo/services/ui/views/interfaces/view_manager.mojom.h"

namespace launcher {

class LauncherViewTree : public mojo::ui::ViewTree,
                         public mojo::gfx::composition::SceneListener {
 public:
  LauncherViewTree(mojo::gfx::composition::Compositor* compositor,
                   mojo::ui::ViewManager* view_manager,
                   mojo::ContextProviderPtr context_provider,
                   mojo::ViewportMetricsPtr viewport_metrics,
                   const base::Closure& shutdown_callback);

  ~LauncherViewTree() override;

  void SetRoot(mojo::ui::ViewTokenPtr token);
  void SetViewportMetrics(mojo::ViewportMetricsPtr viewport_metrics);
  void DispatchEvent(mojo::EventPtr event);

 private:
  // |SceneListener|:
  void OnResourceUnavailable(
      uint32_t resource_id,
      const OnResourceUnavailableCallback& callback) override;

  // |ViewTree|:
  void OnLayout(const OnLayoutCallback& callback) override;
  void OnRootUnavailable(uint32_t root_key,
                         const OnRootUnavailableCallback& callback) override;

  void OnRendererConnectionError();
  void OnSceneConnectionError();
  void OnViewTreeConnectionError();
  void OnInputDispatcherConnectionError();

  void OnSceneRegistered(mojo::gfx::composition::SceneTokenPtr scene_token);
  void OnViewTreeRegistered(mojo::ui::ViewTreeTokenPtr view_tree_token);

  void LayoutRoot();
  void OnLayoutResult(mojo::ui::ViewLayoutInfoPtr info);

  void SetRootScene();

  void PublishFrame();

  void Shutdown();

  mojo::gfx::composition::Compositor* compositor_;
  mojo::ui::ViewManager* view_manager_;

  mojo::ContextProviderPtr context_provider_;
  mojo::ViewportMetricsPtr viewport_metrics_;
  base::Closure shutdown_callback_;

  mojo::Binding<mojo::gfx::composition::SceneListener> scene_listener_binding_;
  mojo::Binding<mojo::ui::ViewTree> view_tree_binding_;

  mojo::gfx::composition::ScenePtr scene_;
  mojo::gfx::composition::SceneTokenPtr scene_token_;
  uint32_t scene_version_ = 1u;

  mojo::gfx::composition::RendererPtr renderer_;
  mojo::ui::ViewTreeHostPtr view_tree_host_;
  mojo::ui::InputDispatcherPtr input_dispatcher_;

  mojo::ui::ViewTokenPtr root_;
  uint32_t root_key_ = 0u;
  mojo::ui::ViewLayoutInfoPtr root_layout_info_;

  DISALLOW_COPY_AND_ASSIGN(LauncherViewTree);
};

}  // namespace launcher

#endif  // SERVICES_UI_LAUNCHER_VIEW_TREE_IMPL_H_
