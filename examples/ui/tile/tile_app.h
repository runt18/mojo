// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef EXAMPLES_UI_TILE_TILE_APP_H_
#define EXAMPLES_UI_TILE_TILE_APP_H_

#include "mojo/ui/view_provider_app.h"

namespace examples {

class TileApp : public mojo::ui::ViewProviderApp {
 public:
  TileApp();
  ~TileApp() override;

  bool CreateView(
      const std::string& connection_url,
      mojo::InterfaceRequest<mojo::ServiceProvider> services,
      mojo::ServiceProviderPtr exposed_services,
      const mojo::ui::ViewProvider::CreateViewCallback& callback) override;

 private:
  DISALLOW_COPY_AND_ASSIGN(TileApp);
};

}  // namespace examples

#endif  // EXAMPLES_UI_TILE_TILE_APP_H_
