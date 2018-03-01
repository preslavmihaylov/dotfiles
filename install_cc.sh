#!/bin/bash

cd ~/.vim/bundle
git clone https://github.com/jeaye/color_coded

# taken from
cd ~/.vim/bundle/color_coded
rm -f CMakeCache.txt || true
mkdir build && cd build
cmake ..
make && make install # Compiling with GCC is preferred, ironically
# Clang works on OS X, but has mixed success on Linux and the BSDs

# Cleanup afterward; frees several hundred megabytes
make clean && make clean_clang
