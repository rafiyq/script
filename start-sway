#!/bin/sh -e

export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=sway
export _JAVA_AWT_WM_NONREPARENTING=1
export MOZ_ENABLE_WAYLAND=1
# export GDK_BACKEND=wayland

case "$1" in
debug)
	/usr/local/bin/sway -d >/tmp/sway.log 2>&1
	;;
"")
	sway >/tmp/sway.log 2>&1
	;;
*)
	echo >&2 "Invalid argument: $1"
	exit 1
esac
