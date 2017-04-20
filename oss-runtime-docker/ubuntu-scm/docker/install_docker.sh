#!/usr/bin/env bash

# install docker 
apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
    echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | tee /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get -yq install docker-engine && \
    apt-get -q clean -y && rm -rf /var/lib/apt/lists/* && rm -f /var/cache/apt/*.bin && \
    wget -q ${build_fileserver}/docker/machine/releases/download/v0.8.2/docker-machine-Linux-x86_64 -O /usr/bin/docker-machine && \
    chmod +x /usr/bin/docker-machine

# add docker group if not exits
groupadd -f docker

## install docker-compose
wget -q -O /usr/local/bin/docker-compose ${build_fileserver}/docker/compose/releases/download/1.10.0/docker-compose-Linux-x86_64 && \
    chmod +x /usr/local/bin/docker-compose
