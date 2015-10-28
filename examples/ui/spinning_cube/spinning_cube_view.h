// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef EXAMPLES_UI_SPINNING_CUBE_SPINNING_CUBE_VIEW_H_
#define EXAMPLES_UI_SPINNING_CUBE_SPINNING_CUBE_VIEW_H_

#include <memory>

#include "base/bind.h"
#include "base/memory/weak_ptr.h"
#include "examples/spinning_cube/spinning_cube.h"
#include "mojo/gpu/gl_context.h"
#include "mojo/gpu/gl_context_owner.h"
#include "mojo/gpu/gl_texture.h"
#include "mojo/gpu/texture_cache.h"
#include "mojo/gpu/texture_uploader.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/public/cpp/bindings/strong_binding.h"
#include "mojo/public/cpp/environment/environment.h"
#include "mojo/public/cpp/system/core.h"
#include "mojo/public/cpp/system/macros.h"
#include "mojo/services/surfaces/interfaces/quads.mojom.h"
#include "mojo/services/surfaces/interfaces/surfaces.mojom.h"
#include "mojo/services/ui/views/interfaces/view_manager.mojom.h"
#include "mojo/services/ui/views/interfaces/view_provider.mojom.h"
#include "mojo/services/ui/views/interfaces/views.mojom.h"

namespace examples {

class SpinningCubeView : public mojo::ui::View {
 public:
  SpinningCubeView(mojo::ApplicationImpl* app,
                   const mojo::ui::ViewProvider::CreateViewCallback& callback);

  ~SpinningCubeView() override;

 private:
  // |View|:
  void OnLayout(mojo::ui::ViewLayoutParamsPtr layout_params,
                mojo::Array<uint32_t> children_needing_layout,
                const OnLayoutCallback& callback) override;
  void OnChildUnavailable(uint32_t child_key,
                          const OnChildUnavailableCallback& callback) override;

  void OnSurfaceIdNamespaceAvailable(uint32_t id_namespace);

  void InitView();

  void InitCube();
  void DrawCube();
  void OnSurfaceSubmitted();
  void ScheduleDraw();

  mojo::ui::ViewProvider::CreateViewCallback callback_;
  mojo::StrongBinding<mojo::ui::View> binding_;

  mojo::GLContextOwner context_owner_;
  mojo::ResourceReturnerPtr resource_returner_;  // must be before texture cache
  mojo::TextureCache texture_cache_;

  mojo::SurfacePtr surfaces_;
  mojo::SurfaceIdPtr surface_id_;
  uint32_t surface_id_namespace_;

  mojo::ui::ViewManagerPtr view_manager_;
  mojo::ui::ViewHostPtr view_host_;
  mojo::ServiceProviderPtr view_service_provider_;

  mojo::Size size_;

  SpinningCube cube_;
  MojoTimeTicks last_draw_;
  bool draw_scheduled_;

  base::WeakPtrFactory<SpinningCubeView> weak_ptr_factory_;

  DISALLOW_COPY_AND_ASSIGN(SpinningCubeView);
};

}  // namespace examples

#endif  // EXAMPLES_UI_SPINNING_CUBE_SPINNING_CUBE_VIEW_H_
