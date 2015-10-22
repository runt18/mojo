// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/edk/system/mutex.h"

#if !defined(NDEBUG) || defined(DCHECK_ALWAYS_ON)
#include <errno.h>
#include <string.h>

#include "base/logging.h"

namespace mojo {
namespace system {

Mutex::Mutex() {
  pthread_mutexattr_t attr;
  int error = pthread_mutexattr_init(&attr);
  DCHECK(!error) << "pthread_mutexattr_init: " << strerror(error);
  error = pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_ERRORCHECK);
  DCHECK(!error) << "pthread_mutexattr_settype: " << strerror(error);
  error = pthread_mutex_init(&impl_, &attr);
  DCHECK(!error) << "pthread_mutex_init: " << strerror(error);
  error = pthread_mutexattr_destroy(&attr);
  DCHECK(!error) << "pthread_mutexattr_destroy: " << strerror(error);
}

Mutex::~Mutex() {
  int error = pthread_mutex_destroy(&impl_);
  DCHECK(!error) << "pthread_mutex_destroy: " << strerror(error);
}

void Mutex::Lock() MOJO_EXCLUSIVE_LOCK_FUNCTION() {
  int error = pthread_mutex_lock(&impl_);
  DCHECK(!error) << "pthread_mutex_lock: " << strerror(error);
}

void Mutex::Unlock() MOJO_UNLOCK_FUNCTION() {
  int error = pthread_mutex_unlock(&impl_);
  DCHECK(!error) << "pthread_mutex_unlock: " << strerror(error);
}

bool Mutex::TryLock() MOJO_EXCLUSIVE_TRYLOCK_FUNCTION(true) {
  int error = pthread_mutex_trylock(&impl_);
  DCHECK(!error || error == EBUSY) << "pthread_mutex_trylock: "
                                   << strerror(error);
  return !error;
}

void Mutex::AssertHeld() MOJO_ASSERT_EXCLUSIVE_LOCK() {
  int error = pthread_mutex_lock(&impl_);
  DCHECK_EQ(error, EDEADLK) << ". pthread_mutex_lock: " << strerror(error);
}

}  // namespace system
}  // namespace mojo

#endif  // !defined(NDEBUG) || defined(DCHECK_ALWAYS_ON)
