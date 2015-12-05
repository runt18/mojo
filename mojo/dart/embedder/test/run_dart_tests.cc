// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/bind.h"
#include "base/files/file_path.h"
#include "base/path_service.h"
#include "base/rand_util.h"
#include "mojo/dart/embedder/dart_controller.h"
#include "mojo/public/c/system/types.h"
#include "mojo/public/cpp/environment/environment.h"
#include "testing/gtest/include/gtest/gtest.h"

namespace mojo {
namespace dart {
namespace {

static bool generateEntropy(uint8_t* buffer, intptr_t length) {
  base::RandBytes(static_cast<void*>(buffer), length);
  return true;
}

static void ExceptionCallback(bool* exception,
                              int64_t* closed_handles,
                              Dart_Handle error,
                              int64_t count) {
  EXPECT_TRUE(Dart_IsError(error));
  *exception = true;
  *closed_handles = count;
}

static void RunTest(const std::string& test,
                    bool compile_all,
                    bool expect_unhandled_exception,
                    int expected_unclosed_handles) {
  base::FilePath path;
  PathService::Get(base::DIR_SOURCE_ROOT, &path);
  path = path.AppendASCII("mojo")
             .AppendASCII("dart")
             .AppendASCII("test")
             .AppendASCII(test);

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
  config.compile_all = compile_all;
  config.script_uri = path.AsUTF8Unsafe();
  config.package_root = package_root.AsUTF8Unsafe();
  config.callbacks.exception =
      base::Bind(&ExceptionCallback, &unhandled_exception, &closed_handles);
  config.entropy = generateEntropy;
  config.error = &error;

  bool success = DartController::RunSingleDartScript(config);
  EXPECT_TRUE(success) << error;
  EXPECT_EQ(expect_unhandled_exception, unhandled_exception);
  EXPECT_EQ(expected_unclosed_handles, closed_handles);
}

// TODO(zra): instead of listing all these tests, search //mojo/dart/test for
// _test.dart files.

TEST(DartTest, async_await_test) {
  RunTest("async_await_test.dart", false, false, 0);
}

TEST(DartTest, async_test) {
  RunTest("async_test.dart", false, false, 0);
}

TEST(DartTest, bindings_generation_test) {
  RunTest("bindings_generation_test.dart", false, false, 0);
}

TEST(DartTest, codec_test) {
  RunTest("codec_test.dart", false, false, 0);
}

TEST(DartTest, compile_all_interfaces_test) {
  RunTest("compile_all_interfaces_test.dart", true, false, 0);
}

TEST(DartTest, control_messages_test) {
  RunTest("control_messages_test.dart", false, false, 0);
}

TEST(DartTest, core_test) {
  RunTest("core_test.dart", false, false, 0);
}

TEST(DartTest, core_types_test) {
  RunTest("core_types_test.dart", false, false, 0);
}

TEST(DartTest, exception_test) {
  RunTest("exception_test.dart", false, false, 0);
}

TEST(DartTest, handle_finalizer_test) {
  RunTest("handle_finalizer_test.dart", false, true, 1);
}

TEST(DartTest, hello_mojo) {
  RunTest("hello_mojo.dart", false, false, 0);
}

TEST(DartTest, isolate_test) {
  RunTest("isolate_test.dart", false, false, 0);
}

TEST(DartTest, import_mojo) {
  RunTest("import_mojo.dart", false, false, 0);
}

TEST(DartTest, ping_pong_test) {
  RunTest("ping_pong_test.dart", false, false, 0);
}

TEST(DartTest, simple_handle_watcher_test) {
  RunTest("simple_handle_watcher_test.dart", false, false, 0);
}

TEST(DartTest, timer_test) {
  RunTest("timer_test.dart", false, false, 0);
}

TEST(DartTest, unhandled_exception_test) {
  RunTest("unhandled_exception_test.dart", false, true, 2);
}

TEST(DartTest, uri_base_test) {
  RunTest("uri_base_test.dart", false, false, 0);
}

}  // namespace
}  // namespace dart
}  // namespace mojo
