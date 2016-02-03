// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_PARTS_DEMUX_H_
#define SERVICES_MEDIA_FRAMEWORK_PARTS_DEMUX_H_

#include <memory>
#include <vector>

#include "services/media/framework/metadata.h"
#include "services/media/framework/models/multistream_packet_source.h"
#include "services/media/framework/packet.h"
#include "services/media/framework/parts/reader.h"
#include "services/media/framework/result.h"
#include "services/media/framework/stream_type.h"

namespace mojo {
namespace media {

class Demux;

typedef SharedPtr<Demux, MultiStreamPacketSource> DemuxPtr;

// Abstract base class for sources that parse input from a reader and
// produce one or more output streams.
class Demux : public MultiStreamPacketSource {
 public:
  // Represents a stream produced by the demux.
  class DemuxStream {
    // TODO(dalesat): Replace this class with stream_type_, unless more stuff
    // needs to be added.
   public:
    virtual ~DemuxStream() {}

    virtual uint32_t index() const = 0;

    virtual StreamTypePtr stream_type() const = 0;
  };

  // Creates a Demux object for a given reader.
  static Result Create(ReaderPtr reader, DemuxPtr* demux_out);

  ~Demux() override {}

  // TODO(dalesat): Don't let the demux talk to the reader. We're doing it this
  // way now because of ffmpeg's synchronous read call. Ideally, the demux
  // would tell its owner how much data it needs from the reader, and the
  // owner would later hand over the data and possibly get a packet back.

  // TODO(dalesat): Implement seek, etc.

  // TODO(dalesat): Make the demux use an allocator. Ffmpeg demuxes don't
  // support this.

  // Initializes the demux.
  virtual Result Init(ReaderPtr reader) = 0;

  // Gets the current metadata.
  virtual MetadataPtr metadata() const = 0;

  // Gets the stream collection.
  virtual const std::vector<DemuxStream*>& streams() const = 0;

  // MultiStreamProducer implementation (deferred to subclasses).
  // bool can_accept_allocator(uint32_t stream_index) const override;
  // void set_allocator(uint32_t stream_index, Allocator* allocator) override;

  // MultiStreamPacketSource implementation (deferred to subclasses).
  // uint32_t stream_count() const override;
  // PacketPtr PullPacket(uint32_t* stream_index_out) override;
};

}  // namespace media
}  // namespace mojo

#endif // SERVICES_MEDIA_FRAMEWORK_PARTS_DEMUX_H_
