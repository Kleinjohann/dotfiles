#!/bin/bash
on() {
  kill -SIGUSR2 $(pidof dunst)
}

off() {
  kill -SIGUSR1 $(pidof dunst)
}


if [ "$1" = "on" ] ; then
  on
elif [ "$1" = "off" ] ; then
  off
fi

