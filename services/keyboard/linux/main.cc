// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/macros.h"
#include "base/threading/sequenced_worker_pool.h"
#include "mojo/application/application_runner_chromium.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_connection.h"
#include "mojo/public/cpp/application/application_delegate.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/public/cpp/application/connect.h"
#include "mojo/public/cpp/application/interface_factory.h"
#include "mojo/services/native_viewport/interfaces/native_viewport.mojom.h"
#include "services/keyboard/linux/keyboard_service_impl.h"

namespace keyboard {

class KeyboardServiceApp : public mojo::ApplicationDelegate,
                           public mojo::InterfaceFactory<KeyboardService> {
 public:
  KeyboardServiceApp() {}
  ~KeyboardServiceApp() override {}

 private:
  // |ApplicationDelegate| override:
  void Initialize(mojo::ApplicationImpl* app) override {
    shell_ = app->shell();

  /*
  // WRONG TROUSERS
    mojo::ServiceProviderPtr viewport_service_provider;
    shell_->ConnectToApplication("mojo:native_viewport_service",
                                 mojo::GetProxy(&viewport_service_provider),
                                 nullptr);
    mojo::NativeViewportPtr viewport_service_;
    mojo::ConnectToService(viewport_service_provider.get(), &viewport_service_);

    mojo::NativeViewportEventDispatcherPtr dispatcher;
    mojo::Binding<mojo::NativeViewportEventDispatcher> event_dispatcher_binding_(this);
    event_dispatcher_binding_.Bind(GetProxy(&dispatcher));
    viewport_service_->SetKeyEventDispatcher(dispatcher.Pass());
  */
  }

  // |ApplicationDelegate| override:
  bool ConfigureIncomingConnection(mojo::ApplicationConnection* connection) override {
    connection->AddService<KeyboardService>(this);
    return true;
  }

  // |InterfaceFactory<KeyboardService>| implementation:
  void Create(mojo::ApplicationConnection* connection,
              mojo::InterfaceRequest<KeyboardService> request) override {
    new LinuxKeyboardServiceImpl(request.Pass(), shell_, connection);
  }

 private:

  mojo::Shell* shell_;
  DISALLOW_COPY_AND_ASSIGN(KeyboardServiceApp);
};

}  // namespace keyboard

MojoResult MojoMain(MojoHandle application_request) {
  mojo::ApplicationRunnerChromium runner(
      new keyboard::KeyboardServiceApp());
  return runner.Run(application_request);
}
