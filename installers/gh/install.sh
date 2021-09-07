#!/bin/bash

VERSION="2.0.0"
DOWNURL="https://github.com/cli/cli/releases/download/v${VERSION}/gh_${VERSION}_linux_amd64.tar.gz"

BUILD="gh_${VERSION}_linux_amd64"
DOWNLOAD="./$BUILD.tar.gz"

# Actual download and install application
wget -O $DOWNLOAD $DOWNURL
tar xzf $DOWNLOAD
mkdir -p ~/opt/gh/bin
cp -r $BUILD/* ~/opt/gh/
rm -f $DOWNLOAD
rm -rf $BUILD
ln ~/opt/gh/bin/gh ~/.local/bin/
