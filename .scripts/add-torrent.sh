#!/bin/sh

pgrep -x transmission-da >/dev/null || (transmission-daemon && notify-send "Transmission" "Starting transmission daemon..." && sleep 1)

transmission-remote -a "$@" && exec notify-send "Transmission" "Torrent added!"

