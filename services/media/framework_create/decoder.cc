// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/media/framework/parts/decoder.h"

namespace mojo {
namespace media {

Result Decoder::Create(
    const StreamTypePtr& stream_type,
    DecoderPtr* decoder_out) {
  return Result::kUnsupportedOperation;
}

} // namespace media
} // namespace mojo
