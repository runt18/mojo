// Copyright 2013 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SHELL_TASK_RUNNERS_H_
#define SHELL_TASK_RUNNERS_H_

#include "base/macros.h"
#include "base/memory/ref_counted.h"
#include "base/memory/scoped_ptr.h"
#include "base/single_thread_task_runner.h"
#include "base/threading/thread.h"
#include "mojo/edk/embedder/platform_task_runner.h"
#include "mojo/edk/util/ref_ptr.h"

namespace base {
class SequencedWorkerPool;
}

namespace shell {

// A context object that contains the common task runners for the shell's main
// process.
class TaskRunners {
 public:
  explicit TaskRunners(
      const scoped_refptr<base::SingleThreadTaskRunner>& shell_runner);
  ~TaskRunners();

  const mojo::util::RefPtr<mojo::embedder::PlatformTaskRunner>& shell_runner()
      const {
    return shell_runner_;
  }

  const mojo::util::RefPtr<mojo::embedder::PlatformTaskRunner>& io_runner()
      const {
    return io_runner_;
  }

  base::SequencedWorkerPool* blocking_pool() const {
    return blocking_pool_.get();
  }

 private:
  mojo::util::RefPtr<mojo::embedder::PlatformTaskRunner> shell_runner_;
  scoped_ptr<base::Thread> io_thread_;
  mojo::util::RefPtr<mojo::embedder::PlatformTaskRunner> io_runner_;

  scoped_refptr<base::SequencedWorkerPool> blocking_pool_;

  DISALLOW_COPY_AND_ASSIGN(TaskRunners);
};

}  // namespace shell

#endif  // SHELL_TASK_RUNNERS_H_
