export CC=$(which clang-5.0)
export CXX=$(which clang++-5.0)
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export LIBRARY_PATH=/usr/local/lib:$LIBRARY_PATH

# set to true to link against libc++abi
export FILAMENT_REQUIRES_CXXABI=true

TARGET=release
echo "Building $TARGET target"
GENERATE_ARCHIVES=-a

cd filament && ./build.sh -c $GENERATE_ARCHIVES $TARGET
