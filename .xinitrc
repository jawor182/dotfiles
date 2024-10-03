#!/bin/bash


# Launch applications in the background
picom -b &
# nm-applet &
# blueman-applet &
dunst &
dwmblocks &
nitrogen --restore &
# pavucontrol &


export GTK_THEME=Adwaita-dark
export QT_STYLE_OVERRIDE=fusion
# gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
# qsettings write org/qt/application/stylesheet fusion

xrdb -load ~/.Xresources
~/.config/screenlayout/screen.sh
exec dwm
