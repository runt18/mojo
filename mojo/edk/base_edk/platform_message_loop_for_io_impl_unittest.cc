// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/edk/base_edk/platform_message_loop_for_io_impl.h"

#include <unistd.h>

#include <memory>

#include "base/message_loop/message_loop.h"
#include "base/posix/eintr_wrapper.h"
#include "mojo/edk/base_edk/message_loop_test_helper.h"
#include "mojo/edk/platform/platform_handle.h"
#include "mojo/edk/platform/platform_handle_watcher.h"
#include "mojo/edk/platform/scoped_platform_handle.h"
#include "testing/gtest/include/gtest/gtest.h"

using mojo::platform::MessageLoop;
using mojo::platform::PlatformHandle;
using mojo::platform::PlatformHandleWatcher;
using mojo::platform::ScopedPlatformHandle;

namespace base_edk {
namespace {

TEST(PlatformMessageLoopForIOImplTest, Basic) {
  PlatformMessageLoopForIOImpl message_loop_for_io;
  EXPECT_EQ(base::MessageLoop::TYPE_IO,
            message_loop_for_io.base_message_loop_for_io().type());
  test::MessageLoopTestHelper(&message_loop_for_io);
}

TEST(PlatformMessageLoopForIOImplTest, Watch) {
  const char kHello[] = "hello";

  PlatformMessageLoopForIOImpl message_loop_for_io;

  // TODO(vtl): This is an extremely cursory test. We should test more carefully
  // (e.g., we should test that the watch callbacks aren't called spuriously,
  // that the "persist" flag works correctly, and that cancellation works).
  int pipe_fds[2] = {};
  ASSERT_EQ(pipe(pipe_fds), 0);
  // The read end.
  ScopedPlatformHandle h0((PlatformHandle(pipe_fds[0])));
  ASSERT_TRUE(h0.is_valid());
  // The write end.
  ScopedPlatformHandle h1((PlatformHandle(pipe_fds[1])));
  ASSERT_TRUE(h1.is_valid());

  // Watch for read on |h1|; it should never trigger.
  std::unique_ptr<PlatformHandleWatcher::WatchToken> watch1 =
      message_loop_for_io.Watch(
          h1.get(), false, []() { EXPECT_TRUE(false); },
          [&h1, &kHello]() {
            EXPECT_EQ(static_cast<ssize_t>(sizeof(kHello)),
                      HANDLE_EINTR(write(h1.get().fd, kHello, sizeof(kHello))));
          });
  unsigned h0_read_count = 0u;
  std::unique_ptr<PlatformHandleWatcher::WatchToken> watch0 =
      message_loop_for_io.Watch(
          h0.get(),
          true, [&h0_read_count, &h0, &kHello, &message_loop_for_io]() {
            char buf[100] = {};
            h0_read_count++;
            EXPECT_EQ(static_cast<ssize_t>(sizeof(kHello)),
                      HANDLE_EINTR(read(h0.get().fd, buf, sizeof(buf))));
            EXPECT_STREQ(kHello, buf);
            message_loop_for_io.QuitWhenIdle();
          }, nullptr);
  message_loop_for_io.Run();
  EXPECT_EQ(1u, h0_read_count);
}

}  // namespace
}  // namespace base_edk
