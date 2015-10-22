# Copyright 2015 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

# Disable the line-too-long warning.
# pylint: disable=C0301
"""This module implements the Chromium Performance Dashboard JSON v1.0 data
format.

See http://www.chromium.org/developers/speed-infra/performance-dashboard/sending-data-to-the-performance-dashboard.
"""

import json
from collections import defaultdict

class ChartDataRecorder(object):
  """Allows one to record measurement values one by one and then generate the
  JSON string that represents them in the 'chart_data' format expected by the
  performance dashboard.
  """

  def __init__(self):
    self.charts = defaultdict(list)

  def record_scalar(self, chart_name, value_name, units, value):
    """Records a single measurement value of a scalar type."""
    self.charts[chart_name].append({
        'type': 'scalar',
        'name': value_name,
        'units': units,
        'value': value})

  def get_json(self):
    """Returns the JSON string representing the recorded chart data."""
    return json.dumps(self.charts)
