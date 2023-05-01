#!/bin/bash

#id_tab=$(brotab list | awk '{!($NF=$1);!($1="");print $0;}' | rofi -drun-use-desktop-cache -show -dmenu -i -p "Tab" -markup-rows 5 -theme Arc-Dark | awk '{print $NF}')

$HOME/.local/bin/brotab list | awk '{!($NF=$1);!($1="");print $0;}'

selection=$(
	bspc query -N -n .window | while read -r wid; do
		bspc query -T -n "$wid" | jq -r '
            [
                if .hidden then "H" else "S" end,
                (.client
                 | (.state
                    | if   . == "floating"   then "F"
                      elif . == "fullscreen" then "="
                      elif . == "tiled"      then "T"
                      else "P" end)
                 , "\(.className):\(.instanceName)"),
                .id
            ] | join(" ")
        '
	done | grep "google-chrome"
)

[ -z "$selection" ] && exit 1

if [ "$@" ]; then
	echo "$@" >>$HOME/cafe.txt
	id_tab=$(echo "$@" | awk '{print $NF}')

	echo "$id_tab" >>$HOME/cafe.txt
	$HOME/.local/bin/brotab activate "$id_tab"
	wid=${selection##* }

	bspc node -f "$wid"
	pkill rofi

fi
