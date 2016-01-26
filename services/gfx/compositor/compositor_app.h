// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_GFX_COMPOSITOR_COMPOSITOR_APP_H_
#define SERVICES_GFX_COMPOSITOR_COMPOSITOR_APP_H_

#include <memory>

#include "base/macros.h"
#include "base/memory/scoped_ptr.h"
#include "mojo/common/strong_binding_set.h"
#include "mojo/common/tracing_impl.h"
#include "mojo/public/cpp/application/application_delegate.h"
#include "mojo/services/gfx/composition/interfaces/compositor.mojom.h"
#include "services/gfx/compositor/compositor_engine.h"

namespace compositor {

// Compositor application entry point.
class CompositorApp
    : public mojo::ApplicationDelegate,
      public mojo::InterfaceFactory<mojo::gfx::composition::Compositor> {
 public:
  CompositorApp();
  ~CompositorApp() override;

 private:
  // |ApplicationDelegate|:
  void Initialize(mojo::ApplicationImpl* app_impl) override;
  bool ConfigureIncomingConnection(
      mojo::ApplicationConnection* connection) override;

  // |InterfaceFactory<Compositor>|:
  void Create(mojo::ApplicationConnection* connection,
              mojo::InterfaceRequest<mojo::gfx::composition::Compositor>
                  request) override;

  mojo::ApplicationImpl* app_impl_;
  mojo::TracingImpl tracing_;

  mojo::StrongBindingSet<mojo::gfx::composition::Compositor>
      compositor_bindings_;
  std::unique_ptr<CompositorEngine> engine_;

  DISALLOW_COPY_AND_ASSIGN(CompositorApp);
};

}  // namespace compositor

#endif  // SERVICES_GFX_COMPOSITOR_COMPOSITOR_APP_H_
