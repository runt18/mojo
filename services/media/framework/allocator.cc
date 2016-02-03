// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <cstdlib>

#include "base/logging.h"
#include "services/media/framework/allocator.h"

namespace mojo {
namespace media {

namespace {

class DefaultAllocator : public Allocator {
 public:
  constexpr DefaultAllocator() {}

  // Allocator implementation.
  void* AllocatePayloadBuffer(uint64_t size) override;

  void ReleasePayloadBuffer(uint64_t size, void* buffer) override;
};

void* DefaultAllocator::AllocatePayloadBuffer(uint64_t size) {
  DCHECK(size > 0);
  return std::malloc(static_cast<size_t>(size));
}

void DefaultAllocator::ReleasePayloadBuffer(uint64_t size, void* buffer) {
  DCHECK(size > 0);
  DCHECK(buffer);
  std::free(buffer);
}

static constexpr DefaultAllocator default_allocator;

} // namespace

// static
Allocator* Allocator::GetDefault() {
  return const_cast<DefaultAllocator*>(&default_allocator);
}

} // namespace media
} // namespace mojo
