#!/bin/bash
zshenv_dir=$HOME/.zshenv
zsh_dir=$HOME/.config/zsh
zshrc_path=$zsh_dir/.zshrc

if [ ! -f $zshenv ] 
then
    ln -sf $HOME/.config/zsh/zshenv $zshenv
fi

prefix=$(dirname $(readlink -f $0))
[ ! -z "$1" ] && prefix=$1 

ohmyzsh ()
{
    ## Clone oh-my-zsh
    ohmyz_url="https://github.com/ohmyzsh/ohmyzsh.git"
    ohmyz_dir=$HOME/.config/oh-my-zsh
    [ ! -d $ohmyz_dir ] && git clone $ohmyz_url $ohmyz_dir 

    ## Plugins
    git clone https://github.com/esc/conda-zsh-completion $ohmyz_dir/plugins/conda-zsh-completion
}

echo "Select version of zsh."
while true; do
    echo -n "(b)asic; (o)h-my-zsh; (g)rml: "
    read z
    case $z in
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
            echo "Invalid option $z"
            continue
            ;;
    esac
done

