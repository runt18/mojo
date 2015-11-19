// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/keyboard/linux/keyboard_service_impl.h"

#include "base/logging.h"
#include "base/strings/string16.h"
#include "base/strings/utf_string_conversions.h"
#include "mojo/public/cpp/application/application_connection.h"
#include "mojo/public/cpp/application/connect.h"
#include "mojo/services/input_events/interfaces/input_key_codes.mojom.h"

namespace keyboard {

LinuxKeyboardServiceImpl::LinuxKeyboardServiceImpl(
    mojo::InterfaceRequest<::keyboard::KeyboardService> request,
    mojo::InterfaceRequest<NativeViewportEventDispatcher> dispatcher)
    : binding_(this, request.Pass()),
      event_dispatcher_binding_(this, dispatcher.Pass()) {
}

LinuxKeyboardServiceImpl::~LinuxKeyboardServiceImpl() {
}

void LinuxKeyboardServiceImpl::Show(::keyboard::KeyboardClientPtr client,
                                    ::keyboard::KeyboardType type) {
  client_ = client.Pass();
}

void LinuxKeyboardServiceImpl::ShowByRequest() {
}

void LinuxKeyboardServiceImpl::Hide() {
  client_ = nullptr;
}

void LinuxKeyboardServiceImpl::SetText(const mojo::String& text) {
  text_ = text;
}

void LinuxKeyboardServiceImpl::SetSelection(int32_t start, int32_t end) {
  // Not applicable for physical keyboards
}

/*
  void commitCompletion(CompletionData completion);
  void commitCorrection(CorrectionData correction);
  void commitText(String text, int newCursorPosition);
  void deleteSurroundingText(int beforeLength, int afterLength);
  void setComposingRegion(int start, int end);
  void setComposingText(String text, int newCursorPosition);
  void setSelection(int start, int end);
  void submit(SubmitAction action);
*/

// |mojo::NativeViewportEventDispatcher| implementation:
void LinuxKeyboardServiceImpl::OnEvent(mojo::EventPtr event,
                                       const mojo::Callback<void()>& callback) {
  if (event->action == mojo::EventType::KEY_PRESSED && event->key_data->is_char) {
    if (client_) {
      switch(event->key_data->windows_key_code) {
        case mojo::KeyboardCode::BACK: // backspace
          client_->DeleteSurroundingText(1, 0);
          break;
        case mojo::KeyboardCode::DELETE:
          client_->DeleteSurroundingText(0, 1);
          break;
        case mojo::KeyboardCode::HOME:
          client_->SetSelection(0, 0);
          break;
        case mojo::KeyboardCode::END:
          client_->SetSelection(text_.size()-1, text_.size()-1);
          break;
        case mojo::KeyboardCode::TAB: // tab
          // TODO: Advance focus, in reverse if shifted
          break;
        case mojo::KeyboardCode::RETURN:
          client_->Submit(::keyboard::SubmitAction::DONE);
          break;
        default:
          base::string16 character;
          character.push_back(event->key_data->character);
          std::string s = base::UTF16ToUTF8(character);
          text_ += s;
          client_->CommitText(mojo::String(s), 1);
          break;
      }
    }
  }
  callback.Run();
}

}  // namespace keyboard
