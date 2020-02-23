#!/bin/sh

if [ ! -z "$(pidof cmus)" ]; then
	# Play / Pause
	cmus-remote -u
else
	$TERMINAL -c cmus -e cmus
fi

