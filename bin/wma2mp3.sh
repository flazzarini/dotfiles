#!/bin/bash

#convert wma to mp3

FILES="*.wma"

for F in $FILES

do
    newname=`basename "$F" .wma`
    echo $newname
    ffmpeg -i "$F" -acodec libmp3lame -ac 2 -ab 192k -ar 44100 "$newname.mp3"
done
