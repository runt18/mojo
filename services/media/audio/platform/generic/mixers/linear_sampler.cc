// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <limits>

#include "base/logging.h"
#include "services/media/audio/platform/generic/mixers/linear_sampler.h"
#include "services/media/audio/platform/generic/mixers/mixer_utils.h"

namespace mojo {
namespace media {
namespace audio {
namespace mixers {

template <size_t   DChCount,
          typename SType,
          size_t   SChCount>
class LinearSamplerImpl : public LinearSampler {
 public:
  LinearSamplerImpl()
    : LinearSampler(FRAC_ONE - 1, FRAC_ONE - 1) {
    Reset();
  }

  bool Mix(int32_t*    dst,
           uint32_t    dst_frames,
           uint32_t*   dst_offset,
           const void* src,
           uint32_t    frac_src_frames,
           int32_t*    frac_src_offset,
           uint32_t    frac_step_size,
           bool        accumulate) override;

  void Reset() override {
    ::memset(filter_data_, 0, sizeof(filter_data_));
  }

 private:
  template <bool DoAccumulate>
  inline bool Mix(int32_t*    dst,
                  uint32_t    dst_frames,
                  uint32_t*   dst_offset,
                  const void* src,
                  uint32_t    frac_src_frames,
                  int32_t*    frac_src_offset,
                  uint32_t    frac_step_size);

  static inline int32_t Interpolate(int32_t A, int32_t B, uint32_t alpha) {
    return ((A * static_cast<int32_t>(FRAC_ONE - alpha))
          + (B * static_cast<int32_t>(alpha)))
         >> AudioTrackImpl::PTS_FRACTIONAL_BITS;
  }

  int32_t filter_data_[2 * DChCount];
};

template <size_t   DChCount,
          typename SType,
          size_t   SChCount>
template <bool DoAccumulate>
inline bool LinearSamplerImpl<DChCount, SType, SChCount>::Mix(
    int32_t*    dst,
    uint32_t    dst_frames,
    uint32_t*   dst_offset,
    const void* src_void,
    uint32_t    frac_src_frames,
    int32_t*    frac_src_offset,
    uint32_t    frac_step_size) {
  using SR = utils::SrcReader<SType, SChCount, DChCount>;
  using DM = utils::DstMixer<DoAccumulate>;
  const SType* src  = static_cast<const SType*>(src_void);
  uint32_t     doff = *dst_offset;
  int32_t      soff = *frac_src_offset;

  DCHECK_LT(doff, dst_frames);
  DCHECK_GE(frac_src_frames, FRAC_ONE);
  DCHECK_LE(frac_src_frames,
            static_cast<uint32_t>(std::numeric_limits<int32_t>::max()));

  if (soff < 0) {
    DCHECK_LT(static_cast<uint32_t>(-soff), FRAC_ONE);

    for (size_t D = 0; D < DChCount; ++D) {
      filter_data_[DChCount + D] = SR::Read(src + (D / SR::DstPerSrc));
    }

    do {
      int32_t* out = dst + (doff * DChCount);

      for (size_t D = 0; D < DChCount; ++D) {
        int32_t sample = Interpolate(filter_data_[DChCount + D],
                                     filter_data_[D],
                                     -soff);
        out[D] = DM::Mix(out[D], sample);
      }

      doff += 1;
      soff += frac_step_size;
    } while ((doff < dst_frames) && (soff < 0));
  }

  int32_t source_end = static_cast<int32_t>(frac_src_frames - FRAC_ONE);
  while ((doff < dst_frames) && (soff < source_end)) {
    uint32_t S = (soff >> AudioTrackImpl::PTS_FRACTIONAL_BITS) * SChCount;
    int32_t* out = dst + (doff * DChCount);

    for (size_t D = 0; D < DChCount; ++D) {
      int32_t s1 = SR::Read(src + S + (D / SR::DstPerSrc));
      int32_t s2 = SR::Read(src + S + (D / SR::DstPerSrc) + SChCount);
      int32_t sample = Interpolate(s1, s2, soff & FRAC_MASK);
      out[D] = DM::Mix(out[D], sample);
    }

    doff += 1;
    soff += frac_step_size;
  }

  // If we have room to produce one more sample, and our sampling position hits
  // the position input buffer's final frame exactly, go ahead and sample the
  // final frame into the output buffer.
  if ((doff < dst_frames) && (soff == source_end)) {
    uint32_t S = (soff >> AudioTrackImpl::PTS_FRACTIONAL_BITS) * SChCount;
    int32_t* out = dst + (doff * DChCount);

    for (size_t D = 0; D < DChCount; ++D) {
      int32_t sample = SR::Read(src + S + (D / SR::DstPerSrc));
      out[D] = DM::Mix(out[D], sample);
    }

    doff += 1;
    soff += frac_step_size;
  }

  *dst_offset = doff;
  *frac_src_offset = soff;

  if (soff >= source_end) {
    uint32_t S = (source_end >> AudioTrackImpl::PTS_FRACTIONAL_BITS) * SChCount;
    for (size_t D = 0; D < DChCount; ++D) {
      filter_data_[D] = SR::Read(src + S + (D / SR::DstPerSrc));
    }
    return (doff < dst_frames);
  }

  return false;
}

template <size_t   DChCount,
          typename SType,
          size_t   SChCount>
bool LinearSamplerImpl<DChCount, SType, SChCount>::Mix(
    int32_t*    dst,
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
// Linear Sampler Mixer configurations.
template <size_t   DChCount,
          typename SType,
          size_t   SChCount>
static inline MixerPtr SelectLSM(const LpcmMediaTypeDetailsPtr& src_format,
                                 const LpcmMediaTypeDetailsPtr& dst_format) {
  return MixerPtr(new LinearSamplerImpl<DChCount, SType, SChCount>());
}

template <size_t   DChCount,
          typename SType>
static inline MixerPtr SelectLSM(const LpcmMediaTypeDetailsPtr& src_format,
                                 const LpcmMediaTypeDetailsPtr& dst_format) {
  switch (src_format->channels) {
  case 1:
    return SelectLSM<DChCount, SType, 1>(src_format, dst_format);
  case 2:
    return SelectLSM<DChCount, SType, 2>(src_format, dst_format);
  default:
    return nullptr;
  }
}

template <size_t DChCount>
static inline MixerPtr SelectLSM(const LpcmMediaTypeDetailsPtr& src_format,
                                 const LpcmMediaTypeDetailsPtr& dst_format) {
  switch (src_format->sample_format) {
  case LpcmSampleFormat::UNSIGNED_8:
    return SelectLSM<DChCount, uint8_t>(src_format, dst_format);
  case LpcmSampleFormat::SIGNED_16:
    return SelectLSM<DChCount, int16_t>(src_format, dst_format);
  default:
    return nullptr;
  }
}

MixerPtr LinearSampler::Select(const LpcmMediaTypeDetailsPtr& src_format,
                               const LpcmMediaTypeDetailsPtr& dst_format) {
  switch (dst_format->channels) {
  case 1:
    return SelectLSM<1>(src_format, dst_format);
  case 2:
    return SelectLSM<2>(src_format, dst_format);
  default:
    return nullptr;
  }
}

}  // namespace mixers
}  // namespace audio
}  // namespace media
}  // namespace mojo
