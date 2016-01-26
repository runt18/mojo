// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// This is the "main" for the embeddable Moterm terminal view, which provides
// services to the thing embedding it. (This is not very useful as a "top-level"
// application.)

#include "apps/moterm/moterm_app.h"
#include "mojo/application/application_runner_chromium.h"
#include "mojo/public/c/system/main.h"

MojoResult MojoMain(MojoHandle application_request) {
  mojo::ApplicationRunnerChromium runner(new MotermApp());
  return runner.Run(application_request);
}
