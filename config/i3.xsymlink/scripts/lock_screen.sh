#!/bin/bash
if [[ $(pgrep -u $UID -x i3lock) ]] ; then
  echo "The screen is already locked. Exiting."
  exit
fi

~/.config/i3/scripts/notifications.sh off
i3lock-fancy -nf Fira-Code-Retina-Nerd-Font-Complete
~/.config/i3/scripts/notifications.sh on

