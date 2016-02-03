// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_PACKET_H_
#define SERVICES_MEDIA_FRAMEWORK_PACKET_H_

#include <memory>

#include "base/logging.h"
#include "services/media/framework/allocator.h"
#include "services/media/framework/ptr.h"

namespace mojo {
namespace media {

class Packet;

// Used for PacketPtr.
struct PacketDeleter {
  void operator()(Packet* ptr) const;
};

// Unique pointer for packets.
typedef UniquePtr<Packet, PacketDeleter> PacketPtr;

// Media packet abstract base class. Subclasses may be defined as needed.
// Packet::Create and Packet::CreateEndOfStream use an implementation with
// no special behavior.
// TODO(dalesat): Revisit this definition:
// 1) We probably need an extensible way to add metadata to packets.
// 2) The relationship to the allocator could be clearer.
class Packet {
 public:
  // Creates a packet. If size is 0, payload must be nullptr and vice-versa.
  // If payload is not nullptr, an allocator must be provided.
  static PacketPtr Create(
      int64_t presentation_time,
      uint64_t duration,
      bool end_of_stream,
      uint64_t size,
      void* payload,
      Allocator* allocator);

  // Creates a packet. If size is 0, payload must be nullptr and vice-versa.
  // No allocator is provided, and the payload will not be released when the
  // packet is released.
  static PacketPtr CreateNoAllocator(
      int64_t presentation_time,
      uint64_t duration,
      bool end_of_stream,
      uint64_t size,
      void* payload);

  // Creates an end-of-stream packet with no payload.
  static PacketPtr CreateEndOfStream(int64_t presentation_time);

  virtual int64_t presentation_time() const = 0;

  virtual uint64_t duration() const = 0;

  virtual bool end_of_stream() const = 0;

  virtual uint64_t size() const = 0;

  virtual void* payload() const = 0;

 protected:
  virtual ~Packet() {}

  virtual void Release() = 0;

  friend PacketDeleter;
};

inline void PacketDeleter::operator()(Packet* ptr) const {
  DCHECK(ptr);
  ptr->Release();
}

}  // namespace media
}  // namespace mojo

#endif // SERVICES_MEDIA_FRAMEWORK_PACKET_H_
