// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_PARTS_NULL_SINK_H_
#define SERVICES_MEDIA_FRAMEWORK_PARTS_NULL_SINK_H_

#include "services/media/framework/models/active_sink.h"

namespace mojo {
namespace media {

class NullSink;

typedef SharedPtr<NullSink, ActiveSink> NullSinkPtr;

// Sink that throws packets away.
class NullSink : public ActiveSink {
 public:
  static NullSinkPtr Create() { return NullSinkPtr(new NullSink()); }

  ~NullSink() override;

  // ActiveSink implementation.
  bool must_allocate() const override;

  Allocator* allocator() override;

  void SetDemandCallback(DemandCallback demand_callback) override;

  void Prime() override;

  Demand SupplyPacket(PacketPtr packet) override;

 private:
  NullSink();

  DemandCallback demand_callback_;
};

}  // namespace media
}  // namespace mojo

#endif  // SERVICES_MEDIA_FRAMEWORK_PARTS_NULL_SINK_H_
