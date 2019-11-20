The 3 million record query file has been replaced with a 10 million
record query file as 3 million records were not enough for a full
resperf run on modern hardware.

The latest version of the query file is available at:

ftp://ftp.nominum.com/pub/nominum/dnsperf/data/queryfile-example-current.gz

If you are using a file that is over a year old, please download an
update. Running tests with old query files will skew results.

For more information on query data, please see the Caching DNS
Performance whitepaper included with the dnsperf distribution.
