// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <fcntl.h>
#include <unistd.h>

#include "base/files/file_util.h"
#include "base/logging.h"
#include "mojo/tools/embed/data.h"

namespace nacl {

int DataToTempFileDescriptor(const mojo::embed::Data& data) {
  base::FilePath path;
  CHECK(CreateTemporaryFile(&path)) << "Could not create temp file for data";

  int fd = open(path.value().c_str(), O_RDWR);
  CHECK_GE(fd, 0) << "Could not open temporary file";

  size_t bytes_left_to_write = data.size;
  const char* source = data.data;
  while (bytes_left_to_write > 0) {
    ssize_t bytes = HANDLE_EINTR(write(fd, source, bytes_left_to_write));
    CHECK_GE(bytes, 0) << "Error writing data to temp file";
    bytes_left_to_write -= bytes;
    source += bytes;
  }

  CHECK(!unlink(path.value().c_str())) << "Could not unlink temporary file";
  return fd;
}

}  // namespace nacl
