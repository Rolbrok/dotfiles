#!/bin/sh

xrandr --auto
xrandr --output eDP1 --mode 1366x768 --primary --pos 0x0
xrandr --output HDMI1 --off
xrandr --current
reset_wm
