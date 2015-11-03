// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <fcntl.h>

#include "base/files/file_util.h"
#include "mojo/application/application_runner_chromium.h"
#include "mojo/application/content_handler_factory.h"
#include "mojo/data_pipe_utils/data_pipe_utils.h"
#include "mojo/message_pump/message_pump_mojo.h"
#include "mojo/nacl/nonsfi/nexe_launcher_nonsfi.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_impl.h"

namespace nacl {
namespace content_handler {

class NaClContentHandler : public mojo::ApplicationDelegate,
                           public mojo::ContentHandlerFactory::Delegate {
 public:
  NaClContentHandler() : content_handler_factory_(this) {}

 private:
  // Overridden from ApplicationDelegate:
  void Initialize(mojo::ApplicationImpl* app) override {}

  // Overridden from ApplicationDelegate:
  bool ConfigureIncomingConnection(
      mojo::ApplicationConnection* connection) override {
    connection->AddService(&content_handler_factory_);
    return true;
  }

  // Overridden from ContentHandlerFactory::Delegate:
  void RunApplication(
      mojo::InterfaceRequest<mojo::Application> application_request,
      mojo::URLResponsePtr response) override {
    // Needed to use Mojo interfaces on this thread.
    base::MessageLoop loop(mojo::common::MessagePumpMojo::Create());
    // Acquire the nexe.
    base::ScopedFILE nexe_fp =
        mojo::common::BlockingCopyToTempFile(response->body.Pass());
    if (!nexe_fp) {
      LOG(FATAL) << "Could not redirect nexe to temp file";
    }
    FILE* nexe_file_stream = nexe_fp.release();
    int fd = fileno(nexe_file_stream);
    if (fd == -1) {
      LOG(FATAL) << "Could not open the stream pointer's file descriptor";
    }
    fd = dup(fd);
    if (fd == -1) {
      LOG(FATAL) << "Could not dup the file descriptor";
    }
    if (fclose(nexe_file_stream)) {
      LOG(FATAL) << "Failed to close temp file";
    }

    MojoHandle handle =
        application_request.PassMessagePipe().release().value();
    // MojoLaunchNexeNonsfi takes ownership of the fd.
    MojoLaunchNexeNonsfi(fd, handle, false /* enable_translation_irt */);
  }

  mojo::ContentHandlerFactory content_handler_factory_;

  DISALLOW_COPY_AND_ASSIGN(NaClContentHandler);
};

}  // namespace content_handler
}  // namespace nacl

MojoResult MojoMain(MojoHandle application_request) {
  mojo::ApplicationRunnerChromium runner(
      new nacl::content_handler::NaClContentHandler());
  return runner.Run(application_request);
}
