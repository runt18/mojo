// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_STREAM_TYPE_H_
#define SERVICES_MEDIA_FRAMEWORK_STREAM_TYPE_H_

#include <cstring>
#include <string>
#include <vector>

#include "base/logging.h"
#include "services/media/framework/ptr.h"

namespace mojo {
namespace media {

class StreamType;
class StreamTypes;
class MultiplexedStreamType;
class LpcmStreamType;
class CompressedAudioStreamType;
class VideoStreamType;

typedef UniquePtr<StreamType> StreamTypePtr;
typedef UniquePtr<StreamTypes> StreamTypesPtr;

// TODO(dalesat): Get rid of this class.
class StreamTypes : public std::vector<StreamTypePtr> {
 public:
  static StreamTypesPtr Create(size_t size) {
    return StreamTypesPtr(new StreamTypes(size));
  }

  explicit StreamTypes(size_t size) : std::vector<StreamTypePtr>(size) {}

  StreamTypesPtr Clone() const;
};

class Bytes;
typedef UniquePtr<Bytes> BytesPtr;

// TODO(dalesat): Get rid of this class.
class Bytes : public std::vector<uint8_t> {
 public:
  static BytesPtr Create(size_t size) {
    return BytesPtr(new Bytes(size));
  }

  static BytesPtr Create(uint8_t* data, size_t size) {
    BytesPtr result = Create(size);
    if (size != 0) {
      DCHECK(result->data());
      DCHECK(data);
      std::memcpy(result->data(), data, size);
    }
    return result;
  }

  explicit Bytes(size_t size) : std::vector<uint8_t>(size) {}

  explicit Bytes(const Bytes& copy_from) : std::vector<uint8_t>(copy_from) {}

  BytesPtr Clone() const;
};

// Describes the type of a stream.
class StreamType {
 public:
  enum class Scheme {
    kUnknown,
    kNone,
    kAnyElementary,
    kAnyAudio,
    kAnyVideo,
    kAnySubpicture,
    kAnyText,
    kAnyMultiplexed,
    kAny,

    kMultiplexed,
    kLpcm,
    kCompressedAudio,
    kVideo
  };

  static StreamTypePtr Create(Scheme scheme) {
    return StreamTypePtr(new StreamType(scheme));
  }

  explicit StreamType(Scheme scheme);

  virtual ~StreamType();

  Scheme scheme() const {
    return scheme_;
  }

  virtual const MultiplexedStreamType* multiplexed() const;
  virtual const LpcmStreamType* lpcm() const;
  virtual const CompressedAudioStreamType* compressed_audio() const;
  virtual const VideoStreamType* video() const;

  virtual StreamTypePtr Clone() const;

 private:
  Scheme scheme_;
};

template<typename T>
struct Range {
  Range(T min_param, T max_param) : min(min_param), max(max_param) {
    DCHECK(min_param <= max_param);
  }

  T min;
  T max;

  constexpr bool contains(const T& t) const {
    return t >= min && t <= max;
  }
};

class StreamTypeSet;
class StreamTypeSets;
class MultiplexedStreamTypeSet;
class LpcmStreamTypeSet;
class CompressedAudioStreamTypeSet;
class VideoStreamTypeSet;

typedef UniquePtr<StreamTypeSet> StreamTypeSetPtr;
typedef UniquePtr<StreamTypeSets> StreamTypeSetsPtr;

// TODO(dalesat): Get rid of this class.
class StreamTypeSets : public std::vector<StreamTypeSetPtr> {
 public:
  static StreamTypeSetsPtr Create(size_t size) {
    return StreamTypeSetsPtr(new StreamTypeSets(size));
  }

  StreamTypeSets(size_t size) : std::vector<StreamTypeSetPtr>(size) {}

  StreamTypeSetsPtr Clone() const;
};

// Describes a set of possible stream types.
class StreamTypeSet {
 public:
  static StreamTypeSetPtr Create(StreamType::Scheme scheme) {
    return StreamTypeSetPtr(new StreamTypeSet(scheme));
  }

