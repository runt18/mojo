// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/logging.h"
#include "services/media/framework/stream_type.h"

namespace mojo {
namespace media {

BytesPtr Bytes::Clone() const {
  return BytesPtr(new Bytes(*this));
}

StreamType::StreamType(Scheme scheme) : scheme_(scheme) {}

StreamType::~StreamType() {}

const MultiplexedStreamType* StreamType::multiplexed() const {
  NOTREACHED();
  return nullptr;
}

const LpcmStreamType* StreamType::lpcm() const {
  NOTREACHED();
  return nullptr;
}

const CompressedAudioStreamType* StreamType::compressed_audio() const {
  NOTREACHED();
  return nullptr;
}

const VideoStreamType* StreamType::video() const {
  NOTREACHED();
  return nullptr;
}

StreamTypePtr StreamType::Clone() const {
  return Create(scheme());
}

StreamTypesPtr StreamTypes::Clone() const {
  StreamTypes* result = new StreamTypes(size());
  for (const StreamTypePtr& stream_type : *this) {
    result->push_back(stream_type.Clone());
  }
  return StreamTypesPtr(result);
}

StreamTypeSet::StreamTypeSet(StreamType::Scheme scheme) : scheme_(scheme) {}

StreamTypeSet::~StreamTypeSet() {}

StreamTypeSetsPtr StreamTypeSets::Clone() const {
  StreamTypeSets* result = new StreamTypeSets(size());
  for (const StreamTypeSetPtr& stream_type_set : *this) {
    result->push_back(stream_type_set.Clone());
  }
  return StreamTypeSetsPtr(result);
}

const MultiplexedStreamTypeSet* StreamTypeSet::multiplexed() const {
  NOTREACHED();
  return nullptr;
}

const LpcmStreamTypeSet* StreamTypeSet::lpcm() const {
  NOTREACHED();
  return nullptr;
}

const CompressedAudioStreamTypeSet* StreamTypeSet::compressed_audio() const {
  NOTREACHED();
  return nullptr;
}

const VideoStreamTypeSet* StreamTypeSet::video() const {
  NOTREACHED();
  return nullptr;
}

StreamTypeSetPtr StreamTypeSet::Clone() const {
  return Create(scheme());
}

MultiplexedStreamType::MultiplexedStreamType(
    StreamTypePtr multiplex_type,
    StreamTypesPtr substream_types) :
    StreamType(Scheme::kMultiplexed),
    multiplex_type_(std::move(multiplex_type)),
    substream_types_(std::move(substream_types)) {}

MultiplexedStreamType::~MultiplexedStreamType() {}

const MultiplexedStreamType* MultiplexedStreamType::multiplexed() const {
  return this;
}

StreamTypePtr MultiplexedStreamType::Clone() const {
  return Create(multiplex_type().Clone(), substream_types().Clone());
}

MultiplexedStreamTypeSet::MultiplexedStreamTypeSet(
    StreamTypeSetPtr multiplex_type_set,
    StreamTypeSetsPtr substream_type_sets) :
    StreamTypeSet(StreamType::Scheme::kMultiplexed),
    multiplex_type_set_(std::move(multiplex_type_set)),
    substream_type_sets_(std::move(substream_type_sets)) {}

MultiplexedStreamTypeSet::~MultiplexedStreamTypeSet() {}

const MultiplexedStreamTypeSet* MultiplexedStreamTypeSet::multiplexed() const {
  return this;
}

StreamTypeSetPtr MultiplexedStreamTypeSet::Clone() const {
  return Create(multiplex_type_set().Clone(), substream_type_sets().Clone());
}

LpcmStreamType::LpcmStreamType(
    SampleFormat sample_format,
    uint32_t channels,
    uint32_t frames_per_second) :
    LpcmStreamType(
        Scheme::kLpcm,
        sample_format,
        channels,
        frames_per_second) {}

LpcmStreamType::LpcmStreamType(
    Scheme scheme,
    SampleFormat sample_format,
    uint32_t channels,
    uint32_t frames_per_second) :
    StreamType(scheme),
    sample_format_(sample_format),
    channels_(channels),
    frames_per_second_(frames_per_second),
    sample_size_(SampleSizeFromFormat(sample_format)) {}

LpcmStreamType::~LpcmStreamType() {}

const LpcmStreamType* LpcmStreamType::lpcm() const {
  return this;
}

// static
uint32_t LpcmStreamType::SampleSizeFromFormat(
    SampleFormat sample_format) {
  switch(sample_format) {
    case SampleFormat::kUnsigned8:
      return sizeof(uint8_t);
    case SampleFormat::kSigned16:
      return sizeof(int16_t);
    case SampleFormat::kSigned24In32:
      return sizeof(int32_t);
    case SampleFormat::kFloat:
      return sizeof(float);
    case SampleFormat::kUnknown:
    case SampleFormat::kAny:
      return 0;
  }

  return 0;
}

StreamTypePtr LpcmStreamType::Clone() const {
  return Create(sample_format(), channels(), frames_per_second());
}

LpcmStreamTypeSet::LpcmStreamTypeSet(
    LpcmStreamType::SampleFormat sample_format,
    Range<uint32_t> channels,
    Range<uint32_t> frames_per_second) :
    LpcmStreamTypeSet(
        StreamType::Scheme::kLpcm,
        sample_format,
        channels,
        frames_per_second) {}

LpcmStreamTypeSet::LpcmStreamTypeSet(
    StreamType::Scheme scheme,
    LpcmStreamType::SampleFormat sample_format,
    Range<uint32_t> channels,
    Range<uint32_t> frames_per_second) :
    StreamTypeSet(scheme),
    sample_format_(sample_format),
    channels_(channels),
    frames_per_second_(frames_per_second) {}

LpcmStreamTypeSet::~LpcmStreamTypeSet() {}

const LpcmStreamTypeSet* LpcmStreamTypeSet::lpcm() const {
  return this;
}

bool LpcmStreamTypeSet::contains(const LpcmStreamType& type) const {
  return
      (sample_format() == type.sample_format() ||
          sample_format() == LpcmStreamType::SampleFormat::kAny) &&
      channels().contains(type.frames_per_second()) &&
      frames_per_second().contains(type.frames_per_second());
}

StreamTypeSetPtr LpcmStreamTypeSet::Clone() const {
  return Create(sample_format(), channels(), frames_per_second());
}

CompressedAudioStreamType::CompressedAudioStreamType(
  AudioEncoding encoding,
  SampleFormat sample_format,
  uint32_t channels,
  uint32_t frames_per_second,
  BytesPtr encoding_details) :
  LpcmStreamType(
      Scheme::kCompressedAudio,
      sample_format,
      channels,
      frames_per_second),
  encoding_(encoding),
  encoding_details_(std::move(encoding_details)) {}

CompressedAudioStreamType::~CompressedAudioStreamType() {}

const CompressedAudioStreamType* CompressedAudioStreamType::compressed_audio()
    const {
  return this;
}

StreamTypePtr CompressedAudioStreamType::Clone() const {
  return Create(
      encoding(),
      sample_format(),
      channels(),
      frames_per_second(),
      encoding_details().Clone());
}

CompressedAudioStreamTypeSet::CompressedAudioStreamTypeSet(
  CompressedAudioStreamType::AudioEncoding encoding,
  CompressedAudioStreamType::SampleFormat sample_format,
  Range<uint32_t> channels,
  Range<uint32_t> frames_per_second) :
  LpcmStreamTypeSet(
      StreamType::Scheme::kCompressedAudio,
      sample_format,
      channels,
      frames_per_second),
  encoding_(encoding) {}

CompressedAudioStreamTypeSet::~CompressedAudioStreamTypeSet() {}

const CompressedAudioStreamTypeSet*
    CompressedAudioStreamTypeSet::compressed_audio() const {
  return this;
}

bool CompressedAudioStreamTypeSet::contains(
    const CompressedAudioStreamType& type) const {
  return
      (encoding() == type.encoding() ||
          encoding() == CompressedAudioStreamType::AudioEncoding::kAny) &&
      (sample_format() == type.sample_format() ||
          sample_format() == LpcmStreamType::SampleFormat::kAny) &&
      channels().contains(type.frames_per_second()) &&
      frames_per_second().contains(type.frames_per_second());
}

StreamTypeSetPtr CompressedAudioStreamTypeSet::Clone() const {
  return Create(
      encoding(),
      sample_format(),
      channels(),
      frames_per_second());
}

VideoStreamType::VideoStreamType(
  VideoEncoding encoding,
  VideoProfile profile,
  PixelFormat pixel_format,
  ColorSpace color_space,
  uint32_t width,
  uint32_t height,
  uint32_t coded_width,
  uint32_t coded_height,
  BytesPtr encoding_details) :
  StreamType(StreamType::Scheme::kVideo),
  encoding_(encoding),
  profile_(profile),
  pixel_format_(pixel_format),
  color_space_(color_space),
  width_(width),
  height_(height),
  coded_width_(coded_width),
  coded_height_(coded_height),
  encoding_details_(std::move(encoding_details)) {}

VideoStreamType::~VideoStreamType() {}

const VideoStreamType* VideoStreamType::video() const {
  return this;
}

StreamTypePtr VideoStreamType::Clone() const {
  return Create(
      encoding(),
      profile(),
      pixel_format(),
      color_space(),
      width(),
      height(),
      coded_width(),
      coded_height(),
      encoding_details().Clone());
}

VideoStreamTypeSet::VideoStreamTypeSet(
  VideoStreamType::VideoEncoding encoding,
  Range<uint32_t> width,
  Range<uint32_t> height) :
  StreamTypeSet(StreamType::Scheme::kVideo),
  encoding_(encoding),
  width_(width),
  height_(height) {}

VideoStreamTypeSet::~VideoStreamTypeSet() {}

const VideoStreamTypeSet* VideoStreamTypeSet::video() const {
  return this;
}

StreamTypeSetPtr VideoStreamTypeSet::Clone() const {
  return Create(
      encoding(),
      width(),
      height());
}

} // namespace media
} // namespace mojo
