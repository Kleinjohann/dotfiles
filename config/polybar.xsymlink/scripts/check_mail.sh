#!/bin/bash

THUNDERBIRD_HOME=$HOME/.thunderbird
ALL_READ_COLOR="%{F#3a3a3a}"  # Color when there are no unread mails
END_COLOR="%{F-}"
ICON=" "

cd $THUNDERBIRD_HOME
COUNTS=`find . -name '*.msf' -exec grep -REo 'A2=[0-9]' {} + | grep -Eo 'imap.fz-juelich.*INBOX.*=[0-9]+'`

COUNT=0

# Counts are in chronological order, so it's safe to assume that the latest is the most recent update
for line in $COUNTS; do
    COUNT=`echo $line | awk -F ':A2=' '{ print $2 }'`
done

# Showing the formatted message
if (( COUNT > 0)); then
    echo "$ICON$COUNT"
else
    echo "${ALL_READ_COLOR}${ICON}${END_COLOR}"
fi

