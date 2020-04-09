#!/bin/bash

get_build_ext() {
  arch=$(lscpu | grep Architecture | cut -d ":" -f 2 | xargs)
  declare -A map
  map["x86_64"]="x86_64-unknown-linux-gnu"
  map["x86"]="i686-unknown-linux-gnu"
  map["arm"]="arm-unknown-linux-gnueabihf"
  echo "${map[$arch]}"
}

VERSION="0.13.0"
BASEURL="https://github.com/sharkdp/bat/releases/download/v$VERSION"
FILEBASE="bat-v$VERSION"

BUILDEXT=$(get_build_ext)
BUILD=$FILEBASE-$BUILDEXT
DOWNLOAD="/tmp/bat-$VERSION.tar.gz"

# Actual download and install application
wget -O $DOWNLOAD $BASEURL/$BUILD.tar.gz
tar xzf $DOWNLOAD $BUILD/bat
mv $BUILD/bat $HOME/.local/bin/
rm $DOWNLOAD && rm -rf $BUILD
