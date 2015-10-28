// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_UI_VIEW_MANAGER_SURFACE_MANAGER_H_
#define SERVICES_UI_VIEW_MANAGER_SURFACE_MANAGER_H_

#include "base/macros.h"
#include "mojo/services/surfaces/interfaces/surfaces.mojom.h"

namespace view_manager {

// Manages surfaces on behalf of the view manager.
class SurfaceManager {
 public:
  explicit SurfaceManager(mojo::SurfacePtr surfaces);
  ~SurfaceManager();

  mojo::SurfaceIdPtr CreateWrappedSurface(mojo::SurfaceId* inner_surface_id);

  void DestroySurface(mojo::SurfaceIdPtr surface_id);

 private:
  void OnSurfaceIdNamespaceAvailable(uint32_t id_namespace);

  mojo::SurfacePtr surfaces_;
  uint32_t surface_namespace_;

  DISALLOW_COPY_AND_ASSIGN(SurfaceManager);
};

}  // namespace view_manager

#endif  // SERVICES_UI_VIEW_MANAGER_SURFACE_MANAGER_H_
