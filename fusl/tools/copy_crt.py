#!/usr/bin/env python
# Copyright 2016 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

"""A tool to populate the C runtime portions of a fusl sysroot. This
script primarily exists because it is easier to copy manually than to
teach GN how to treat .o files as first class outputs."""

import argparse
import os
import shutil
import sys

def copy_sysroot(args, files):
  try:
    os.makedirs(args.target)
  except OSError:
    # It already exists. Probably.
    pass

  for file in files:
    source_file = os.path.join(args.source, file)

  # Some source files will be under a subdirectory, so take the last
  # path component.
  _, stripped_file = os.path.split(source_file)
  # Strip out the prefix gn places for its object files.
  assert(stripped_file.startswith(args.gn_prefix))
  stripped_file = stripped_file[len(args.gn_prefix):]
  target_file = os.path.join(args.target, stripped_file)

  shutil.copyfile(source_file, target_file)


def parse():
  parser = argparse.ArgumentParser()

  parser.add_argument('--source',
                      required=True,
                      help='Source directory')
  parser.add_argument('--target',
                      required=True,
                      help='Target directory')
  parser.add_argument('--gn-prefix',
                      required=True,
                      help='File prefix added by GN')

  return parser.parse_known_args()


def main():
  args, files = parse()
  copy_sysroot(args, files)
  return 0


if __name__ == '__main__':
  sys.exit(main())