  StreamTypeSet(StreamType::Scheme scheme);

  virtual ~StreamTypeSet();

  StreamType::Scheme scheme() const {
    return scheme_;
  }

  virtual const MultiplexedStreamTypeSet* multiplexed() const;
  virtual const LpcmStreamTypeSet* lpcm() const;
  virtual const CompressedAudioStreamTypeSet* compressed_audio() const;
  virtual const VideoStreamTypeSet* video() const;

  virtual StreamTypeSetPtr Clone() const;

 private:
  StreamType::Scheme scheme_;
};

// Describes the type of a multiplexed stream.
class MultiplexedStreamType : public StreamType {
 public:
  static StreamTypePtr Create(
      StreamTypePtr multiplex_type,
      StreamTypesPtr substream_types) {
    return StreamTypePtr(
        new MultiplexedStreamType(
            std::move(multiplex_type),
            std::move(substream_types)));
  }

  MultiplexedStreamType(
      StreamTypePtr multiplex_type,
      StreamTypesPtr substream_types);

  ~MultiplexedStreamType() override;

  const MultiplexedStreamType* multiplexed() const override;

  const StreamTypePtr& multiplex_type() const {
    return multiplex_type_;
  }

  const StreamTypesPtr& substream_types() const {
    return substream_types_;
  }

  StreamTypePtr Clone() const override;

private:
  StreamTypePtr multiplex_type_;
  StreamTypesPtr substream_types_;
};

// Describes the type of a multiplexed stream.
class MultiplexedStreamTypeSet : public StreamTypeSet {
public:
  static StreamTypeSetPtr Create(
      StreamTypeSetPtr multiplex_type_set,
      StreamTypeSetsPtr substream_type_sets) {
    return StreamTypeSetPtr(
        new MultiplexedStreamTypeSet(
            std::move(multiplex_type_set),
            std::move(substream_type_sets)));
  }

  MultiplexedStreamTypeSet(
      StreamTypeSetPtr multiplex_type_set,
      StreamTypeSetsPtr substream_type_sets);

  ~MultiplexedStreamTypeSet() override;

  const MultiplexedStreamTypeSet* multiplexed() const override;

  const StreamTypeSetPtr& multiplex_type_set() const {
    return multiplex_type_set_;
  }

  const StreamTypeSetsPtr& substream_type_sets() const {
    return substream_type_sets_;
  }

  StreamTypeSetPtr Clone() const override;

private:
  StreamTypeSetPtr multiplex_type_set_;
  StreamTypeSetsPtr substream_type_sets_;
};

// Describes the type of an LPCM stream.
class LpcmStreamType : public StreamType {
 public:
  enum class SampleFormat {
    kUnknown,
    kAny,
    kUnsigned8,
    kSigned16,
    kSigned24In32,
    kFloat
  };

  static StreamTypePtr Create(
      SampleFormat sample_format,
      uint32_t channels,
      uint32_t frames_per_second) {
    return StreamTypePtr(new LpcmStreamType(
        sample_format,
        channels,
        frames_per_second));
  }

  LpcmStreamType(
      SampleFormat sample_format,
      uint32_t channels,
      uint32_t frames_per_second);

  ~LpcmStreamType() override;

  const LpcmStreamType* lpcm() const override;

  SampleFormat sample_format() const {
    return sample_format_;
  }

  uint32_t channels() const {
    return channels_;
  }

  uint32_t frames_per_second() const {
    return frames_per_second_;
  }

  uint32_t sample_size() const {
    return sample_size_;
  }

  uint32_t bytes_per_frame() const {
    return sample_size_ * channels_;
  }

  uint64_t min_buffer_size(uint64_t frame_count) const {
    return frame_count * sample_size_ * channels_;
  }

  static uint32_t SampleSizeFromFormat(SampleFormat sample_format);

  StreamTypePtr Clone() const override;

 protected:
  LpcmStreamType(
      Scheme scheme,
      SampleFormat sample_format,
      uint32_t channels,
      uint32_t frames_per_second);

