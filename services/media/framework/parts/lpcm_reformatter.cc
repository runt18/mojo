// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/logging.h"
#include "services/media/framework/parts/lpcm_reformatter.h"

namespace mojo {
namespace media {

// LpcmReformatter implementation that accepts samples of type TIn and
// produces samples of type TOut.
template<typename TIn, typename TOut>
class LpcmReformatterImpl : public LpcmReformatter {
 public:
  LpcmReformatterImpl(
      const LpcmStreamType& in_type,
      const LpcmStreamTypeSet& out_type);

  ~LpcmReformatterImpl() override;

  // LpcmTransform implementation.
  const LpcmStreamType& input_stream_type() const override;

  const LpcmStreamType& output_stream_type() const override;

  void TransformFrames(
      LpcmFrameBuffer* source,
      LpcmFrameBuffer* dest,
      bool mix) override;

 private:
  LpcmStreamType in_type_;
  LpcmStreamType out_type_;
};

LpcmReformatterPtr LpcmReformatter::Create(
    const LpcmStreamType& in_type,
    const LpcmStreamTypeSet& out_type) {
  LpcmReformatter* result = nullptr;

  switch (in_type.sample_format()) {
    case LpcmStreamType::SampleFormat::kUnsigned8:
      switch (out_type.sample_format()) {
        case LpcmStreamType::SampleFormat::kUnsigned8:
        case LpcmStreamType::SampleFormat::kAny:
          result = new LpcmReformatterImpl<uint8_t, uint8_t>(
              in_type, out_type);
          break;
        case LpcmStreamType::SampleFormat::kSigned16:
          result = new LpcmReformatterImpl<uint8_t, int16_t>(
              in_type, out_type);
          break;
        case LpcmStreamType::SampleFormat::kSigned24In32:
          result = new LpcmReformatterImpl<uint8_t, int32_t>(
              in_type, out_type);
          break;
        case LpcmStreamType::SampleFormat::kFloat:
          result = new LpcmReformatterImpl<uint8_t, float>(
              in_type, out_type);
          break;
        default:
          NOTREACHED() << "unsupported sample format";
          result = nullptr;
          break;
      }
      break;
    case LpcmStreamType::SampleFormat::kSigned16:
      switch (out_type.sample_format()) {
        case LpcmStreamType::SampleFormat::kUnsigned8:
          result = new LpcmReformatterImpl<int16_t, uint8_t>(
              in_type, out_type);
          break;
        case LpcmStreamType::SampleFormat::kSigned16:
        case LpcmStreamType::SampleFormat::kAny:
          result = new LpcmReformatterImpl<int16_t, int16_t>(
              in_type, out_type);
          break;
        case LpcmStreamType::SampleFormat::kSigned24In32:
          result = new LpcmReformatterImpl<int16_t, int32_t>(
              in_type, out_type);
          break;
        case LpcmStreamType::SampleFormat::kFloat:
          result = new LpcmReformatterImpl<int16_t, float>(
              in_type, out_type);
          break;
        default:
          NOTREACHED() << "unsupported sample format";
          result = nullptr;
          break;
      }
      break;
    case LpcmStreamType::SampleFormat::kSigned24In32:
      switch (out_type.sample_format()) {
        case LpcmStreamType::SampleFormat::kUnsigned8:
          result = new LpcmReformatterImpl<int32_t, uint8_t>(
              in_type, out_type);
          break;
        case LpcmStreamType::SampleFormat::kSigned16:
          result = new LpcmReformatterImpl<int32_t, int16_t>(
              in_type, out_type);
          break;
        case LpcmStreamType::SampleFormat::kSigned24In32:
        case LpcmStreamType::SampleFormat::kAny:
          result = new LpcmReformatterImpl<int32_t, int32_t>(
              in_type, out_type);
          break;
        case LpcmStreamType::SampleFormat::kFloat:
          result = new LpcmReformatterImpl<int32_t, float>(
              in_type, out_type);
          break;
        default:
          NOTREACHED() << "unsupported sample format";
          result = nullptr;
          break;
      }
      break;
    case LpcmStreamType::SampleFormat::kFloat:
      switch (out_type.sample_format()) {
        case LpcmStreamType::SampleFormat::kUnsigned8:
          result = new LpcmReformatterImpl<float, uint8_t>(
              in_type, out_type);
          break;
        case LpcmStreamType::SampleFormat::kSigned16:
          result = new LpcmReformatterImpl<float, int16_t>(
              in_type, out_type);
          break;
        case LpcmStreamType::SampleFormat::kSigned24In32:
          result = new LpcmReformatterImpl<float, int32_t>(
              in_type, out_type);
          break;
        case LpcmStreamType::SampleFormat::kFloat:
        case LpcmStreamType::SampleFormat::kAny:
          result = new LpcmReformatterImpl<float, float>(in_type, out_type);
          break;
        default:
          NOTREACHED() << "unsupported sample format";
          result = nullptr;
          break;
      }
      break;
    default:
      NOTREACHED() << "unsupported sample format";
      result = nullptr;
      break;
  }

  return LpcmReformatterPtr(result);
}

template<typename TIn, typename TOut>
LpcmReformatterImpl<TIn, TOut>::LpcmReformatterImpl(
    const LpcmStreamType& in_type,
    const LpcmStreamTypeSet& out_type) :
    in_type_(in_type),
    out_type_(
        out_type.sample_format() == LpcmStreamType::SampleFormat::kAny ?
            in_type.sample_format() :
            out_type.sample_format(),
        in_type.channels(),
        in_type.frames_per_second()) {}

template<typename TIn, typename TOut>
LpcmReformatterImpl<TIn, TOut>::~LpcmReformatterImpl() {}

namespace {

template <typename T>
inline constexpr T Clamp(T val, T min, T max) {
  return (val > max) ? max : ((val < min) ? min : val);
}

template <typename T>
inline constexpr T Clamp(T val);

template <>
inline constexpr float Clamp(float val) {
  return Clamp(val, -1.0f, 1.0f);
}

template <>
inline constexpr int32_t Clamp(int32_t val) {
  return Clamp(val, 1 << 23, -(1 << 23));
}

template<typename TIn, typename TOut>
inline void CopySample(TOut* dest, TIn* source) {
  *dest = static_cast<TOut>(*source);
}

inline void CopySample(uint8_t* dest, int16_t* source) {
  *dest = static_cast<uint8_t>((*source >> 8) ^ 0x80);
}

inline void CopySample(uint8_t* dest, int32_t* source) {
  *dest = static_cast<uint8_t>((Clamp(*source) >> 16) ^ 0x80);
}

inline void CopySample(uint8_t* dest, float* source) {
  *dest = static_cast<uint8_t>((Clamp(*source) * 0x7f) + 128);
}

inline void CopySample(int16_t* dest, uint8_t* source) {
  *dest = static_cast<int16_t>(*source ^ 0x80) << 8;
}

inline void CopySample(int16_t* dest, int32_t* source) {
  *dest = static_cast<int16_t>(Clamp(*source) >> 8);
}

inline void CopySample(int16_t* dest, float* source) {
  *dest = static_cast<int16_t>(Clamp(*source) * 0x7fff);
}

inline void CopySample(int32_t* dest, uint8_t* source) {
  *dest = static_cast<int32_t>(*source ^ 0x80) << 16;
}

inline void CopySample(int32_t* dest, int16_t* source) {
  *dest = static_cast<int32_t>(*source << 8);
}

inline void CopySample(int32_t* dest, float* source) {
  *dest = static_cast<int32_t>(Clamp(*source) * 0x7fffff);
}

inline void CopySample(float* dest, uint8_t* source) {
  *dest = static_cast<float>(*source ^ 0x80) / 0x80;
}

inline void CopySample(float* dest, int16_t* source) {
  *dest = static_cast<float>(*source) / 0x8000;
}

inline void CopySample(float* dest, int32_t* source) {
  *dest = static_cast<float>(Clamp(*source)) / 0x800000;
}

template<typename TIn, typename TOut>
inline void MixSample(TOut* dest, TIn* source) {
  *dest += static_cast<TOut>(*source);
}

inline void MixSample(uint8_t* dest, int16_t* source) {
  *dest += static_cast<uint8_t>((*source >> 8) ^ 0x80);
}

inline void MixSample(uint8_t* dest, int32_t* source) {
  *dest += static_cast<uint8_t>((Clamp(*source) >> 16) ^ 0x80);
}

inline void MixSample(uint8_t* dest, float* source) {
  *dest += static_cast<uint8_t>((Clamp(*source) * 0x7f) + 128);
}

inline void MixSample(int16_t* dest, uint8_t* source) {
  *dest += static_cast<int16_t>(*source ^ 0x80) << 8;
}

inline void MixSample(int16_t* dest, int32_t* source) {
  *dest += static_cast<int16_t>(Clamp(*source) >> 8);
}

inline void MixSample(int16_t* dest, float* source) {
  *dest += static_cast<int16_t>(Clamp(*source) * 0x7fff);
}

inline void MixSample(int32_t* dest, uint8_t* source) {
  *dest += static_cast<int32_t>(*source ^ 0x80) << 16;
}

inline void MixSample(int32_t* dest, int16_t* source) {
  *dest += static_cast<int32_t>(*source << 8);
}

inline void MixSample(int32_t* dest, float* source) {
  *dest += static_cast<int32_t>(Clamp(*source) * 0x7fffff);
}

inline void MixSample(float* dest, uint8_t* source) {
  *dest += static_cast<float>(*source ^ 0x80) / 0x80;
}

inline void MixSample(float* dest, int16_t* source) {
  *dest += static_cast<float>(*source) / 0x8000;
}

inline void MixSample(float* dest, int32_t* source) {
  *dest += static_cast<float>(Clamp(*source)) / 0x800000;
}

} // namespace

template<typename TIn, typename TOut>
const LpcmStreamType& LpcmReformatterImpl<TIn, TOut>::input_stream_type()
    const {
  return in_type_;
}

template<typename TIn, typename TOut>
const LpcmStreamType& LpcmReformatterImpl<TIn, TOut>::output_stream_type()
    const {
  return out_type_;
}

template<typename TIn, typename TOut>
void LpcmReformatterImpl<TIn, TOut>::TransformFrames(
    LpcmFrameBuffer* source,
    LpcmFrameBuffer* dest,
    bool mix) {
  DCHECK(source);
  DCHECK(dest);
  DCHECK(source->buffer());
  DCHECK(source->frame_count());
  DCHECK(dest->buffer());
  DCHECK(dest->frame_count());

  uint64_t frame_count = std::min(source->frame_count(), dest->frame_count());

  uint8_t* in_channel = static_cast<uint8_t*>(source->buffer());
  uint8_t* out_channel = static_cast<uint8_t*>(dest->buffer());

  for (uint32_t channel = 0; channel < in_type_.channels(); channel++) {
    TIn* in_sample = reinterpret_cast<TIn*>(in_channel);
    TOut* out_sample = reinterpret_cast<TOut*>(out_channel);
    if (mix) {
      for (uint64_t sample = 0; sample < frame_count; sample++) {
        MixSample(out_sample, in_sample);
        in_sample += in_type_.channels();
        out_sample += out_type_.channels();
      }
    } else {
      for (uint64_t sample = 0; sample < frame_count; sample++) {
        CopySample(out_sample, in_sample);
        in_sample += in_type_.channels();
        out_sample += out_type_.channels();
      }
    }
    in_channel += in_type_.sample_size();
    out_channel += out_type_.sample_size();
  }

  source->Advance(frame_count);
  dest->Advance(frame_count);
}

}  // namespace media
}  // namespace mojo
