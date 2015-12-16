#!/usr/bin/env python
# Copyright 2015 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

# This script will build the mojom parser for both mac and linux.

import argparse
import subprocess
import sys
import os


def get_parser_builder(src_root=None, go_tool=None, go_root=None, out_dir=None):
  """Builds a parser building function.

  Args:
    src_root: Path to the root of the source tree. (If None, the path of the
        directory 3 levels above the one containing this script is used.)
    go_tool: Path to the go tool.
        (If None, uses {src_root}/third_party/go/tool/linux_amd64/bin/go)
    go_root: Path to the root of the go installation.
        (If None, uses the directory containing the go tool.)
    out_dir: Path to the directory in which the built parser should be placed.
        (If None, uses the current working directory.)

  Returns:
    A function which accepts a compilation target and builds the parser for it.
  """
  if src_root:
    src_root = os.path.abspath(src_root)
  else:
    src_root = os.path.abspath(
        os.path.join(os.path.dirname(__file__), *([os.pardir] * 3)))
  assert os.path.exists(src_root)

  if go_tool:
    go_tool = os.path.abspath(go_tool)
  else:
    go_tool = os.path.join(src_root,
        'third_party', 'go', 'tool', 'linux_amd64', 'bin', 'go')
  assert os.path.exists(go_tool)

  if go_root:
    go_root = os.path.abspath(go_root)
  else:
    go_root = os.path.dirname(os.path.dirname(go_tool))
  assert os.path.exists(go_root)

  if not out_dir:
    out_dir = os.getcwd()
  out_dir = os.path.abspath(out_dir)

  def _build_parser(target_os, target_arch):
    """Builds the mojom parser for target_os and target_arch.

    Args:
      target_os: Any value valid for GOOS.
      target_arch: Any value valid for GOARCH.

    Returns:
      The go tool's return value.
    """
    output = os.path.join(out_dir,
                          'mojom_parser_%s_%s' % (target_os, target_arch))

    environ = {
        'GOROOT': go_root,
        'GOPATH': os.path.dirname(src_root),
        'GOOS': target_os,
        'GOARCH': target_arch,
        }

    save_cwd = os.getcwd()
    os.chdir(os.path.join(src_root, 'mojom', 'mojom_parser'))
    result = subprocess.call([go_tool, 'build', '-o', output] , env=environ)

    os.chdir(save_cwd)

    return result

  return _build_parser


def main():
  parser = argparse.ArgumentParser(description="Build the mojom parser.")
  parser.add_argument('--src-root', dest='src_root', action='store',
                      help='Path to the source tree. (optional)')
  parser.add_argument('--go-tool', dest='go_tool', action='store',
                      help='Path to the go tool. (optional)')
  parser.add_argument('--go-root', dest='go_root', action='store',
                      help='Path to the root of the go installation.'
                           ' (optional')
  parser.add_argument('--out-dir', dest='out_dir', action='store',
                      help='Directory in which to place the built parser.'
                           ' (optional)')
  args = parser.parse_args()
  build_parser = get_parser_builder(
      src_root=args.src_root,
      go_tool=args.go_tool,
      go_root=args.go_root,
      out_dir=args.out_dir)

  targets = [
      ('darwin', 'amd64'),
      ('linux', 'amd64'),
      ]
  for target_os, target_arch in targets:
    result = build_parser(target_os, target_arch)
    if result != 0:
      return result

  return 0


if __name__ == '__main__':
  sys.exit(main())
