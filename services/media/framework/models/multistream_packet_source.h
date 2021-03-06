// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_MEDIA_MODELS_MULTISTREAM_PACKET_SOURCE_H_
#define MOJO_MEDIA_MODELS_MULTISTREAM_PACKET_SOURCE_H_

#include <memory>

#include "services/media/framework/packet.h"

namespace mojo {
namespace media {

// Synchronous source of packets for multiple streams. This is currently used
// by Demux, though it would be better if Demux were asynchronous.
class MultiStreamPacketSource {
 public:
  virtual ~MultiStreamPacketSource() {}

  // Returns the number of streams the source produces.
  virtual uint32_t stream_count() const = 0;

  // Gets a packet for the stream indicated via stream_index_out. This call
  // should always produce a packet until end-of-stream. The caller is
  // responsible for releasing the packet.
  virtual PacketPtr PullPacket(uint32_t *stream_index_out) = 0;
};

typedef std::shared_ptr<MultiStreamPacketSource> MultiStreamPacketSourcePtr;

}  // namespace media
}  // namespace mojo

#endif // MOJO_MEDIA_MODELS_MULTISTREAM_PACKET_SOURCE_H_
