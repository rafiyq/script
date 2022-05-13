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
    ohmyz_dir=$HOME/.config/oh-my-zsh
    [ ! -d $ohmyz_dir ] && git clone $ohmyz_url $ohmyz_dir 

    ## Plugins
    newplug https://github.com/esc/conda-zsh-completion
    newplug https://github.com/zsh-users/zsh-autosuggestions
    newtheme https://github.com/spaceship-prompt/spaceship-prompt
}

while true; do
    if [ -z $1 ]
    then
        echo "Select version of zsh."
        echo -n "(b)asic; (o)h-my-zsh; (g)rml: "
        read z
        input=$z
    else
        input=$1
    fi
    case $input in
        "b"|"B"|"basic")
            echo "basic zsh selected."
            ln -sf $zsh_dir/basicrc $zshrc_path
            break
            ;;
        "o"|"O"|"ohmyzsh")
            echo "oh-my-zsh selected."
            ohmyzsh
            ln -sf $zsh_dir/ohmyzrc $zshrc_path
            break
            ;;
        "g"|"G"|"grml")
            echo "grml selected."
            rm $zshrc
            wget -O $zshrc https://git.grml.org/f/grml-etc-core/etc/zsh/zshrc
            wget -O $zshrc.local  https://git.grml.org/f/grml-etc-core/etc/skel/.zshrc
            break
            ;;
        *)
            echo "Invalid option $input"
            continue
            ;;
    esac
done



