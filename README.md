# Docker image for DNS Performance Testing Tool (dnsperf)

## Components

* DNSPerf: 2.1.0.0-1
* Sample query file: 100k records

## Usage

Run dnsperf with default parameters:
`$ docker run -it --rm theo01/dnsperf`

Run dnsperf with custom query file:
`$ docker run -it --rm -v /path/to/file:/opt/queryfile theo01/dnsperf`

Help:
`$ docker run -it --rm theo01/dnsperf -h`

## Run inside Kubernetes

* Replace dns server IP address in k8s/deployement.yaml

* Run dnsperf
```
$ kubectl apply -f k8s/deployment.yaml
deployment.apps/dnsperf created
```

* Make sure pods are running
```
$ kubectl get po -l app=dnsperf
NAME                       READY   STATUS    RESTARTS   AGE
dnsperf-69f5786848-2hvfz   1/1     Running   0          10s
dnsperf-69f5786848-2m6wv   1/1     Running   0          10s
dnsperf-69f5786848-8nqdt   1/1     Running   0          10s
dnsperf-69f5786848-cqbhl   1/1     Running   0          10s
dnsperf-69f5786848-l72mp   1/1     Running   0          10s
dnsperf-69f5786848-mjlx5   1/1     Running   0          10s
```

* Check results
```
$ kubectl logs -f dnsperf-69f5786848-2hvzf
DNS Performance Testing Tool
Nominum Version 2.1.0.0

...

Statistics:

  Queries sent:         100000
  Queries completed:    86102 (86.10%)
  Queries lost:         13898 (13.90%)

  Response codes:       NOERROR 65216 (75.74%), SERVFAIL 456 (0.53%), NXDOMAIN 20430 (23.73%)
  Average packet size:  request 38, response 97
  Run time (s):         86.267839
  Queries per second:   998.077627

  Average Latency (s):  0.158047 (min 0.000049, max 4.795985)
  Latency StdDev (s):   0.192944
```

