#!/bin/sh

case "$1" in
    --popup)
        notify-send "Memory (MB)" "$(ps axch -o cmd,rss k -rss | head | awk '$NF=int($NF/1024)"M"' )"
        ;;
    *)
        echo "$(free -h --si | awk '/^Mem:/ {print $3}' | sed 's/,/./g')"
        ;;
esac
