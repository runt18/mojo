// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package org.chromium.mojo.shell;

import android.os.Looper;

import org.chromium.mojo.application.ServiceFactoryBinder;
import org.chromium.mojo.bindings.InterfaceRequest;
import org.chromium.mojo.system.impl.CoreImpl;
import org.chromium.mojo.vsync.VSyncProviderImpl;
import org.chromium.mojom.vsync.VSyncProvider;

/**
 * A ServiceFactoryBinder for the vsync service.
 */
final class VsyncFactory implements ServiceFactoryBinder<VSyncProvider> {
    private final Looper mLooper;

    public VsyncFactory(Looper looper) {
        mLooper = looper;
    }

    @Override
    public void bind(InterfaceRequest<VSyncProvider> request) {
        VSyncProviderImpl implementation = new VSyncProviderImpl(CoreImpl.getInstance(), mLooper);
        implementation.setBinding(VSyncProvider.MANAGER.bind(implementation, request));
    }

    @Override
    public String getInterfaceName() {
        return VSyncProvider.MANAGER.getName();
    }
}
