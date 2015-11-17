// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package org.chromium.mojo.vsync;

import android.os.Handler;
import android.os.Looper;
import android.view.Choreographer;

import org.chromium.mojo.system.Core;
import org.chromium.mojo.system.MojoException;
import org.chromium.mojo.system.RunLoop;
import org.chromium.mojom.vsync.VSyncProvider;

/**
 * Android implementation of VSyncProvider.
 */
public class VSyncProviderImpl implements VSyncProvider, Choreographer.FrameCallback {
    private final RunLoop mRunLoop;
    private Choreographer mChoreographer;
    private AwaitVSyncResponse mCallback;
    private Binding mBinding = null;

    public VSyncProviderImpl(Core core, Looper looper) {
        mRunLoop = core.getCurrentRunLoop();
        // The choreographer must be initialized on a thread with a looper.
        new Handler(looper).post(new Runnable() {
            @Override
            public void run() {
                final Choreographer choreographer = Choreographer.getInstance();
                mRunLoop.postDelayedTask(new Runnable() {
                    @Override
                    public void run() {
                        mChoreographer = choreographer;
                        if (mCallback != null) {
                            mChoreographer.postFrameCallback(VSyncProviderImpl.this);
                        }
                    }
                }, 0);
            }
        });
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
        if (mChoreographer != null) {
            // Posting from another thread is allowed on a choreographer.
            mChoreographer.postFrameCallback(this);
        }
    }

    @Override
    public void doFrame(final long frameTimeNanos) {
        mRunLoop.postDelayedTask(new Runnable() {
            @Override
            public void run() {
                mCallback.call(frameTimeNanos / 1000);
                mCallback = null;
            }
        }, 0);
    }
}
