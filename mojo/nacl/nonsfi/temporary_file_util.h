// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_NACL_NONSFI_TEMPORARY_FILE_UTIL_H_
#define MOJO_NACL_NONSFI_TEMPORARY_FILE_UTIL_H_

#include "mojo/tools/embed/data.h"

namespace nacl {

// Returns a file descriptor to a file descriptor holding all the data inside
// the parameter "data". Unlinks the file behind this file descriptor, which is
// deleted when the file descriptor is closed.
int DataToTempFileDescriptor(const mojo::embed::Data& data);

}  // namespace nacl

#endif  // MOJO_NACL_NONSFI_TEMPORARY_FILE_UTIL_H_
