########################################################################
Tests for the --rate option (aka the limited rate mode)
########################################################################

# Failing to deliver the requested rate should result in a non-zero exit code
  $ sysbench --rate=2000000000 cpu run --verbosity=1
  FATAL: The event queue is full. This means the worker threads are unable to keep up with the specified event generation rate
  [1]

# Invalid queue lengths should fail fast
  $ sysbench --queue-length=3 cpu run --events=1 --verbosity=1
  FATAL: Invalid value for --queue-length: 3. Must be a power of 2 and at least 2.
  [1]

# Custom queue lengths should be accepted in rate-limited mode
  $ sysbench --rate=1 --queue-length=2 cpu run --cpu-max-prime=10 --events=1 --threads=1 | grep 'total number of events'
      total number of events:              1

# queue-length should be accepted even when rate limiting is disabled
  $ sysbench --queue-length=2 cpu run --cpu-max-prime=10 --events=1 --threads=1 | grep 'total number of events'
      total number of events:              1
