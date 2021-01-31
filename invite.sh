#!/usr/bin/env bash

## Configuration

from="office@krautspace.de"
to=("hackspace-jena@lstsrv.org" "krautspace-announce@lstsrv.org")
replyto="hackspace-jena@lstsrv.org"
subject="Einladung zum Plenum"
location="https://blue.kabi.tk/b/hac-nuf-fp4"
body_file=email_text # Use PROSEDATE for dd.mm.YYYY and URLDATE for YYYmmdd

## Find next Thursday
date_fmt () { date -u -d "$2 next Thu" $1; }

## Check if next Thursday is the first of a month

if (( $(date_fmt +%_d) > 7 )); then
    echo "Invitation should be sent at most a week in advance."
    echo "Exiting without sending an inviation..."
    exit
fi

## Send invitation

prose_date=$(date_fmt +%d.%m.%Y)
url_date=$(date_fmt +%Y%m%d)

script_path=$(readlink -f "$0")
source_directory=$(dirname "$script_path")

sed -E \
	-e "s/#DTSTART#/$(date_fmt +%Y%m%dT%H%M%SZ "TZ=\"Europe/Berlin\" 20:00")/" \
	-e "s/#DTEND#/$(date_fmt +%Y%m%dT%H%M%SZ "TZ=\"Europe/Berlin\" 21:00")/" \
	-e "s/#DTSTAMP#/$(date -u +%Y%m%dT%H%M%SZ)/" \
	-e "s/#SUMMARY#/KrautSpace Plenum/" \
	-e "s%#LOCATION#%${location}%" \
	-e "s/#FROM#/${from}/g" \
	-e "s/#URLDATE#/${url_date}/g" \
	-e 's/(^[^ ].{73}|.{73})/\1\r\n /g' \
	"$source_directory/invite.ics" > /tmp/invite.ics

sed -e "s/PROSEDATE/$prose_date/g" \
	-e "s/URLDATE/$url_date/g" \
	"$source_directory/$body_file" | mail -s "$subject" -r "$from" -A /tmp/invite.ics "${to[@]}"
ret=$?
rm -f /tmp/invite.ics
exit $ret
