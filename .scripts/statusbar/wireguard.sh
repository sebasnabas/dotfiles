#!/bin/sh

if [ -n "$(nmcli connection show --active | grep wireguard)" ]; then
    echo "%{T8}列%{T-}"
else
    echo ""
fi

