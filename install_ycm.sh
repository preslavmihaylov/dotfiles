#!/bin/bash

# NOTE: This installation will work only if your vim is v. 7.4, 1578 or higher and it has python or python3
# To ensure these preconditions are met:
# 1. type vim --version and search for version number and Extra patches. Verify they meet criteria
# 2. enter vim and type :echo has('python') || has('python3'). If the result is 1, you are good to go

# Specific for Ubuntu
sudo apt-get install -y build-essential cmake python-dev python3-dev

# if this link doesn't work, go to releases.llvm.org/download.html and download correct tarball
LLVM_TAR_URL=http://releases.llvm.org/5.0.1/clang+llvm-5.0.1-x86_64-linux-gnu-ubuntu-16.04.tar.xz
LLVM_TAR_ARC=clang+llvm-5.0.1-x86_64-linux-gnu-ubuntu-16.04.tar.xz
LLVM_ROOT_DIR=clang+llvm-5.0.1-x86_64-linux-gnu-ubuntu-16.04

# clone ycm and install dependencies
cd ~/.vim/bundle
git clone https://github.com/Valloric/YouCompleteMe

cd ~/.vim/bundle/YouCompleteMe
git submodule update --init --recursive

# go to ~/ycm_temp, download llvm tar and extract it
mkdir ~/ycm_temp
cd ~/ycm_temp

wget $LLVM_TAR_URL
tar xvf $LLVM_TAR_ARC
mv $LLVM_ROOT_DIR llvm_root_dir

# go to ~/ycm_build and build the project with clang-completion
mkdir ~/ycm_build
cd ~/ycm_build

cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=~/ycm_temp/llvm_root_dir \
    . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp

cmake --build . --target ycm_core --config Release

# Add support for other languages here
# Full ycm docs: https://github.com/Valloric/YouCompleteMe

cd ~
rm -rf ~/ycm_temp
rm -rf ~/ycm_build

