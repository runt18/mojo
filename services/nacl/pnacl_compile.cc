// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <fcntl.h>

#include "base/at_exit.h"
#include "base/files/file_util.h"
#include "base/path_service.h"
#include "mojo/nacl/nonsfi/nexe_launcher_nonsfi.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_connection.h"
#include "mojo/public/cpp/application/application_delegate.h"
#include "mojo/public/cpp/application/application_runner.h"
#include "mojo/public/cpp/application/interface_factory.h"
#include "mojo/public/cpp/bindings/strong_binding.h"
#include "services/nacl/pnacl_compile.mojom.h"

namespace mojo {
namespace nacl {

class PexeCompilerImpl : public PexeCompilerInit {
 public:
  void PexeCompilerStart(ScopedMessagePipeHandle handle) override {
    base::FilePath path;
    if (!PathService::Get(base::DIR_MODULE, &path))
      LOG(FATAL) << "Could not find mojo root directory";
    path = path.Append("pnacl_translation_files/pnacl-llc.nexe");
    int nexe_fd = open(path.value().c_str(), O_RDONLY);
    if (nexe_fd < 0)
      LOG(FATAL) << "Could not open compiler nexe: " << path.value();
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
  base::AtExitManager at_exit;
  mojo::ApplicationRunner runner(new mojo::nacl::MultiPexeCompiler());
  return runner.Run(application_request);
}
