// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/edk/embedder/simple_platform_support.h"

#include <utility>

#include "mojo/edk/embedder/simple_platform_shared_buffer.h"
#include "mojo/edk/platform/random.h"

using mojo::platform::PlatformSharedBuffer;
using mojo::platform::ScopedPlatformHandle;
using mojo::util::RefPtr;

namespace mojo {
namespace embedder {

void SimplePlatformSupport::GetCryptoRandomBytes(void* bytes,
                                                 size_t num_bytes) {
  platform::GetCryptoRandomBytes(bytes, num_bytes);
}

RefPtr<PlatformSharedBuffer> SimplePlatformSupport::CreateSharedBuffer(
    size_t num_bytes) {
  return SimplePlatformSharedBuffer::Create(num_bytes);
}

RefPtr<PlatformSharedBuffer>
SimplePlatformSupport::CreateSharedBufferFromHandle(
    size_t num_bytes,
    ScopedPlatformHandle platform_handle) {
  return SimplePlatformSharedBuffer::CreateFromPlatformHandle(
      num_bytes, std::move(platform_handle));
}

}  // namespace embedder
}  // namespace mojo
