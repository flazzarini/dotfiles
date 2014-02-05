#!/bin/sh

while true; do
    find ~/pictures/wallpapers/ -type f \( -name '*.jpg' -o -name '*.png' \) -print0 |
        shuf -n1 -z | xargs -0 feh --bg-fill --auto-zoom
    sleep 5
done
