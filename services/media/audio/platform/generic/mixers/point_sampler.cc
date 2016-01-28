// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <limits>

#include "base/logging.h"
#include "services/media/audio/audio_track_impl.h"
#include "services/media/audio/platform/generic/mixers/mixer_utils.h"
#include "services/media/audio/platform/generic/mixers/point_sampler.h"

namespace mojo {
namespace media {
namespace audio {
namespace mixers {

// Point Sample Mixer implementation.
template <typename DType,
          size_t   DChCount,
          typename SType,
          size_t   SChCount>
class PointSamplerImpl : public PointSampler {
 public:
  PointSamplerImpl() : PointSampler(0, FRAC_ONE - 1) {}

  bool Mix(void*       dst,
           uint32_t    dst_frames,
           uint32_t*   dst_offset,
           const void* src,
           uint32_t    frac_src_frames,
           int32_t*    frac_src_offset,
           uint32_t    frac_step_size,
           bool        accumulate) override;

 private:
  template <bool DoAccumulate>
  static inline bool Mix(void*       dst,
                         uint32_t    dst_frames,
                         uint32_t*   dst_offset,
                         const void* src,
                         uint32_t    frac_src_frames,
                         int32_t*    frac_src_offset,
                         uint32_t    frac_step_size);
};

template <typename DType,
          size_t   DChCount,
          typename SType,
          size_t   SChCount>
template <bool DoAccumulate>
inline bool PointSamplerImpl<DType, DChCount, SType, SChCount>::Mix(
    void*       dst_void,
    uint32_t    dst_frames,
    uint32_t*   dst_offset,
    const void* src_void,
    uint32_t    frac_src_frames,
    int32_t*    frac_src_offset,
    uint32_t    frac_step_size) {
  using SR = utils::SrcReader<SType, SChCount, DChCount>;
  using DM = utils::DstMixer<DType, DoAccumulate>;

  const SType* src  = static_cast<const SType*>(src_void);
  DType*       dst  = static_cast<DType*>(dst_void);
  uint32_t     doff = *dst_offset;
  int32_t      soff = *frac_src_offset;

  DCHECK_LE(frac_src_frames,
            static_cast<uint32_t>(std::numeric_limits<int32_t>::max()));
  DCHECK_LT(soff, static_cast<int32_t>(frac_src_frames));
  DCHECK_GE(soff, 0);

  while ((doff < dst_frames) &&
         (soff < static_cast<int32_t>(frac_src_frames))) {
    uint32_t src_iter;
    DType*   out;

    src_iter = (soff >> AudioTrackImpl::PTS_FRACTIONAL_BITS) * SChCount;
    out = dst + (doff * DChCount);

    for (size_t dst_iter = 0; dst_iter < DChCount; ++dst_iter) {
      int32_t sample = SR::Read(src + src_iter + (dst_iter / SR::DstPerSrc));
      out[dst_iter] = DM::Mix(out + dst_iter, sample);
    }

    doff += 1;
    soff += frac_step_size;
  }

  *dst_offset = doff;
  *frac_src_offset = soff;

  return (soff >= static_cast<int32_t>(frac_src_frames));
}

template <typename DType,
          size_t   DChCount,
          typename SType,
          size_t   SChCount>
bool PointSamplerImpl<DType, DChCount, SType, SChCount>::Mix(
    void*       dst,
    uint32_t    dst_frames,
    uint32_t*   dst_offset,
    const void* src,
    uint32_t    frac_src_frames,
    int32_t*    frac_src_offset,
    uint32_t    frac_step_size,
    bool        accumulate) {
  return accumulate ? Mix<true>(dst, dst_frames, dst_offset,
                                src, frac_src_frames, frac_src_offset,
                                frac_step_size)
                    : Mix<false>(dst, dst_frames, dst_offset,
                                src, frac_src_frames, frac_src_offset,
                                frac_step_size);
}

// Templates used to expand all of the different combinations of the possible
// Point Sampler Mixer configurations.
template <typename DType,
          size_t   DChCount,
          typename SType,
          size_t   SChCount>
static inline MixerPtr SelectPSM(const LpcmMediaTypeDetailsPtr& src_format,
                                 const LpcmMediaTypeDetailsPtr& dst_format) {
  return MixerPtr(new PointSamplerImpl<DType, DChCount, SType, SChCount>());
}

template <typename DType,
          size_t   DChCount,
          typename SType>
static inline MixerPtr SelectPSM(const LpcmMediaTypeDetailsPtr& src_format,
                                 const LpcmMediaTypeDetailsPtr& dst_format) {
  switch (src_format->channels) {
  case 1:
    return SelectPSM<DType, DChCount, SType, 1>(src_format, dst_format);
  case 2:
    return SelectPSM<DType, DChCount, SType, 2>(src_format, dst_format);
  default:
    return nullptr;
  }
}

template <typename DType,
          size_t   DChCount>
static inline MixerPtr SelectPSM(const LpcmMediaTypeDetailsPtr& src_format,
                                 const LpcmMediaTypeDetailsPtr& dst_format) {
  switch (src_format->sample_format) {
  case LpcmSampleFormat::UNSIGNED_8:
    return SelectPSM<DType, DChCount, uint8_t>(src_format, dst_format);
  case LpcmSampleFormat::SIGNED_16:
    return SelectPSM<DType, DChCount, int16_t>(src_format, dst_format);
  default:
    return nullptr;
  }
}

template <typename DType>
static inline MixerPtr SelectPSM(const LpcmMediaTypeDetailsPtr& src_format,
                                 const LpcmMediaTypeDetailsPtr& dst_format) {
  switch (dst_format->channels) {
  case 1:
    return SelectPSM<DType, 1>(src_format, dst_format);
  case 2:
    return SelectPSM<DType, 2>(src_format, dst_format);
  default:
    return nullptr;
  }
}

MixerPtr PointSampler::Select(const LpcmMediaTypeDetailsPtr& src_format,
                              const LpcmMediaTypeDetailsPtr& dst_format) {
  switch (dst_format->sample_format) {
  case LpcmSampleFormat::UNSIGNED_8:
    return SelectPSM<uint8_t>(src_format, dst_format);
  case LpcmSampleFormat::SIGNED_16:
    return SelectPSM<int16_t>(src_format, dst_format);
  default:
    return nullptr;
  }
}

}  // namespace mixers
}  // namespace audio
}  // namespace media
}  // namespace mojo
