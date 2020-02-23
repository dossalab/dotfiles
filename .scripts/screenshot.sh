#!/bin/sh

if [ ! -n "$1" ]; then
	echo -e "Usage:\n" \
		"-s: whole screen\n" \
		"-w: current window\n" \
		"-a: selected area"
	exit
fi

case $1 in
"-s")
	maim -B | xclip -selection clipboard -t image/png
	;;
"-w")
	maim -Bi $(xdotool getactivewindow) | xclip -selection clipboard -t image/png
	;;
"-a")
	maim -Bg $(slop) | xclip -selection clipboard -t image/png
	;;
*)
	echo "Unknown argument!"
esac

