theme_one=$1
theme_two=$2
theme_alt= echo $1 | sed -e "s/-light//" -e "s/-dark//"
current_shell_theme=$(gsettings get org.gnome.shell.extensions.user-theme name | tr -d "'")
current_gtk_theme=$(gsettings get org.gnome.desktop.interface gtk-theme | tr -d "'")

# toogle gtk theme
if [ $theme_one = $current_gtk_theme ]
then
    gsettings set org.gnome.desktop.interface gtk-theme $theme_two
else
    gsettings set org.gnome.desktop.interface gtk-theme $theme_one
fi

# toogle shell theme
if [ $theme_one = $current_shell_theme ]
then
    gsettings set org.gnome.shell.extensions.user-theme name "$theme_alt"
    gsettings set org.gnome.shell.extensions.user-theme name $theme_two
else
    gsettings set org.gnome.shell.extensions.user-theme name "$theme_alt"
    gsettings set org.gnome.shell.extensions.user-theme name $theme_one
fi
