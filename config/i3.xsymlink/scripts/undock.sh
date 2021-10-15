#!/bin/bash

mons -o
nitrogen --restore
killall polybar > /dev/null 2>&1
sleep 1
setxkbmap -option 'caps:ctrl_modifier'
xmodmap ~/.Xmodmap
~/.config/i3/scripts/launch_polybar.sh > /dev/null 2>&1 &
