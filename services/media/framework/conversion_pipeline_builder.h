// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_CONVERSION_PIPELINE_BUILDER_H_
#define SERVICES_MEDIA_FRAMEWORK_CONVERSION_PIPELINE_BUILDER_H_

#include "services/media/framework/engine.h"
#include "services/media/framework/packet.h"
#include "services/media/framework/stream_type.h"

namespace mojo {
namespace media {

// Attempts to add transforms to the given pipeline to convert in_type to a
// type compatible with out_type_sets. If it succeeds, returns true, updates
// *output and delivers the resulting output type via *out_type. If it fails,
// returns false, sets *out_type to nullptr and leaves *output unchanged.
bool BuildConversionPipeline(
    const StreamTypePtr& in_type,
    const StreamTypeSetsPtr& out_type_sets,
    Engine* engine,
    Engine::Output* output,
    StreamTypePtr* out_type);

}  // namespace media
}  // namespace mojo

#endif // SERVICES_MEDIA_FRAMEWORK_CONVERSION_PIPELINE_BUILDER_H_
