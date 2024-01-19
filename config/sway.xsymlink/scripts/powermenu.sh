#!/bin/bash

swaynag -t warning -m 'Power Menu Options' -b 'Logout' 'swaymsg exit' -b 'Suspend' 'systemctl suspend' -b 'reboot' 'systemctl reboot' -b 'shutdown' 'systemctl poweroff'
