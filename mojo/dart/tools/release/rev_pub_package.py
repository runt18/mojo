#!/usr/bin/env python
# Copyright 2015 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

# See https://github.com/domokit/mojo/wiki/Release-process

"""Updates version number in a package's pubspec.yaml and edits the CHANGELOG"""

import argparse
import os
import subprocess
import yaml

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
SRC_DIR = os.path.dirname(
    os.path.dirname(
        os.path.dirname(
            os.path.dirname(SCRIPT_DIR))))

PACKAGES_DIR = os.path.join(SRC_DIR, 'mojo', 'dart', 'packages')

def increment_version(version):
    pieces = version.split('.')
    pieces[-1] = str(int(pieces[-1]) + 1)
    return '.'.join(pieces)


def count_commits(start, end):
    return subprocess.check_output([
        'git', 'rev-list', '{0!s}...{1!s}'.format(start, end)]).count('\n')


def last_commit_to(file_path, fmt='%h'):
    return subprocess.check_output([
        'git', 'log', '-1', '--format=' + fmt, file_path]).strip()


def update_pubspec(pubspec):
    # TODO(johnmccutchan): Call out to den tool to update version number.
    with open(pubspec, 'r') as stream:
        spec = yaml.load(stream)
        old_version = spec['version']
        spec['version'] = increment_version(old_version)
        print "{0:20!s}  {1:6!s} => {2:6!s}".format(spec['name'], old_version, spec['version'])

    with open(pubspec, 'w') as stream:
        yaml.dump(spec, stream=stream, default_flow_style=False)
    return spec['version']


def update_changelog(changelog, pubspec, version):
    old = last_commit_to(pubspec)
    new = last_commit_to('.')
    long_new = last_commit_to('.', '%H')
    url = "https://github.com/domokit/mojo/compare/{0!s}...{1!s}".format(old, new)
    count = count_commits(old, new)
    message = """## {0!s}

  - {1!s} changes: {2!s}

  MOJO_SDK: {3!s}

""".format(version, count, url, long_new)
    prepend_to_file(message, changelog)


def prepend_to_file(to_prepend, filepath):
    with open(filepath, 'r+') as f:
        content = f.read()
        f.seek(0, 0)
        f.write(to_prepend + content)


# Returns a map from package name to source directory.
def build_package_map():
  packages = {}
  for package in os.listdir(PACKAGES_DIR):
    # Skip private packages.
    if package.startswith('_'):
      continue
    package_path = os.path.join(PACKAGES_DIR, package)
    # Skip everything but directories.
    if not os.path.isdir(package_path):
      continue
    packages[package] = package_path
  return packages


def print_package_map(package_map):
  if (package_map == None) or (len(package_map) == 0):
    print('No packages found in {0!s}'.format(PACKAGES_DIR))
    return

  print('There are {0:d} known packages:'.format(len(package_map)))
  for package in package_map:
    package_dir = package_map[package]
    print('{0!s} -> {1!s}'.format(package, package_dir))


def main():
    parser = argparse.ArgumentParser(
        description='Rev a Dart package for release')
    parser.add_argument('--packages',
                        metavar='packages',
                        help='Package names, for example: mojo mojo_services',
                        required=True,
                        nargs='+')
    args = parser.parse_args()

    package_map = build_package_map()

    # Validate packages passed on command line before operating on any package.
    for package in args.packages:
      package_dir = package_map.get(package)
      if package_dir == None:
          print('ERROR: Do not know package {0!s}'.format(package))
          print_package_map(package_map)
          return 1

    # Now update packages.
    for package in args.packages:
        package_dir = package_map.get(package)
        assert(package_dir != None)
        pubspec = os.path.join(package_dir, 'pubspec.yaml')
        changelog = os.path.join(package_dir, 'CHANGELOG.md')
        new_version = update_pubspec(pubspec)
        update_changelog(changelog, pubspec, new_version)


if __name__ == '__main__':
    main()
