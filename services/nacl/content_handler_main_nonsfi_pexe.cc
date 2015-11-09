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
#include "mojo/public/cpp/bindings/array.h"
#include "mojo/services/files/c/lib/template_util.h"
#include "services/nacl/pnacl_compile.mojom.h"
#include "services/nacl/pnacl_link.mojom.h"

namespace nacl {
namespace content_handler {
namespace {

class CompilerUI {
 public:
  explicit CompilerUI(mojo::ScopedMessagePipeHandle handle) {
    compiler_.Bind(mojo::InterfacePtrInfo<mojo::nacl::PexeCompiler>(
        handle.Pass(), 0u));
  }

  // Synchronous method to compile pexe into object file.
  mojo::Array<mojo::String> CompilePexe(mojo::String pexe_file_path) {
    mojo::Array<mojo::String> output;
    compiler_->PexeCompile(pexe_file_path, mojio::Capture(&output));
    CHECK(compiler_.WaitForIncomingResponse())
        << "Waiting for pexe compiler failed";
    return output;
  }

 private:
  mojo::nacl::PexeCompilerPtr compiler_;
};

class LinkerUI {
 public:
  explicit LinkerUI(mojo::ScopedMessagePipeHandle handle) {
    linker_.Bind(mojo::InterfacePtrInfo<mojo::nacl::PexeLinker>(
        handle.Pass(), 0u));
  }

  // Synchronous method to link object file into nexe.
  mojo::String LinkPexe(mojo::Array<mojo::String> object_file_paths) {
    mojo::String output;
    linker_->PexeLink(std::move(object_file_paths), mojio::Capture(&output));
    CHECK(linker_.WaitForIncomingResponse())
        << "Waiting for pexe linker failed";
    return output;
  }

 private:
  mojo::nacl::PexeLinkerPtr linker_;
};

}  // namespace anonymous

class PexeContentHandler : public mojo::ApplicationDelegate,
                           public mojo::ContentHandlerFactory::Delegate {
 public:
  PexeContentHandler() : content_handler_factory_(this) {}

 private:
  // Overridden from ApplicationDelegate:
  void Initialize(mojo::ApplicationImpl* app) override {
    app->ConnectToService("mojo:pnacl_compile", &compiler_init_);
    app->ConnectToService("mojo:pnacl_link", &linker_init_);
  }

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
    // Create temporary file for pexe
    base::FilePath pexe_file_path;
    FILE* pexe_fp = CreateAndOpenTemporaryFile(&pexe_file_path);
    CHECK(pexe_fp) << "Could not create temporary file for pexe";
    // Acquire the pexe.
    CHECK(mojo::common::BlockingCopyToFile(response->body.Pass(), pexe_fp))
        << "Could not copy pexe to file";
    CHECK_EQ(fclose(pexe_fp), 0) << "Could not close pexe file";

    // Compile the pexe into an object file
    mojo::ScopedMessagePipeHandle parent_compile_pipe;
    mojo::ScopedMessagePipeHandle child_compile_pipe;
    CHECK_EQ(CreateMessagePipe(nullptr, &parent_compile_pipe,
                               &child_compile_pipe), MOJO_RESULT_OK)
        << "Could not create message pipe to compiler";
    compiler_init_->PexeCompilerStart(child_compile_pipe.Pass());

    // Communicate with the compiler using a mojom interface.
    CompilerUI compiler_ui(parent_compile_pipe.Pass());
    mojo::Array<mojo::String> object_files =
        compiler_ui.CompilePexe(pexe_file_path.value());

    // Link the object file into a nexe
    mojo::ScopedMessagePipeHandle parent_link_pipe;
    mojo::ScopedMessagePipeHandle child_link_pipe;
    CHECK_EQ(CreateMessagePipe(nullptr, &parent_link_pipe, &child_link_pipe),
             MOJO_RESULT_OK) << "Could not create message pipe to linker";
    linker_init_->PexeLinkerStart(child_link_pipe.Pass());

    // Communicate with the linker using a mojom interface.
    LinkerUI linker_ui(parent_link_pipe.Pass());
    mojo::String nexe_file = linker_ui.LinkPexe(std::move(object_files));

    // Open the nexe file and launch it (with our mojo handle)
    int nexe_fd = open(nexe_file.get().c_str(), O_RDONLY);
    CHECK(!unlink(nexe_file.get().c_str()))
        << "Could not unlink temporary nexe file";
    CHECK_GE(nexe_fd, 0) << "Could not open nexe object file";

    // Pass the handle connecting us with mojo_shell to the nexe.
    MojoHandle handle = application_request.PassMessagePipe().release().value();
    ::nacl::MojoLaunchNexeNonsfi(nexe_fd, handle,
                                 false /* enable_translation_irt */);
  }

 private:
  mojo::ContentHandlerFactory content_handler_factory_;
  mojo::nacl::PexeCompilerInitPtr compiler_init_;
  mojo::nacl::PexeLinkerInitPtr linker_init_;

  DISALLOW_COPY_AND_ASSIGN(PexeContentHandler);
};

}  // namespace content_handler
}  // namespace nacl

MojoResult MojoMain(MojoHandle application_request) {
  mojo::ApplicationRunnerChromium runner(
      new nacl::content_handler::PexeContentHandler());
  return runner.Run(application_request);
}
