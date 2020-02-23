#!/bin/sh

pgrep -x transmission-da >/dev/null || (transmission-daemon && notify-send "Transmission" "Starting transmission daemon..." && sleep 1)

tremc

