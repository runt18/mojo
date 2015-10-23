#!/usr/bin/env python
# Copyright 2015 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

"""A tool that runs a perf test and uploads the resulting data to the
performance dashboard.
"""

import argparse
import subprocess
import sys
import re

from mopy import perf_data_uploader
from mopy.version import Version

_PERF_LINE_FORMAT = r"""^\s*([^\s/]+)  # chart name
                        (/([^\s/]+))?  # trace name (optional, separated with
                                       # the chart name by a '/')
                        \s+(\S+)       # value
                        \s+(\S+)       # units
                        \s*$"""

_PERF_LINE_REGEX = re.compile(_PERF_LINE_FORMAT, re.VERBOSE)


def _GetCurrentCommitCount():
  return subprocess.check_output(
      ["git", "rev-list", "HEAD", "--count"]).strip()


def _ConvertPerfDataToChartFormat(perf_data, test_name):
  """Converts the perf data produced by a perf test to the "chart_data" format
  accepted by the performance dashboard, see:
  http://www.chromium.org/developers/speed-infra/performance-dashboard/sending-data-to-the-performance-dashboard.

  Returns:
    A dictionary that (after being converted to JSON) conforms to the server
    format.
  """
  charts = {}
  for line in perf_data:
    match = re.match(_PERF_LINE_REGEX, line)
    assert match, "Unable to parse the following input: %s" % line

    chart_name = match.group(1)
    trace_name = match.group(3) if match.group(3) else "summary"

    if chart_name not in charts:
      charts[chart_name] = {}
    charts[chart_name][trace_name] = {
        "type": "scalar",
        "value": float(match.group(4)),
        "units": match.group(5)
    }

  return {
      "format_version": "1.0",
      "benchmark_name": test_name,
      "charts": charts
  }


def main():
  parser = argparse.ArgumentParser(
      description="A tool that runs a perf test and uploads the resulting data "
                  "to the performance dashboard.")

  parser.add_argument(
      "--master-name",
      help="Buildbot master name, used to construct link to buildbot log by "
           "the dashboard, and also as the top-level category for the data.")
  parser.add_argument(
      "--perf-id",
      help="Used as the second-level category for the data, usually the "
           "platform type.")
  parser.add_argument(
      "--test-name",
      help="Name of the test that the perf data was generated from.")
  parser.add_argument(
      "--builder-name",
      help="Buildbot builder name, used to construct link to buildbot log by "
           "the dashboard.")
  parser.add_argument(
      "--build-number", type=int,
      help="Build number, used to construct link to buildbot log by the "
           "dashboard.")
  parser.add_argument(
      "--perf-data-path",
      help="The path to the perf data that the perf test generates.")
  parser.add_argument(
      "--dry-run", action="store_true", default=False,
      help="Display the server URL and the data to upload, but do not actually "
           "upload the data.")
  server_group = parser.add_mutually_exclusive_group()
  server_group.add_argument(
      "--testing-dashboard", action="store_true", default=True,
      help="Upload the data to the testing dashboard (default).")
  server_group.add_argument(
      "--production-dashboard", dest="testing_dashboard", action="store_false",
      default=False, help="Upload the data to the production dashboard.")
  parser.add_argument("command", nargs=argparse.REMAINDER)
  args = parser.parse_args()

  subprocess.check_call(args.command)

  if args.master_name is None or \
     args.perf_id is None or \
     args.test_name is None or \
     args.builder_name is None or \
     args.build_number is None or \
     args.perf_data_path is None:
    print "Won't upload perf data to the dashboard because not all of the " \
          "following values are specified: master-name, perf-id, test-name, " \
          "builder-name, build-number, perf-data-path."
    return 0

  revision = Version().version
  point_id = _GetCurrentCommitCount()
  with open(args.perf_data_path, "r") as perf_data:
    chart_data = _ConvertPerfDataToChartFormat(perf_data, args.test_name)

  result = perf_data_uploader.UploadPerfData(
      args.master_name, args.perf_id, args.test_name, args.builder_name,
      args.build_number, revision, chart_data, point_id, args.dry_run,
      args.testing_dashboard)

  return 0 if result else 1


if __name__ == '__main__':
  sys.exit(main())
