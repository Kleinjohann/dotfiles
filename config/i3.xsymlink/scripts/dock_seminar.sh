#!/bin/bash

xrandr --output DVI-I-2-2 --auto --right-of eDP-1
xrandr --output DVI-I-1-1 --auto --right-of DVI-I-2-2
nitrogen --restore
killall polybar > /dev/null 2>&1
sleep 1
setxkbmap -option 'caps:ctrl_modifier'
xmodmap ~/.Xmodmap
~/.config/i3/scripts/launch_polybar.sh > /dev/null 2>&1 &
