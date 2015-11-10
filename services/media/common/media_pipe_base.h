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
 public:
  class MediaPacketState {
   public:
    ~MediaPacketState();

    const MediaPacketPtr& GetPacket() const { return packet_; }
    void SetResult(MediaResult result);

   private:
    friend class MediaPipeBase;
    MediaPacketState(MediaPacketPtr packet,
                     const SendPacketCallback& cbk);

    MediaPacketPtr packet_;
    SendPacketCallback cbk_;
    std::atomic<MediaResult> result_;
  };
  using MediaPacketStatePtr = std::unique_ptr<MediaPacketState>;

  // Default constructor and destructor
  MediaPipeBase();
  ~MediaPipeBase() override;

  // Initialize the internal state of the pipe (allocate resources, etc..)
  MojoResult Init(InterfaceRequest<MediaPipe> request,
                  uint64_t shared_buffer_size);

  bool IsInitialized() const;

 protected:
  // Interface to be implemented by derived classes
  virtual void OnPacketReceived(MediaPacketStatePtr state) = 0;
  virtual void OnFlushRequested(const FlushCallback& cbk) = 0;

  const size_t buffer_size() const { return buffer_size_; }
  const void*  buffer() const      { return buffer_; }

 private:
  void Cleanup();

  // MediaPipe.mojom implementation.
  void GetState(const GetStateCallback& cbk) final;
  void SendPacket(MediaPacketPtr packet,
                  const SendPacketCallback& cbk) final;
  void Flush(const FlushCallback& cbk) final;

  ScopedSharedBufferHandle buffer_handle_;
  size_t                   buffer_size_;
  void*                    buffer_ = nullptr;
  Binding<MediaPipe>       binding_;
};

}  // namespace media
}  // namespace mojo

#endif  // SERVICES_MEDIA_COMMON_MEDIA_PIPE_BASE_H_
