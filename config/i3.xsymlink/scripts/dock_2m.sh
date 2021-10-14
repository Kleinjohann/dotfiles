#!/bin/bash

xrandr --output DP2-2 --auto --right-of eDP1
xrandr --output DP2-3 --auto --right-of DP2-2
nitrogen --restore
killall polybar > /dev/null 2>&1
sleep 1
setxkbmap -option 'caps:ctrl_modifier'
~/.config/i3/scripts/launch_polybar.sh > /dev/null 2>&1 &
