#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

export WIFI_IF="$(ip -br addr | grep -E 'w(\w+|\d+).*UP' | cut -d ' ' -f 1)"

if [ "$(grep '^ID' /etc/os-release | cut -d '=' -f 2)" == 'arch' ]; then
        export MONITOR="HDMI-2"
        polybar --reload top -c ~/.config/polybar/config-top.ini &
        polybar --reload bottom -c ~/.config/polybar/config-bottom.ini &
else
    for monitor in $(polybar --list-monitors | cut -d ":" -f1); do
        MONITOR=$monitor polybar --reload top -c ~/.config/polybar/config-top.ini &
        MONITOR=$monitor polybar --reload bottom -c ~/.config/polybar/config-bottom-work.ini &
    done
fi

