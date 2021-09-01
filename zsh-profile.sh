#!/bin/sh

[ -z "$ZDOTDIR" ] && export ZDOTDIR=$HOME/.config/zsh

case $1 in
    "grml")
        ln -sf $HOME/.config/grml/zsh $ZDOTDIR/.zshrc
        exec zsh
        ;;
    "ohmyzsh")
        ln -sf $ZDOTDIR/ohmyzrc $ZDOTDIR/.zshrc
	exec zsh
        ;;
    "my")
        ln -sf $ZDOTDIR/myzshrc $ZDOTDIR/.zshrc
        exec zsh
        ;;
esac
