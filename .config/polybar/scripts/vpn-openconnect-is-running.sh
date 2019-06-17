#!/bin/sh

if [ "$(pgrep openconnect)" ]; then
    echo "vpn"
    # ⇆ vpn
else
    echo "vpn off"
fi
