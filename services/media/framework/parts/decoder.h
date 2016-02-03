// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_PARTS_DECODER_H_
#define SERVICES_MEDIA_FRAMEWORK_PARTS_DECODER_H_

#include "services/media/framework/allocator.h"
#include "services/media/framework/models/packet_transform.h"
#include "services/media/framework/packet.h"
#include "services/media/framework/result.h"
#include "services/media/framework/stream_type.h"

namespace mojo {
namespace media {

class Decoder;

typedef SharedPtr<Decoder, PacketTransform> DecoderPtr;

// Abstract base class for transforms that decode compressed media.
class Decoder : public PacketTransform {
 public:
  // Creates a Decoder object for a given stream type.
  static Result Create(
      const StreamTypePtr& stream_type,
      DecoderPtr* decoder_out);

  ~Decoder() override {}

  // Returns the type of the stream the decoder will produce.
  virtual StreamTypePtr output_stream_type() = 0;

 protected:
  // Initializes the decoder. Called by Decoder::Create.
  virtual Result Init(const StreamTypePtr& stream_type) = 0;
};

}  // namespace media
}  // namespace mojo

#endif // SERVICES_MEDIA_FRAMEWORK_PARTS_DECODER_H_
