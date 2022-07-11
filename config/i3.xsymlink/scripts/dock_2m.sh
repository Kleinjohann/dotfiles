#!/bin/bash

xrandr --output DP-2-2 --auto --above eDP-1
xrandr --output DP-2-1 --auto --right-of DP-2-2
nitrogen --restore
killall polybar > /dev/null 2>&1
sleep 1
setxkbmap -option 'caps:ctrl_modifier'
xmodmap ~/.Xmodmap
~/.config/i3/scripts/launch_polybar.sh > /dev/null 2>&1 &
