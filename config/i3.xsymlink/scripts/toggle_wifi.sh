#!/bin/bash

if nmcli nm wifi | grep -q "disabled" ; then
    nmcli nm wifi on
    notify-send -i network-wireless-full "Wireless enabled" "Your wireless adaptor has been enabled."
else
    nmcli nm wifi off
    notify-send -i network-wireless-disconnected "Wireless disabled" "Your wireless adaptor has been disabled."
fi
