#!/bin/busybox ash
#(c) Robert Shingledecker 2012
. /etc/init.d/tc-functions
useBusybox
getMirror
MIRROR="${MIRROR/tcz/scm}"
if [ "$1" == "-O" ]; then
	shift
	wget -cq -O- "$MIRROR"/"$1"
else
	[ -f "$1" ] && rm -f "$1"
	wget -cq "$MIRROR"/"$1"
fi
