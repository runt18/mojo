// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef EXAMPLES_UI_TILE_TILE_APP_H_
#define EXAMPLES_UI_TILE_TILE_APP_H_

#include "base/bind.h"
#include "base/memory/scoped_ptr.h"
#include "mojo/common/strong_binding_set.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_connection.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/public/cpp/system/core.h"
#include "mojo/public/cpp/system/macros.h"
#include "mojo/services/ui/views/interfaces/view_provider.mojom.h"

namespace examples {

class TileApp : public mojo::ApplicationDelegate,
                public mojo::InterfaceFactory<mojo::ui::ViewProvider> {
 public:
  TileApp();
  ~TileApp() override;

  // |ApplicationDelegate|:
  void Initialize(mojo::ApplicationImpl* app) override;
  bool ConfigureIncomingConnection(
      mojo::ApplicationConnection* connection) override;

  // |InterfaceFactory<mojo::ui::ViewProvider>|:
  void Create(mojo::ApplicationConnection* connection,
              mojo::InterfaceRequest<mojo::ui::ViewProvider> request) override;

 private:
  mojo::ApplicationImpl* app_impl_;
  mojo::StrongBindingSet<mojo::ui::ViewProvider> bindings_;

  DISALLOW_COPY_AND_ASSIGN(TileApp);
};

}  // namespace examples

#endif  // EXAMPLES_UI_TILE_TILE_APP_H_
