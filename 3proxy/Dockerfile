# 3proxy docker

FROM alpine:latest as builder

ARG VERSION=0.8.12

RUN apk add --update alpine-sdk wget bash && \
    cd / && \
    wget -q  https://github.com/z3APA3A/3proxy/archive/${VERSION}.tar.gz && \
    tar -xf ${VERSION}.tar.gz && \
    cd 3proxy-${VERSION} && \
    make -f Makefile.Linux

# STEP 2 build a small image
FROM alpine:latest

ARG VERSION=0.8.12

RUN mkdir /etc/3proxy/

COPY --from=builder /3proxy-${VERSION}/src/3proxy /3proxy
COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN mkdir -p /etc/3proxy/traf &&\
    chmod +x /docker-entrypoint.sh && \
    chmod +x /3proxy

ENTRYPOINT ["/docker-entrypoint.sh"]

VOLUME ["/etc/3proxy/"]

EXPOSE 3128 1080 8080

CMD ["start_proxy"]

