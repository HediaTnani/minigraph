ARG LINUX_DISTRO=ubuntu
ARG LINUX_DISTRO_VERSION=18.04
ARG LINUX_VERSION=${LINUX_DISTRO}${LINUX_DISTRO_VERSION}
FROM ${LINUX_DISTRO}:${LINUX_DISTRO_VERSION} AS minigraph

ARG MINIGRAPH_VERSION=v0.5
ENV MINIGRAPH_VERSION=${MINIGRAPH_VERSION}

# Ensure apt-get won't prompt for selecting options
ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# Install dependencies for htslib and Clara Genomics SDK
RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
        git \
        build-essential \
        make \
        zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/lh3/minigraph/build

RUN git clone --recursive -b ${MINIGRAPH_VERSION} --single-branch https://github.com/lh3/minigraph.git \
    && cd minigraph \
    && make
