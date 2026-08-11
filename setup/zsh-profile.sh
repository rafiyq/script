#!/bin/sh
zshenv_path=$HOME/.zshenv
zsh_dir=$HOME/.config/zsh
zshrc_path=$zsh_dir/.zshrc

if [ ! -f $zshenv_path ]
then
    ln -sf $zsh_dir/zshenv $zshenv_path
fi

#prefix=$(dirname $(readlink -f $0))
#[ ! -z "$1" ] && prefix=$1 
newplug ()
{
    plug_url=$1
    plug_name=${plug_url##*/}
    plug_dir=$zsh_dir/plugins/$plug_name
    if [ ! -d $plug_dir ]; then
        git clone $plug_url $plug_dir
    else
        echo "$plug_dir already exist."
    fi
    ln -sfv $plug_dir $ohmyz_dir/custom/plugins/
}

newtheme ()
{
    theme_url=$1
    theme_name=${theme_url##*/}
    theme_dir=$zsh_dir/themes/$theme_name
    if [ ! -d $theme_dir ]; then
        git clone $theme_url $theme_dir
    else
        echo "$theme_dir already exist."
    fi
    ln -sfv $theme_dir/*zsh-theme $ohmyz_dir/custom/themes/
}

ohmyzsh ()
{
    ## Clone oh-my-zsh
    ohmyz_url="https://github.com/ohmyzsh/ohmyzsh.git"
    ohmyz_dir=$zsh_dir/oh-my-zsh
    [ ! -d $ohmyz_dir ] && git clone $ohmyz_url $ohmyz_dir 

    ## Plugins
    #newplug https://github.com/esc/conda-zsh-completion
    #newplug https://github.com/zsh-users/zsh-autosuggestions
    #newtheme https://github.com/spaceship-prompt/spaceship-prompt
}

grml ()
{
    rm $zshrc_path
    wget -O "$zshrc_path" https://git.grml.org/f/grml-etc-core/etc/zsh/zshrc
    if [ ! -f "$zshrc_path.local" ]; then
        wget -O  "$zshrc_path.local" https://git.grml.org/f/grml-etc-core/etc/skel/.zshrc
    else
        echo "$zshrc_path.local exist!"
    fi
}

plugins() {
    plugins_dir="$zsh_dir/plugins"
    wget -O "$plugins_dir/autosuggestions.zsh" https://raw.githubusercontent.com/zsh-users/zsh-autosuggestions/master/zsh-autosuggestions.zsh
    wget -O "$plugins_dir/syntax-highlighting.zsh" https://raw.githubusercontent.com/zsh-users/zsh-syntax-highlighting/master/zsh-syntax-highlighting.zsh
    wget -O "$plugins_dir/git.zsh" https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/git/git.plugin.zsh
}

while true; do
    if [ -z $1 ]
    then
        echo "1. Basic"
        echo "2. Oh-My-Zsh"
        echo "3. grml"
        echo -n "Select version of zsh: "
        read z
        input=$z
    else
        input=$1
    fi
    case $input in
        "1"|"B"|"basic")
            echo "basic zsh selected."
            ln -sf $zsh_dir/basicrc $zshrc_path
            break
            ;;
        "2"|"O"|"ohmyzsh")
            echo "oh-my-zsh selected."
            ohmyzsh
            ln -sf $zsh_dir/ohmyzrc $zshrc_path
            break
            ;;
        "3"|"G"|"grml")
            echo "grml selected."
            grml
            break
            ;;
        *)
            echo "Invalid option $input"
            continue
            ;;
    esac
done
