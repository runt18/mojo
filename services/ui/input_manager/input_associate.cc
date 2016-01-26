// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/ui/input_manager/input_associate.h"

#include "base/bind.h"
#include "base/logging.h"
#include "mojo/public/cpp/bindings/interface_request.h"

namespace input_manager {

InputAssociate::InputAssociate() {}

InputAssociate::~InputAssociate() {}

void InputAssociate::Connect(mojo::ui::ViewInspectorPtr inspector,
                             const ConnectCallback& callback) {
  DCHECK(inspector);  // checked by mojom

  auto info = mojo::ui::ViewAssociateInfo::New();
  info->view_service_names.push_back(mojo::ui::InputConnection::Name_);
  info->view_tree_service_names.push_back(mojo::ui::InputDispatcher::Name_);
  callback.Run(info.Pass());
}

void InputAssociate::ConnectToViewService(
    mojo::ui::ViewTokenPtr view_token,
    const mojo::String& service_name,
    mojo::ScopedMessagePipeHandle client_handle) {
  DCHECK(view_token);  // checked by mojom

  if (service_name == mojo::ui::InputConnection::Name_) {
    input_connections_.AddBinding(
        new InputConnectionImpl(this, view_token.Pass()),
        mojo::MakeRequest<mojo::ui::InputConnection>(client_handle.Pass()));
  }
}

void InputAssociate::ConnectToViewTreeService(
    mojo::ui::ViewTreeTokenPtr view_tree_token,
    const mojo::String& service_name,
    mojo::ScopedMessagePipeHandle client_handle) {
  DCHECK(view_tree_token);  // checked by mojom

  if (service_name == mojo::ui::InputDispatcher::Name_) {
    input_dispatchers_.AddBinding(
        new InputDispatcherImpl(this, view_tree_token.Pass()),
        mojo::MakeRequest<mojo::ui::InputDispatcher>(client_handle.Pass()));
  }
}

void InputAssociate::SetListener(mojo::ui::ViewToken* view_token,
                                 mojo::ui::InputListenerPtr listener) {
  // TODO(jeffbrown): This simple hack just hooks up the first listener
  // ever seen.
  listener_ = listener.Pass();
}

void InputAssociate::DispatchEvent(mojo::ui::ViewTreeToken* view_tree_token,
                                   mojo::EventPtr event) {
  if (listener_)
    listener_->OnEvent(
        event.Pass(),
        base::Bind(&InputAssociate::OnEventFinished, base::Unretained(this)));
}

void InputAssociate::OnEventFinished(bool handled) {
  // TODO: detect ANRs
}

InputAssociate::InputConnectionImpl::InputConnectionImpl(
    InputAssociate* associate,
    mojo::ui::ViewTokenPtr view_token)
    : associate_(associate), view_token_(view_token.Pass()) {
  DCHECK(associate_);
  DCHECK(view_token_);
}

InputAssociate::InputConnectionImpl::~InputConnectionImpl() {}

void InputAssociate::InputConnectionImpl::SetListener(
    mojo::ui::InputListenerPtr listener) {
  associate_->SetListener(view_token_.get(), listener.Pass());
}

InputAssociate::InputDispatcherImpl::InputDispatcherImpl(
    InputAssociate* associate,
    mojo::ui::ViewTreeTokenPtr view_tree_token)
    : associate_(associate), view_tree_token_(view_tree_token.Pass()) {
  DCHECK(associate_);
  DCHECK(view_tree_token_);
}

InputAssociate::InputDispatcherImpl::~InputDispatcherImpl() {}

void InputAssociate::InputDispatcherImpl::DispatchEvent(mojo::EventPtr event) {
  associate_->DispatchEvent(view_tree_token_.get(), event.Pass());
}

}  // namespace input_manager
