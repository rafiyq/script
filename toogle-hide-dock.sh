#!/bin/sh

dock_fixed=$(gsettings get org.gnome.shell.extensions.dash-to-dock dock-fixed)

gsettings set org.gnome.shell.extensions.dash-to-dock autohide true
gsettings set org.gnome.shell.extensions.dash-to-dock intellihide true
if [ $dock_fixed = "true" ]
then
    gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
else
    gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed true
fi
