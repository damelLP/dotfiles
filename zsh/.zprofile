export PATH="/home/damel/.local/share/solana/install/active_release/bin:$PATH"


# Added by Antigravity CLI installer
export PATH="/home/damel/.local/bin:$PATH"


# Auto-start X on tty1. Must stay LAST: `exec` replaces this shell, so anything
# below it never runs and i3 would inherit an unfinished environment.
# Guards: interactive only (so `zsh -lc ...` and other scripted login shells are
# unaffected), tty1 only, and not already inside X.
# To stay in the TTY: run `NO_STARTX=1 login`, or hit Ctrl-C during the grace period.
if [[ -o interactive && -z $DISPLAY && $XDG_VTNR == 1 && -z $NO_STARTX ]]; then
	print -n "Starting X in 2s (Ctrl-C for a shell)... "
	if sleep 2; then
		exec startx
	fi
	print "cancelled."
fi
