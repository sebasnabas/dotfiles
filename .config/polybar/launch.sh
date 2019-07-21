#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
polybar top -c ~/.config/polybar/config-top.ini &
polybar bottom -c ~/.config/polybar/config-bottom.ini &

my_laptop_external_monitor=$(xrandr --query | grep 'HDMI1')
if [[ $my_laptop_external_monitor = *connected* ]]; then
    polybar top-external -c ~/.config/polybar/config-top-external.ini &
    polybar bottom-external -c ~/.config/polybar/config-bottom-external.ini &
fi

