#!/bin/sh

path="."
[ ! -z "$1" ] && path="$1"

echo "$path"
file=$(find "$path" -name '*.png' -o -name '*.jp*g' | shuf -n 1)
echo "The chosen walpaper is:" $file
setbg "$file"

