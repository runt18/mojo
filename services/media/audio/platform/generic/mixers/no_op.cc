// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/logging.h"
#include "services/media/audio/platform/generic/mixers/no_op.h"

namespace mojo {
namespace media {
namespace audio {
namespace mixers {

bool NoOp::Mix(void*       dst,
               uint32_t    dst_frames,
               uint32_t*   dst_offset,
               const void* src,
               uint32_t    frac_src_frames,
               uint32_t*   frac_src_offset,
               uint32_t    frac_step_size,
               bool        accumulate) {
  DCHECK_LT(*dst_offset, dst_frames);
  DCHECK_LT(*frac_src_offset, frac_src_frames);

  uint32_t frames_produced = ((frac_src_frames - *frac_src_offset)
                           + frac_step_size - 1) / frac_step_size;

  if (frames_produced > (dst_frames - *dst_offset)) {
      frames_produced = (dst_frames - *dst_offset);
  }

  *dst_offset      += frames_produced;
  *frac_src_offset += frames_produced * frac_step_size;

  return (*frac_src_offset >= frac_src_frames);
}

}  // namespace mixers
}  // namespace audio
}  // namespace media
}  // namespace mojo
