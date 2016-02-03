// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_MEDIA_MODELS_ACTIVE_SINK_H_
#define MOJO_MEDIA_MODELS_ACTIVE_SINK_H_

#include <memory>

#include "services/media/framework/allocator.h"
#include "services/media/framework/models/demand.h"
#include "services/media/framework/packet.h"

namespace mojo {
namespace media {

// Sink that consumes packets asynchronously.
class ActiveSink {
 public:
  using DemandCallback = std::function<void(Demand demand)>;

  virtual ~ActiveSink() {}

  // Indicates whether the sink must allocate.
  virtual bool must_allocate() const = 0;

  // The consumer's allocator. Can return nullptr, in which case the default
  // allocator should be used.
  virtual Allocator* allocator() = 0;

  // Sets the callback that signals demand asynchronously.
  virtual void SetDemandCallback(DemandCallback demand_callback) = 0;

  // Initiates demand.
  virtual void Prime() = 0;

  // Supplies a packet to the sink.
  virtual Demand SupplyPacket(PacketPtr packet) = 0;
};

typedef std::shared_ptr<ActiveSink> ActiveSinkPtr;

}  // namespace media
}  // namespace mojo

#endif // MOJO_MEDIA_MODELS_ACTIVE_SINK_H_
