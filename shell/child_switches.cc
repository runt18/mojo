// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "shell/child_switches.h"

namespace switches {

// The value of this switch is the string that should be given to
// |ConnectToMaster()| for its |platform_connection_id| argument.
const char kChildConnectionId[] = "child-connection-id";

// The value of this switch is the string that was produced by
// |PlatformChannelPair::PrepareToPassClientHandleToChildProcess()| and should
// be given to |PlatformChannelPair::PassClientHandleFromParentProcess()|.
const char kPlatformChannelHandleInfo[] = "platform-channel-handle-info";

}  // namespace switches
