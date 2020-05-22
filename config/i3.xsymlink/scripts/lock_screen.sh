#!/bin/bash
if [[ $(pgrep -u $UID -x i3lock) ]] ; then
  echo "The screen is already locked. Exiting."
  exit
fi

~/.config/i3/scripts/notifications.sh off
~/.config/i3/scripts/i3lock-fancy-dualmonitor.sh -f FiraCode Nerd Font
~/.config/i3/scripts/notifications.sh on

