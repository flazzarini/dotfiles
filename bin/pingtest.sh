#!/bin/bash

if ping -c 1 -W 2 $1 > /dev/null; then
    echo "\${color3}UP"
else
    echo "\${color4}DOWN"
fi
