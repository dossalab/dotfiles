#!/bin/sh
ffmpeg -framerate 25 -f x11grab $(slop -f "-video_size %wx%h -i :0.0+%x,%y") out.gif
xclip -selection clipboard -t image/gif out.gif
