#!/usr/bin/env python
# Copyright 2015 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

"""Upload mojom_parser to Google Cloud Storage based on SHA1 digest.

This script is used to upload a new version of the mojom_parser binary to
Google Cloud Storage. It operates in three steps:
i) Computes the sha1 digest of the binary file.
ii) Uploads the file to Google Cloud Storage using the sha1 as the file name.
iii) Updates a local file named "mojom_parser.sha1" to contain the sha1
digest of the file that was uploaded. This allows "gclient sync" to download
the file.

In order to use this script, you need:
- depot_tools in your path
- WRITE access to the bucket at
  https://console.developers.google.com/storage/browser/mojo/mojom_parser/.

To upload a new version of mojom_parser do the following:
1) Build a new version: ninja -C out/Release mojom/mojom_parser.
This creates a binary in out/Release called "moparse".
2) If necessary, run 'gsutil.py config' to update gsutil's credentials
3) Run this script: python mojom/mojom_parser/tools/upload_binary.py
4) Land a CL with the updated version of mojom_parser.sha1 that this
   script has modified. (Do not check-in the binary "mojom_parser" itself into
   source control.)
"""

import argparse
import os
import shutil
import subprocess
import sys

# We assume this script is located in <src>/mojom/mojom_parser/tools
TOOLS_DIR = os.path.abspath(os.path.dirname(__file__))
MOJOM_PARSER_DIR = os.path.abspath(os.path.join(TOOLS_DIR, os.pardir))
SRC_DIR = os.path.abspath(os.path.join(MOJOM_PARSER_DIR, os.pardir, os.pardir))
TOOLS_DIR = os.path.abspath(os.path.join(SRC_DIR, "tools"))
BIN_DIR = os.path.abspath(os.path.join(SRC_DIR,
  'mojo', 'public', 'tools', 'bindings', 'mojom_parser', 'bin'))
LINUX64_BIN_DIR = os.path.abspath(os.path.join(BIN_DIR, 'linux64'))

sys.path.insert(0, TOOLS_DIR)
import find_depot_tools

DEPOT_TOOLS_PATH = find_depot_tools.add_depot_tools_to_path()


def Upload(path_to_binary):
  """Computes the sha1 digest of the contents of the file at |path_to_binary|,
     then uploads the contents of the file at that path to the Google Cloud
     Storage bucket "mojo/mojom_parser", using the sha1 as the filename.
     A file named <path_to_binary>.sha1 is created containing the sha1."""
  # We invoke upload_to_google.storage.py from depot_tools.
  upload_script = os.path.abspath(os.path.join(DEPOT_TOOLS_PATH,
      "upload_to_google_storage.py"))
  upload_cmd = ['python', upload_script, path_to_binary,
                '-b', 'mojo/mojom_parser/linux64']

  print "Uploading mojom_parser to GCS..."
  subprocess.check_call(upload_cmd)


def UploadAndStamp(path_to_binary):
  """Computes the sha1 digest of the contents of the file at |path_to_binary|,
     then uploads the contents of the file at that path to the Google Cloud
     Storage bucket "mojo/mojom_parser", using the sha1 as the filename, then
     updates the contents of the file at <LINUX64_BIN_DIR>/mojom_parser.sha1
     to contain the sha1."""

  Upload(path_to_binary)

  # Copy the generated sha1 file to the stamp_file location.
  sha1_file = "%s.sha1" % path_to_binary
  stamp_file = os.path.join(LINUX64_BIN_DIR, 'mojom_parser.sha1')
  shutil.copy(sha1_file, stamp_file)
  print "Wrote stamp file %s. You probably want to commit this." % stamp_file

def main():
  default_path_to_binary = os.path.abspath(os.path.join(SRC_DIR,
      'out','Release', 'moparse'))
  parser = argparse.ArgumentParser(description="Upload the mojom_parser "
      "binary to Google Cloud Storage and update mojom_parser.sha1.")
  parser.add_argument("--path-to-binary", action="store",
                      default=default_path_to_binary,
                      help="Path to the binary to upload. If not specified "
                      "'out/Release/moparse' is used.")
  args = parser.parse_args()

  try:
    UploadAndStamp(args.path_to_binary)
  except Exception as e:
    print e
    return 1
  return 0

if __name__ == '__main__':
  sys.exit(main())
