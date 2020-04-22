#!/bin/bash

if [ -z "$(pgrep -x polybar)" ]; then
    BAR="alexbar"
    for m in $(polybar --list-monitors | cut -d":" -f1); do
        if [[ $m == *"eDP"* ]]; then
            pos="right"
        else
            pos=""
        fi
        MONITOR=$m TRAYPOS=$pos polybar --reload $BAR &
        sleep 1
    done
else
    polybar-msg cmd restart
fi
