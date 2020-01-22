#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

for monitor in $(polybar --list-monitors | cut -d ":" -f1); do
    MONITOR=$monitor polybar --reload top -c ~/.config/polybar/config-top.ini &
    if [ $(cat /etc/os-release | grep '^ID' | cut -d '=' -f 2) == 'arch' ]; then
        MONITOR=$monitor polybar --reload bottom -c ~/.config/polybar/config-bottom.ini &
    else
        MONITOR=$monitor polybar --reload bottom -c ~/.config/polybar/config-bottom-work.ini &
    fi
done

