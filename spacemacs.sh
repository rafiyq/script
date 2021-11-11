#!/bin/sh
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
