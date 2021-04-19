#!/usr/bin/env zsh

# Checks if there's a frame open
emacsclient -n -e "(if (> (length (frame-list)) 1) 't)" 2> /dev/null | grep t &> /dev/null

if [ "$?" = "1" ]; then
    emacsclient -a "" -nc "$@" &> /dev/null
else
    emacsclient -n "$@"
fi
