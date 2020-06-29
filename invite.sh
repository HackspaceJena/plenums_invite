#!/usr/bin/env bash

## Configuration

from="office@krautspace.de"
to=("hackspace-jena@lstsrv.org" "krautspace-announce@lstsrv.org")
subject="Einladung zum Plenum"
body_file=email_text # Use PROSEDATE for dd.mm.YYYY and URLDATE for YYYmmdd

## Find next Thursday

day_of_week=$(date +%u)

next_thursday_offset=$(( ( ( 7 - $day_of_week ) + 4 ) % 7 ))

## Check if next Thursday is the first of a month

if (( $(date -d "+$next_thursday_offset days" +%_d) > 7 )); then
    echo "Invitation should be sent at most a week in advance."
    echo "Exiting without sending an inviation..."
    exit
fi

## Send invitation

prose_date=$(date -d "+$next_thursday_offset days" +%d.%m.%Y)
url_date=$(date -d "+$next_thursday_offset days" +%Y%m%d)

script_path=$(readlink -f "$0")
source_directory=$(dirname "$script_path")

cat "$source_directory/$body_file" | sed -e "s/PROSEDATE/$prose_date/g" | sed -e "s/URLDATE/$url_date/g" | mail -s "$subject" -r "$from" "${to[@]}"
