// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/edk/system/cond_var.h"

#include <stdint.h>
#include <stdlib.h>

#include <thread>
#include <type_traits>
#include <vector>

#include "mojo/edk/system/mutex.h"
#include "mojo/edk/system/test_utils.h"
#include "mojo/public/cpp/system/macros.h"
#include "testing/gtest/include/gtest/gtest.h"

namespace mojo {
namespace system {
namespace {

// Sleeps for a "very small" amount of time.
void EpsilonRandomSleep() {
  test::Sleep(test::DeadlineFromMilliseconds(rand() % 20));
}

// We'll use |MojoDeadline| with |uint64_t| (for |CondVar::WaitWithTimeout()|'s
// timeout argument), though note that |WaitWithTimeout()| doesn't support
// |MOJO_DEADLINE_INDEFINITE|.
static_assert(std::is_same<uint64_t, MojoDeadline>::value,
              "MojoDeadline isn't uint64_t!");

TEST(CondVarTest, Basic) {
  // Create/destroy.
  { CondVar cv; }

  // Signal with no waiter.
  {
    CondVar cv;
    cv.Signal();
    cv.SignalAll();
  }

  // Wait with a zero and with very short timeout.
  {
    Mutex mu;
    CondVar cv;

    MutexLocker locker(&mu);

    // Note: Theoretically, pthreads is allowed to wake us up spuriously, in
    // which case |WaitWithTimeout()| would return false. (This would also
    // happen if we're interrupted, e.g., by ^Z.)
    EXPECT_TRUE(cv.WaitWithTimeout(&mu, 0));
    mu.AssertHeld();
    EXPECT_TRUE(cv.WaitWithTimeout(&mu, test::DeadlineFromMilliseconds(1)));
    mu.AssertHeld();
  }

  // Wait using |Wait()| or |WaitWithTimeout()|, to be signalled by |Signal()|
  // or |SignalAll()|.
  for (size_t i = 0; i < 30; i++) {
    Mutex mu;
    CondVar cv;
    bool condition = false;

    auto thread = std::thread([&mu, &cv, &condition]() {
      EpsilonRandomSleep();

      MutexLocker locker(&mu);
      condition = true;
      if (rand() % 2 == 0)
        cv.Signal();
      else
        cv.SignalAll();
    });

    EpsilonRandomSleep();

    MutexLocker locker(&mu);
    if (rand() % 2 == 0) {
      while (!condition) {
        cv.Wait(&mu);
        mu.AssertHeld();
      }
    } else {
      while (!condition) {
        EXPECT_FALSE(cv.WaitWithTimeout(&mu, test::TinyDeadline()));
        mu.AssertHeld();
      }
    }

    thread.join();
  }
}

TEST(CondVarTest, SignalAll) {
  Mutex mu;
  CondVar cv;
  bool condition = false;

  for (size_t i = 0; i < 10; i++) {
    for (size_t num_waiters = 1; i < 5; i++) {
      std::vector<std::thread> threads;
      for (size_t i = 0; i < num_waiters; i++) {
        threads.push_back(std::thread([&mu, &cv, &condition]() {
          EpsilonRandomSleep();

          MutexLocker locker(&mu);
          if (rand() % 2 == 0) {
            while (!condition) {
              cv.Wait(&mu);
              mu.AssertHeld();
            }
          } else {
            while (!condition) {
              EXPECT_FALSE(cv.WaitWithTimeout(&mu, test::TinyDeadline()));
              mu.AssertHeld();
            }
          }
        }));
      }

      EpsilonRandomSleep();

      {
        MutexLocker locker(&mu);
        condition = true;
        cv.SignalAll();
      }

      for (auto& thread : threads)
        thread.join();
    }
  }
}

TEST(CondVarTest, Timeouts) {
  static const unsigned kTestTimeoutsMs[] = {0, 10, 20, 40, 80, 160};

  test::Stopwatch stopwatch;

  Mutex mu;
  CondVar cv;

  MutexLocker locker(&mu);

  for (size_t i = 0; i < MOJO_ARRAYSIZE(kTestTimeoutsMs); i++) {
    uint64_t timeout = test::DeadlineFromMilliseconds(kTestTimeoutsMs[i]);

    stopwatch.Start();
    // See note in CondVarTest.Basic about spurious wakeups.
    EXPECT_TRUE(cv.WaitWithTimeout(&mu, timeout));
    MojoDeadline elapsed = stopwatch.Elapsed();

    // It should time out after *at least* the specified amount of time.
    EXPECT_GE(elapsed, timeout);
    // But we expect that it should time out soon after that amount of time.
    EXPECT_LT(elapsed, timeout + test::EpsilonDeadline());
  }
}

// TODO(vtl): Test that |Signal()| (usually) wakes only one waiter.

}  // namespace
}  // namespace system
}  // namespace mojo
