#!/bin/sh
export DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS
gsettings set org.gnome.desktop.interface gtk-theme $1
