// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_AUDIO_PLATFORM_GENERIC_MIXERS_MIXER_UTILS_H_
#define SERVICES_MEDIA_AUDIO_PLATFORM_GENERIC_MIXERS_MIXER_UTILS_H_

#include <limits>
#include <type_traits>

namespace mojo {
namespace media {
namespace audio {
namespace mixers {
namespace utils {

// mixer_utils.h is a collection of inline templated utility functions meant to
// be used by mixer implementations and expanded/optimized at compile time in
// order to produce efficient inner mixing loops for all of the different
// variations of source/destination sample type/channel counts.

// Template to read samples and normalize them into signed 32 bit integers.
template <typename SType, typename Enable = void> class SampleNormalizer;

template <typename SType>
class SampleNormalizer<
      SType,
      typename std::enable_if<
        std::is_same<SType, uint8_t>::value,
      void>::type> {
 public:
  static inline int32_t Read(const SType* src) {
    register SType tmp = *src;
    return (static_cast<int32_t>(tmp) << 8) - 0x8000;
  }
};

template <typename SType>
class SampleNormalizer<
      SType,
      typename std::enable_if<
        std::is_same<SType, int16_t>::value,
      void>::type> {
 public:
  static inline int32_t Read(const SType* src) {
    return static_cast<int32_t>(*src);
  }
};

// Template to read normalized source samples, and combine channels if required.
template <typename SType,
          size_t   SChCount,
          size_t   DChCount,
          typename Enable = void>
class SrcReader;

template <typename SType,
          size_t   SChCount,
          size_t   DChCount>
class SrcReader<SType, SChCount, DChCount,
      typename std::enable_if<
        (SChCount == DChCount) ||
        ((SChCount == 1) && (DChCount == 2)),
      void>::type> {
 public:
  static constexpr size_t DstPerSrc = DChCount / SChCount;
  static inline int32_t Read(const SType* src) {
    return SampleNormalizer<SType>::Read(src);
  }
};

template <typename SType,
          size_t   SChCount,
          size_t   DChCount>
class SrcReader<SType, SChCount, DChCount,
      typename std::enable_if<
        (SChCount == 2) && (DChCount == 1),
      void>::type> {
 public:
  static constexpr size_t DstPerSrc = 1;
  static inline int32_t Read(const SType* src) {
    return (SampleNormalizer<SType>::Read(src + 0) +
            SampleNormalizer<SType>::Read(src + 1)) >> 1;
  }
};

// Template to produce destination samples from normalized samples.
template <typename DType, typename Enable = void> class DstConverter;

template <typename DType>
class DstConverter<DType,
      typename std::enable_if<
        std::is_same<DType, int16_t>::value,
      void>::type> {
 public:
  static inline DType Convert(int32_t sample) {
    return static_cast<DType>(sample);
  }
};

template <typename DType>
class DstConverter<DType,
      typename std::enable_if<
        std::is_same<DType, uint8_t>::value,
      void>::type> {
 public:
  static inline DType Convert(int32_t sample) {
    return static_cast<DType>((sample >> 8) + 0x80);
  }
};

// Template to mix destination samples with normalized source samples based on
// accumulation policy.
template <typename DType,
          bool     DoAccumulate,
          typename Enable = void>
class DstMixer;

template <typename DType,
          bool     DoAccumulate>
class DstMixer<DType, DoAccumulate,
      typename std::enable_if<
        DoAccumulate == false,
      void>::type> {
 public:
  static inline int32_t Mix(const DType* dst, uint32_t sample) {
    return DstConverter<DType>::Convert(sample);
  }
};

template <typename DType,
          bool     DoAccumulate>
class DstMixer<DType, DoAccumulate,
      typename std::enable_if<
        DoAccumulate == true,
      void>::type> {
 public:
  static inline int32_t Mix(const DType* dst, int32_t sample) {
    sample += SampleNormalizer<DType>::Read(dst);

    if (sample > std::numeric_limits<int16_t>::max()) {
      return DstConverter<DType>::Convert(std::numeric_limits<int16_t>::max());
    } else if (sample < std::numeric_limits<int16_t>::min()) {
      return DstConverter<DType>::Convert(std::numeric_limits<int16_t>::min());
    } else {
      return DstConverter<DType>::Convert(sample);
    }
  }
};


}  // namespace utils
}  // namespace mixers
}  // namespace audio
}  // namespace media
}  // namespace mojo

#endif  // SERVICES_MEDIA_AUDIO_PLATFORM_GENERIC_MIXERS_MIXER_UTILS_H_
