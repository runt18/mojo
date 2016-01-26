// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <vector>

#include "base/strings/string_split.h"
#include "examples/ui/tile/tile_app.h"
#include "examples/ui/tile/tile_view.h"
#include "url/gurl.h"

namespace examples {

TileApp::TileApp() {}

TileApp::~TileApp() {}

bool TileApp::CreateView(
    const std::string& connection_url,
    mojo::InterfaceRequest<mojo::ServiceProvider> services,
    mojo::ServiceProviderPtr exposed_services,
    const mojo::ui::ViewProvider::CreateViewCallback& callback) {
  GURL url(connection_url);
  std::vector<std::string> view_urls;
  base::SplitString(url.query(), ',', &view_urls);

  if (view_urls.empty()) {
    LOG(ERROR) << "Must supply comma-delimited URLs of mojo views to tile as a "
                  "query parameter.";
    return false;
  }

  new TileView(app_impl(), view_urls, callback);
  return true;
}

}  // namespace examples
