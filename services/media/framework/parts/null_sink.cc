// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/media/framework/parts/null_sink.h"

namespace mojo {
namespace media {

NullSink::NullSink() {}

NullSink::~NullSink() {}

bool NullSink::must_allocate() const {
  return false;
}

Allocator* NullSink::allocator() {
  return nullptr;
}

void NullSink::SetDemandCallback(DemandCallback demand_callback) {
  demand_callback_ = demand_callback;
}

void NullSink::Prime() {
  DCHECK(demand_callback_);
  demand_callback_(Demand::kNeutral);
}

Demand NullSink::SupplyPacket(PacketPtr packet) {
  return Demand::kNeutral;
}

} // namespace media
} // namespace mojo
