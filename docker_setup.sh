#!/bin/bash

# version of clang we want to use
CLANG_VERSION=5.0
# version of libcxx and libcxxabi we want to use
CXX_VERSION=5.0.2   

cd /filament

sudo ln -s /usr/include/x86_64-linux-gnu/asm /usr/include/asm

sudo apt-add-repository "deb http://apt.llvm.org/trusty/ llvm-toolchain-trusty-$CLANG_VERSION main"
wget -O - http://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add -
sudo apt-get update -y
sudo apt-get --assume-yes --force-yes install clang-$CLANG_VERSION

mkdir -p clang
cd clang

# download LLVM sources
curl -O http://releases.llvm.org/$CXX_VERSION/llvm-$CXX_VERSION.src.tar.xz
tar xf llvm-$CXX_VERSION.src.tar.xz
mv llvm-$CXX_VERSION.src llvm_src

# download libc++ sources
curl -O http://releases.llvm.org/$CXX_VERSION/libcxx-$CXX_VERSION.src.tar.xz
tar xf libcxx-$CXX_VERSION.src.tar.xz
mv libcxx-$CXX_VERSION.src llvm_src/projects/libcxx

# download libc++abi sources
curl -O http://releases.llvm.org/$CXX_VERSION/libcxxabi-$CXX_VERSION.src.tar.xz
tar xf libcxxabi-$CXX_VERSION.src.tar.xz
mv libcxxabi-$CXX_VERSION.src llvm_src/projects/libcxxabi

mkdir -p build
cd build

export CC=/usr/bin/clang-$CLANG_VERSION
export CXX=/usr/bin/clang++-$CLANG_VERSION

# prepare makefiles
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DLIBCXX_ENABLE_RTTI=YES \
    -DLIBCXX_ENABLE_EXCEPTIONS=YES \
    -DLIBCXX_USE_COMPILER_RT=NO \
    -DLIBCXXABI_USE_COMPILER_RT=NO \
    ../llvm_src

# compile libraries
make -j cxx
make -j cxxabi

# install libraries
(cd projects/libcxx && sudo make -j install)
(cd projects/libcxxabi && sudo make -j install)

cd ../..

wget -q https://github.com/ninja-build/ninja/releases/download/v1.8.2/ninja-linux.zip
unzip -q ninja-linux.zip
mv ninja /usr/local/bin
