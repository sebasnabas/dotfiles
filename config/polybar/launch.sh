#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

primary_monitor="$(xrandr | grep primary | cut -d ' ' -f 1)"

MONITOR="$primary_monitor" polybar --reload top -c ~/.config/polybar/config-top.ini &

xrandr | grep '\sconnected' | grep -v "$primary_monitor" | cut -d ' ' -f 1 | while read -r monitor
do
    MONITOR="$monitor" polybar --reload top -c ~/.config/polybar/config-top-simple.ini &
done

feh --bg-fill ~/.config/wall.png &
