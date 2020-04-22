#!/bin/bash
if [[ $(pgrep -u $UID -x i3lock) ]] ; then
  echo "The screen is already locked. Exiting."
  exit
fi
kill -SIGUSR1 $(pidof dunst)
i3lock-fancy -f Fira-Code-Retina-Nerd-Font-Complete
kill -SIGUSR2 $(pidof dunst)
