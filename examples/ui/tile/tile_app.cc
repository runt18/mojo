// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <vector>

#include "base/strings/string_split.h"
#include "examples/ui/tile/tile_app.h"
#include "examples/ui/tile/tile_view.h"
#include "url/gurl.h"

namespace examples {

class TileViewProvider : public mojo::ui::ViewProvider {
 public:
  TileViewProvider(mojo::ApplicationImpl* app_impl,
                   const std::vector<std::string>& view_urls)
      : app_impl_(app_impl), view_urls_(view_urls) {}
  ~TileViewProvider() override {}

 private:
  // |ViewProvider|:
  void CreateView(mojo::InterfaceRequest<mojo::ServiceProvider> services,
                  mojo::ServiceProviderPtr exposed_services,
                  const CreateViewCallback& callback) override {
    new TileView(app_impl_, view_urls_, callback);
  }

  mojo::ApplicationImpl* app_impl_;
  std::vector<std::string> view_urls_;

  DISALLOW_COPY_AND_ASSIGN(TileViewProvider);
};

TileApp::TileApp() {}

TileApp::~TileApp() {}

void TileApp::Initialize(mojo::ApplicationImpl* app_impl) {
  app_impl_ = app_impl;
}

bool TileApp::ConfigureIncomingConnection(
    mojo::ApplicationConnection* connection) {
  connection->AddService<mojo::ui::ViewProvider>(this);
  return true;
}

void TileApp::Create(mojo::ApplicationConnection* connection,
                     mojo::InterfaceRequest<mojo::ui::ViewProvider> request) {
  GURL url(connection->GetConnectionURL());
  std::vector<std::string> view_urls;
  base::SplitString(url.query(), ',', &view_urls);

  if (view_urls.empty()) {
    LOG(ERROR) << "Must supply comma-delimited URLs of mojo views to tile as a "
                  "query parameter.";
    return;
  }

  bindings_.AddBinding(new TileViewProvider(app_impl_, view_urls),
                       request.Pass());
}

}  // namespace examples
