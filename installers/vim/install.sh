#!/bin/bash

set -e

VERSION="9.0.1216"
DOWNURL="https://github.com/vim/vim/archive/v$VERSION.tar.gz"

BUILD="vim-$VERSION"
DOWNLOAD="./$BUILD.tar.gz"

# Actual download and install application
test -f $DOWNLOAD || wget -O $DOWNLOAD $DOWNURL
test -d $BUILD || tar xzf $DOWNLOAD

# Issue when compiling against pyenv python
#  https://github.com/ycm-core/YouCompleteMe/issues/3580
export LDFLAGS="-rdynamic"
export PY_CONF=/home/users/frank/.pyenv/versions/3.10.9/lib/python3.10/config-3.10-x86_64-linux-gnu
export PY_INCL=/home/users/frank/.pyenv/versions/3.10.9/include

cd $BUILD
make distclean
./configure \
  --prefix="$HOME/opt/vim" \
  --disable-darwin \
  --disable-smack \
  --enable-multibyte \
  --enable-python3interp \
  --enable-cscope \
  --with-python3-config-dir=$PY_CONF \
  --includedir=$PY_INCL \
  --with-features=huge

make && make install
