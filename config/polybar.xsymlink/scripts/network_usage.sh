#!/usr/bin/env bash

COUNTER_FILE="/dev/shm/polybar_network_usage_$MONITOR"
REFRESH=5

get_icon_by_device()
{
    device=$1

    status_output=$(nmcli -t device status)

    device_type=$(echo "$status_output" | grep -E -m 1 "^$device" | cut -f 2 -d ":")

    case "$device_type" in
        ethernet)
            icon=""
        ;;
        wifi)
            ssid=$(echo "$status_output" | grep -E -m 1 "^$device" | cut -f 4 -d ":")
            icon=" $ssid"
        ;;
        *)
            icon=""
        ;;
    esac

    vpn="$(nmcli -t -f name,type connection show --order name --active 2>/dev/null | grep vpn | head -1 | cut -d ':' -f 1)"

    if [ -n "$vpn" ]; then
        icon="$icon 酪 $vpn"
    fi

    echo $icon
}

while true; do
    default_device=$(ip route list | grep -F default | grep -vF tun | cut -d " " -f 5)
    icon=$(get_icon_by_device "$default_device")
    now=$(date +%s)
    counter_age=$(stat --format %Z $COUNTER_FILE 2>/dev/null)

    if [ -f $COUNTER_FILE ] && [ $((now-counter_age)) -lt $((REFRESH+1)) ]; then
        last_value_in=$(cut -f 1 -d " " $COUNTER_FILE)
        last_value_out=$(cut -f 2 -d " " $COUNTER_FILE)
    fi

    current_values=$(awk -v dev="${default_device}:" '{
        if ($1 == dev) print $2,$10
    }' < /proc/net/dev)

    current_bytes_in=$(echo "$current_values" | cut -f 1 -d " ")
    current_bytes_out=$(echo "$current_values" | cut -f 2 -d " ")

    if [ -n "$last_value_in" ]; then
        bits_in=$((((current_bytes_in-last_value_in) / REFRESH) * 8))
        bits_out=$((((current_bytes_out-last_value_out) / REFRESH) * 8))

        bits_in=$(numfmt --to iec --format "%3.2f" "$bits_in" 2>/dev/null)
        bits_out=$(numfmt --to iec --format "%3.2f" "$bits_out" 2>/dev/null)

        bits_in=$(echo "$bits_in" | sed 's/,/./g')
        bits_out=$(echo "$bits_out" | sed 's/,/./g')
        output=" $bits_in  $bits_out"
        echo "$icon  $output"
    else
        echo "$icon  --  --"
    fi

    echo "$current_values">$COUNTER_FILE
    unset last_value

    sleep $REFRESH
done
