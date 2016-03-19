#!/usr/bin/env python
# Copyright 2015 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

"""Build and optionally upload mojom_parser to Google Cloud Storage.

This script is used to build a new version of the mojom_parser binary for both
mac and linux and optionally upload them to Google Cloud Storage based on their
SHA1 digest. It operates in 2 steps:
  1) Invokes the Go compiler to build the mojom parser for all
  target os and architectures.
  2) If the --upload flag is specified, for each of the binaries built:
    i) Computes the sha1 digest of the binary file.
    ii) Uploads the file to Google Cloud Storage using the sha1 as the filename.
    iii) Updates a local file named "mojom_parser.sha1" to contain the sha1
    digest of the file that was uploaded. This allows "gclient sync" to download
    the file.

In order to use this script to upload a new version of the parser, you need:
- depot_tools in your path
- WRITE access to the bucket at
  https://console.developers.google.com/storage/browser/mojo/mojom_parser/.

If you want to hack on the parser and use your locally-built version, from the
Mojo source root directory do:
1) Run this script: mojom/mojom_parser/tools/build_mojom_parser.py
2) Copy the architecture-specific binary to the architecture-specific location:
For example for linux do:
cp mojom_parser_linux_amd64  \
mojo/public/tools/bindings/mojom_parser/bin/linux64/mojom_parser

This script will build for all architectures before it attempts to upload any
binary. If any of the builds fail, the whole script will abort and nothing will
be uploaded. This behavior can be overriden with the --keep-going flag.
"""

import argparse
import imp
import os
import shutil
import subprocess
import sys


