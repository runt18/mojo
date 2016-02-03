// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_MEDIA_MODELS_LPCM_TRANSFORM_H_
#define MOJO_MEDIA_MODELS_LPCM_TRANSFORM_H_

#include <memory>

#include "services/media/framework/models/lpcm_frame_buffer.h"
#include "services/media/framework/stream_type.h"

namespace mojo {
namespace media {

// Synchronous lpcm transform.
class LpcmTransform {
 public:
  virtual ~LpcmTransform() {}

  // Gets the input stream type.
  virtual const LpcmStreamType& input_stream_type() const = 0;

  // Gets the output stream type.
  virtual const LpcmStreamType& output_stream_type() const = 0;

  // Processes frames.
  virtual void TransformFrames(
      LpcmFrameBuffer* source,
      LpcmFrameBuffer* dest,
      bool mix) = 0;
};

typedef std::shared_ptr<LpcmTransform> LpcmTransformPtr;

}  // namespace media
}  // namespace mojo

#endif // MOJO_MEDIA_MODELS_LPCM_TRANSFORM_H_
