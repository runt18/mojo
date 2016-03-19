#!/usr/bin/env python
# Copyright 2013 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

# Script to install the Chrome OS fonts on Linux.
# This script can be run manually (as root), but is also run as part
# install-build-deps.sh.

import os
import shutil
import subprocess
import sys

# Taken from the media-fonts/notofonts ebuild in chromiumos-overlay.
VERSION = '20140815'
URL = ('https://commondatastorage.googleapis.com/chromeos-localmirror/'
       'distfiles/notofonts-%s.tar.bz2') % (VERSION)
FONTS_DIR = '/usr/local/share/fonts'

def main(args):
  if not sys.platform.startswith('linux'):
    print "Error: {0!s} must be run on Linux.".format(__file__)
    return 1

  if os.getuid() != 0:
    print "Error: {0!s} must be run as root.".format(__file__)
    return 1

  if not os.path.isdir(FONTS_DIR):
    print "Error: Destination directory does not exist: {0!s}".format(FONTS_DIR)
    return 1

  dest_dir = os.path.join(FONTS_DIR, 'chromeos')

  stamp = os.path.join(dest_dir, ".stamp02")
  if os.path.exists(stamp):
    with open(stamp) as s:
      if s.read() == URL:
        print "Chrome OS fonts already up-to-date in {0!s}.".format(dest_dir)
        return 0

  if os.path.isdir(dest_dir):
    shutil.rmtree(dest_dir)
  os.mkdir(dest_dir)
  os.chmod(dest_dir, 0755)

  print "Installing Chrome OS fonts to {0!s}.".format(dest_dir)
  tarball = os.path.join(dest_dir, os.path.basename(URL))
  subprocess.check_call(['curl', '-L', URL, '-o', tarball])
  subprocess.check_call(['tar', '--no-same-owner', '--no-same-permissions',
                         '-xf', tarball, '-C', dest_dir])
  os.remove(tarball)

  readme = os.path.join(dest_dir, "README")
  with open(readme, 'w') as s:
    s.write("This directory and its contents are auto-generated.\n")
    s.write("It may be deleted and recreated. Do not modify.\n")
    s.write("Script: {0!s}\n".format(__file__))

  with open(stamp, 'w') as s:
    s.write(URL)

  for base, dirs, files in os.walk(dest_dir):
    for dir in dirs:
      os.chmod(os.path.join(base, dir), 0755)
    for file in files:
      os.chmod(os.path.join(base, file), 0644)

  return 0

if __name__ == '__main__':
  sys.exit(main(sys.argv[1:]))
