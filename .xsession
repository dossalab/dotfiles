#!/bin/sh

xrdb -merge .cache/wal/colors.Xresources
xinput --set-prop 17 'libinput Accel Speed' 0.3
setxkbmap -layout pl,ru -option caps:super,grp:alt_shift_toggle && killall xcape 2>/dev/null ; xcape -e 'Super_L=Escape'
xset r rate 250 50

case $DESKTOP_SESSION in
i3)
  setbg &
  udiskie &
  sxhkd &
  unclutter &
  ;;
esac
