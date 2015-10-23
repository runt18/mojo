# Copyright 2014 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

"""Uploads data points to the performance dashboard.

By default uploads to a local testing dashboard assumed to be running on the
host. To run such server, check out Catapult and follow instructions at
https://github.com/catapult-project/catapult/blob/master/dashboard/README.md .
"""

import httplib
import json
import pprint
import urllib
import urllib2

# TODO(yzshen): The following are missing currently:
#     (1) CL range on the dashboard;
#     (2) improvement direction on the dashboard;
#     (3) a link from the build step pointing to the dashboard page.

_PRODUCTION_SERVER = "https://chromeperf.appspot.com"
_TESTING_SERVER = "http://127.0.0.1:8080"


def UploadPerfData(master_name, perf_id, test_name, builder_name, build_number,
                   revision, chart_data, point_id, dry_run=False,
                   testing_dashboard=True):
  """Uploads the provided chart data to performance dashboard.

  Returns:
    A boolean value indicating whether the operation succeeded or not.
  """
  class _UploadException(Exception):
    pass

  def _Upload(server_url, json_data):
    """Make an HTTP POST with the given data to the performance dashboard.

    Args:
      server_url: URL of the performance dashboard instance.
      json_data: JSON string that contains the data to be sent.

    Raises:
      _UploadException: An error occurred during uploading.
    """
    # When data is provided to urllib2.Request, a POST is sent instead of GET.
    # The data must be in the application/x-www-form-urlencoded format.
    data = urllib.urlencode({"data": json_data})
    req = urllib2.Request("%s/add_point" % server_url, data)
    try:
      urllib2.urlopen(req)
    except urllib2.HTTPError as e:
      raise _UploadException("HTTPError: %d. Response: %s\n"
                             "JSON: %s\n" % (e.code, e.read(), json_data))
    except urllib2.URLError as e:
      raise _UploadException("URLError: %s for JSON %s\n" %
                             (str(e.reason), json_data))
    except httplib.HTTPException as e:
      raise _UploadException("HTTPException for JSON %s\n" % json_data)

  # Wrap the |chart_data| with meta data as required by the spec.
  formatted_data = {
      "master": master_name,
      "bot": perf_id,
      "masterid": master_name,
      "buildername": builder_name,
      "buildnumber": build_number,
      "versions": {
          "mojo": revision
      },
      "point_id": point_id,
      "supplemental": {},
      "chart_data": chart_data
  }

  server_url = _TESTING_SERVER if testing_dashboard else _PRODUCTION_SERVER

  if dry_run:
    print "Won't upload because --dry-run is specified."
    print "Server: %s" % server_url
    print "Data:"
    pprint.pprint(formatted_data)
  else:
    print "Uploading data to %s ..." % server_url
    try:
      _Upload(server_url, json.dumps(formatted_data))
    except _UploadException as e:
      print e
      return False

    print "Done."

    dashboard_params = urllib.urlencode({
        "masters": master_name,
        "bots": perf_id,
        "tests": test_name,
        "rev": point_id
    })
    print "Results Dashboard: %s/report?%s" % (server_url, dashboard_params)

  return True
