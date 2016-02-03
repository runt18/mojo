// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/media/framework/conversion_pipeline_builder.h"
#include "services/media/framework/formatting.h"
#include "services/media/framework/parts/decoder.h"
#include "services/media/framework/parts/lpcm_reformatter.h"

namespace mojo {
namespace media {

namespace {

enum class AddResult {
  kFailed, // Can't convert.
  kProgressed, // Added a conversion transform.
  kFinished // Done adding conversion transforms.
};

// Produces a score for in_type with respect to out_type_set. The score
// is used to compare type sets to see which represents the best goal for
// conversion. Higher scores are preferred. A score of zero indicates that
// in_type is incompatible with out_type_set.
int Score(
    const LpcmStreamType& in_type,
    const LpcmStreamTypeSet& out_type_set) {
  // TODO(dalesat): Plenty of room for more subtlety here. Maybe actually
  // measure conversion costs (cpu, quality, etc) and reflect them here.

  int score = 1; // We can convert anything, so 1 is the minimum score.

  if (in_type.sample_format() == out_type_set.sample_format() ||
      out_type_set.sample_format() == LpcmStreamType::SampleFormat::kAny) {
    // Prefer not to convert sample format.
    score += 10;
  } else {
    // Prefer higher-quality formats.
    switch (out_type_set.sample_format()) {
      case LpcmStreamType::SampleFormat::kUnsigned8:
        break;
      case LpcmStreamType::SampleFormat::kSigned16:
        score += 1;
        break;
      case LpcmStreamType::SampleFormat::kSigned24In32:
        score += 2;
        break;
      case LpcmStreamType::SampleFormat::kFloat:
        score += 3;
        break;
      default:
        NOTREACHED() << "unsupported sample format "
            << out_type_set.sample_format();
    }
  }

  if (out_type_set.channels().contains(in_type.channels())) {
    // Prefer not to mixdown/up.
    score += 10;
  } else {
    return 0; // TODO(dalesat): Remove when we have mixdown/up.
  }

  if (out_type_set.frames_per_second().
      contains(in_type.frames_per_second())) {
    // Very much prefer not to resample.
    score += 50;
  } else {
    return 0; // TODO(dalesat): Remove when we have resamplers.
  }

  return score;
}

// Finds the media type set that best matches in_type.
const StreamTypeSetPtr* FindBestLpcm(
    const LpcmStreamType& in_type,
    const StreamTypeSetsPtr& out_type_sets) {
  const StreamTypeSetPtr* best = nullptr;
  int best_score = 0;
  for (const StreamTypeSetPtr& out_type_set : *out_type_sets) {
    switch (out_type_set->scheme()) {
      case StreamType::Scheme::kAnyElementary:
      case StreamType::Scheme::kAnyAudio:
      case StreamType::Scheme::kAny:
        // Wildcard scheme allows any type without conversion.
        return &out_type_set;
      case StreamType::Scheme::kLpcm: {
        int score = Score(in_type, *out_type_set->lpcm());
        if (best_score < score) {
          best_score = score;
          best = &out_type_set;
        }
        break;
      }
      default:
        break;
    }
  }
  return best;
}

// Attempts to add transforms to the pipeline given an input compressed audio
// stream type with (in_type) and the set of output types we need to convert to
// (out_type_sets). If the call succeeds, *out_type is set to the new output
// type. Otherwise, *out_type is set to nullptr.
AddResult AddTransformsForCompressedAudio(
    const CompressedAudioStreamType& in_type,
    const StreamTypePtr& in_type_ptr,
    const StreamTypeSetsPtr& out_type_sets,
    Engine* engine,
    Engine::Output* output,
    StreamTypePtr* out_type) {
  DCHECK(out_type);
  DCHECK(engine);

  // See if we have a matching COMPRESSED_AUDIO type.
  for (const StreamTypeSetPtr& out_type_set : *out_type_sets) {
    switch (out_type_set->scheme()) {
      case StreamType::Scheme::kAnyElementary:
      case StreamType::Scheme::kAnyAudio:
      case StreamType::Scheme::kAny:
        // Wildcard scheme allows any type without conversion.
        *out_type = in_type.Clone();
        return AddResult::kFinished;
      case StreamType::Scheme::kCompressedAudio: {
        if (out_type_set->compressed_audio()->contains(in_type)) {
          // No transform needed.
          *out_type = in_type.Clone();
          return AddResult::kFinished;
        }
        break;
      }
      default:
        break;
    }
    // TODO(dalesat): Support a different compressed output type by transcoding.
  }

  // Find the best LPCM output type.
  const StreamTypeSetPtr* best = FindBestLpcm(in_type, out_type_sets);
  if (best == nullptr) {
    // No candidates found.
    *out_type = nullptr;
    return AddResult::kFailed;
  }

  DCHECK_EQ((*best)->scheme(), StreamType::Scheme::kLpcm);

  // Need to decode. Create a decoder and go from there.
  DecoderPtr decoder;
  Result result = Decoder::Create(in_type_ptr, &decoder);
  if (result !=  Result::kOk) {
    // No decoder found.
    *out_type = nullptr;
    return AddResult::kFailed;
  }

  *output = engine->ConnectOutputToPart(*output, engine->Add(decoder)).output();
  *out_type = decoder->output_stream_type();

  return AddResult::kProgressed;
}

// Attempts to add transforms to the pipeline given an input LPCM stream type
// (in_type) and the output lpcm stream type set for the type we need to convert
// to (out_type_set). If the call succeeds, *out_type is set to the new output
// type. Otherwise, *out_type is set to nullptr.
AddResult AddTransformsForLpcm(
    const LpcmStreamType& in_type,
    const LpcmStreamTypeSet& out_type_set,
    Engine* engine,
    Engine::Output* output,
    StreamTypePtr* out_type) {
  DCHECK(engine);
  DCHECK(out_type);

  // TODO(dalesat): Room for more intelligence here wrt transform ordering and
  // transforms that handle more than one conversion.
  if (in_type.sample_format() != out_type_set.sample_format() &&
      out_type_set.sample_format() != LpcmStreamType::SampleFormat::kAny) {
    // The reformatter will fix interleave conversion.
    *output = engine->ConnectOutputToPart(
        *output,
        engine->Add(LpcmReformatter::Create(in_type, out_type_set))).output();
  }

  if (!out_type_set.channels().contains(in_type.channels())) {
    // TODO(dalesat): Insert mixdown/up transform.
    NOTREACHED() << "conversion requires mixdown/up - not supported";
    *out_type = nullptr;
    return AddResult::kFailed;
  }

  if (!out_type_set.frames_per_second().contains(in_type.frames_per_second())) {
    // TODO(dalesat): Insert resampler.
    NOTREACHED() << "conversion requires resampling - not supported";
    *out_type = nullptr;
    return AddResult::kFailed;
  }

  // Build the resulting media type.
  *out_type = LpcmStreamType::Create(
      out_type_set.sample_format() == LpcmStreamType::SampleFormat::kAny ?
          in_type.sample_format() :
          out_type_set.sample_format(),
      in_type.channels(),
      in_type.frames_per_second());

  return AddResult::kFinished;
}

// Attempts to add transforms to the pipeline given an input media type with
// scheme LPCM (in_type) and the set of output types we need to convert to
// (out_type_sets). If the call succeeds, *out_type is set to the new output
// type. Otherwise, *out_type is set to nullptr.
AddResult AddTransformsForLpcm(
    const LpcmStreamType& in_type,
    const StreamTypeSetsPtr& out_type_sets,
    Engine* engine,
    Engine::Output* output,
    StreamTypePtr* out_type) {
  DCHECK(engine);
  DCHECK(out_type);

  const StreamTypeSetPtr* best = FindBestLpcm(in_type, out_type_sets);
  if (best == nullptr) {
    // TODO(dalesat): Support a compressed output type by encoding.
    NOTREACHED() << "conversion using encoder not supported";
    *out_type = nullptr;
    return AddResult::kFailed;
  }

  switch ((*best)->scheme()) {
    case StreamType::Scheme::kAnyElementary:
    case StreamType::Scheme::kAnyAudio:
    case StreamType::Scheme::kAny:
      // Wildcard scheme allows any type without conversion.
      *out_type = in_type.Clone();
      return AddResult::kFinished;
    case StreamType::Scheme::kLpcm:
      return AddTransformsForLpcm(
          in_type,
          *(*best)->lpcm(),
          engine,
          output,
          out_type);
    default:
      NOTREACHED() << "FindBestLpcm produced unexpected type set scheme"
          << (*best)->scheme();
      return AddResult::kFailed;
  }
}

// Attempts to add transforms to the pipeline given an input media type of any
// scheme (in_type) and the set of output types we need to convert to
// (out_type_sets). If the call succeeds, *out_type is set to the new output
// type. Otherwise, *out_type is set to nullptr.
AddResult AddTransforms(
    const StreamTypePtr& in_type,
    const StreamTypeSetsPtr& out_type_sets,
    Engine* engine,
    Engine::Output* output,
    StreamTypePtr* out_type) {
  DCHECK(in_type);
  DCHECK(engine);
  DCHECK(out_type);

  switch (in_type->scheme()) {
    case StreamType::Scheme::kLpcm:
      return AddTransformsForLpcm(
          *in_type->lpcm(),
          out_type_sets,
          engine,
          output,
          out_type);
    case StreamType::Scheme::kCompressedAudio:
      return AddTransformsForCompressedAudio(
          *in_type->compressed_audio(),
          in_type,
          out_type_sets,
          engine,
          output,
          out_type);
    default:
      NOTREACHED() << "conversion not supported for scheme"
          << in_type->scheme();
      *out_type = nullptr;
      return AddResult::kFailed;
  }
}

}  // namespace

bool BuildConversionPipeline(
    const StreamTypePtr& in_type,
    const StreamTypeSetsPtr& out_type_sets,
    Engine* engine,
    Engine::Output* output,
    StreamTypePtr* out_type) {
  DCHECK(in_type);
  DCHECK(out_type_sets);
  DCHECK(engine);
  DCHECK(output);
  DCHECK(out_type);

  Engine::Output out = *output;

  const StreamTypePtr* type_to_convert = &in_type;
  StreamTypePtr next_in_type;
  while (true) {
    StreamTypePtr converted_type;
    switch (AddTransforms(
        *type_to_convert,
        out_type_sets,
        engine,
        &out,
        &converted_type)) {
      case AddResult::kFailed:
        // Failed to find a suitable conversion. Return the pipeline to its
        // original state.
        engine->RemovePartsConnectedToOutput(*output);
        *out_type = nullptr;
        return false;
      case AddResult::kProgressed:
        // Made progress. Continue.
        break;
      case AddResult::kFinished:
        // No further conversion required.
        *output = out;
        *out_type = std::move(converted_type);
        return true;
    }

    next_in_type = std::move(converted_type);
    type_to_convert = &next_in_type;
  }
}

}  // namespace media
}  // namespace mojo
