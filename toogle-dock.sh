#!/bin/sh

dock_state=$(gnome-extensions info ubuntu-dock@ubuntu.com | grep "State" | cut -d":" -f 2 | xargs)
if [ $dock_state = "ENABLED" ]
then
    gnome-extensions disable ubuntu-dock@ubuntu.com
else
    gnome-extensions enable ubuntu-dock@ubuntu.com
fi
