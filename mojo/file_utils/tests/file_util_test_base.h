// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_FILE_UTILS_TESTS_FILE_UTIL_TEST_BASE_H_
#define MOJO_FILE_UTILS_TESTS_FILE_UTIL_TEST_BASE_H_

#include "mojo/public/cpp/application/application_test_base.h"
#include "mojo/public/cpp/system/macros.h"
#include "mojo/services/files/interfaces/files.mojom.h"

namespace file_utils {
namespace test {

class FileUtilTestBase : public mojo::test::ApplicationTestBase {
 public:
  FileUtilTestBase();
  ~FileUtilTestBase() override;

  void SetUp() override;

 protected:
  mojo::files::FilesPtr& files() { return files_; }

 private:
  mojo::files::FilesPtr files_;

  MOJO_DISALLOW_COPY_AND_ASSIGN(FileUtilTestBase);
};

}  // namespace test
}  // namespace file_utils

#endif  // MOJO_FILE_UTILS_TESTS_FILE_UTIL_TEST_BASE_H_
