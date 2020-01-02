#!/bin/sh

if [ -n "$(nmcli connection show --active | rg wireguard)" ]; then
    echo "Wg"
else
    echo ""
fi
