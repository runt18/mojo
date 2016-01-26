// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_UI_CONTENT_VIEWER_APP_H_
#define MOJO_UI_CONTENT_VIEWER_APP_H_

#include "mojo/common/strong_binding_set.h"
#include "mojo/services/content_handler/interfaces/content_handler.mojom.h"
#include "mojo/ui/view_provider_app.h"

namespace mojo {
namespace ui {

// A simple ContentHandler application implementation for rendering
// content as Views.  Subclasses must provide a function to create
// the view provider application on demand.
//
// TODO(jeffbrown): Support creating the view provider application in a
// separate thread if desired (often not the case).  This is one reason
// we are not using the ContentHandlerFactory here.
class ContentViewerApp : public mojo::ApplicationDelegate,
                         public mojo::InterfaceFactory<mojo::ContentHandler> {
 public:
  ContentViewerApp();
  ~ContentViewerApp() override;

  mojo::ApplicationImpl* app_impl() { return app_impl_; }

  // |ApplicationDelegate|:
  void Initialize(mojo::ApplicationImpl* app) override;
  bool ConfigureIncomingConnection(
      mojo::ApplicationConnection* connection) override;

  // Called to create the view provider application to view the content.
  //
  // This method may be called multiple times to load different content
  // into separate view providers.  The view provider implementation should
  // cache the loaded content in case it is asked to create multiple instances
  // of the view since the response can only be consumed once.
  //
  // The |content_handler_url| is the connection URL of the content handler
  // request.
  // The |response| carries the data retrieved by the content handler.
  //
  // Returns the view provider application delegate to view the content,
  // or nullptr if the content could not be loaded.
  virtual ViewProviderApp* LoadContent(const std::string& content_handler_url,
                                       mojo::URLResponsePtr response) = 0;

 private:
  class DelegatingContentHandler;

  // |InterfaceFactory<ContentHandler>|:
  void Create(mojo::ApplicationConnection* connection,
              mojo::InterfaceRequest<mojo::ContentHandler> request) override;

  void StartViewer(
      const std::string& content_handler_url,
      mojo::InterfaceRequest<mojo::Application> application_request,
      mojo::URLResponsePtr response);

  mojo::ApplicationImpl* app_impl_ = nullptr;
  mojo::StrongBindingSet<mojo::ContentHandler> bindings_;

  MOJO_DISALLOW_COPY_AND_ASSIGN(ContentViewerApp);
};

}  // namespace ui
}  // namespace mojo

#endif  // MOJO_UI_CONTENT_VIEWER_APP_H_
