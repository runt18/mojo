// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_PARTS_LPCM_REFORMATTER_H_
#define SERVICES_MEDIA_FRAMEWORK_PARTS_LPCM_REFORMATTER_H_

#include "services/media/framework/models/lpcm_transform.h"
#include "services/media/framework/stream_type.h"

namespace mojo {
namespace media {

class LpcmReformatter;

typedef SharedPtr<LpcmReformatter, LpcmTransform> LpcmReformatterPtr;

// A transform that reformats samples.
// TODO(dalesat): Some variations on this could be InPlacePacketTransforms.
class LpcmReformatter : public LpcmTransform {
 public:
  static LpcmReformatterPtr Create(
      const LpcmStreamType& in_type,
      const LpcmStreamTypeSet& out_type);
};

}  // namespace media
}  // namespace mojo

#endif // SERVICES_MEDIA_FRAMEWORK_PARTS_LPCM_REFORMATTER_H_