 private:
  SampleFormat sample_format_;
  uint32_t channels_;
  uint32_t frames_per_second_;
  uint32_t sample_size_;
};

// Describes a set of LPCM stream types.
class LpcmStreamTypeSet : public StreamTypeSet {
 public:
  static StreamTypeSetPtr Create(
      LpcmStreamType::SampleFormat sample_format,
      Range<uint32_t> channels,
      Range<uint32_t> frames_per_second) {
    return StreamTypeSetPtr(new LpcmStreamTypeSet(
        sample_format,
        channels,
        frames_per_second));
  }

  LpcmStreamTypeSet(
      LpcmStreamType::SampleFormat sample_format,
      Range<uint32_t> channels,
      Range<uint32_t> frames_per_second);

  ~LpcmStreamTypeSet() override;

  const LpcmStreamTypeSet* lpcm() const override;

  LpcmStreamType::SampleFormat sample_format() const {
    return sample_format_;
  }

  Range<uint32_t> channels() const {
    return channels_;
  }

  Range<uint32_t> frames_per_second() const {
    return frames_per_second_;
  }

  bool contains(const LpcmStreamType& type) const;

  StreamTypeSetPtr Clone() const override;

 protected:
  LpcmStreamTypeSet(
      StreamType::Scheme scheme,
      LpcmStreamType::SampleFormat sample_format,
      Range<uint32_t> channels,
      Range<uint32_t> frames_per_second);

 private:
  LpcmStreamType::SampleFormat sample_format_;
  Range<uint32_t> channels_;
  Range<uint32_t> frames_per_second_;
};

// Describes the type of a compressed audio stream.
class CompressedAudioStreamType : public LpcmStreamType {
 public:
  enum class AudioEncoding {
    kUnknown,
    kAny,
    kVorbis
  };

  static StreamTypePtr Create(
      AudioEncoding encoding,
      SampleFormat sample_format,
      uint32_t channels,
      uint32_t frames_per_second,
      BytesPtr encoding_details) {
    return StreamTypePtr(new CompressedAudioStreamType(
        encoding,
        sample_format,
        channels,
        frames_per_second,
        std::move(encoding_details)));
  }

  CompressedAudioStreamType(
    AudioEncoding encoding,
    SampleFormat sample_format,
    uint32_t channels,
    uint32_t frames_per_second,
    BytesPtr encoding_details);

  ~CompressedAudioStreamType() override;

  const CompressedAudioStreamType* compressed_audio() const override;

  AudioEncoding encoding() const {
    return encoding_;
  }

  const BytesPtr& encoding_details() const {
    return encoding_details_;
  }

  StreamTypePtr Clone() const override;

 private:
  AudioEncoding encoding_;
  BytesPtr encoding_details_;
};

// Describes a set of compressed audio stream types.
class CompressedAudioStreamTypeSet : public LpcmStreamTypeSet {
 public:
  static StreamTypeSetPtr Create(
      CompressedAudioStreamType::AudioEncoding encoding,
      CompressedAudioStreamType::SampleFormat sample_format,
      Range<uint32_t> channels,
      Range<uint32_t> frames_per_second) {
    return StreamTypeSetPtr(new CompressedAudioStreamTypeSet(
        encoding,
        sample_format,
        channels,
        frames_per_second));
  }

  CompressedAudioStreamTypeSet(
    CompressedAudioStreamType::AudioEncoding encoding,
    CompressedAudioStreamType::SampleFormat sample_format,
    Range<uint32_t> channels,
    Range<uint32_t> frames_per_second);

  ~CompressedAudioStreamTypeSet() override;

  const CompressedAudioStreamTypeSet* compressed_audio() const override;

  CompressedAudioStreamType::AudioEncoding encoding() const {
    return encoding_;
  }

  bool contains(const CompressedAudioStreamType& type) const;

  StreamTypeSetPtr Clone() const override;

