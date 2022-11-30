#!/bin/sh

is_workspace_isolated=$(gsettings get org.gnome.shell.extensions.dash-to-dock isolate-workspaces)

if [ $is_workspace_isolated = "true" ]
then
    gsettings set org.gnome.shell.extensions.dash-to-dock isolate-workspaces false
else
    gsettings set org.gnome.shell.extensions.dash-to-dock isolate-workspaces true
fi
