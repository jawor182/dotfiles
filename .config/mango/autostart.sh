#!/bin/sh

waybar &
awww-daemon &
foot -s &
dunst &
playerctld &
wallpaper random &
nightlight &
/usr/lib/xdg-desktop-portal &
/usr/lib/xdg-desktop-portal-wlr &

swayidle -w \
    timeout 600 "wlr-dpms off" \
    resume "wlr-dpms on"