 private:
  CompressedAudioStreamType::AudioEncoding encoding_;
};

// Describes the type of a video stream.
class VideoStreamType : public StreamType {
 public:
  enum class VideoEncoding {
    kUnknown,
    kAny,
    kTheora,
    kVp8,
  };

  enum class VideoProfile {
    kUnknown,
    kNotApplicable,
    kH264Baseline,
    kH264Main,
    kH264Extended,
    kH264High,
    kH264High10,
    kH264High422,
    kH264High444Predictive,
    kH264ScalableBaseline,
    kH264ScalableHigh,
    kH264StereoHigh,
    kH264MultiviewHigh
  };

  enum class PixelFormat {
    kUnknown,
    kI420,
    kYv12,
    kYv16,
    kYv12A,
    kYv24,
    kNv12,
    kNv21,
    kUyvy,
    kYuy2,
    kArgb,
    kXrgb,
    kRgb24,
    kRgb32,
    kMjpeg,
    kMt21
  };

  enum class ColorSpace {
    kUnknown,
    kNotApplicable,
    kJpeg,
    kHdRec709,
    kSdRec601
  };

  static StreamTypePtr Create(
      VideoEncoding encoding,
      VideoProfile profile,
      PixelFormat pixel_format,
      ColorSpace color_space,
      uint32_t width,
      uint32_t height,
      uint32_t coded_width,
      uint32_t coded_height,
      BytesPtr encoding_details) {
    return StreamTypePtr(new VideoStreamType(
        encoding,
        profile,
        pixel_format,
        color_space,
        width,
        height,
        coded_width,
        coded_height,
        std::move(encoding_details)));
  }

  VideoStreamType(
    VideoEncoding encoding,
    VideoProfile profile,
    PixelFormat pixel_format,
    ColorSpace color_space,
    uint32_t width,
    uint32_t height,
    uint32_t coded_width,
    uint32_t coded_height,
    BytesPtr encoding_details);

  ~VideoStreamType() override;

  const VideoStreamType* video() const override;

  VideoEncoding encoding() const {
    return encoding_;
  }

  VideoProfile profile() const {
    return profile_;
  }

  PixelFormat pixel_format() const {
    return pixel_format_;
  }

  ColorSpace color_space() const {
    return color_space_;
  }

  uint32_t width() const {
    return width_;
  }

  uint32_t height() const {
    return height_;
  }

  uint32_t coded_width() const {
    return coded_width_;
  }

  uint32_t coded_height() const {
    return coded_height_;
  }

  const BytesPtr& encoding_details() const {
    return encoding_details_;
  }

  StreamTypePtr Clone() const override;

 private:
  VideoEncoding encoding_;
  VideoProfile profile_;
  PixelFormat pixel_format_;
  ColorSpace color_space_;
  uint32_t width_;
  uint32_t height_;
  uint32_t coded_width_;
  uint32_t coded_height_;
  BytesPtr encoding_details_;
};

// Describes a set of video stream types.
class VideoStreamTypeSet : public StreamTypeSet {
 public:
  static StreamTypeSetPtr Create(
      VideoStreamType::VideoEncoding encoding,
      Range<uint32_t> width,
      Range<uint32_t> height) {
    return StreamTypeSetPtr(new VideoStreamTypeSet(
        encoding,
        width,
        height));
  }

  VideoStreamTypeSet(
    VideoStreamType::VideoEncoding encoding,
    Range<uint32_t> width,
    Range<uint32_t> height);

  ~VideoStreamTypeSet() override;

  const VideoStreamTypeSet* video() const override;

  VideoStreamType::VideoEncoding encoding() const {
    return encoding_;
  }

  Range<uint32_t> width() const {
    return width_;
  }

  Range<uint32_t> height() const {
    return height_;
  }

  StreamTypeSetPtr Clone() const override;

 private:
  VideoStreamType::VideoEncoding encoding_;
  Range<uint32_t> width_;
  Range<uint32_t> height_;
};

}  // namespace media
}  // namespace mojo

#endif // SERVICES_MEDIA_FRAMEWORK_STREAM_TYPE_H_
