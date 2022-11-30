#!/bin/sh

light_gtk_theme="Prof-Gnome-Light-DS-3.6"
dark_gtk_theme="Prof-Gnome-Dark-3.6"

light_shell_theme="Prof-Gnome-Light-DS-3.6"
dark_shell_theme="Prof-Gnome-Dark-3.6"

#theme_alt=$(echo $1 | sed -e "s/-light//" -e "s/-dark//")
current_gtk_theme=$(gsettings get org.gnome.desktop.interface gtk-theme | tr -d "'")
current_shell_theme=$(gsettings get org.gnome.shell.extensions.user-theme name | tr -d "'")

if [ $light_gtk_theme = "$current_gtk_theme" ]
then
    gsettings set org.gnome.desktop.interface gtk-theme $dark_gtk_theme
    gsettings set org.gnome.shell.extensions.user-theme name $dark_shell_theme
else
    gsettings set org.gnome.desktop.interface gtk-theme $light_gtk_theme
    gsettings set org.gnome.shell.extensions.user-theme name $light_shell_theme
fi

