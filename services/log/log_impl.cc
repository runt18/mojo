// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/log/log_impl.h"

#include <stdio.h>

#include <utility>

#include "base/logging.h"
#include "base/strings/stringprintf.h"
#include "mojo/public/cpp/application/application_connection.h"
#include "mojo/public/cpp/system/functions.h"
#include "mojo/services/log/interfaces/entry.mojom.h"

namespace mojo {
namespace log {
namespace {

std::string LogLevelToString(int32_t log_level) {
  if (log_level <= kLogLevelVerbose - 3)
    return "VERBOSE4+";
  switch (log_level) {
    case kLogLevelVerbose - 2:
      return "VERBOSE3";
    case kLogLevelVerbose - 1:
      return "VERBOSE2";
    case kLogLevelVerbose:
      return "VERBOSE1";
    case kLogLevelInfo:
      return "INFO";
    case kLogLevelWarning:
      return "WARNING";
    case kLogLevelError:
      return "ERROR";
  }
  return "FATAL";
}

}  // namespace

LogImpl::LogImpl(const std::string& remote_url,
                 InterfaceRequest<Log> request,
                 FILE* out_file)
    : remote_url_(remote_url),
      binding_(this, std::move(request)),
      out_file_(out_file) {}

LogImpl::~LogImpl() {}

// static
void LogImpl::Create(ApplicationConnection* connection,
                     InterfaceRequest<Log> request,
                     FILE* out_file) {
  DCHECK(connection);
  DCHECK(out_file);

  const std::string& remote_url = connection->GetRemoteApplicationURL();
  if (remote_url.empty()) {
    LOG(ERROR) << "No remote URL.";
    return;
  }

  new LogImpl(remote_url, std::move(request), out_file);
}

void LogImpl::AddEntry(EntryPtr entry) {
  DCHECK(entry);

  // In order to keep LogImpl thread-safe (for the future), we should only print
  // one thing here (otherwise, it could interleave with other prints).
  fprintf(out_file_, "%s\n", FormatEntry(entry).c_str());
}

// This should return:
// <REMOTE_URL> [LOG_LEVEL] SOURCE_FILE:SOURCE_LINE MESSAGE
std::string LogImpl::FormatEntry(const EntryPtr& entry) {
  std::string source;
  if (entry->source_file) {
    source += entry->source_file.To<std::string>();
    if (entry->source_line) {
      base::StringAppendF(&source, ":%u", entry->source_line);
    }
    source += ": ";
  }

  return base::StringPrintf(
      "<%s> [%s] %s%s", remote_url_.c_str(),
      LogLevelToString(entry->log_level).c_str(), source.c_str(),
      entry->message ? entry->message.To<std::string>().c_str()
                     : "<no message>");
}

}  // namespace log
}  // namespace mojo
