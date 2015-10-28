// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef EXAMPLES_UI_TILE_TILE_VIEW_H_
#define EXAMPLES_UI_TILE_TILE_VIEW_H_

#include <map>
#include <memory>

#include "base/bind.h"
#include "base/memory/weak_ptr.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/public/cpp/bindings/strong_binding.h"
#include "mojo/public/cpp/environment/environment.h"
#include "mojo/public/cpp/system/core.h"
#include "mojo/public/cpp/system/macros.h"
#include "mojo/services/geometry/interfaces/geometry.mojom.h"
#include "mojo/services/surfaces/interfaces/surfaces.mojom.h"
#include "mojo/services/ui/views/interfaces/view_manager.mojom.h"
#include "mojo/services/ui/views/interfaces/view_provider.mojom.h"
#include "mojo/services/ui/views/interfaces/views.mojom.h"

namespace examples {

class TileView : public mojo::ui::View {
 public:
  TileView(mojo::ApplicationImpl* app_impl_,
           const std::vector<std::string>& view_urls,
           const mojo::ui::ViewProvider::CreateViewCallback& callback);

  ~TileView() override;

 private:
  struct ViewData {
    explicit ViewData(const std::string& url);
    ~ViewData();

    const std::string url;

    bool layout_pending;
    mojo::ui::ViewLayoutParamsPtr layout_params;
    mojo::ui::ViewLayoutInfoPtr layout_info;
    mojo::Rect layout_bounds;
  };

  // |View|:
  void OnLayout(mojo::ui::ViewLayoutParamsPtr layout_params,
                mojo::Array<uint32_t> children_needing_layout,
                const OnLayoutCallback& callback) override;
  void OnChildUnavailable(uint32_t child_key,
                          const OnChildUnavailableCallback& callback) override;

  void OnSurfaceIdNamespaceAvailable(uint32_t id_namespace);

  void InitView();
  void OnChildConnectionError(uint32_t child_key, const std::string& url);
  void OnChildCreated(uint32_t child_key,
                      const std::string& url,
                      mojo::ui::ViewProviderPtr provider,
                      mojo::ui::ViewTokenPtr token);
  void OnChildLayoutFinished(uint32_t child_key,
                             mojo::ui::ViewLayoutInfoPtr child_layout_info);
  void FinishLayout();

  void OnFrameSubmitted();

  mojo::ApplicationImpl* app_impl_;
  std::vector<std::string> view_urls_;
  mojo::ui::ViewProvider::CreateViewCallback callback_;
  mojo::StrongBinding<mojo::ui::View> binding_;

  mojo::SurfacePtr surfaces_;
  mojo::SurfaceIdPtr surface_id_;
  uint32_t surface_id_namespace_;

  mojo::ui::ViewManagerPtr view_manager_;
  mojo::ui::ViewHostPtr view_host_;

  std::map<uint32_t, std::unique_ptr<ViewData>> views_;

  mojo::Size size_;
  OnLayoutCallback pending_layout_callback_;
  uint32_t pending_child_layout_count_;
  bool frame_pending_;

  base::WeakPtrFactory<TileView> weak_ptr_factory_;

  DISALLOW_COPY_AND_ASSIGN(TileView);
};

}  // namespace examples

#endif  // EXAMPLES_UI_TILE_TILE_VIEW_H_
