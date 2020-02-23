#!/bin/sh

RESULT=$(echo -e "yes\nno" | dmenu -p $1)

case $RESULT in
"yes")
	exec $2
	;;
"no")
	;;
esac
