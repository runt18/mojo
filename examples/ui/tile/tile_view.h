// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef EXAMPLES_UI_TILE_TILE_VIEW_H_
#define EXAMPLES_UI_TILE_TILE_VIEW_H_

#include <map>
#include <memory>

#include "mojo/ui/base_view.h"

namespace examples {

class TileView : public mojo::ui::BaseView {
 public:
  TileView(mojo::ApplicationImpl* app_impl_,
           const std::vector<std::string>& view_urls,
           const mojo::ui::ViewProvider::CreateViewCallback& callback);

  ~TileView() override;

 private:
  struct ViewData {
    explicit ViewData(const std::string& url, uint32_t key);
    ~ViewData();

    const std::string url;
    const uint32_t key;

    bool layout_pending;
    mojo::ui::ViewLayoutParamsPtr layout_params;
    mojo::ui::ViewLayoutInfoPtr layout_info;
    mojo::Rect layout_bounds;
  };

  // |BaseView|:
  void OnLayout(mojo::ui::ViewLayoutParamsPtr layout_params,
                mojo::Array<uint32_t> children_needing_layout,
                const OnLayoutCallback& callback) override;
  void OnChildUnavailable(uint32_t child_key,
                          const OnChildUnavailableCallback& callback) override;

  void ConnectViews();
  void OnChildConnectionError(uint32_t child_key, const std::string& url);
  void OnChildCreated(uint32_t child_key,
                      const std::string& url,
                      mojo::ui::ViewProviderPtr provider,
                      mojo::ui::ViewTokenPtr token);
  void OnChildLayoutFinished(uint32_t child_key,
                             mojo::ui::ViewLayoutInfoPtr child_layout_info);
  void FinishLayout();

  void OnFrameSubmitted();

  std::vector<std::string> view_urls_;
  std::map<uint32_t, std::unique_ptr<ViewData>> views_;

  mojo::Size size_;
  OnLayoutCallback pending_layout_callback_;
  uint32_t pending_child_layout_count_ = 0u;

  DISALLOW_COPY_AND_ASSIGN(TileView);
};

}  // namespace examples

#endif  // EXAMPLES_UI_TILE_TILE_VIEW_H_
