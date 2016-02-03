// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/logging.h"
#include "services/media/framework/parts/file_reader.h"
#include "services/media/framework/parts/reader.h"
#include "url/gurl.h"

namespace mojo {
namespace media {

Result Reader::Create(const GURL& gurl, ReaderPtr* reader_out) {
  if (!gurl.is_valid()) {
    return Result::kInvalidArgument;
  }

  ReaderPtr reader = nullptr;
  if (gurl.SchemeIsFile()) {
    reader = FileReader::Create();
  }
  // TODO(dalesat): More schemes.

  if (reader == nullptr) {
    return Result::kUnsupportedOperation;
  }

  Result result = reader->Init(gurl);
  if (result == Result::kOk) {
    *reader_out = reader;
  }

  return result;
}

} // namespace media
} // namespace mojo
