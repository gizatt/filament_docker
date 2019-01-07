#!/bin/bash

set -euxo pipefail

apt-get update

apt install --no-install-recommends \
  git \
  curl \
  wget \
  unzip \
  software-properties-common \
  python \
  apt-utils \
  make \
  tmux \
  libxi-dev \
  libx11-dev \
  libglu1-mesa-dev \
  freeglut3-dev \
  mesa-common-dev

add-apt-repository -y ppa:ubuntu-toolchain-r/test
apt-get update -y
apt-get --assume-yes --force-yes install gcc++-4.9

wget -qO- "https://cmake.org/files/v3.13/cmake-3.13.0-Linux-x86_64.tar.gz" | tar --strip-components=1 -xz -C /usr/local