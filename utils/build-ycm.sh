#!/bin/bash
# Script to build YCM component

# Read directory from command line argument
ycm_dir="$HOME/.vim/bundle/YouCompleteMe" 
[ -n "$1" ] && ycm_dir="$1"

# Check that directory exists
[ -e "$ycm_dir" ] || echo "Directory $ycm_dir does not exist. Exiting."

# Go to directory and check out git submodules
cd ~/linux-config/dotfiles/vim/bundle/YouCompleteMe
git submodule update --init --recursive

# Make a temp directory for build files
build_dir=/tmp/ycm_build
[ -e "$build_dir" ] && rm -rf "$build_dir"
mkdir -f "$build_dir"
cd "$build_dir"

# Build with cmake
cmake -G "Unix Makefiles" -DUSE_SYSTEM_LIBCLANG=ON . "$ycm_dir/third_party/ycmd/cpp"
cmake --build . --target ycm_core
