// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/logging.h"
#include "services/media/common/media_pipe_base.h"

namespace mojo {
namespace media {

MediaPipeBase::MediaPipeBase()
  : binding_(this) {
}

MediaPipeBase::~MediaPipeBase() {
  Cleanup();
}

MojoResult MediaPipeBase::Init(InterfaceRequest<MediaPipe> request,
                               uint64_t shared_buffer_size) {
  static const MojoCreateSharedBufferOptions opt {
    .struct_size = sizeof(MojoDuplicateBufferHandleOptions),
    .flags = MOJO_CREATE_SHARED_BUFFER_OPTIONS_FLAG_NONE,
  };

  // Double init?
  if (IsInitialized()) {
    return MOJO_RESULT_ALREADY_EXISTS;
  }

  // Valid size?
  DCHECK_GT(shared_buffer_size, 0u);
  DCHECK_LE(shared_buffer_size, MediaPipeState::kMaxPayloadLen);
  if (!shared_buffer_size ||
      (shared_buffer_size > MediaPipeState::kMaxPayloadLen)) {
    return MOJO_RESULT_INVALID_ARGUMENT;
  }

  MojoResult res;
  res = CreateSharedBuffer(&opt, shared_buffer_size, &buffer_handle_);
  if (MOJO_RESULT_OK == res) {
    // TODO(johngro) : We really only need read access to this buffer.  Ideally,
    // we could request that using flags, but there does not seem to be a way to
    // do this right now.
    res = MapBuffer(buffer_handle_.get(),
                    0u,
                    shared_buffer_size,
                    &buffer_,
                    MOJO_MAP_BUFFER_FLAG_NONE);
  }

  if (MOJO_RESULT_OK != res) {
    Cleanup();
  } else {
    buffer_size_ = shared_buffer_size;
    binding_.Bind(request.Pass());
  }
  return res;
}

bool MediaPipeBase::IsInitialized() const {
  DCHECK((!binding_.is_bound() && (buffer_ == nullptr)) ||
          (binding_.is_bound() && (buffer_ != nullptr)));
  return !!buffer_;
}

void MediaPipeBase::GetState(const GetStateCallback& cbk) {
  static const MojoDuplicateBufferHandleOptions options = {
    .struct_size = sizeof(*this),
    .flags = MOJO_DUPLICATE_BUFFER_HANDLE_OPTIONS_FLAG_NONE,
  };

  MediaPipeStatePtr state_ptr(MediaPipeState::New());

  // If we have not been successfully initialized, send back an invalid handle
  // and a zero length.
  if (!buffer_) {
    state_ptr->payload_buffer_len = 0;
  } else {
    MojoResult res = DuplicateBuffer(buffer_handle_.get(),
                                     &options,
                                     &state_ptr->payload_buffer);
    state_ptr->payload_buffer_len = buffer_size_;
    DCHECK(MOJO_RESULT_OK == res);
  }

  cbk.Run(state_ptr.Pass());
}

void MediaPipeBase::SendPacket(MediaPacketPtr packet,
                               const SendPacketCallback& cbk) {
  // If we have not been successfully initialized, then we should not be getting
  // packets pushed to us.
  if (!buffer_) {
    cbk.Run(MediaResult::BAD_STATE);
    return;
  }
  DCHECK(buffer_size_);

  // The offset(s) and size(s) of this payload must to reside within the space
  // of the shared buffer.  If any does not, this send operation is not valid.
  const MediaPacketRegionPtr* r = &packet->payload;
  size_t i = 0;
  while (true) {
    if ((*r).is_null()) {
      cbk.Run(MediaResult::INVALID_ARGUMENT);
      return;
    }

    auto offset = (*r)->offset;
    auto length = (*r)->length;
    if ((offset > buffer_size_) || (length > (buffer_size_ - offset))) {
      cbk.Run(MediaResult::INVALID_ARGUMENT);
      return;
    }

    if (i >= packet->extra_payload.size()) {
      break;
    }

    r = &packet->extra_payload[i++];
  }

  // Looks good, send this packet up to the implementation layer.
  MediaPacketStatePtr ptr(new MediaPacketState(packet.Pass(), cbk));
  OnPacketReceived(std::move(ptr));
}

void MediaPipeBase::Flush(const FlushCallback& cbk) {
  // If we have not been successfully initialized, then we should not be getting
  // packets pushed to us.
  if (!buffer_) {
    cbk.Run(MediaResult::BAD_STATE);
    return;
  }

  // Pass the flush request up to the implementation layer
  OnFlushRequested(cbk);
}

void MediaPipeBase::Cleanup() {
  if (nullptr != buffer_) {
    MojoResult res;
    res = UnmapBuffer(buffer_);
    CHECK(res == MOJO_RESULT_OK);
  }

  buffer_handle_.reset();
}

MediaPipeBase::MediaPacketState::MediaPacketState(
    MediaPacketPtr packet,
    const SendPacketCallback& cbk)
  : packet_(packet.Pass())
  , cbk_(cbk)
  , result_(MediaResult::OK) {
  DCHECK(packet_);
  DCHECK(packet_->payload);
  DCHECK(packet_->extra_payload);
}

MediaPipeBase::MediaPacketState::~MediaPacketState() {
  cbk_.Run(result_);
}

void MediaPipeBase::MediaPacketState::SetResult(MediaResult result) {
  MediaResult tmp = MediaResult::OK;
  result_.compare_exchange_strong(tmp, result);
}

}  // namespace media
}  // namespace mojo
