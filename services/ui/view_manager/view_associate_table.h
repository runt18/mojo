// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_UI_VIEW_MANAGER_VIEW_ASSOCIATE_TABLE_H_
#define SERVICES_UI_VIEW_MANAGER_VIEW_ASSOCIATE_TABLE_H_

#include <memory>
#include <string>
#include <vector>

#include "base/callback.h"
#include "base/macros.h"
#include "mojo/common/binding_set.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/services/ui/views/interfaces/view_associates.mojom.h"

namespace view_manager {

// Maintains a table of all connected view associates.
class ViewAssociateTable {
 public:
  using AssociateConnectionErrorCallback =
      base::Callback<void(const std::string&)>;

  ViewAssociateTable();
  ~ViewAssociateTable();

  // Begins connecting to the view associates.
  // Invokes |connection_error_callback| if an associate connection fails
  // and provides the associate's url.
  void ConnectAssociates(
      mojo::ApplicationImpl* app_impl,
      mojo::ui::ViewInspector* inspector,
      const std::vector<std::string>& urls,
      const AssociateConnectionErrorCallback& connection_error_callback);

  // Connects to services offered by the view associates.
  void ConnectToViewService(mojo::ui::ViewTokenPtr view_token,
                            const mojo::String& service_name,
                            mojo::ScopedMessagePipeHandle client_handle);
  void ConnectToViewTreeService(mojo::ui::ViewTreeTokenPtr view_tree_token,
                                const mojo::String& service_name,
                                mojo::ScopedMessagePipeHandle client_handle);

  void OnConnected(uint32_t index, mojo::ui::ViewAssociateInfoPtr info);

  void CompleteDeferredWork();

 private:
  struct AssociateData {
    AssociateData(const std::string& url, mojo::ui::ViewInspector* inspector);
    ~AssociateData();

    const std::string url;
    mojo::ui::ViewAssociatePtr associate;
    mojo::ui::ViewAssociateInfoPtr info;
    mojo::Binding<mojo::ui::ViewInspector> inspector_binding;
  };

  std::vector<std::unique_ptr<AssociateData>> associates_;

  uint32_t pending_connection_count_ = 0u;
  std::vector<base::Closure> deferred_work_;

  DISALLOW_COPY_AND_ASSIGN(ViewAssociateTable);
};

}  // namespace view_manager

#endif  // SERVICES_UI_VIEW_MANAGER_VIEW_ASSOCIATE_TABLE_H_
