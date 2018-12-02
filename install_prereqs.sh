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
  screen \
  libxi-dev \
  libx11-dev \
  libglu1-mesa-dev \
  freeglut3-dev \
  mesa-common-dev


wget -qO- "https://cmake.org/files/v3.13/cmake-3.13.0-Linux-x86_64.tar.gz" | tar --strip-components=1 -xz -C /usr/local