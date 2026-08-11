#!/bin/sh
# GNOME theme switcher.
#
# Usage:
#   theme.sh dark          apply the dark theme
#   theme.sh light         apply the light theme
#   theme.sh toggle        switch between light/dark based on the current GTK theme
#   theme.sh set <name>    set the GTK theme (and shell theme if a match is known)

DARK_CURSOR="Yaru-Purple"
DARK_APP="Yaru-Purple-dark"
DARK_SHELL="Yaru-Purple"

LIGHT_CURSOR="Yaru"
LIGHT_APP="Yaru-Purple"
LIGHT_SHELL="Yaru-Purple-light"

TOGGLE_LIGHT_APP="Prof-Gnome-Light-DS-3.6"
TOGGLE_DARK_APP="Prof-Gnome-Dark-3.6"
TOGGLE_LIGHT_SHELL="Prof-Gnome-Light-DS-3.6"
TOGGLE_DARK_SHELL="Prof-Gnome-Dark-3.6"

apply_theme() {
    gsettings set org.gnome.desktop.interface cursor-theme "$1"
    gsettings set org.gnome.desktop.interface gtk-theme "$2"
    gsettings set org.gnome.desktop.wm.preferences theme "$2"
    gsettings set org.gnome.shell.extensions.user-theme name "$3"
}

apply_shell_theme() {
    gsettings set org.gnome.desktop.interface gtk-theme "$1"
    gsettings set org.gnome.shell.extensions.user-theme name "$2"
}

case $1 in
dark)
    apply_theme "$DARK_CURSOR" "$DARK_APP" "$DARK_SHELL"
    ;;
light)
    apply_theme "$LIGHT_CURSOR" "$LIGHT_APP" "$LIGHT_SHELL"
    ;;
toggle)
    current=$(gsettings get org.gnome.desktop.interface gtk-theme | tr -d "'")
    if [ "$current" = "$TOGGLE_LIGHT_APP" ]; then
        apply_shell_theme "$TOGGLE_DARK_APP" "$TOGGLE_DARK_SHELL"
    else
        apply_shell_theme "$TOGGLE_LIGHT_APP" "$TOGGLE_LIGHT_SHELL"
    fi
    ;;
set)
    if [ -z "$2" ]; then
        echo "Usage: theme.sh set <name>" >&2
        exit 1
    fi
    gsettings set org.gnome.desktop.interface gtk-theme "$2"
    ;;
*)
    echo "Usage: theme.sh [dark|light|toggle|set <name>]" >&2
    exit 1
    ;;
esac
