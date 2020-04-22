#!/bin/bash

xrandr --output DP2-2 --auto --left-of eDP1
nitrogen --restore
killall polybar > /dev/null 2>&1
sleep 1
~/.config/i3/scripts/launch_polybar.sh > /dev/null 2>&1 &
