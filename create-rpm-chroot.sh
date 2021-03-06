#!/bin/bash
. $(dirname $(readlink -f $0))/config
CONTAINERNAME=mockbuild:latest
CACHEPATH=/var/cache/docker-builder/mock
[ -z "${DIST_VERSION}" ] && DIST_VERSION=6
docker run ${DNSPARAM} -i -t --privileged --rm -v ${CACHEPATH}/cache:/var/cache/mock -v ${CACHEPATH}/lib:/var/lib/mock ${CONTAINERNAME} \
    bash -c "chown -R abuild:mock /var/cache/mock /var/lib/mock; \
             chmod -R g+s /var/cache/mock /var/lib/mock; \
             su - abuild -c 'mock -r centos-${DIST_VERSION}-x86_64 -v --init'"
