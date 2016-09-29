#!/bin/bash

# Setup environment
FORMAT=$(which mkfs.vfat 2>/dev/null)
MOUNT=$(which mount 2>/dev/null)
TMP='/tmp'
shopt -s dotglob

# Verify binaries exist
MISSING=''
[ ! -e "$FORMAT" ] && MISSING+='mkfs.vfat, '
[ ! -e "$MOUNT" ] && MISSING+='mount, '
if [ -n "$MISSING" ]; then
   echo "Error: cannot find the following binaries: ${MISSING%%, }"
   exit
fi

# Verify arguments
if [ ! -d "$1" ]; then
   echo "Error: You must specify a directory containing the floppy disk files"
   exit
else
   DISK=$(basename "${1}")
   IMG="${TMP}/${DISK}.img"
   TEMP="${TMP}/temp_${DISK}"
fi

# Load loopback module if necessary
if [ ! -e /dev/loop0 ]; then
   sudo modprobe loop
   sleep 1
fi

# Create disk image
${FORMAT} -C "${IMG}" 1440
mkdir "${TEMP}"
sudo $MOUNT -o loop,uid=$UID -t vfat "${IMG}" "${TEMP}"
cp -f "${DISK}"/* "${TEMP}"/
sudo umount "${TEMP}"
rmdir "${TEMP}"
mv "${IMG}" .
