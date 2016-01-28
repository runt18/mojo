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
}

MojoResult MediaPipeBase::Init(InterfaceRequest<MediaPipe> request,
                               uint64_t shared_buffer_size) {
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

  DCHECK(!buffer_);
  buffer_ = MappedSharedBuffer::Create(shared_buffer_size);
  if (buffer_ == nullptr) {
    return MOJO_RESULT_UNKNOWN;
  }

  binding_.Bind(request.Pass());
  binding_.set_connection_error_handler([this]() -> void {
    Reset();
  });
  return MOJO_RESULT_OK;
}

bool MediaPipeBase::IsInitialized() const {
  DCHECK((!binding_.is_bound() && (buffer_ == nullptr)) ||
          (binding_.is_bound() && (buffer_ != nullptr)));
  return !!buffer_;
}

void MediaPipeBase::Reset() {
  if (binding_.is_bound()) {
    binding_.Close();
  }
  buffer_ = nullptr;
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
    MojoResult res = DuplicateBuffer(buffer_->handle().get(),
                                     &options,
                                     &state_ptr->payload_buffer);
    state_ptr->payload_buffer_len = buffer_->size();
    DCHECK(MOJO_RESULT_OK == res);
  }

  cbk.Run(state_ptr.Pass());
}

void MediaPipeBase::SendPacket(MediaPacketPtr packet,
                               const SendPacketCallback& cbk) {
  // If we have not been successfully initialized, then we should not be getting
  // packets pushed to us.
  if (!buffer_) {
    LOG(ERROR) << "SendPacket called with no shared buffer established!";
    Reset();
    return;
  }
  DCHECK(buffer_->size());

  // The offset(s) and size(s) of this payload must to reside within the space
  // of the shared buffer.  If any does not, this send operation is not valid.
  const MediaPacketRegionPtr* r = &packet->payload;
  size_t i = 0;
  size_t extra_payload_size =
      packet->extra_payload.is_null() ? 0 : packet->extra_payload.size();
  while (true) {
    if ((*r).is_null()) {
      LOG(ERROR) << "Missing region structure at index " << i
                 << " during SendPacket";
      Reset();
      return;
    }

    auto offset = (*r)->offset;
    auto length = (*r)->length;
    if ((offset > buffer_->size()) || (length > (buffer_->size() - offset))) {
      LOG(ERROR) << "Region [" << offset << "," << (offset + length)
                 << ") at index " << i
                 << " is out of range for shared buffer of size "
                 << buffer_->size()
                 << " during SendPacket.";
      Reset();
      return;
    }

    if (i >= extra_payload_size) {
      break;
    }

    DCHECK(packet->extra_payload);
    r = &packet->extra_payload[i++];
  }

  // Looks good, send this packet up to the implementation layer.
  MediaPacketStatePtr ptr(new MediaPacketState(packet.Pass(), buffer_, cbk));
  OnPacketReceived(std::move(ptr));
}

void MediaPipeBase::Flush(const FlushCallback& cbk) {
  // If we have not been successfully initialized, then we should not be getting
  // packets pushed to us.
  if (!buffer_) {
    LOG(ERROR) << "Flush called with no shared buffer established!";
    Reset();
    return;
  }

  // Pass the flush request up to the implementation layer.  If something goes
  // fatally wrong up there, close the connection.
  if (!OnFlushRequested(cbk)) {
    Reset();
  }
}

MediaPipeBase::MediaPacketState::MediaPacketState(
    MediaPacketPtr packet,
    const MappedSharedBufferPtr& buffer,
    const SendPacketCallback& cbk)
  : packet_(packet.Pass()),
    buffer_(buffer),
    cbk_(cbk),
    result_(MediaPipe::SendResult::CONSUMED) {
  DCHECK(packet_);
  DCHECK(packet_->payload);
}

MediaPipeBase::MediaPacketState::~MediaPacketState() {
  cbk_.Run(result_);
}

void MediaPipeBase::MediaPacketState::SetResult(MediaPipe::SendResult result) {
  MediaPipe::SendResult tmp = MediaPipe::SendResult::CONSUMED;
  result_.compare_exchange_strong(tmp, result);
}

MediaPipeBase::MappedSharedBufferPtr MediaPipeBase::MappedSharedBuffer::Create(
    size_t size) {
  MappedSharedBufferPtr ret(new MappedSharedBuffer(size));
  return ret->base() ? ret : nullptr;
}

MediaPipeBase::MappedSharedBuffer::~MappedSharedBuffer() {
  if (nullptr != base_) {
    MojoResult res = UnmapBuffer(base_);
    CHECK(res == MOJO_RESULT_OK);
  }
}

MediaPipeBase::MappedSharedBuffer::MappedSharedBuffer(size_t size)
  : size_(size) {
  static const MojoCreateSharedBufferOptions opt {
    .struct_size = sizeof(MojoDuplicateBufferHandleOptions),
    .flags = MOJO_CREATE_SHARED_BUFFER_OPTIONS_FLAG_NONE,
  };
  MojoResult res;

  res = CreateSharedBuffer(&opt, size_, &handle_);
  if (MOJO_RESULT_OK == res) {
    // TODO(johngro) : We really only need read access to this buffer.  Ideally,
    // we could request that using flags, but there does not seem to be a way to
    // do this right now.
    res = MapBuffer(handle_.get(),
                    0u,
                    size_,
                    &base_,
                    MOJO_MAP_BUFFER_FLAG_NONE);

    if (MOJO_RESULT_OK != res) {
      LOG(ERROR) << "Failed to map shared buffer of size " << size_
                 << " (res " << res << ")";
      DCHECK(base_ == nullptr);
      handle_.reset();
    }
  } else {
    LOG(ERROR) << "Failed to create shared buffer of size " << size_
               << " (res " << res << ")";
    DCHECK(!handle_.is_valid());
  }
}

}  // namespace media
}  // namespace mojo
