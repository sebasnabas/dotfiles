#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

for monitor in $(polybar --list-monitors | cut -d ":" -f1); do
    MONITOR=$monitor polybar --reload top -c ~/.config/polybar/config-top.ini &
    if [ $(uname -r | grep 'arch')] ; then
        MONITOR=$monitor polybar --reload bottom -c ~/.config/polybar/config-bottom.ini &
    else
        MONITOR=$monitor polybar --reload bottom -c ~/.config/polybar/config-bottom-work.ini &
    fi
done

