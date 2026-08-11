#!/bin/sh

spacemacs_url="https://github.com/syl20bnr/spacemacs"
spacemacs_path="$HOME/.config/spacemacs"

# clone spacemacs
[ ! -d $spacemacs_path/master ] && git clone -b master $spacemacs_url $spacemacs_path/master
[ ! -d $spacemacs_path/develop ] && git clone -b develop $spacemacs_url $spacemacs_path/develop    
    
rm -rf ~/.emacs.d
case $1 in
    "emacs")
        mkdir -pv ~/.config/emacs
        ln -sfv $PWD/emacs/early-init.el ~/.config/emacs/
        ln -sfv $PWD/emacs/init.el ~/.config/emacs/
        ln -sfv ~/.config/emacs ~/.emacs.d
        ;;
    "master")
        ln -sfv ~/.config/spacemacs-master ~/.emacs.d
        ln -sfv $PWD/emacs/spacemacs-master.el ~/.spacemacs
        ;;
    "develop")
        ln -sfv ~/.config/spacemacs-develop ~/.emacs.d
        ln -sfv $PWD/emacs/spacemacs-develop.el ~/.spacemacs
        ;;
esac
if [ $2 == "term" ]
then
    /usr/bin/emacs -nw
else
    /usr/bin/emacs
fi
