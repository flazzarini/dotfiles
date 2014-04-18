#!/bin/bash

status=`synclient | grep TouchpadOff | tr -d ' '`

if [ $status == 'TouchpadOff=1' ]; then
    synclient TouchpadOff=0
else
    synclient TouchpadOff=1
fi
