# mojo_benchmark

`mojo_benchmark` allows you to run performance tests for any Mojo application
that participates in the [tracing
ecosystem](https://github.com/domokit/mojo/blob/master/mojo/services/tracing/interfaces/tracing.mojom)
with no app changes required.

The script reads a list of benchmarks to run from a file, runs each benchmark in
controlled caching conditions with tracing enabled and performs specified
measurements on the collected trace data.

## Defining benchmarks

`mojo_benchmark` runs performance tests defined in a benchmark file. The
benchmark file is a Python dictionary of the following format:

```python
benchmarks = [
  {
    'name': '<name of the benchmark>',
    'app': '<url of the app to benchmark>',
    'shell-args': [],
    'duration': <duration in seconds>,

    # List of measurements to make.
    'measurements': [
      '<measurement type>/<event category>/<event name>',
    ],
  },
]
```

The following types of measurements are available:

 - `time_until` - measures time until the first occurence of the specified event
 - `avg_duration` - measures the average duration of all instances of the 
    specified event

## Caching

The script runs each benchmark twice. The first run (**cold start**) clears
caches of the following apps on startup:

 - network_service.mojo
 - url_response_disk_cache.mojo

The second run (**warm start**) runs immediately afterwards, without clearing
any caches.

## Time origin

The underlying benchmark runner records the time origin just before issuing the
connection call to the application being benchmarked. Results of `time_until`
measurements are relative to this time.

## Example

For an app that records a trace event named "initialized" in category "my_app"
once its initialization is complete, we can benchmark the initialization time of
the app (from the moment someone tries to connect to it to the app completing
its initialization) using the following benchmark file:

```python
benchmarks = [
  {
    'name': 'My app initialization',
    'app': 'https://my_domain/my_app.mojo',
    'duration': 10,
    'measurements': [
      'time_until/my_app/initialized',
    ],
  },
]
```

## Dashboard

`mojo_benchmark` supports uploading the results to an instance of a Catapult
performance dashboard. In order to upload the results of a run to performance
dashboard, pass the `--upload` flag along with required meta-data describing the
data being uploaded:

```sh
mojo_benchmark \
--upload \
--master-name my-master \
--bot-name my-bot \
--test-name my-test-suite
--builder-name my-builder \
--build-number my-build
--server-url http://my-server.example.com
```

If no `--server-url` is specified, the script assumes that a local instance of
the dashboard is running at `http://localhost:8080`. The script assumes that the
working directory from which it is called is a git repository and queries it to
determine the sequential number identifying the revision (as the number of
commits in the current branch in the repository).

For more information refer to:

 - [Catapult project](https://github.com/catapult-project/catapult)
