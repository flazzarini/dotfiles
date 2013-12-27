#!/bin/bash

LOCKFILE="/tmp/touchpad-off.lck"

if [ -f "$LOCKFILE" ]; then
    echo "Enabling touchpad"
    xinput set-prop "SynPS/2 Synaptics TouchPad" "Synaptics Off" 0
    rm -f $LOCKFILE
else
    echo "Disabling touchpad"
    xinput set-prop "SynPS/2 Synaptics TouchPad" "Synaptics Off" 1
    touch $LOCKFILE
fi
