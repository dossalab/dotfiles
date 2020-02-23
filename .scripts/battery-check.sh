#!/bin/sh
# Notify me with notify-send if my battery is below 10%.
# You can set this to run via cron.

[ "$(cat /sys/class/power_supply/BAT0/status)" = "Charging" ] && exit
[ "$(cat /sys/class/power_supply/BAT0/capacity)" -lt 20 ] &&
notify-send -u critical "Battery critically low."

