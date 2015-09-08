#!/bin/sh

xrandr --auto
xrandr --output eDP1 --mode 1366x768 --noprimary --pos 1920x0
xrandr --output HDMI1 --mode 1920x780 --primary --pos 0x0
xrandr --current

reset_wm
