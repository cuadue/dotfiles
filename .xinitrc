#!/bin/bash

setxkbmap -option ctrl:nocaps
xrandr --output HDMI2 --auto --right-of HDMI1
xsetroot -bg \#121212 -mod 3 3

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

exec i3

