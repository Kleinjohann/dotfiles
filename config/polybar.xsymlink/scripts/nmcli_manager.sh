#!/usr/bin/env bash

#
# nmcli connection switching from a rofi menu.
# When a network is selected its status is switched  from UP to DOWN or vice versa.
#
# WARNING, connection name can't contain a # or | symbol
#

ROFI="rofi -dmenu
           -sep #
           -i -p Network
           -location 3
           -yoffset +45
           -xoffset -80
           -width 30
"

build_rofi_menu()
{
    while read -r line
    do
          name="$(echo "$line" | cut -d':' -f1)"
         dtype="$(echo "$line" | cut -d':' -f2)"
        device="$(echo "$line" | cut -d':' -f3)"

        [ -z "$device" ] && status= || status=
        dtype=${dtype##*-}
        option=$(printf '%-35s | %-15s | %s\n' "$name" "$dtype" $status)

        menu="$menu # $option"
    done  < <(nmcli -c no --terse -f NAME,TYPE,DEVICE connection show)

    echo "$menu" | cut -c 3-
}

switch_connections()
{
    name="$1"
    status=$2

    if [ "$status" = "" ]; then
        nmcli connection down "$name"
    else
        nmcli connection up "$name"
    fi
}

main()
{
    menu=$(build_rofi_menu)
    choice=$(echo "$menu" | $ROFI)
    [ "$?" -ne 0 ] && return 1

    name=$(echo "$choice" | cut -d '|' -f 1 | awk '{$1=$1;print}')
    stat=$(echo "$choice" | cut -d '|' -f 3 | awk '{$1=$1;print}')

    switch_connections "$name" "$stat"
}

main
