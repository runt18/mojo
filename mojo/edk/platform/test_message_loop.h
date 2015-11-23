// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// This file declares a factory function (which must be implemented by the
// embedder) for message loops to be used in tests.

#ifndef MOJO_EDK_PLATFORM_TEST_MESSAGE_LOOP_H_
#define MOJO_EDK_PLATFORM_TEST_MESSAGE_LOOP_H_

#include <memory>

#include "mojo/edk/platform/message_loop.h"

namespace mojo {
namespace platform {
namespace test {

// Creates a basic |platform::MessageLoop|, to be used by tests. This must be
// implemented by the embedder (if building tests that require it).
std::unique_ptr<MessageLoop> CreateTestMessageLoop();

}  // namespace test
}  // namespace platform
}  // namespace mojo

#endif  // MOJO_EDK_PLATFORM_TEST_MESSAGE_LOOP_H_
