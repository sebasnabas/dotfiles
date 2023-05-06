#!/bin/sh

usb_icon="󰕓"

if [ -n "$(udisksctl status | grep -vE '(DEVICE|-|sda)')" ]; then
    echo "$usb_icon "
else
    echo ""
fi
