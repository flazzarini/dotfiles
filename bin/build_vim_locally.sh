#!/bin/bash

BASE_COMPILE_PATH=`realpath ~/downloads/tmp_build_vim`
PREFIX_PATH=`realpath ~/opt/vim/`

# Change directory to ~/downloads
mkdir -p $BASE_COMPILE_PATH && cd $BASE_COMPILE_PATH

[ -f $BASE_COMPILE_PATH/vim ] || cd $BASE_COMPILE_PATH && git clone --depth 1 https://github.com/vim/vim.git
cd $BASE_COMPILE_PATH/vim && git checkout master && git pull

cd $BASE_COMPILE_PATH/vim && ./configure \
    --enable-python3interp=yes \
    --enable-luainterp=yes \
    --with-features=huge \
    --prefix=$PREFIX_PATH

cd $BASE_COMPILE_PATH/vim && make && make install
