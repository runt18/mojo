#!/usr/bin/env python
# Copyright 2014 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

"""A "smart" test runner for gtest unit tests (that caches successes)."""

import argparse
import logging
import os
import subprocess
import sys

from mopy import gtest
from mopy.config import Config
from mopy.gn import ConfigForGNArgs, ParseGNConfig
from mopy.log import InitLogging
from mopy.paths import Paths
from mopy.transitive_hash import file_hash, transitive_hash


_logger = logging.getLogger()
_paths = Paths()


def main():
  parser = argparse.ArgumentParser(
      description="A 'smart' test runner for gtest unit tests (that caches "
                  "successes).")

  parser.add_argument("--verbose", help="be verbose (multiple times for more)",
                      default=0, dest="verbose_count", action="count")
  parser.add_argument("--successes-cache",
                      help="the file caching test results (empty to not cache)",
                      default="mojob_test_successes")
  parser.add_argument("test_list_file",
                      help="the file containing the tests to run", type=file)
  parser.add_argument("root_dir", help="the build directory")
  args = parser.parse_args()

  InitLogging(args.verbose_count)
  config = ConfigForGNArgs(ParseGNConfig(args.root_dir))

  _logger.debug("Test list file: %s", args.test_list_file)
  execution_globals = {"config": config}
  exec args.test_list_file in execution_globals
  test_list = execution_globals["tests"]
  _logger.debug("Test list: {0!s}".format(test_list))

  print "Running tests in directory: {0!s}".format(args.root_dir)
  os.chdir(args.root_dir)

  if args.successes_cache:
    print "Successes cache file: {0!s}".format(args.successes_cache)
  else:
    print "No successes cache file (will run all tests unconditionally)"

  if args.successes_cache:
    # This file simply contains a list of transitive hashes of tests that
    # succeeded.
    try:
      _logger.debug("Trying to read successes cache file: %s",
                     args.successes_cache)
      with open(args.successes_cache, 'rb') as f:
        successes = set([x.strip() for x in f.readlines()])
      _logger.debug("Successes: %s", successes)
    except IOError:
      # Just assume that it didn't exist, or whatever.
      print ("Failed to read successes cache file {0!s} (will create)".format(
             args.successes_cache))
      successes = set()

  gtest.set_color()

  exit_code = 0
  successes_cache_file = (open(args.successes_cache, "ab")
      if args.successes_cache else None)
  for test_dict in test_list:
    test = test_dict["test"]
    test_name = test_dict.get("name", test)
    # TODO(vtl): Add type.
    cacheable = test_dict.get("cacheable", True)
    if not cacheable:
      _logger.debug("{0!s} is marked as non-cacheable".format(test_name))

    gtest_file = test
    if config.target_os == Config.OS_ANDROID:
      gtest_file = test + "_apk/" + test + "-debug.apk"

    if successes_cache_file and cacheable:
      _logger.debug("Getting transitive hash for {0!s} ... ".format(test_name))
      try:
        if config.target_os == Config.OS_ANDROID:
          gtest_hash = file_hash(gtest_file)
        else:
          gtest_hash = transitive_hash(gtest_file)
      except subprocess.CalledProcessError:
        print "Failed to get transitive hash for {0!s}".format(test_name)
        exit_code = 1
        continue
      _logger.debug("  Transitive hash: {0!s}".format(gtest_hash))

      if gtest_hash in successes:
        print "Skipping {0!s} (previously succeeded)".format(test_name)
        continue

    _logger.info("Will start: {0!s}".format(test_name))
    print "Running {0!s}....".format(test_name),
    sys.stdout.flush()
    try:
      if config.target_os == Config.OS_ANDROID:
        command = [
            "python",
            os.path.join(_paths.src_root, "build", "android", "test_runner.py"),
            "gtest",
            "--output-directory",
            args.root_dir,
            "-s",
            test,
        ]
      else:
        command = ["./" + test]
      _logger.debug("Command: {0!s}".format(command))
      subprocess.check_output(command, stderr=subprocess.STDOUT)
      print "Succeeded"
      # Record success.
      if args.successes_cache and cacheable:
        successes.add(gtest_hash)
        successes_cache_file.write(gtest_hash + "\n")
        successes_cache_file.flush()
    except subprocess.CalledProcessError as e:
      print "Failed with exit code {0:d} and output:".format(e.returncode)
      print 72 * "-"
      print e.output
      print 72 * "-"
      exit_code = 1
      continue
    except OSError as e:
      print "  Failed to start test"
      exit_code = 1
      continue
    _logger.info("Completed: {0!s}".format(test_name))
  if exit_code == 0:
    print "All tests succeeded"
  if successes_cache_file:
    successes_cache_file.close()

  return exit_code


if __name__ == "__main__":
  sys.exit(main())
