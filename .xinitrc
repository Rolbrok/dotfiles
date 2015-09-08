#!/bin/bash

wm=3

setxkbmap fr

feh --bg-fill ~/Pictures/sharky.jpg

synclient TapButton2=2
synclient TapButton3=3
synclient HorizTwoFingerScroll=1

export PATH=$PATH:/home/rolbrok/.bin
export _JAVA_AWT_WM_NONREPARENTING=1
export _THEME=default

update_notifier &
notify-server &
start_xflux &

systemctl --user start audio-server

case $wm in
    1)
        echo "gnome it is !"
        exec gnome-session
        ;;
    2)
        echo "cinnamon it is !"
        exec cinnamon-session
        ;;
    3)
        export PATH=$PATH:/home/rolbrok/.panel
        echo "bspwm it is !"
        sxhkd &
        xsetroot -cursor_name left_ptr
        notify-daemon &
        xrdb -load ~/.Xresources &
        exec bspwm
        ;;
esac