class ParserBuilder(object):
  def __init__(self,
      src_root=None,
      go_tool=None,
      go_root=None,
      out_dir=None,
      upload=False,
      quiet=False):
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
      upload: If True, get the path to the depot tools as those are needed to
          upload only. If False, the upload method will fail.
      quiet: If True, do not print any messages on success.
    """
    if src_root:
      self._src_root = os.path.abspath(src_root)
    else:
      self._src_root = os.path.abspath(
          os.path.join(os.path.dirname(__file__), *([os.pardir] * 3)))
    assert os.path.exists(self._src_root)

    if go_tool:
      self._go_tool = os.path.abspath(go_tool)
    else:
      self._go_tool = os.path.join(self._src_root,
          'third_party', 'go', 'tool', 'linux_amd64', 'bin', 'go')
    assert os.path.exists(self._go_tool)

    if go_root:
      self._go_root = os.path.abspath(go_root)
    else:
      self._go_root = os.path.dirname(os.path.dirname(self._go_tool))
    assert os.path.exists(self._go_root)

    if not out_dir:
      out_dir = os.getcwd()
    self._out_dir = os.path.abspath(out_dir)

    self._depot_tools_path = None
    if upload:
      self._depot_tools_path = self._get_depot_tools_path(self._src_root)

    self._quiet = quiet

  def upload(self, target_os, target_arch):
    """Uploads the mojom parser that was just created for the given target.

    upload must have been set to True when creating this class.

    Args:
      target_os: Any value valid for GOOS.
      target_arch: Any value valid for GOARCH.

    Returns:
      0 if everything went well, something else otherwise.
    """
    assert self._depot_tools_path
    upload_result = self._upload_binary(target_os, target_arch)
    if upload_result != 0:
      return upload_result

    # Copy the generated sha1 file to the stamp_file location.
    target_dir = self._get_dir_name_for_arch(target_os, target_arch)
    sha1_file = '{0!s}.sha1'.format(self._get_output_path(target_os, target_arch))
    assert os.path.exists(sha1_file)
    stamp_file = os.path.join(self._src_root, 'mojo', 'public', 'tools',
        'bindings', 'mojom_parser', 'bin', target_dir, 'mojom_parser.sha1')
    shutil.move(sha1_file, stamp_file)
    self._info_print(
        "Wrote stamp file {0!s}. You probably want to commit this.".format(stamp_file))

    return 0

  def build_parser(self, target_os, target_arch):
    """Builds the mojom parser for target_os and target_arch.

    Args:
      target_os: Any value valid for GOOS.
      target_arch: Any value valid for GOARCH.

    Returns:
      The go tool's return value.
    """
    out_path = self._get_output_path(target_os, target_arch)

    environ = {
        'GOROOT': self._go_root,
        'GOPATH': os.path.dirname(self._src_root),
        'GOOS': target_os,
        'GOARCH': target_arch,
        }

    save_cwd = os.getcwd()
    os.chdir(os.path.join(self._src_root, 'mojom', 'mojom_parser'))
    self._info_print(
        "Building the Mojom parser for {0!s} {1!s}...".format(target_os, target_arch))
    result = subprocess.call(
        [self._go_tool, 'build', '-o', out_path] , env=environ)
    if result == 0:
      self._info_print("Success! Built {0!s}".format(out_path))
    else:
      print >> sys.stderr, "Failure building Mojom parser for {0!s} {1!s}!".format(
          target_os, target_arch)

    os.chdir(save_cwd)

    return result

  def _upload_binary(self, target_os, target_arch):
    """Computes the sha1 digest of the contents of the specified binary, then
    uploads the contents of the file at that path to the Google Cloud Storage
    bucket "mojo" using the filename "mojom_parser/$%target/$sha1." $target
    is computed based upon the target_os and target_arch. A file whose name is
    the name of the binary with .sha1 appended is created containing the sha1.

    This method will only work if self._depot_tools_path has been set.
    """
    assert self._depot_tools_path
    upload_script = os.path.abspath(os.path.join(self._depot_tools_path,
        "upload_to_google_storage.py"))
    out_path = self._get_output_path(target_os, target_arch)
    assert os.path.exists(out_path)

    cloud_path = 'mojo/mojom_parser/{0!s}'.format(self._get_dir_name_for_arch(
        target_os, target_arch))

    upload_cmd = ['python', upload_script, out_path, '-b', cloud_path]

    stdout = None
    if self._quiet:
      stdout = open(os.devnull, 'w')
    self._info_print(
        "Uploading mojom_parser ({0!s},{1!s}) to GCS...".format(target_os, target_arch))
    return subprocess.call(upload_cmd, stdout=stdout)

  def _get_dir_name_for_arch(self, target_os, target_arch):
    dir_names = {
        ('darwin', 'amd64'): 'mac64',
        ('linux', 'amd64'): 'linux64',
        }
    return dir_names[(target_os, target_arch)]

  def _get_output_path(self, target_os, target_arch):
    return os.path.join(self._out_dir,
                        'mojom_parser_{0!s}_{1!s}'.format(target_os, target_arch))

  def _get_depot_tools_path(self, src_root):
    name = 'find_depot_tools'
    find_depot_tools = imp.load_source(name,
        os.path.join(src_root, 'tools', name + '.py'))
    return find_depot_tools.add_depot_tools_to_path()

  def _info_print(self, message):
    if self._quiet:
      return
    print message


def main():
  parser = argparse.ArgumentParser(description="Build the mojom parser.")
  parser.add_argument('--src-root', dest='src_root', action='store',
                      help='Path to the source tree. (optional)')
  parser.add_argument('--go-tool', dest='go_tool', action='store',
                      help='Path to the go tool. (optional)')
  parser.add_argument('--go-root', dest='go_root', action='store',
                      help='Path to the root of the go installation. '
                           '(optional)')
  parser.add_argument('--out-dir', dest='out_dir', action='store',
                      help='Directory in which to place the built parser. '
                           'Defaults to the current working directory. '
                           '(optional)')
  parser.add_argument('--upload', dest='upload', action='store_true',
                      default=False,
                      help='Upload the built binaries to Google Cloud Storage '
                           'and update the corresponding hash files locally.')
  parser.add_argument('--keep-going', dest='keep_going', action='store_true',
                      default=False,
                      help='Instead of stopping when encountering a failure '
                           'move on to the next step.')
  parser.add_argument('--quiet', dest='quiet', action='store_true',
                      default=False,
                      help='Do not output anything on success.')
  args = parser.parse_args()
  parser_builder = ParserBuilder(
      src_root=args.src_root,
      go_tool=args.go_tool,
      go_root=args.go_root,
      out_dir=args.out_dir,
      upload=args.upload,
      quiet=args.quiet)

  targets = [
      ('darwin', 'amd64'),
      ('linux', 'amd64'),
      ]
  final_result = 0
  # First we build the mojom parser for each target.
  for target_os, target_arch in targets:
    result = parser_builder.build_parser(target_os, target_arch)
    if result != 0:
      final_result = result
      if not args.keep_going:
        return result

  # Then we upload each target.
  if args.upload:
    for target_os, target_arch in targets:
      result = parser_builder.upload(target_os, target_arch)
      if result != 0:
        final_result = result
        if not args.keep_going:
          return result

  return final_result


if __name__ == '__main__':
  sys.exit(main())
