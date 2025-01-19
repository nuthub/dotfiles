#!/usr/bin/env bash
output=$(emacsclient -e '(jf/org-pomodoro-text-time)')
output=$(sed -e 's/^"//' -e 's/"$//' <<< "$output")
output=$(sed -e 's/\\"/"/g' <<< $output)
output=$(echo $output | sed -e 's/nil//g')
echo $output
