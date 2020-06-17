#!/bin/bash

VERSION="8.2.0993"
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
  --enable-python3interp \
  --with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu
make && make install
rm -f $DOWNLOAD
rm -rf $BUILD
