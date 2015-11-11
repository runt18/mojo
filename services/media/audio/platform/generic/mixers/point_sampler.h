// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_AUDIO_PLATFORM_GENERIC_MIXERS_POINT_SAMPLER_H_
#define SERVICES_MEDIA_AUDIO_PLATFORM_GENERIC_MIXERS_POINT_SAMPLER_H_

#include "mojo/services/media/common/interfaces/media_types.mojom.h"
#include "services/media/audio/platform/generic/mixer.h"

namespace mojo {
namespace media {
namespace audio {
namespace mixers {

class PointSampler : public Mixer {
 public:
  static MixerPtr Select(const LpcmMediaTypeDetailsPtr& src_format,
                         const LpcmMediaTypeDetailsPtr& dst_format);
};

}  // namespace mixers
}  // namespace audio
}  // namespace media
}  // namespace mojo

#endif  // SERVICES_MEDIA_AUDIO_PLATFORM_GENERIC_MIXERS_POINT_SAMPLER_H_
