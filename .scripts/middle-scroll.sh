#!/bin/sh

device_id="12"

case $1 in
	"enable")
		xinput set-prop $device_id "libinput Button Scrolling Button" 2
		notify-send "middle scroll enabled."
		;;

	"disable")
		xinput set-prop $device_id "libinput Button Scrolling Button" 0
		notify-send "middle scroll disabled."
		;;

	*)
		echo $0 "disable | enable"
		;;
esac

