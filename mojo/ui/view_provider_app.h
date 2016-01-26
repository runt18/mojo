// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_UI_VIEW_PROVIDER_APP_H_
#define MOJO_UI_VIEW_PROVIDER_APP_H_

#include <string>

#include "mojo/common/strong_binding_set.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_connection.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/public/cpp/system/core.h"
#include "mojo/public/cpp/system/macros.h"
#include "mojo/services/ui/views/interfaces/view_provider.mojom.h"

namespace mojo {
namespace ui {

// Abstract implementation of a simple application that offers a ViewProvider.
// Subclasses must provide a function to create the necessary Views.
//
// It is not necessary to use this class to implement all ViewProviders.
// This class is merely intended to make the simple apps easier to write.
class ViewProviderApp : public mojo::ApplicationDelegate,
                        public mojo::InterfaceFactory<mojo::ui::ViewProvider> {
 public:
  ViewProviderApp();
  ~ViewProviderApp() override;

  mojo::ApplicationImpl* app_impl() { return app_impl_; }

  // |ApplicationDelegate|:
  void Initialize(mojo::ApplicationImpl* app) override;
  bool ConfigureIncomingConnection(
      mojo::ApplicationConnection* connection) override;

  // Called by the ViewProvider to create a view.
  // This method may be called multiple times in the case where the
  // view provider is asked to create multiple view instances.
  //
  // The |view_provider_url| is the connection URL of the view provider request.
  //
  // Returns true if successful, false if the view could not be created.
  virtual bool CreateView(
      const std::string& view_provider_url,
      mojo::InterfaceRequest<mojo::ServiceProvider> services,
      mojo::ServiceProviderPtr exposed_services,
      const mojo::ui::ViewProvider::CreateViewCallback& callback) = 0;

 private:
  class DelegatingViewProvider;

  // |InterfaceFactory<mojo::ui::ViewProvider>|:
  void Create(mojo::ApplicationConnection* connection,
              mojo::InterfaceRequest<mojo::ui::ViewProvider> request) override;

  void CreateView(DelegatingViewProvider* provider,
                  const std::string& view_provider_url,
                  mojo::InterfaceRequest<mojo::ServiceProvider> services,
                  mojo::ServiceProviderPtr exposed_services,
                  const mojo::ui::ViewProvider::CreateViewCallback& callback);

  mojo::ApplicationImpl* app_impl_ = nullptr;
  mojo::StrongBindingSet<mojo::ui::ViewProvider> bindings_;

  MOJO_DISALLOW_COPY_AND_ASSIGN(ViewProviderApp);
};

}  // namespace ui
}  // namespace mojo

#endif  // MOJO_UI_VIEW_PROVIDER_APP_H_
