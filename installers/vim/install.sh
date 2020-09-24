#!/bin/bash

VERSION="8.2.1736"
DOWNURL="https://github.com/vim/vim/archive/v$VERSION.tar.gz"

BUILD="vim-$VERSION"
DOWNLOAD="./$BUILD.tar.gz"

# Actual download and install application
wget -O $DOWNLOAD $DOWNURL
tar xzf $DOWNLOAD
cd $BUILD && ./configure \
  --prefix="$HOME/opt/vim" \
  --disable-darwin \
  --disable-smack \
  --enable-multibyte \
  --enable-python3interp \
  --enable-cscope \
  --with-features=huge \
  --with-python3-config-dir=/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu
make && make install
rm -f $DOWNLOAD
rm -rf $BUILD
