// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_AUDIO_PLATFORM_GENERIC_MIXER_H_
#define SERVICES_MEDIA_AUDIO_PLATFORM_GENERIC_MIXER_H_

#include <memory>

#include "mojo/services/media/common/interfaces/media_types.mojom.h"

namespace mojo {
namespace media {
namespace audio {

class Mixer;
using MixerPtr = std::unique_ptr<Mixer>;

class Mixer {
 public:
  virtual ~Mixer();

  // Select
  //
  // Select an appropriate instance of a mixer based on the properties of the
  // source and destination formats.
  //
  // TODO(johngro): Come back here and add a way to indicate user preference
  // where appropriate.  For example, where we might chose a linear
  // interpolation sampler, the user may actually prefer cubic interpolation, or
  // perhaps just a point sampler.
  static MixerPtr Select(const LpcmMediaTypeDetailsPtr& src_format,
                         const LpcmMediaTypeDetailsPtr& dst_format);

  // Mix
  //
  // Perform a mixing operation from the source buffer into the destination
  // buffer.
  //
  // @param dst
  // The pointer to the destination buffer into which frames will be mixed.
  //
  // @param dst_frames
  // The total number of frames of audio which comprise the destination buffer.
  //
  // @param dst_offset
  // The pointer to the offset (in destination frames) at which we should start
  // to mix destination frames.  When Mix has finished, dst_offset will be
  // updated to indicate the offset into the destination buffer of the next
  // frame to be mixed.
  //
  // @param src
  // The pointer the the source buffer containing the frames to be mixed into
  // the destination buffer.
  //
  // @param frac_src_frames
  // The total number of fractional track frames contained by the source buffer.
  //
  // @param frac_src_offset
  // A pointer to the offset (expressed in fractional track frames) at which the
  // first frame to be mixed with the destination buffer should be sampled.
  // When Mix has finished, frac_src_offset will be updated to indicate the
  // offset of the sampling position of the next frame to be mixed with the
  // output buffer.
  //
  // @param frac_step_size
  // How much to increment the fractional sampling position for each output
  // frame produced.
  //
  // TODO(johngro): Right now, this number may have some amount of rounding
  // error which will accumulate as sampling position error as we produce more
  // output samples for a single call to Mix.  This error will reset when we
  // swtich to the next source buffer, but could (in theory) be the source of
  // distortion.  If this becomes a problem, we should consider switching to
  // some form of (N,M) stepping system where we count by frac_step_size for N
  // output samples, then frac_step_size+1 for M samples, etc...
  //
  // @param accumulate
  // When true, the mixer will accumulate into the destination buffer (read,
  // sum, clip, write-back).  When false, the mixer will simply replace the
  // destination buffer with its output.
  //
  // @return True if the mixer is finished with this source data and will not
  // need it in the future.  False if the mixer has not consumed the entire
  // source buffer and will need more of it in the future.
  virtual bool Mix(void*       dst,
                   uint32_t    dst_frames,
                   uint32_t*   dst_offset,
                   const void* src,
                   uint32_t    frac_src_frames,
                   uint32_t*   frac_src_offset,
                   uint32_t    frac_step_size,
                   bool        accumulate) = 0;

  // Reset
  //
  // Reset the internal state of the mixer.  Will be called every time there is
  // a discontinuity in the source stream.  Mixer implementations should reset
  // anything related to their internal filter state.
  virtual void Reset() {}

 protected:
  Mixer();
};

}  // namespace audio
}  // namespace media
}  // namespace mojo

#endif  // SERVICES_MEDIA_AUDIO_PLATFORM_GENERIC_MIXER_H_
