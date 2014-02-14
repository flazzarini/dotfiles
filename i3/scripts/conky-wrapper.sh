#!/bin/sh

# Send the header so that i3bar knows we want to use JSON:
echo "{\"version\":1}"

# Begin the endless array.
echo "[[]"

# Now send blocks with information forever:
exec conky -c $HOME/.i3/scripts/conkyrc
