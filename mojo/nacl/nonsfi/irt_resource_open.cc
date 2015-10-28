// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <fcntl.h>

#include "base/files/file_util.h"
#include "base/path_service.h"
#include "mojo/nacl/nonsfi/irt_mojo_nonsfi.h"
#include "native_client/src/untrusted/irt/irt_dev.h"

namespace {

int IrtOpenResource(const char* filename, int* newfd) {
  base::FilePath path;
  if (!PathService::Get(base::DIR_MODULE, &path))
    return ENOENT;
  path = path.Append("pnacl_translation_files");
  if (strcmp(filename, "libpnacl_irt_shim.a"))
    path = path.Append(filename);
  else
    path = path.Append("libpnacl_irt_shim_dummy.a");
  int rv = open(path.value().c_str(), O_RDONLY);
  if (rv < 0)
    return errno;
  *newfd = rv;
  return 0;
}

}  // namespace anonymous

namespace nacl {

const struct nacl_irt_resource_open nacl_irt_resource_open = {
  IrtOpenResource,
};

}  // namespace nacl
