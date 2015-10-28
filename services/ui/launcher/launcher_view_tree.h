// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_UI_LAUNCHER_VIEW_TREE_IMPL_H_
#define SERVICES_UI_LAUNCHER_VIEW_TREE_IMPL_H_

#include "base/macros.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/public/cpp/bindings/binding.h"
#include "mojo/services/native_viewport/interfaces/native_viewport.mojom.h"
#include "mojo/services/surfaces/cpp/surfaces_utils.h"
#include "mojo/services/surfaces/interfaces/display.mojom.h"
#include "mojo/services/surfaces/interfaces/quads.mojom.h"
#include "mojo/services/surfaces/interfaces/surfaces.mojom.h"
#include "mojo/services/ui/views/interfaces/view_manager.mojom.h"

namespace launcher {

class LauncherViewTree : public mojo::ui::ViewTree {
 public:
  LauncherViewTree(mojo::ApplicationImpl* app_impl,
                   mojo::DisplayPtr display,
                   mojo::ViewportMetricsPtr viewport_metrics);

  ~LauncherViewTree() override;

  void SetRoot(mojo::ui::ViewTokenPtr token);
  void SetViewportMetrics(mojo::ViewportMetricsPtr viewport_metrics);
  void DispatchEvent(mojo::EventPtr event);

 private:
  // |ViewTree|:
  void OnLayout(const OnLayoutCallback& callback) override;
  void OnRootUnavailable(uint32_t root_key,
                         const OnRootUnavailableCallback& callback) override;

  void OnViewManagerConnectionError();
  void OnViewTreeRegistered();

  void LayoutRoot();
  void OnLayoutResult(mojo::ui::ViewLayoutInfoPtr info);

  void ScheduleFrame();
  void FinishFrame();
  void OnFrameSubmitted();

  mojo::ui::ViewManagerPtr view_manager_;
  mojo::DisplayPtr display_;
  mojo::ViewportMetricsPtr viewport_metrics_;
  mojo::Binding<mojo::ui::ViewTree> binding_;

  mojo::ui::ViewTreeHostPtr view_tree_host_;

  mojo::ui::ViewTokenPtr root_;
  uint32_t root_key_;
  mojo::ui::ViewLayoutInfoPtr root_layout_info_;

  bool frame_scheduled_;
  bool frame_pending_;

  DISALLOW_COPY_AND_ASSIGN(LauncherViewTree);
};

}  // namespace launcher

#endif  // SERVICES_UI_LAUNCHER_VIEW_TREE_IMPL_H_
