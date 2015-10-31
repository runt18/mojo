// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <fcntl.h>

#include "base/files/file_util.h"
#include "base/logging.h"
#include "mojo/nacl/nonsfi/irt_mojo_nonsfi.h"
#include "mojo/public/cpp/bindings/string.h"
#include "mojo/public/cpp/bindings/strong_binding.h"
#include "mojo/public/cpp/utility/run_loop.h"
#include "native_client/src/untrusted/irt/irt_dev.h"
#include "services/nacl/pnacl_compile.mojom.h"

namespace {

// Implements a mojom interface which allows the content handler to communicate
// with the nexe compiler service.
class PexeCompilerImpl : public mojo::nacl::PexeCompiler {
 public:
  PexeCompilerImpl(mojo::ScopedMessagePipeHandle handle,
                   const struct nacl_irt_pnacl_compile_funcs* funcs)
      : funcs_(funcs), strong_binding_(this, handle.Pass()) {}
  void PexeCompile(const mojo::String& pexe_file_name,
                   const mojo::Callback<void(mojo::String)>& callback)
      override {
    base::FilePath obj_file_name;
    if (!CreateTemporaryFile(&obj_file_name))
      LOG(FATAL) << "Could not make temporary object file";
    // TODO(smklein): Use multiple object files to increase parallelism.
    int obj_file_fd = open(obj_file_name.value().c_str(), O_RDWR, O_TRUNC);

    if (obj_file_fd < 0)
      LOG(FATAL) << "Could not create temp file for compiled pexe";

    // TODO(smklein): Is there a less arbitrary number to choose?
    uint32_t num_threads = 8;
    size_t obj_file_fd_count = 1;
    // Non-SFI mode requries PIC.
    char relocation_model[] = "-relocation-model=pic";
    // Since we are compiling pexes, the bitcode format is 'pnacl'.
    char bitcode_format[] = "-bitcode-format=pnacl";
    char* args[] = { relocation_model, bitcode_format, nullptr };
    size_t argc = 2;
    funcs_->init_callback(num_threads, &obj_file_fd, obj_file_fd_count,
                          args, argc);

    // Read the pexe using fread, and write the pexe into the callback function.
    static const size_t kBufferSize = 0x100000;
    scoped_ptr<char[]> buf(new char[kBufferSize]);
    FILE* pexe_file_stream = fopen(pexe_file_name.get().c_str(), "r");
    // Once the pexe has been opened, it is no longer needed, so we unlink it.
    if (unlink(pexe_file_name.get().c_str()))
      LOG(FATAL) << "Could not unlink temporary pexe file";
    if (pexe_file_stream == nullptr)
      LOG(FATAL) << "Could not open pexe for reading";
    for (;;) {
      size_t num_bytes_from_pexe = fread(buf.get(), 1, kBufferSize,
                                         pexe_file_stream);
      if (ferror(pexe_file_stream)) {
        LOG(FATAL) << "Error reading from pexe file stream";
      }
      if (num_bytes_from_pexe == 0) {
        break;
      }
      funcs_->data_callback(buf.get(), num_bytes_from_pexe);
    }
    buf.reset();

    if (fclose(pexe_file_stream))
      LOG(FATAL) << "Failed to close pexe file stream from compiler nexe";
    funcs_->end_callback();

    // Return the name of the object file.
    callback.Run(mojo::String(obj_file_name.value()));
    mojo::RunLoop::current()->Quit();
  }
 private:
  const struct nacl_irt_pnacl_compile_funcs* funcs_;
  mojo::StrongBinding<mojo::nacl::PexeCompiler> strong_binding_;
};

void ServeTranslateRequest(const struct nacl_irt_pnacl_compile_funcs* funcs) {
  // Acquire the handle -- this is our mechanism to contact the
  // content handler which called us.
  MojoHandle handle;
  nacl::MojoGetInitialHandle(&handle);

  // Convert the MojoHandle into a ScopedMessagePipeHandle, and use that to
  // implement the PexeCompiler interface.
  PexeCompilerImpl impl(
      mojo::ScopedMessagePipeHandle(mojo::MessagePipeHandle(handle)).Pass(),
      funcs);
  mojo::RunLoop::current()->Run();
}

}  // namespace anonymous

namespace nacl {

const struct nacl_irt_private_pnacl_translator_compile
    nacl_irt_private_pnacl_translator_compile = {
  ServeTranslateRequest
};

}  // namespace nacl
