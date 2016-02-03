// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/logging.h"
#include "services/media/framework/allocator.h"
#include "services/media/framework/packet.h"

namespace mojo {
namespace media {

class PacketImpl : public Packet {
 public:
  PacketImpl(
      int64_t presentation_time,
      uint64_t duration,
      bool end_of_stream,
      uint64_t size,
      void* payload,
      Allocator* allocator) :
      presentation_time_(presentation_time),
      duration_(duration),
      end_of_stream_(end_of_stream),
      size_(size),
      payload_(payload),
      allocator_(allocator) {
    DCHECK((size == 0) == (payload == nullptr));
  }

  ~PacketImpl() override {};

  int64_t presentation_time() const override { return presentation_time_; }

  uint64_t duration() const override { return duration_; }

  bool end_of_stream() const override { return end_of_stream_; }

  uint64_t size() const override { return size_; }

  void* payload() const override { return payload_; }

 protected:
  void Release() override {
    if (payload_ != nullptr && allocator_ != nullptr) {
      DCHECK(allocator_);
      allocator_->ReleasePayloadBuffer(size_, payload_);
    }
    delete this;
  }

 private:
  int64_t presentation_time_;
  uint64_t duration_;
  bool end_of_stream_;
  uint64_t size_;
  void* payload_;
  Allocator* allocator_;
};

// static
PacketPtr Packet::Create(
    int64_t presentation_time,
    uint64_t duration,
    bool end_of_stream,
    uint64_t size,
    void* payload,
    Allocator* allocator) {
  DCHECK(payload == nullptr || allocator != nullptr);
  return PacketPtr(new PacketImpl(
      presentation_time,
      duration,
      end_of_stream,
      size,
      payload,
      allocator));
}

// static
PacketPtr Packet::CreateNoAllocator(
    int64_t presentation_time,
    uint64_t duration,
    bool end_of_stream,
    uint64_t size,
    void* payload) {
  return PacketPtr(new PacketImpl(
      presentation_time,
      duration,
      end_of_stream,
      size,
      payload,
      nullptr));
}

// static
PacketPtr Packet::CreateEndOfStream(int64_t presentation_time) {
  return PacketPtr(new PacketImpl(
      presentation_time,
      0, // duration
      true, // end_of_stream
      0, // size
      nullptr, // payload
      nullptr)); // allocator
}

}  // namespace media
}  // namespace mojo
