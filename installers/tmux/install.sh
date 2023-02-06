#!/bin/bash

VERSION="3.3"
DOWNURL="https://github.com/tmux/tmux/archive/$VERSION.tar.gz"

BUILD="tmux-$VERSION"
DOWNLOAD="./$BUILD.tar.gz"

# Actual download and install application
wget -O $DOWNLOAD $DOWNURL
tar xzf $DOWNLOAD
( cd $BUILD && sh autogen.sh )
( cd $BUILD && ./configure \
  --prefix="$HOME/opt/tmux" )
( cd $BUILD && make )
mkdir -p ~/opt/tmux/bin
cp $BUILD/tmux ~/opt/tmux/bin/
rm -f $DOWNLOAD
rm -rf $BUILD
