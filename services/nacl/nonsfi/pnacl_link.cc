// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/logging.h"
#include "mojo/nacl/nonsfi/nexe_launcher_nonsfi.h"
#include "mojo/nacl/nonsfi/temporary_file_util.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_connection.h"
#include "mojo/public/cpp/application/application_delegate.h"
#include "mojo/public/cpp/application/application_runner.h"
#include "mojo/public/cpp/application/interface_factory.h"
#include "mojo/public/cpp/bindings/strong_binding.h"
#include "services/nacl/nonsfi/kLdNexe.h"
#include "services/nacl/nonsfi/pnacl_link.mojom.h"

namespace mojo {
namespace nacl {

class PexeLinkerImpl : public PexeLinkerInit {
 public:
  void PexeLinkerStart(ScopedMessagePipeHandle handle) override {
    int nexe_fd = ::nacl::DataToTempFileDescriptor(::nacl::kLdNexe);
    CHECK(nexe_fd >= 0) << "Could not open linker nexe";
    ::nacl::MojoLaunchNexeNonsfi(nexe_fd,
                                 handle.release().value(),
                                 true /* enable_translate_irt */);
  }
};

class StrongBindingPexeLinkerImpl : public PexeLinkerImpl {
 public:
  explicit StrongBindingPexeLinkerImpl(InterfaceRequest<PexeLinkerInit> request)
      : strong_binding_(this, request.Pass()) {}

 private:
  StrongBinding<PexeLinkerInit> strong_binding_;
};

class MultiPexeLinker : public ApplicationDelegate,
                        public InterfaceFactory<PexeLinkerInit> {
 public:
  MultiPexeLinker() {}

  // From ApplicationDelegate
  bool ConfigureIncomingConnection(ApplicationConnection* connection) override {
    connection->AddService<PexeLinkerInit>(this);
    return true;
  }

  // From InterfaceFactory
  void Create(ApplicationConnection* connection,
              InterfaceRequest<PexeLinkerInit> request) override {
    new StrongBindingPexeLinkerImpl(request.Pass());
  }
};

}  // namespace nacl
}  // namespace mojo

MojoResult MojoMain(MojoHandle application_request) {
  mojo::ApplicationRunner runner(new mojo::nacl::MultiPexeLinker());
  return runner.Run(application_request);
}
