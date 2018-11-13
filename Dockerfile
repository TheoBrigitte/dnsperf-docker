FROM alpine:3.8
ENV DNSPERF_VERSION 2.1.0.0-1

RUN apk add --no-cache                                                        \
        bind                                                                  \
        bind-dev                                                              \
        g++                                                                   \
        json-c-dev                                                            \
        libcap-dev                                                            \
        libxml2-dev                                                           \
        make                                                                  \
        openssl-dev                                                           \
        wget

# Compile dnsperf
# https://www.akamai.com/us/en/products/network-operator/measurement-tools.jsp
RUN mkdir -p /tmp/build/                                                      &&\
        wget -O /tmp/build/dnsperf-src-${DNSPERF_VERSION}.tar.gz \
                http://wwwns.akamai.com/dnsperf-src-${DNSPERF_VERSION}.tar.gz &&\
        tar -zxf /tmp/build/dnsperf-src-${DNSPERF_VERSION}.tar.gz \
                -C /tmp/build/                                                &&\
        cd /tmp/build/dnsperf-src-${DNSPERF_VERSION}/                         &&\
        ./configure --prefix=/                                                &&\
        make install                                                          &&\
        cd /tmp                                                               &&\
        rm -rf /tmp/build

# Download sample query file
# ftp://ftp.nominum.com/pub/nominum/dnsperf/data/README
RUN mkdir -p /opt &&\
        cd /opt &&\
        wget -O queryfile-example-current.gz \
        ftp://ftp.nominum.com/pub/nominum/dnsperf/data/queryfile-example-current.gz  &&\
        gunzip queryfile-example-current.gz                                     &&\
        head -q -n100000 queryfile-example-current > queryfile-example-100k &&\
        # comment next line to use the original example query file (> 200M)
        mv queryfile-example-100k    queryfile && rm queryfile-example-current && exit &&\
        mv queryfile-example-current queryfile

ENTRYPOINT ["/bin/dnsperf", "-d", "/opt/queryfile"]
