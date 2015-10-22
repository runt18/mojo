# Copyright 2015 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

"""Tests for the Chromium Performance Dashboard data format implementation."""

import imp
import json
import os.path
import sys
import unittest

try:
  imp.find_module("devtoolslib")
except ImportError:
  sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from devtoolslib.perf_dashboard import ChartDataRecorder

class ChartDataRecorderTest(unittest.TestCase):
  """Tests the chart data recorder."""

  def test_empty(self):
    """Tests chart data with no charts."""
    recorder = ChartDataRecorder()
    result = json.loads(recorder.get_json())
    self.assertEquals(0, len(result))

  def test_one_chart(self):
    """Tests chart data with two samples in one chart."""
    recorder = ChartDataRecorder()
    recorder.record_scalar('chart', 'val1', 'ms', 1)
    recorder.record_scalar('chart', 'val2', 'ms', 2)

    result = json.loads(recorder.get_json())
    self.assertEquals(1, len(result))
    self.assertEquals(2, len(result['chart']))
    self.assertEquals({
        'type': 'scalar',
        'name': 'val1',
        'units': 'ms',
        'value': 1}, result['chart'][0])
    self.assertEquals({
        'type': 'scalar',
        'name': 'val2',
        'units': 'ms',
        'value': 2}, result['chart'][1])

  def test_two_charts(self):
    """Tests chart data with two samples over two charts."""
    recorder = ChartDataRecorder()
    recorder.record_scalar('chart1', 'val1', 'ms', 1)
    recorder.record_scalar('chart2', 'val2', 'ms', 2)

    result = json.loads(recorder.get_json())
    self.assertEquals(2, len(result))
    self.assertEquals(1, len(result['chart1']))
    self.assertEquals({
        'type': 'scalar',
        'name': 'val1',
        'units': 'ms',
        'value': 1}, result['chart1'][0])
    self.assertEquals(1, len(result['chart2']))
    self.assertEquals({
        'type': 'scalar',
        'name': 'val2',
        'units': 'ms',
        'value': 2}, result['chart2'][0])
