// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/bind.h"
#include "base/files/file_path.h"
#include "base/path_service.h"
#include "mojo/dart/embedder/dart_controller.h"
#include "mojo/public/c/system/types.h"
#include "mojo/public/cpp/environment/environment.h"
#include "testing/gtest/include/gtest/gtest.h"

namespace mojo {
namespace dart {
namespace {

static void ExceptionCallback(bool* exception,
                              int64_t* closed_handles,
                              Dart_Handle error,
                              int64_t count) {
  EXPECT_TRUE(Dart_IsError(error));
  *exception = true;
  *closed_handles = count;
}

TEST(DartTest, handle_finalizer_test) {
  base::FilePath path;
  PathService::Get(base::DIR_SOURCE_ROOT, &path);
  path = path.AppendASCII("mojo")
             .AppendASCII("dart")
             .AppendASCII("test")
             .AppendASCII("handle_finalizer_test.dart");

  // Setup the package root.
  base::FilePath package_root;
  PathService::Get(base::DIR_EXE, &package_root);
  package_root = package_root.AppendASCII("gen")
                             .AppendASCII("dart-pkg")
                             .AppendASCII("packages");

  char* error = nullptr;
  bool unhandled_exception = false;
  int64_t closed_handles = 0;

  DartControllerConfig config;
  // Run with strict compilation even in Release mode so that ASAN testing gets
  // coverage of Dart asserts, type-checking, etc.
  config.strict_compilation = true;
  config.script_uri = path.AsUTF8Unsafe();
  config.package_root = package_root.AsUTF8Unsafe();
  config.callbacks.exception =
      base::Bind(&ExceptionCallback, &unhandled_exception, &closed_handles);
  config.error = &error;

  const int kNumArgs = 2;
  const char* args[kNumArgs];
  args[0] = "--new-gen-semi-max-size=1";
  args[1] = "--old_gen_growth_rate=1";
  config.SetVmFlags(args, kNumArgs);

  bool success = DartController::RunSingleDartScript(config);
  EXPECT_TRUE(success) << error;
  EXPECT_FALSE(unhandled_exception);
  EXPECT_EQ(0, closed_handles);
}

}  // namespace
}  // namespace dart
}  // namespace mojo
