#!/usr/bin/bash

date=$(date +%Y%m%d%H%M%S)
new_version="/tmp/email-todo"$date
echo "tempfile: "$new_version | tee -a /tmp/email-todo-log$date
grep -Pzo "(?s)\* todo \n.*?\* Personal" /home/mathan/orgd/organiser.org | head -n -1 | tail -n+5 > "$new_version"
# cat $new_version

diff_result=$(diff "$new_version" /home/mathan/sh/email-todo.bck)

app_specific_password=$(cat /home/mathan/sh/app-specific-curl-password)

if [[ $diff_result ]] ; then
    echo "updates detected, sending mail" | tee -a /tmp/email-todo-log$date
    /home/mathan/sh/curl-smtp-google.sh  barrelrollmais $app_specific_password mais16384@gmail.com "Todo\ update:\ $(date +%Y-%m-%d)" $new_version && cat "$new_version" > /home/mathan/sh/email-todo.bck
else
    echo "no updates detected, stopping." | tee -a /tmp/email-todo-log$date
fi



