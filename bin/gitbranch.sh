#!/bin/bash
#
# Display the current git branch
#
# SYNOPSIS
# ========
#
#    gitbranch [prefix [suffix]]
#
# prefix    - prefix the output with this value
#             If no suffix is specified, this value will also be used as
#             suffix. You can pass an empty string to suppress this behaviour.
#
# suffix    - append this value to the output
#
# ---------------------------------------------------------------------------

BRANCH_NAME="`git name-rev --name-only --always HEAD 2>/dev/null`"
PREFIX=""
SUFFIX=""

if [[ $# == 1 ]]; then
    PREFIX=$1
    SUFFIX=$1
elif [[ $# == 2 ]]; then
    PREFIX=$1
    SUFFIX=$2
fi

if [[ $BRANCH_NAME != "" ]]; then
    echo "${PREFIX}${BRANCH_NAME}${SUFFIX}";
else
    echo "";
fi
