// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/media/framework/models/lpcm_frame_buffer.h"

namespace mojo {
namespace media {

LpcmFrameBuffer::LpcmFrameBuffer() :
    bytes_per_frame_(0),
    remaining_buffer_(nullptr),
    remaining_frame_count_(0),
    exhausted_callback_(nullptr) {}

LpcmFrameBuffer::~LpcmFrameBuffer() {}

}  // namespace media
}  // namespace mojo
