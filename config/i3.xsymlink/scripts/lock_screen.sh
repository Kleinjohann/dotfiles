#!/bin/bash
if [[ $(pgrep -u $UID -x i3lock) ]] ; then
  echo "The screen is already locked. Exiting."
  exit
fi

BLANK='#00000000'
CLEAR='#262626ff'
DEFAULT='#85ad85ff'
TEXT='#dab997ff'
WRONG='#d75f5fff'
VERIFYING='#ffaf00ff'

ARGS="--nofork\
      --insidever-color=$CLEAR\
      --ringver-color=$VERIFYING\
      --insidewrong-color=$CLEAR\
      --ringwrong-color=$WRONG\
      --inside-color=$BLANK\
      --ring-color=$DEFAULT\
      --line-color=$BLANK\
      --separator-color=$DEFAULT\
      --verif-color=$TEXT\
      --wrong-color=$TEXT\
      --time-color=$TEXT\
      --date-color=$TEXT\
      --layout-color=$TEXT\
      --keyhl-color=$VERIFYING\
      --bshl-color=$WRONG\
      --bar-indicator\
      --bar-color=$CLEAR"

~/.config/i3/scripts/notifications.sh off
~/.config/i3/scripts/i3lock-multimonitor/lock -a "$ARGS"
~/.config/i3/scripts/notifications.sh on

