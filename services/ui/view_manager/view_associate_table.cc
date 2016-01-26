// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/ui/view_manager/view_associate_table.h"

#include <algorithm>

#include "base/bind.h"
#include "base/bind_helpers.h"
#include "mojo/services/ui/views/cpp/formatting.h"

namespace view_manager {

template <typename T>
static bool Contains(const mojo::Array<T>& array, const T& value) {
  return std::find(array.storage().cbegin(), array.storage().cend(), value) !=
         array.storage().cend();
}

ViewAssociateTable::ViewAssociateTable() {}

ViewAssociateTable::~ViewAssociateTable() {}

void ViewAssociateTable::ConnectAssociates(
    mojo::ApplicationImpl* app_impl,
    mojo::ui::ViewInspector* inspector,
    const std::vector<std::string>& urls,
    const AssociateConnectionErrorCallback& connection_error_callback) {
  DCHECK(app_impl);
  DCHECK(inspector);

  for (auto& url : urls) {
    DVLOG(1) << "Connecting to view associate: url=" << url;
    associates_.emplace_back(new AssociateData(url, inspector));
    AssociateData* data = associates_.back().get();

    app_impl->ConnectToService(url, &data->associate);
    data->associate.set_connection_error_handler(
        base::Bind(connection_error_callback, url));

    mojo::ui::ViewInspectorPtr inspector;
    data->inspector_binding.Bind(mojo::GetProxy(&inspector));
    data->associate->Connect(
        inspector.Pass(),
        base::Bind(&ViewAssociateTable::OnConnected, base::Unretained(this),
                   pending_connection_count_));

    pending_connection_count_++;
  }
}

void ViewAssociateTable::ConnectToViewService(
    mojo::ui::ViewTokenPtr view_token,
    const mojo::String& service_name,
    mojo::ScopedMessagePipeHandle client_handle) {
  if (pending_connection_count_) {
    deferred_work_.push_back(
        base::Bind(&ViewAssociateTable::ConnectToViewService,
                   base::Unretained(this), base::Passed(view_token.Pass()),
                   service_name, base::Passed(client_handle.Pass())));
    return;
  }

  for (auto& data : associates_) {
    DCHECK(data->info);
    if (Contains(data->info->view_service_names, service_name)) {
      DVLOG(2) << "Connecting to view service: view_token=" << view_token
               << ", service_name=" << service_name
               << ", associate_url=" << data->url;
      DCHECK(data->associate);
      data->associate->ConnectToViewService(view_token.Pass(), service_name,
                                            client_handle.Pass());
      return;
    }
  }

  DVLOG(2) << "Requested view service not available: view_token=" << view_token
           << ", service_name=" << service_name;
  // Allow pipe to be closed as an indication of failure.
}

void ViewAssociateTable::ConnectToViewTreeService(
    mojo::ui::ViewTreeTokenPtr view_tree_token,
    const mojo::String& service_name,
    mojo::ScopedMessagePipeHandle client_handle) {
  if (pending_connection_count_) {
    deferred_work_.push_back(
        base::Bind(&ViewAssociateTable::ConnectToViewTreeService,
                   base::Unretained(this), base::Passed(view_tree_token.Pass()),
                   service_name, base::Passed(client_handle.Pass())));
    return;
  }

  for (auto& data : associates_) {
    DCHECK(data->info);
    if (Contains(data->info->view_tree_service_names, service_name)) {
      DVLOG(2) << "Connecting to view tree service: view_tree_token="
               << view_tree_token << ", service_name=" << service_name
               << ", associate_url=" << data->url;
      DCHECK(data->associate);
      data->associate->ConnectToViewTreeService(
          view_tree_token.Pass(), service_name, client_handle.Pass());
      return;
    }
  }

  DVLOG(2) << "Requested view tree service not available: view_tree_token="
           << view_tree_token << ", service_name=" << service_name;
  // Allow pipe to be closed as an indication of failure.
}

void ViewAssociateTable::OnConnected(uint32_t index,
                                     mojo::ui::ViewAssociateInfoPtr info) {
  DCHECK(info);
  DCHECK(pending_connection_count_);
  DCHECK(!associates_[index]->info);

  DVLOG(1) << "Connected to view associate: url=" << associates_[index]->url
           << ", info=" << info;
  associates_[index]->info = info.Pass();

  pending_connection_count_--;
  if (!pending_connection_count_)
    CompleteDeferredWork();
}

void ViewAssociateTable::CompleteDeferredWork() {
  DCHECK(!pending_connection_count_);

  for (auto& work : deferred_work_)
    work.Run();
  deferred_work_.clear();
}

ViewAssociateTable::AssociateData::AssociateData(
    const std::string& url,
    mojo::ui::ViewInspector* inspector)
    : url(url), inspector_binding(inspector) {}

ViewAssociateTable::AssociateData::~AssociateData() {}

}  // namespace view_manager
