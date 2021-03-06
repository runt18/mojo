// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef APPS_MOTERM_MOTERM_VIEW_H_
#define APPS_MOTERM_MOTERM_VIEW_H_

#include <memory>

#include "apps/moterm/moterm_driver.h"
#include "apps/moterm/moterm_model.h"
#include "base/macros.h"
#include "base/memory/weak_ptr.h"
#include "mojo/common/binding_set.h"
#include "mojo/public/cpp/application/interface_factory.h"
#include "mojo/public/cpp/application/service_provider_impl.h"
#include "mojo/public/cpp/bindings/callback.h"
#include "mojo/public/cpp/bindings/interface_request.h"
#include "mojo/services/input_events/interfaces/input_event_constants.mojom.h"
#include "mojo/services/input_events/interfaces/input_events.mojom.h"
#include "mojo/services/terminal/interfaces/terminal.mojom.h"
#include "mojo/ui/choreographer.h"
#include "mojo/ui/ganesh_view.h"
#include "mojo/ui/input_handler.h"
#include "third_party/skia/include/core/SkBitmapDevice.h"
#include "third_party/skia/include/core/SkTypeface.h"

class MotermView : public mojo::ui::GaneshView,
                   public mojo::ui::ChoreographerDelegate,
                   public mojo::ui::InputListener,
                   public MotermModel::Delegate,
                   public MotermDriver::Client,
                   public mojo::InterfaceFactory<mojo::terminal::Terminal>,
                   public mojo::terminal::Terminal {
 public:
  MotermView(
      mojo::ApplicationImpl* app_impl,
      mojo::InterfaceRequest<mojo::ServiceProvider> service_provider_request,
      const mojo::ui::ViewProvider::CreateViewCallback& create_view_callback);
  ~MotermView() override;

 private:
  // |mojo::ui::GaneshView|:
  void OnLayout(mojo::ui::ViewLayoutParamsPtr layout_params,
                mojo::Array<uint32_t> children_needing_layout,
                const OnLayoutCallback& callback) override;

  // |mojo::ui::ChoreographerDelegate|:
  void OnDraw(const mojo::gfx::composition::FrameInfo& frame_info,
              const base::TimeDelta& time_delta) override;

  // |mojo::ui::InputListener|:
  void OnEvent(mojo::EventPtr event, const OnEventCallback& callback) override;

  // |MotermModel::Delegate|:
  void OnResponse(const void* buf, size_t size) override;
  void OnSetKeypadMode(bool application_mode) override;

  // |MotermDriver::Client|:
  void OnDataReceived(const void* bytes, size_t num_bytes) override;
  void OnClosed() override;
  void OnDestroyed() override;

  // |mojo::InterfaceFactory<mojo::terminal::Terminal>|:
  void Create(
      mojo::ApplicationConnection* connection,
      mojo::InterfaceRequest<mojo::terminal::Terminal> request) override;

  // |mojo::terminal::Terminal| implementation:
  void Connect(mojo::InterfaceRequest<mojo::files::File> terminal_file,
               bool force,
               const ConnectCallback& callback) override;
  void ConnectToClient(mojo::terminal::TerminalClientPtr terminal_client,
                       bool force,
                       const ConnectToClientCallback& callback) override;
  void GetSize(const GetSizeCallback& callback) override;
  void SetSize(uint32_t rows,
               uint32_t columns,
               bool reset,
               const SetSizeCallback& callback) override;

  // If |force| is true, it will draw everything. Otherwise it will draw only if
  // |model_state_changes_| is dirty.
  void ScheduleDraw(bool force);
  void DrawContent(SkCanvas* canvas);

  void OnKeyPressed(mojo::EventPtr key_event);

  mojo::Size view_size_;
  mojo::ui::Choreographer choreographer_;
  mojo::ui::InputHandler input_handler_;

  // TODO(vtl): Consider the structure of this app. Do we really want the "view"
  // owning the model?
  // The terminal model.
  MotermModel model_;
  // State changes to the model since last draw.
  MotermModel::StateChanges model_state_changes_;

  base::WeakPtr<MotermDriver> driver_;
  // If set, called when we get |OnClosed()| or |OnDestroyed()| from the driver.
  mojo::Closure on_closed_callback_;

  mojo::ServiceProviderImpl service_provider_impl_;
  mojo::BindingSet<mojo::terminal::Terminal> terminal_bindings_;

  // If we skip drawing despite being forced to, we should force the next draw.
  bool force_next_draw_;

  skia::RefPtr<SkTypeface> regular_typeface_;

  int ascent_;
  int line_height_;
  int advance_width_;

  // Keyboard state.
  bool keypad_application_mode_;

  DISALLOW_COPY_AND_ASSIGN(MotermView);
};

#endif  // APPS_MOTERM_MOTERM_VIEW_H_
