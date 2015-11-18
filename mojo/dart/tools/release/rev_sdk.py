#!/usr/bin/env python
# Copyright 2015 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

# See https://github.com/domokit/mojo/wiki/Release-process

"""Updates the mojo_sdk package to require the latest versions of all leaf
packages and updates the version number in and CHANGELOG."""

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

DART_SDK = os.path.join(SRC_DIR, 'third_party', 'dart-sdk', 'dart-sdk', 'bin')
PUB = os.path.join(DART_SDK, 'pub')

MOJO_SDK_SRC_DIR = os.path.join(SRC_DIR, 'mojo/dart/packages/mojo_sdk/')
MOJO_SDK_PUBSPEC = os.path.join(MOJO_SDK_SRC_DIR, 'pubspec.yaml')


def run(cwd, args):
    print 'RUNNING:', ' '.join(args), 'IN:', cwd
    subprocess.check_call(args, cwd=cwd)


# Given the path to a pubspec.yaml file, return the version.
def get_pubspec_version(pubspec):
  with open(pubspec, 'r') as stream:
    spec = yaml.load(stream)
    return spec['version']


# Builds a map of package name to package source directory.
def build_leaf_package_map(leaf_packages):
  packages = {}
  for package in os.listdir(PACKAGES_DIR):
    # Skip private packages.
    if package.startswith('_'):
      continue
    # Skip packages we don't care about.
    if not (package in leaf_packages):
      continue
    package_path = os.path.join(PACKAGES_DIR, package)
    # Skip everything but directories.
    if not os.path.isdir(package_path):
      continue
    packages[package] = package_path
  return packages


def update_pubspec_dependency(pubspec, leaf_package, new_version):
    # TODO(johnmccutchan): Call out to psye tool to update version number.
    with open(pubspec, 'r') as stream:
        spec = yaml.load(stream)
        dependencies = spec['dependencies']
        assert(dependencies != None)
        # Extract the version we currently depend on.
        version = dependencies.get(leaf_package)
        # Handle the case where leaf_package is new or missing from the pubspec.
        if version == None:
            version = ''
        assert(version != None)
        # Update the version to the latest.
        dependencies[leaf_package] = new_version
        if version == new_version:
            print "%20s no update for %20s  %6s" % (spec['name'],
                                                    leaf_package,
                                                    version)
            return
        print "%20s %20s  %6s => %6s" % (spec['name'],
                                         leaf_package,
                                         version,
                                         dependencies[leaf_package])
    with open(pubspec, 'w') as stream:
        yaml.dump(spec, stream=stream, default_flow_style=False)


def main():
    parser = argparse.ArgumentParser(description='Rev Mojo Dart SDK package')
    parser.parse_args()

    # Make the mojo_sdk package depend on the current versions of all leaf
    # packages. The current versions are taken from the source tree and not
    # the pub server. After updating the required dependency versions, this
    # script will verify that the pub can satisfy the package constraints.
    # This means that someone must have published the packages to pub and
    # that pub and the source tree agree on the current version number of
    # each leaf package.
    print('Updating leaf package dependencies to latest...')
    leaf_packages = ['mojo',
                     'mojo_services',
                     'mojom',
                     'mojo_apptest']
    package_map = build_leaf_package_map(leaf_packages)
    for leaf_package in package_map:
        leaf_package_dir = package_map[leaf_package]
        assert(leaf_package_dir != None)
        leaf_package_pubspec = os.path.join(leaf_package_dir, 'pubspec.yaml')
        # Get current the version number for leaf_package.
        leaf_package_version = get_pubspec_version(leaf_package_pubspec)
        # Update the mojo_sdk pubspec to depend the current version number.
        update_pubspec_dependency(MOJO_SDK_PUBSPEC,
                                  leaf_package,
                                  leaf_package_version)

    # Verify that pub can find all required package versions.
    run(MOJO_SDK_SRC_DIR,
        [PUB, 'get', '-n'])

    # Now, rev package.
    run(SRC_DIR,
        ['mojo/dart/tools/release/rev_pub_package.py',
         '--packages',
         'mojo_sdk'])


if __name__ == '__main__':
    main()
