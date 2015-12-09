// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/logging.h"
#include "mojo/nacl/nonsfi/file_util.h"
#include "mojo/nacl/nonsfi/nexe_launcher_nonsfi.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_connection.h"
#include "mojo/public/cpp/application/application_delegate.h"
#include "mojo/public/cpp/application/application_runner.h"
#include "mojo/public/cpp/application/interface_factory.h"
#include "mojo/public/cpp/bindings/strong_binding.h"
#include "services/nacl/nonsfi/kPnaclLlcNexe.h"
#include "services/nacl/nonsfi/pnacl_compile.mojom.h"

namespace mojo {
namespace nacl {

class PexeCompilerImpl : public PexeCompilerInit {
 public:
  void PexeCompilerStart(ScopedMessagePipeHandle handle) override {
    int nexe_fd = ::nacl::DataToTempFileDescriptor(::nacl::kPnaclLlcNexe);
    CHECK(nexe_fd >= 0) << "Could not open compiler nexe";
    ::nacl::MojoLaunchNexeNonsfi(nexe_fd,
                                 handle.release().value(),
                                 true /* enable_translate_irt */);
  }
};

class StrongBindingPexeCompilerImpl : public PexeCompilerImpl {
 public:
  explicit StrongBindingPexeCompilerImpl(InterfaceRequest<PexeCompilerInit>
                                         request)
      : strong_binding_(this, request.Pass()) {}

 private:
  StrongBinding<PexeCompilerInit> strong_binding_;
};

class MultiPexeCompiler : public ApplicationDelegate,
                          public InterfaceFactory<PexeCompilerInit> {
 public:
  MultiPexeCompiler() {}

  // From ApplicationDelegate
  bool ConfigureIncomingConnection(ApplicationConnection* connection) override {
    connection->AddService<PexeCompilerInit>(this);
    return true;
  }

  // From InterfaceFactory
  void Create(ApplicationConnection* connection,
              InterfaceRequest<PexeCompilerInit> request) override {
    new StrongBindingPexeCompilerImpl(request.Pass());
  }
};

}  // namespace nacl
}  // namespace mojo

MojoResult MojoMain(MojoHandle application_request) {
  mojo::ApplicationRunner runner(new mojo::nacl::MultiPexeCompiler());
  return runner.Run(application_request);
}
