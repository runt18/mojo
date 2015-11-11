// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/logging.h"
#include "services/media/audio/platform/generic/mixer.h"
#include "services/media/audio/platform/generic/mixers/no_op.h"
#include "services/media/audio/platform/generic/mixers/point_sampler.h"

namespace mojo {
namespace media {
namespace audio {

Mixer::Mixer() {}
Mixer::~Mixer() {}

MixerPtr Mixer::Select(const LpcmMediaTypeDetailsPtr& src_format,
                       const LpcmMediaTypeDetailsPtr& dst_format) {
  // We should always have a source format.
  DCHECK(src_format);

  // If we don't have a destination format, just stick with no-op.  This is
  // probably the ThrottleOutput we are picking a mixer for.
  if (!dst_format) { return MixerPtr(new mixers::NoOp()); }

  return mixers::PointSampler::Select(src_format, dst_format);
}

}  // namespace audio
}  // namespace media
}  // namespace mojo
