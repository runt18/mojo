// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/bind.h"
#include "base/bind_helpers.h"
#include "mojo/services/surfaces/cpp/surfaces_utils.h"
#include "mojo/services/surfaces/interfaces/quads.mojom.h"
#include "mojo/services/surfaces/interfaces/surfaces.mojom.h"
#include "services/ui/view_manager/surface_manager.h"

namespace view_manager {

SurfaceManager::SurfaceManager(mojo::SurfacePtr surfaces)
    : surfaces_(surfaces.Pass()), surface_namespace_(0u) {}

SurfaceManager::~SurfaceManager() {}

mojo::SurfaceIdPtr SurfaceManager::CreateWrappedSurface(
    mojo::SurfaceId* inner_surface_id) {
  return inner_surface_id->Clone();
}

void SurfaceManager::DestroySurface(mojo::SurfaceIdPtr surface_id) {
  // surfaces_->DestroySurface(surface_id->local);
}

}  // namespace view_manager
