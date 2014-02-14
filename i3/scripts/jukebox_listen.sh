#!/bin/bash

VLC=`which cvlc`

if [ -n $VLC ]; then

    # Check if vlc is running
    if [ -e "/tmp/vlc.socket" ]; then

        # Running so pause vlc
        echo -n "pause" | nc -U /tmp/vlc.socket

    else
        # Start vlc

        cvlc -L -I oldrc --rc-unix "/tmp/vlc.socket" --rc-fake-tty -L http://mixer.gefoo.org:8000/jukebox.ogg

    fi
    echo "Please install vlc"
fi
