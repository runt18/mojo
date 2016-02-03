// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_ALLOCATOR_H_
#define SERVICES_MEDIA_FRAMEWORK_ALLOCATOR_H_

#include <cstdint>

namespace mojo {
namespace media {

// Abstract base class for objects that allocate buffers for packets.
class Allocator {
 public:
  // Gets the default allocator, which allocates vanilla memory from the heap.
  static Allocator* GetDefault();

  // Allocates and returns a buffer of the indicated size or returns nullptr
  // if the allocation fails.
  // TODO(dalesat): Use size_t for sizes in units of bytes framework-wide.
  virtual void* AllocatePayloadBuffer(uint64_t size) = 0;

  // Releases a buffer previously allocated via AllocatePayloadBuffer.
  virtual void ReleasePayloadBuffer(uint64_t size, void* buffer) = 0;
};

}  // namespace media
}  // namespace mojo

#endif // SERVICES_MEDIA_FRAMEWORK_ALLOCATOR_H_
