// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <stdio.h>
#include <string.h>
#include <unistd.h>

#include <utility>

#include "base/files/scoped_file.h"
#include "base/message_loop/message_loop.h"
#include "base/test/test_timeouts.h"
#include "mojo/public/c/environment/logger.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/public/cpp/application/application_test_base.h"
#include "mojo/public/cpp/system/functions.h"
#include "mojo/services/log/interfaces/entry.mojom.h"
#include "mojo/services/log/interfaces/log.mojom.h"
#include "services/log/log_impl.h"
#include "testing/gtest/include/gtest/gtest.h"

namespace mojo {
namespace log {
namespace {

using base::MessageLoop;
using LogImplTest = mojo::test::ApplicationTestBase;

// We need to supply a ApplicationConnection to LogImpl::Create().
class TestApplicationConnection : public ApplicationConnection {
 public:
  const std::string& GetConnectionURL() override {
    static std::string kConnectionURL = "mojo:log";
    return kConnectionURL;
  }

  const std::string& GetRemoteApplicationURL() override {
    static std::string kRemoteApplicationURL = "mojo:log_impl_unittest";
    return kRemoteApplicationURL;
  }

  ServiceProvider* GetServiceProvider() override { return nullptr; }
  void SetServiceConnectorForName(ServiceConnector* service_connector,
                                  const std::string& name) override {}
};

// Tests the Log service implementation by calling its AddEntry and verifying
// the log message it prints to the supplied FILE stream.
TEST_F(LogImplTest, AddEntryOutput) {
  // LogImpl will write to p[1] (which we wrap into a FILE*), we will EXPECT
  // what's written by reading in p[0].
  int p[2];
  ASSERT_EQ(0, pipe(p));

  base::ScopedFILE output_file(fdopen(p[1], "w"));
  ASSERT_NE(nullptr, output_file.get());

  LogPtr log;
  TestApplicationConnection app_connection;
  LogImpl::Create(&app_connection, GetProxy(&log), output_file.get());

  Entry entry;
  entry.log_level = MOJO_LOG_LEVEL_INFO;
  entry.timestamp = GetTimeTicksNow();
  entry.source_file = "file.ext";
  entry.source_line = 0;
  entry.message = "1234567890";
  log->AddEntry(entry.Clone());

  entry.source_line = 1;
  log->AddEntry(entry.Clone());

  entry.source_file.reset();
  log->AddEntry(entry.Clone());

  entry.message.reset();
  log->AddEntry(entry.Clone());

  log.reset();

  MessageLoop::current()->PostDelayedTask(FROM_HERE,
                                          MessageLoop::QuitWhenIdleClosure(),
                                          TestTimeouts::tiny_timeout());

  MessageLoop::current()->Run();
  output_file.reset();  // This closes p[1].

  const char expected_string[] =
      "<mojo:log_impl_unittest> [INFO] file.ext: 1234567890\n"
      "<mojo:log_impl_unittest> [INFO] file.ext:1: 1234567890\n"
      "<mojo:log_impl_unittest> [INFO] 1234567890\n"
      "<mojo:log_impl_unittest> [INFO] <no message>\n";
  char actual_string[1024 * 10];
  ssize_t nbytes = read(p[0], actual_string, strlen(expected_string));
  ASSERT_EQ(static_cast<ssize_t>(strlen(expected_string)), nbytes);

  close(p[0]);

  actual_string[nbytes] = '\0';
  EXPECT_STREQ(expected_string, actual_string);
}

}  // namespace
}  // namespace log
}  // namespace mojo
