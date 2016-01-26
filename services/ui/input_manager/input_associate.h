// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_UI_INPUT_MANAGER_INPUT_ASSOCIATE_IMPL_H_
#define SERVICES_UI_INPUT_MANAGER_INPUT_ASSOCIATE_IMPL_H_

#include "base/macros.h"
#include "mojo/common/strong_binding_set.h"
#include "mojo/services/ui/input/interfaces/input_connection.mojom.h"
#include "mojo/services/ui/input/interfaces/input_dispatcher.mojom.h"
#include "mojo/services/ui/views/interfaces/view_associates.mojom.h"

namespace input_manager {

// InputManager's ViewAssociate interface implementation.
class InputAssociate : public mojo::ui::ViewAssociate {
 public:
  InputAssociate();
  ~InputAssociate() override;

 private:
  // InputConnection implementation.
  // Binds incoming requests to the relevant view token.
  class InputConnectionImpl : public mojo::ui::InputConnection {
   public:
    InputConnectionImpl(InputAssociate* associate,
                        mojo::ui::ViewTokenPtr view_token);
    ~InputConnectionImpl() override;

   private:
    void SetListener(mojo::ui::InputListenerPtr listener) override;

    InputAssociate* const associate_;
    mojo::ui::ViewTokenPtr view_token_;

    DISALLOW_COPY_AND_ASSIGN(InputConnectionImpl);
  };

  // InputDispatcher implementation.
  // Binds incoming requests to the relevant view token.
  class InputDispatcherImpl : public mojo::ui::InputDispatcher {
   public:
    InputDispatcherImpl(InputAssociate* associate,
                        mojo::ui::ViewTreeTokenPtr view_tree_token);
    ~InputDispatcherImpl() override;

   private:
    void DispatchEvent(mojo::EventPtr event) override;

    InputAssociate* const associate_;
    mojo::ui::ViewTreeTokenPtr view_tree_token_;

    DISALLOW_COPY_AND_ASSIGN(InputDispatcherImpl);
  };

  // |ViewAssociate|:
  void Connect(mojo::ui::ViewInspectorPtr inspector,
               const ConnectCallback& callback) override;
  void ConnectToViewService(
      mojo::ui::ViewTokenPtr view_token,
      const mojo::String& service_name,
      mojo::ScopedMessagePipeHandle client_handle) override;
  void ConnectToViewTreeService(
      mojo::ui::ViewTreeTokenPtr view_tree_token,
      const mojo::String& service_name,
      mojo::ScopedMessagePipeHandle client_handle) override;

  // Incoming service calls.
  void SetListener(mojo::ui::ViewToken* view_token,
                   mojo::ui::InputListenerPtr listener);
  void DispatchEvent(mojo::ui::ViewTreeToken* view_tree_token,
                     mojo::EventPtr event);

  // Callbacks.
  void OnEventFinished(bool handled);

  mojo::StrongBindingSet<mojo::ui::InputConnection> input_connections_;
  mojo::StrongBindingSet<mojo::ui::InputDispatcher> input_dispatchers_;

  mojo::ui::InputListenerPtr listener_;

  DISALLOW_COPY_AND_ASSIGN(InputAssociate);
};

}  // namespace input_manager

#endif  // SERVICES_UI_INPUT_MANAGER_INPUT_ASSOCIATE_IMPL_H_
