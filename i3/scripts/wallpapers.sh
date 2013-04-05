#!/bin/sh

while true; do
    find ~/wallpapers/ -type f \( -name '*.jpg' -o -name '*.png' \) -print0 |
        shuf -n1 -z | xargs -0 feh --bg-max --auto-zoom
    sleep 45m
done
