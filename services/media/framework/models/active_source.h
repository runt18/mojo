// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_MEDIA_MODELS_ACTIVE_SOURCE_H_
#define MOJO_MEDIA_MODELS_ACTIVE_SOURCE_H_

#include <memory>

#include "services/media/framework/allocator.h"
#include "services/media/framework/models/demand.h"
#include "services/media/framework/packet.h"

namespace mojo {
namespace media {

// Source that produces packets asynchronously.
class ActiveSource {
 public:
  using SupplyCallback = std::function<void(PacketPtr packet)>;

  virtual ~ActiveSource() {}

  // Whether the source can accept an allocator.
  virtual bool can_accept_allocator() const = 0;

  // Sets the allocator for the source.
  virtual void set_allocator(Allocator* allocator) = 0;

  // Sets the callback that supplies a packet asynchronously.
  virtual void SetSupplyCallback(SupplyCallback supply_callback) = 0;

  // Sets the demand signalled from downstream.
  virtual void SetDownstreamDemand(Demand demand) = 0;
};

typedef std::shared_ptr<ActiveSource> ActiveSourcePtr;

}  // namespace media
}  // namespace mojo

#endif // MOJO_MEDIA_MODELS_ACTIVE_SOURCE_H_
