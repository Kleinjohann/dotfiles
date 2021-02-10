#!/bin/bash

ALL_READ_COLOR="%{F#3a3a3a}"  # Color when there are no unread mails
END_COLOR="%{F-}"
ICON=" "

# We need the first occurrence of `^A2=[0-9]` within the last set of [] that contains this pattern
# 1. get all [] containing `^A2=[0-9]`
# 2. only keep tha last set of []
# 3. remove newlines to search the entire []
# 4. find the first occurrence of `^A2=[0-9]` and extract the number
COUNT=$(sed -n '/.*\[/{:start /\]/!{N;b start};/.*^A2.*/p}' "$(find ~/.thunderbird -name 'INBOX.msf' )" | sed -zn 's/.*\[\(.*\)/\1/p' | tr -s '\n' ' ' | perl -pe "s|.*?A2=([0-9]*).*|\1|p")

# Display the formatted message
if (( COUNT > 0)); then
    echo "$ICON$COUNT"
else
    echo "${ALL_READ_COLOR}${ICON}${END_COLOR}"
fi

