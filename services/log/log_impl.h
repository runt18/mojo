// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_LOG_LOG_IMPL_H_
#define SERVICES_LOG_LOG_IMPL_H_

#include <stdio.h>

#include <string>

#include "base/macros.h"
#include "mojo/public/cpp/bindings/interface_request.h"
#include "mojo/public/cpp/bindings/strong_binding.h"
#include "mojo/services/log/interfaces/entry.mojom.h"
#include "mojo/services/log/interfaces/log.mojom.h"

namespace mojo {

class ApplicationConnection;

namespace log {

// This is an implementation of the log service
// (see mojo/services/log/interfaces/log.mojom).  It formats incoming messages
// and writes them to the supplied FILE stream.  It does not take ownership of
// the FILE stream.
//
// This service implementation binds a new Log implementation for each incoming
// application connection.
class LogImpl : public Log {
 public:
  // LogImpl does not take ownership of |out_file|, so |out_file| must live for
  // the duration of the incoming connection (which is left undefined).
  static void Create(ApplicationConnection* connection,
                     InterfaceRequest<Log> request,
                     FILE* out_file);

  // |Log| implementation:
  void AddEntry(EntryPtr entry) override;

 private:
  LogImpl(const std::string& remote_url,
          InterfaceRequest<Log> request,
          FILE* out_file);
  ~LogImpl() override;

  std::string FormatEntry(const EntryPtr& entry);

  const std::string remote_url_;
  StrongBinding<Log> binding_;
  FILE* out_file_;

  DISALLOW_COPY_AND_ASSIGN(LogImpl);
};

}  // namespace log
}  // namespace mojo

#endif  // SERVICES_LOG_LOG_IMPL_H_
