// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_COMMON_MEDIA_PIPE_BASE_H_
#define SERVICES_MEDIA_COMMON_MEDIA_PIPE_BASE_H_

#include <atomic>
#include <deque>
#include <memory>

#include "base/synchronization/lock.h"
#include "base/task_runner.h"
#include "mojo/public/cpp/bindings/binding.h"
#include "mojo/public/cpp/system/buffer.h"
#include "mojo/services/media/common/interfaces/media_pipe.mojom.h"

namespace mojo {
namespace media {

class MediaPipeBase : public MediaPipe {
 protected:
  class MappedSharedBuffer;
  using MappedSharedBufferPtr = std::shared_ptr<MappedSharedBuffer>;

 public:
  class MediaPacketState {
   public:
    ~MediaPacketState();

    const MediaPacketPtr& packet() const { return packet_; }
    const MappedSharedBufferPtr& buffer() const { return buffer_; }
    void SetResult(MediaPipe::SendResult result);

   private:
    friend class MediaPipeBase;
    MediaPacketState(MediaPacketPtr packet,
                     const MappedSharedBufferPtr& buffer,
                     const SendPacketCallback& cbk);

    MediaPacketPtr packet_;
    MappedSharedBufferPtr buffer_;
    SendPacketCallback cbk_;
    std::atomic<MediaPipe::SendResult> result_;
  };
  using MediaPacketStatePtr = std::unique_ptr<MediaPacketState>;

  // Default constructor and destructor
  MediaPipeBase();
  ~MediaPipeBase() override;

  // Initialize the internal state of the pipe (allocate resources, etc..)
  MojoResult Init(InterfaceRequest<MediaPipe> request,
                  uint64_t shared_buffer_size);

  bool IsInitialized() const;
  void Reset();

 protected:
  class MappedSharedBuffer {
   public:
    static MappedSharedBufferPtr Create(size_t size);
    ~MappedSharedBuffer();

    const ScopedSharedBufferHandle& handle() const { return handle_; }
    size_t size() const { return size_; }
    void*  base() const { return base_; }

   private:
    explicit MappedSharedBuffer(size_t size);

    ScopedSharedBufferHandle handle_;
    size_t size_;
    void*  base_ = nullptr;
  };

  // Interface to be implemented by derived classes
  virtual void OnPacketReceived(MediaPacketStatePtr state) = 0;
  virtual bool OnFlushRequested(const FlushCallback& cbk) = 0;

  MappedSharedBufferPtr buffer_;

 private:
  Binding<MediaPipe> binding_;

  // MediaPipe.mojom implementation.
  void GetState(const GetStateCallback& cbk) final;
  void SendPacket(MediaPacketPtr packet,
                  const SendPacketCallback& cbk) final;
  void Flush(const FlushCallback& cbk) final;
};

}  // namespace media
}  // namespace mojo

#endif  // SERVICES_MEDIA_COMMON_MEDIA_PIPE_BASE_H_
