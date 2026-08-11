#!/bin/sh
# GNOME dock utilities.
#
# Usage:
#   dock.sh toggle        enable/disable the ubuntu-dock extension
#   dock.sh hide          toggle dash-to-dock autohide (dock-fixed)
#   dock.sh isolate       toggle dash-to-dock workspace isolation

case $1 in
toggle)
    dock_state=$(gnome-extensions info ubuntu-dock@ubuntu.com | grep "State" | cut -d":" -f 2 | xargs)
    if [ "$dock_state" = "ENABLED" ]; then
        gnome-extensions disable ubuntu-dock@ubuntu.com
    else
        gnome-extensions enable ubuntu-dock@ubuntu.com
    fi
    ;;
hide)
    dock_fixed=$(gsettings get org.gnome.shell.extensions.dash-to-dock dock-fixed)
    gsettings set org.gnome.shell.extensions.dash-to-dock autohide true
    gsettings set org.gnome.shell.extensions.dash-to-dock intellihide true
    if [ "$dock_fixed" = "true" ]; then
        gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
    else
        gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed true
    fi
    ;;
isolate)
    is_isolated=$(gsettings get org.gnome.shell.extensions.dash-to-dock isolate-workspaces)
    if [ "$is_isolated" = "true" ]; then
        gsettings set org.gnome.shell.extensions.dash-to-dock isolate-workspaces false
    else
        gsettings set org.gnome.shell.extensions.dash-to-dock isolate-workspaces true
    fi
    ;;
*)
    echo "Usage: dock.sh [toggle|hide|isolate]" >&2
    exit 1
    ;;
esac
