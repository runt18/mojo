// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_MEDIA_MODELS_PACKET_TRANSFORM_H_
#define MOJO_MEDIA_MODELS_PACKET_TRANSFORM_H_

#include <memory>

#include "services/media/framework/allocator.h"
#include "services/media/framework/packet.h"

namespace mojo {
namespace media {

// Synchronous packet transform.
class PacketTransform {
 public:
  virtual ~PacketTransform() {}

  // Processes a packet. Returns true to indicate the transform is done
  // processing the input packet. Returns false to indicate the input
  // packet should be processed again. new_input indicates whether the input
  // packet is new (true) or is being processed again (false). An output packet
  // may or may not be generated for any given invocation of this method.
  virtual bool TransformPacket(
      const PacketPtr& input,
      bool new_input,
      Allocator* allocator,
      PacketPtr* output) = 0;
};

typedef std::shared_ptr<PacketTransform> PacketTransformPtr;

}  // namespace media
}  // namespace mojo

#endif // MOJO_MEDIA_MODELS_PACKET_TRANSFORM_H_
