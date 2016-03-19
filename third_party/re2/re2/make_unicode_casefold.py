#!/usr/bin/python
# coding=utf-8
#
# Copyright 2008 The RE2 Authors.  All Rights Reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

# See unicode_casefold.h for description of case folding tables.

"""Generate C++ table for Unicode case folding."""

import unicode, sys

_header = """
// GENERATED BY make_unicode_casefold.py; DO NOT EDIT.
// make_unicode_casefold.py >unicode_casefold.cc

#include "re2/unicode_casefold.h"

namespace re2 {

"""

_trailer = """

} // namespace re2

"""

def _Delta(a, b):
  """Compute the delta for b - a.  Even/odd and odd/even
     are handled specially, as described above."""
  if a+1 == b:
    if a%2 == 0:
      return 'EvenOdd'
    else:
      return 'OddEven'
  if a == b+1:
    if a%2 == 0:
      return 'OddEven'
    else:
      return 'EvenOdd'
  return b - a

def _AddDelta(a, delta):
  """Return a + delta, handling EvenOdd and OddEven specially."""
  if type(delta) == int:
    return a+delta
  if delta == 'EvenOdd':
    if a%2 == 0:
      return a+1
    else:
      return a-1
  if delta == 'OddEven':
    if a%2 == 1:
      return a+1
    else:
      return a-1
  print >>sys.stderr, "Bad Delta: ", delta
  raise "Bad Delta"

def _MakeRanges(pairs):
  """Turn a list like [(65,97), (66, 98), ..., (90,122)]
     into [(65, 90, +32)]."""
  ranges = []
  last = -100

  def evenodd(last, a, b, r):
    if a != last+1 or b != _AddDelta(a, r[2]):
      return False
    r[1] = a
    return True

  def evenoddpair(last, a, b, r):
    if a != last+2:
      return False
    delta = r[2]
    d = delta
    if type(delta) is not str:
      return False
    if delta.endswith('Skip'):
      d = delta[:-4]
    else:
      delta = d + 'Skip'
    if b != _AddDelta(a, d):
      return False
    r[1] = a
    r[2] = delta
    return True

  for a, b in pairs:
    if ranges and evenodd(last, a, b, ranges[-1]):
      pass
    elif ranges and evenoddpair(last, a, b, ranges[-1]):
      pass
    else:
      ranges.append([a, a, _Delta(a, b)])
    last = a
  return ranges

# The maximum size of a case-folding group.
# Case folding is implemented in parse.cc by a recursive process
# with a recursion depth equal to the size of the largest
# case-folding group, so it is important that this bound be small.
# The current tables have no group bigger than 4.
# If there are ever groups bigger than 10 or so, it will be
# time to rework the code in parse.cc.
MaxCasefoldGroup = 4

def main():
  lowergroups, casegroups = unicode.CaseGroups()
  foldpairs = []
  seen = {}
  for c in casegroups:
    if len(c) > MaxCasefoldGroup:
      raise unicode.Error("casefold group too long: {0!s}".format(c))
    for i in range(len(c)):
      if c[i-1] in seen:
        raise unicode.Error("bad casegroups {0:d} -> {1:d}".format(c[i-1], c[i]))
      seen[c[i-1]] = True
      foldpairs.append([c[i-1], c[i]])

  lowerpairs = []
  for lower, group in lowergroups.iteritems():
    for g in group:
      if g != lower:
        lowerpairs.append([g, lower])

  def printpairs(name, foldpairs):
    foldpairs.sort()
    foldranges = _MakeRanges(foldpairs)
    print "// {0:d} groups, {1:d} pairs, {2:d} ranges".format(len(casegroups), len(foldpairs), len(foldranges))
    print "CaseFold unicode_{0!s}[] = {{".format(name)
    for lo, hi, delta in foldranges:
      print "\t{{ {0:d}, {1:d}, {2!s} }},".format(lo, hi, delta)
    print "};"
    print "int num_unicode_{0!s} = {1:d};".format(name, len(foldranges))
    print ""

  print _header
  printpairs("casefold", foldpairs)
  printpairs("tolower", lowerpairs)
  print _trailer

if __name__ == '__main__':
  main()
