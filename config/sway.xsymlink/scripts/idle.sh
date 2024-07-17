#!/bin/bash

swayidle -w timeout 600 'swaymsg "output * dpms off"' \
            resume 'swaymsg "output * dpms on"' \
            before-sleep '~/.config/sway/scripts/lock_screen.sh'

