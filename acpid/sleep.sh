#!/bin/sh

# if launched through a lid event and lid is open, do nothing
echo "$1" | grep "button/lid" && grep -q open /proc/acpi/button/lid/LID/state && exit 0

# sync filesystem and clock
sync
/sbin/hwclock --systohc

# switch to console
FGCONSOLE=`fgconsole`
chvt 6

# go to sleep
sleep 5 && echo -n "mem" > /sys/power/state

# readjust the clock (it might be off a bit after suspend)
/sbin/hwclock --adjust
/sbin/hwclock --hctosys

# turn on the backlight and switch back to X
chvt $FGCONSOLE
