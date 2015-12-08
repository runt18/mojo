// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/file_utils/tests/file_util_test_base.h"

#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/services/files/interfaces/files.mojom.h"

namespace file_utils {
namespace test {

FileUtilTestBase::FileUtilTestBase() {}

FileUtilTestBase::~FileUtilTestBase() {}

void FileUtilTestBase::SetUp() {
  mojo::test::ApplicationTestBase::SetUp();

  application_impl()->ConnectToService("mojo:files", &files_);
}

}  // namespace test
}  // namespace file_utils
