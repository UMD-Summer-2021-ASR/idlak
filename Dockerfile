FROM debian:latest
RUN apt update
RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
    g++ \
    make \
    automake \
    autoconf \
    bzip2 \
    unzip \
    wget \
    sox \
    libtool \
    git \
    subversion \
    python2.7 \
    python3 \
    python-dev \
    python3-dev \
    zlib1g-dev \
    ca-certificates \
    gfortran \
    patch \
    ffmpeg \
    cmake \
    csh \
    libatlas3-base \
    swig \
    vim && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /root

RUN git clone https://github.com/UMD-Summer-2021-ASR/idlak

WORKDIR /root/idlak

RUN cd tools && extras/check_dependencies.sh

RUN cd tools && make -j 2

RUN tools/install_idlak.sh

RUN cd src && \
    ./configure --shared && \
    make -j 2 depend && \
    make -j 2
