// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package org.chromium.mojo.vsync;

import android.view.Choreographer;

import org.chromium.mojo.system.MojoException;
import org.chromium.mojom.vsync.VSyncProvider;

/**
 * Android implementation of VSyncProvider.
 */
public class VSyncProviderImpl implements VSyncProvider, Choreographer.FrameCallback {
    private final Choreographer mChoreographer;
    private AwaitVSyncResponse mCallback;
    private Binding mBinding = null;

    public VSyncProviderImpl() {
        mChoreographer = Choreographer.getInstance();
    }

    public void setBinding(Binding binding) {
        if (mBinding != null) {
            mBinding.unbind().close();
        }
        mBinding = binding;
    }

    @Override
    public void close() {}

    @Override
    public void onConnectionError(MojoException e) {}

    @Override
    public void awaitVSync(final AwaitVSyncResponse callback) {
        if (mCallback != null) {
            setBinding(null);
            return;
        }
        mCallback = callback;
        mChoreographer.postFrameCallback(this);
    }

    @Override
    public void doFrame(final long frameTimeNanos) {
        mCallback.call(frameTimeNanos / 1000);
        mCallback = null;
    }
}
