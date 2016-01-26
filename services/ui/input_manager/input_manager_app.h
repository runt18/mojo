// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_UI_INPUT_MANAGER_INPUT_MANAGER_APP_H_
#define SERVICES_UI_INPUT_MANAGER_INPUT_MANAGER_APP_H_

#include <memory>

#include "base/macros.h"
#include "mojo/common/strong_binding_set.h"
#include "mojo/common/tracing_impl.h"
#include "mojo/public/cpp/application/application_delegate.h"
#include "mojo/services/ui/views/interfaces/view_associates.mojom.h"

namespace input_manager {

// Input manager application entry point.
class InputManagerApp : public mojo::ApplicationDelegate,
                        public mojo::InterfaceFactory<mojo::ui::ViewAssociate> {
 public:
  InputManagerApp();
  ~InputManagerApp() override;

 private:
  // |ApplicationDelegate|:
  void Initialize(mojo::ApplicationImpl* app_impl) override;
  bool ConfigureIncomingConnection(
      mojo::ApplicationConnection* connection) override;

  // |InterfaceFactory<ViewAssociate>|:
  void Create(mojo::ApplicationConnection* connection,
              mojo::InterfaceRequest<mojo::ui::ViewAssociate> request) override;

  mojo::ApplicationImpl* app_impl_;
  mojo::TracingImpl tracing_;

  mojo::StrongBindingSet<mojo::ui::ViewAssociate> input_associates;

  DISALLOW_COPY_AND_ASSIGN(InputManagerApp);
};

}  // namespace input_manager

#endif  // SERVICES_UI_INPUT_MANAGER_INPUT_MANAGER_APP_H_
