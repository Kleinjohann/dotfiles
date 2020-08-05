#!/bin/bash

mons -e left
nitrogen --restore
killall polybar > /dev/null 2>&1
sleep 1
~/.config/i3/scripts/launch_polybar.sh > /dev/null 2>&1 &
