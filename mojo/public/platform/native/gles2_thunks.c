// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/public/platform/native/gles2_thunks.h"

#include <assert.h>

#include "mojo/public/platform/native/thunk_export.h"

static struct MojoGLES2ControlThunks g_control_thunks = {0};

MojoGLES2Context MojoGLES2CreateContext(
    MojoHandle handle,
    MojoGLES2ContextLost lost_callback,
    void* closure,
    const struct MojoAsyncWaiter* async_waiter) {
  assert(g_control_thunks.GLES2CreateContext);
  return g_control_thunks.GLES2CreateContext(handle, lost_callback, closure,
                                             async_waiter);
}

void MojoGLES2DestroyContext(MojoGLES2Context context) {
  assert(g_control_thunks.GLES2DestroyContext);
  g_control_thunks.GLES2DestroyContext(context);
}

void MojoGLES2MakeCurrent(MojoGLES2Context context) {
  assert(g_control_thunks.GLES2MakeCurrent);
  g_control_thunks.GLES2MakeCurrent(context);
}

void MojoGLES2SwapBuffers() {
  assert(g_control_thunks.GLES2SwapBuffers);
  g_control_thunks.GLES2SwapBuffers();
}

void* MojoGLES2GetGLES2Interface(MojoGLES2Context context) {
  assert(g_control_thunks.GLES2GetGLES2Interface);
  return g_control_thunks.GLES2GetGLES2Interface(context);
}

void MojoGLES2SignalSyncPoint(MojoGLES2Context context,
                              uint32_t sync_point,
                              MojoGLES2SignalSyncPointCallback callback,
                              void* closure) {
  assert(g_control_thunks.GLES2SignalSyncPoint);
  g_control_thunks.GLES2SignalSyncPoint(context, sync_point, callback, closure);
}

THUNK_EXPORT size_t MojoSetGLES2ControlThunks(
    const struct MojoGLES2ControlThunks* gles2_control_thunks) {
  if (gles2_control_thunks->size >= sizeof(g_control_thunks))
    g_control_thunks = *gles2_control_thunks;
  return sizeof(g_control_thunks);
}
