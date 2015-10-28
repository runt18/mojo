// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/edk/test/simple_test_thread.h"

#include "base/logging.h"

namespace mojo {
namespace test {

SimpleTestThread::~SimpleTestThread() {
  DCHECK(!thread_.joinable());
}

void SimpleTestThread::Start() {
  DCHECK(!thread_.joinable());
  thread_ = std::thread([this]() { Run(); });
}

void SimpleTestThread::Join() {
  DCHECK(thread_.joinable());
  thread_.join();
}

SimpleTestThread::SimpleTestThread() {}

}  // namespace test
}  // namespace mojo
