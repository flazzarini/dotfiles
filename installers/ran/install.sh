#!/bin/bash

VERSION="0.1.6"
DOWNURL="https://github.com/m3ng9i/ran/releases/download/v${VERSION}/ran_linux_amd64.zip"

BUILD="ran_${VERSION}_linux_amd64"
DOWNLOAD="./$BUILD.zip"

# Actual download and install application
wget -O $DOWNLOAD $DOWNURL
unzip $DOWNLOAD
mkdir -p ~/opt/ran/bin
cp ran_linux_amd64 ~/opt/ran/bin/ran
rm -f ran_linux_amd64 *.zip
ln ~/opt/ran/bin/ran ~/.local/bin/
