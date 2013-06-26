#!/bin/bash
#
# Take screenshot of the desktop. Use this image to show as background on 
# the lock screen

scrot /tmp/i3lockscreen.png
i3lock -i /tmp/i3lockscreen.png
