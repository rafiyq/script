#!/bin/sh
zshenv_path=$HOME/.zshenv
zsh_dir=$HOME/.config/zsh
zshrc_path=$zsh_dir/.zshrc

if [ ! -f $zshenv ] 
then
    ln -sf $zsh_dir/zshenv $zshenv_path
fi

#prefix=$(dirname $(readlink -f $0))
#[ ! -z "$1" ] && prefix=$1 
newclone ()
{
    plug_url=$1
    plug_name=${plug_url##*/}
    plug_dir=$zsh_dir/plugins/$plug_name
    if [ ! -d $plug_dir ]
    then
        git clone $plug_url $plug_dir
    else
        echo "$plug_dir already exist."
    fi
}

ohmyzsh ()
{
    ## Clone oh-my-zsh
    ohmyz_url="https://github.com/ohmyzsh/ohmyzsh.git"
    ohmyz_dir=$HOME/.config/oh-my-zsh
    [ ! -d $ohmyz_dir ] && git clone $ohmyz_url $ohmyz_dir 

    ## Plugins
    newclone https://github.com/esc/conda-zsh-completion
    newclone https://github.com/zsh-users/zsh-autosuggestions
    ln -sfv $zsh_dir/plugins/* $ohmyz_dir/custom/plugins/
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



