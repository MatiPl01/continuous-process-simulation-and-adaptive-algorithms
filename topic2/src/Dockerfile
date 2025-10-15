FROM ubuntu:24.04

WORKDIR /code

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        software-properties-common \
        libzstd-dev \
        git \
        curl \
        ca-certificates \
        just \
        gfortran \
        g++ \
        cmake \
        ninja-build \
        liblapack-dev \
        libboost-all-dev \
        llvm-dev \
        libmumps-dev

ENV CMAKE_GENERATOR=Ninja

COPY scripts/install-dependencies.sh scripts/install-dependencies.sh
RUN scripts/install-dependencies.sh /deps-build /deps

COPY . .


