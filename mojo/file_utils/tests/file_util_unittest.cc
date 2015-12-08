// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <stdint.h>
#include <vector>

#include "mojo/file_utils/file_util.h"
#include "mojo/file_utils/tests/file_util_test_base.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/public/cpp/application/application_test_base.h"
#include "mojo/public/cpp/utility/run_loop.h"
#include "mojo/services/files/interfaces/directory.mojom.h"
#include "mojo/services/files/interfaces/file.mojom.h"
#include "mojo/services/files/interfaces/files.mojom.h"

namespace file_utils {
namespace test {
namespace {

using FileUtilTest = file_utils::test::FileUtilTestBase;

// TODO(smklein): Stuff copied from mojo/services/files/c/lib/template_util.h
typedef char YesType;

struct NoType {
  YesType dummy[2];
};

template <typename T>
struct IsMoveOnlyType {
  template <typename U>
  static YesType Test(const typename U::MoveOnlyTypeForCPP03*);

  template <typename U>
  static NoType Test(...);

  static const bool value =
      sizeof(Test<T>(0)) == sizeof(YesType) && !std::is_const<T>::value;
};

template <typename T>
typename std::enable_if<!IsMoveOnlyType<T>::value, T>::type& Forward(T& t) {
  return t;
}

template <typename T>
typename std::enable_if<IsMoveOnlyType<T>::value, T>::type Forward(T& t) {
  return t.Pass();
}

template <typename T1>
mojo::Callback<void(T1)> Capture(T1* t1) {
  return [t1](T1 got_t1) { *t1 = Forward(got_t1); };
}

template <typename T1, typename T2>
mojo::Callback<void(T1, T2)> Capture(T1* t1, T2* t2) {
  return [t1, t2](T1 got_t1, T2 got_t2) {
    *t1 = Forward(got_t1);
    *t2 = Forward(got_t2);
  };
}
// TODO(smklein): (End of stuff copied from template_util.h)

// Given a FilePtr |file|, write the string |input| and verify
// the output matches the |input|'s size.
void WriteFileHelper(mojo::files::FilePtr* file, const std::string& input) {
  std::vector<uint8_t> bytes_to_write;
  for (size_t i = 0; i < input.size(); i++)
    bytes_to_write.push_back(static_cast<uint8_t>(input[i]));
  mojo::files::Error error = mojo::files::Error::INTERNAL;
  uint32_t num_bytes_written = 0;
  (*file)->Write(mojo::Array<uint8_t>::From(bytes_to_write), 0,
                 mojo::files::Whence::FROM_CURRENT,
                 Capture(&error, &num_bytes_written));
  ASSERT_TRUE(file->WaitForIncomingResponse());
  EXPECT_EQ(mojo::files::Error::OK, error);
  EXPECT_EQ(bytes_to_write.size(), num_bytes_written);
}

// Given a FilePtr |file|, seek to offset |offset| using whence
// FROM_CURRENT. Verifies the post-seek position is |expected_position|.
void SeekFileHelper(mojo::files::FilePtr* file,
                    int64_t offset,
                    int64_t expected_position) {
  int64_t position = -1;
  mojo::files::Error error = mojo::files::Error::INTERNAL;
  (*file)->Seek(offset, mojo::files::Whence::FROM_CURRENT,
                Capture(&error, &position));
  ASSERT_TRUE(file->WaitForIncomingResponse());
  EXPECT_EQ(mojo::files::Error::OK, error);
  EXPECT_EQ(expected_position, position);
}

// Given a FilePtr |file|, read from the file at offset |offset| (using
// Whence::FROM_CURRENT), and verify the result matches the string
// |expected_output|.
void ReadFileHelper(mojo::files::FilePtr* file,
                    int64_t offset,
                    const std::string& expected_output) {
  mojo::Array<uint8_t> bytes_read;
  mojo::files::Error error = mojo::files::Error::INTERNAL;
  uint32_t num_bytes_to_read = expected_output.size();
  (*file)->Read(num_bytes_to_read, offset, mojo::files::Whence::FROM_CURRENT,
                Capture(&error, &bytes_read));
  ASSERT_TRUE(file->WaitForIncomingResponse());
  EXPECT_EQ(mojo::files::Error::OK, error);
  EXPECT_EQ(num_bytes_to_read, bytes_read.size());
  for (size_t i = 0; i < expected_output.size(); i++)
    EXPECT_EQ(static_cast<uint8_t>(expected_output[i]), bytes_read[i]);
}

// Open the file named |path_name| in |directory| and verify that no error
// occurs.  Returns the newly opened file.
mojo::files::FilePtr OpenFileHelper(mojo::files::DirectoryPtr* directory,
                                    const std::string& path_name) {
  mojo::files::FilePtr temp_file;
  mojo::files::Error error = mojo::files::Error::INTERNAL;
  (*directory)
      ->OpenFile(path_name, GetProxy(&temp_file),
                 mojo::files::kOpenFlagWrite | mojo::files::kOpenFlagRead,
                 Capture(&error));
  EXPECT_EQ(true, directory->WaitForIncomingResponse());
  EXPECT_EQ(mojo::files::Error::OK, error);
  return temp_file;
}

// Close the FilePtr |file| and verify that no error occurs.
void CloseFileHelper(mojo::files::FilePtr* file) {
  mojo::files::Error error = mojo::files::Error::INTERNAL;
  (*file)->Close(Capture(&error));
  ASSERT_TRUE(file->WaitForIncomingResponse());
  EXPECT_EQ(mojo::files::Error::OK, error);
}

TEST_F(FileUtilTest, BasicCreateTemporaryFile) {
  mojo::files::Error error = mojo::files::Error::INTERNAL;
  mojo::files::DirectoryPtr directory;
  files()->OpenFileSystem(nullptr, mojo::GetProxy(&directory), Capture(&error));

  ASSERT_TRUE(files().WaitForIncomingResponse());
  EXPECT_EQ(mojo::files::Error::OK, error);

  std::string filename1, filename2, filename3;
  mojo::files::FilePtr file1, file2, file3;
  file1 = CreateTemporaryFileInDir(&directory, &filename1);
  ASSERT_TRUE(file1);
  file2 = CreateTemporaryFileInDir(&directory, &filename2);
  ASSERT_TRUE(file2);
  file3 = CreateTemporaryFileInDir(&directory, &filename3);
  ASSERT_TRUE(file3);

  // The temp filenames should not be equal.
  EXPECT_NE(filename1, filename2);
  EXPECT_NE(filename1, filename3);
  EXPECT_NE(filename2, filename3);

  // Test that 'Write' can be called on the temp files.
  WriteFileHelper(&file1, "abcde");
  WriteFileHelper(&file2, "fghij");
  WriteFileHelper(&file3, "lmnop");

  // Test that 'Seek' can be called on the temp files.
  SeekFileHelper(&file1, -5, 0);
  SeekFileHelper(&file2, -4, 1);
  SeekFileHelper(&file3, -3, 2);

  // Test that 'Read' can be called on the temp files.
  ReadFileHelper(&file1, 0, "abcde");
  ReadFileHelper(&file2, 0, "ghij");
  ReadFileHelper(&file3, 0, "nop");

  // Test that the files can be closed.
  CloseFileHelper(&file1);
  CloseFileHelper(&file2);
  CloseFileHelper(&file3);

  // Test that the files can be reopened after closing.
  file1 = OpenFileHelper(&directory, filename1);
  file2 = OpenFileHelper(&directory, filename2);
  file3 = OpenFileHelper(&directory, filename3);

  // Verify the contents of the reopened files.
  ReadFileHelper(&file1, 0, "abcde");
  ReadFileHelper(&file2, 0, "fghij");
  ReadFileHelper(&file3, 0, "lmnop");

  // Test that the files can be closed once more.
  CloseFileHelper(&file1);
  CloseFileHelper(&file2);
  CloseFileHelper(&file3);
}

}  // namespace
}  // namespace test
}  // namespace file_utils
