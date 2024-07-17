#!/bin/bash


case "$1" in
	--cpu)
		notify-send "CPU time (%)" "$(ps axch -o cmd,pcpu k -pcpu | head | awk '$NF=$NF"%"' )"
		;;
	--mem)
        notify-send "Memory (MB)" "$(ps axch -o cmd,rss k -rss | head | awk '$NF=int($NF/1024)"M"' )"
    esac
