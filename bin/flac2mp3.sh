#!/bin/bash
for file in *.flac; do $(flac -cd "$file" | lame --alt-preset insane - "${file%.flac}.mp3"); done




