#!/bin/sh

usb_icon=""

if [ -n "$(udisksctl status | grep -vE '(DEVICE|-|nvme0n1|sda|sr0)')" ]; then
    echo $usb_icon
else
    echo ""
fi
