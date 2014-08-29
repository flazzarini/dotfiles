#!/bin/bash
#
# update-grive.sh
#
#  Monitor a folder defined in this file for changes and run grive to
#  synchronize changes to google drive

FOLDER="/home/frank/gdrive/"
GRIVE=`which grive`
INOTIFYWAIT=`which inotifywait`
TIMEOUT=300

# Preflight checks
if [ -z $INOTIFYWAIT ]; then
    echo "Please make sure you have inotifywait installed"
    exit 1
fi

if [ -z $GRIVE ]; then
    echo "Please make sure you have grive installed"
    exit 1
fi


while true; do
    $INOTIFYWAIT -t $TIMEOUT -e modify -e move -e create -r $FOLDER
    cd $FOLDER && $GRIVE
done
