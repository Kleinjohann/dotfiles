#!/bin/bash

ALL_READ_COLOR="%{F#3a3a3a}"  # Color when there are no unread mails
END_COLOR="%{F-}"
ICON=" "

COUNT=$(notmuch count 'tag:unread')

# Display the formatted message
if (( COUNT > 0)); then
    echo "$ICON$COUNT"
else
    echo "${ALL_READ_COLOR}${ICON}${END_COLOR}"
fi

