#!/bin/bash
xauth list | cut -f1 -d\  | xargs -i xauth remove {}
