#!/bin/bash

BAT0=$(cat /sys/class/power_supply/BAT0/capacity)
BAT1=$(cat /sys/class/power_supply/BAT1/capacity)

BAT0_ST=$(cat /sys/class/power_supply/BAT0/status)
BAT1_ST=$(cat /sys/class/power_supply/BAT1/status)

if [ "$BAT0_ST" == "Unknown" ]; then
	BAT0_ST=""
fi

if [ "$BAT1_ST" == "Unknown" ]; then
	BAT1_ST=""
fi

DATE=$(date +"%d %B, %A")
TIME=$(date +"%H:%M")


TIMEDATE_STR=$(echo -e "$TIME\n$DATE\n")
BATT0_STR="Battery 0: $BAT0% $BAT0_ST"
BATT1_STR="Battery 1: $BAT1% $BAT1_ST"
NET_STR=$(nmcli | grep -oi 'connected to.*')

notify-send "$(echo -e "$TIMEDATE_STR\n\n$BATT0_STR\n$BATT1_STR\n\n$NET_STR")"

