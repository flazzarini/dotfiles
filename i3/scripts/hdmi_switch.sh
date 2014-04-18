#!/bin/bash

if [ ! -z "`xrandr | grep 'HDMI1 connected'`" ]; then
    xrandr --output LVDS1 --off
    xrandr --output HDMI1 --auto
else
    xrandr --output LVDS1 --auto
    xrandr --output HDMI1 --off
fi
