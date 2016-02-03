// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_MEDIA_MODELS_LPCM_FRAME_BUFFER_H_
#define MOJO_MEDIA_MODELS_LPCM_FRAME_BUFFER_H_

#include <cstdint>
#include <functional>

#include "base/logging.h"

namespace mojo {
namespace media {

// References an LPCM frame buffer and implements advancement through it.
class LpcmFrameBuffer {
 public:
  using ExhaustedCallback = std::function<void()>;

  LpcmFrameBuffer();

  ~LpcmFrameBuffer();

  void set_bytes_per_frame(uint32_t bytes_per_frame) {
    bytes_per_frame_ = bytes_per_frame;
  }

  uint32_t bytes_per_frame() const {
    return bytes_per_frame_;
  }

  // The remaining frame buffer.
  void* buffer() const {
    return remaining_buffer_;
  }

  // The remaining number of frames accommodated by the frame buffer.
  uint64_t frame_count() const {
    return remaining_frame_count_;
  }

  // Resets the buffer and frame.
  void Reset() {
    remaining_buffer_ = nullptr;
    remaining_frame_count_ = 0;
    exhausted_callback_ = nullptr;
  }

  // Sets the buffer and frame count.
  void Set(
      void* buffer,
      uint64_t frame_count,
      ExhaustedCallback exhausted_callback = nullptr) {
    remaining_buffer_ = buffer;
    remaining_frame_count_ = frame_count;
    exhausted_callback_ = exhausted_callback;
  }

  // Updates buffer and frame_count to reflect use of the buffer.
  void Advance(uint64_t frame_count) {
    DCHECK(remaining_buffer_);
    DCHECK(frame_count <= remaining_frame_count_);
    remaining_buffer_ = reinterpret_cast<uint8_t*>(remaining_buffer_) +
        (frame_count * bytes_per_frame_);
    remaining_frame_count_ -= frame_count;
    if (remaining_frame_count_ == 0 && exhausted_callback_ != nullptr) {
      exhausted_callback_();
      exhausted_callback_ = nullptr;
    }
  }

 private:
  uint32_t bytes_per_frame_;
  void* remaining_buffer_;
  uint64_t remaining_frame_count_;
  ExhaustedCallback exhausted_callback_;
};

}  // namespace media
}  // namespace mojo

#endif // MOJO_MEDIA_MODELS_LPCM_FRAME_BUFFER_H_
