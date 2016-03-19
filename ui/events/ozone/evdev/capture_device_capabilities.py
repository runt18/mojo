#!/usr/bin/python
# Copyright 2014 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

"""Code generator DeviceCapabilities literal."""

import argparse
import ctypes
import evdev
import os
import sys


TEST_DATA_GROUP_SIZE = 64  # Aligns with sysfs on 64-bit devices.


def bits_to_groups(bits):
  return (bits + TEST_DATA_GROUP_SIZE - 1) / TEST_DATA_GROUP_SIZE


# As in /sys/class/input/input*/capabilities/*
def serialize_bitfield(bitfield, max_bit):
  result = ""
  group_count = bits_to_groups(max_bit)
  for group in xrange(group_count - 1, -1, -1):
    group_val = 0
    for group_bit in xrange(TEST_DATA_GROUP_SIZE):
      code = group * TEST_DATA_GROUP_SIZE + group_bit
      if code in bitfield:
        group_val |= (1 << group_bit)
    if group_val or result:
      result += '{0:x}'.format(group_val)
      if group:
        result += ' '
  if not result:
    return '0'
  return result


def dump_absinfo(out, capabilities, identifier):
  out.write('const DeviceAbsoluteAxis {0!s}[] = {{\n'.format(identifier))

  for code, absinfo in capabilities[evdev.ecodes.EV_ABS]:
    # Set value := 0 to make it deterministic.
    code_name = evdev.ecodes.bytype[evdev.ecodes.EV_ABS][code]
    absinfo_struct = (0, absinfo.min, absinfo.max, absinfo.fuzz, absinfo.flat,
                      absinfo.resolution)
    data = (code_name,) + absinfo_struct
    out.write('    {{{0!s}, {{{1:d}, {2:d}, {3:d}, {4:d}, {5:d}, {6:d}}}}},\n'.format(*data))

  out.write('};\n')


def dump_capabilities(out, dev, identifier):
  capabilities = dev.capabilities()
  has_abs = evdev.ecodes.EV_ABS in capabilities

  sysfs_path = '/sys/class/input/' + os.path.basename(dev.fn)

  # python-evdev is missing some features
  uniq = open(sysfs_path + '/device/uniq', 'r').read().strip()
  prop = open(sysfs_path + '/device/properties', 'r').read().strip()
  ff = open(sysfs_path + '/device/capabilities/ff', 'r').read().strip()

  # python-evdev parses the id wrong.
  bustype = open(sysfs_path + '/device/id/bustype', 'r').read().strip()
  vendor = open(sysfs_path + '/device/id/vendor', 'r').read().strip()
  product = open(sysfs_path + '/device/id/product', 'r').read().strip()
  version = open(sysfs_path + '/device/id/version', 'r').read().strip()

  # python-evdev drops EV_REP from the event set.
  ev = open(sysfs_path + '/device/capabilities/ev', 'r').read().strip()

  if ctypes.sizeof(ctypes.c_long()) != 8:
    # /sys/class/input/*/properties format is word size dependent.
    # Could be fixed by regrouping but for now, just raise an error.
    raise ValueError("Must be run on 64-bit machine")

  key_bits = capabilities.get(evdev.ecodes.EV_KEY, [])
  rel_bits = capabilities.get(evdev.ecodes.EV_REL, [])
  abs_bits = [abs[0] for abs in capabilities.get(evdev.ecodes.EV_ABS, [])]
  msc_bits = capabilities.get(evdev.ecodes.EV_MSC, [])
  sw_bits = capabilities.get(evdev.ecodes.EV_SW, [])
  led_bits = capabilities.get(evdev.ecodes.EV_LED, [])

  fields = [
    ('path', os.path.realpath(sysfs_path)),
    ('name', dev.name),
    ('phys', dev.phys),
    ('uniq', uniq),
    ('bustype', bustype),
    ('vendor', vendor),
    ('product', product),
    ('version', version),
    ('prop', prop),
    ('ev', ev),
    ('key', serialize_bitfield(key_bits, evdev.ecodes.KEY_CNT)),
    ('rel', serialize_bitfield(rel_bits, evdev.ecodes.REL_CNT)),
    ('abs', serialize_bitfield(abs_bits, evdev.ecodes.ABS_CNT)),
    ('msc', serialize_bitfield(msc_bits, evdev.ecodes.MSC_CNT)),
    ('sw', serialize_bitfield(sw_bits, evdev.ecodes.SW_CNT)),
    ('led', serialize_bitfield(led_bits, evdev.ecodes.LED_CNT)),
    ('ff', ff),
  ]

  if has_abs:
    absinfo_identifier = identifier + 'AbsAxes'
    dump_absinfo(out, capabilities, absinfo_identifier)

  out.write('const DeviceCapabilities {0!s} = {{\n'.format(identifier))
  for name, val in fields:
    out.write('    /* {0!s} */ "{1!s}",\n'.format(name, val))

  if has_abs:
    out.write('    {0!s},\n'.format(absinfo_identifier))
    out.write('    arraysize({0!s}),\n'.format(absinfo_identifier))

  out.write('};\n')


def main(argv):
  parser = argparse.ArgumentParser()
  parser.add_argument('device')
  parser.add_argument('identifier')
  args = parser.parse_args(argv)

  dev = evdev.InputDevice(args.device)
  out = sys.stdout

  dump_capabilities(out, dev, args.identifier)
  return 0


if __name__ == '__main__':
  sys.exit(main(sys.argv[1:]))
