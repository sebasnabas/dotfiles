#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

right_monitor="DisplayPort-0"
left_monitor="HDMI-A-0"

MONITOR=$right_monitor polybar --reload top -c ~/.config/polybar/config-top.ini &
MONITOR=$left_monitor polybar --reload top -c ~/.config/polybar/config-top.ini &

if [ "$(grep '^ID' /etc/os-release | cut -d '=' -f 2)" = 'arch' ]; then
        MONITOR=$left_monitor polybar --reload bottom -c ~/.config/polybar/config-bottom.ini &
else
        MONITOR=$right_monitor polybar --reload bottom -c ~/.config/polybar/config-bottom-work.ini &
fi
