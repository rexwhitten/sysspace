#!/bin/busybox ash
#(c) Robert Shingledecker 2012
. /etc/init.d/tc-functions
useBusybox
cd /tmp
SEARCH="NAME"
if [ "$1" == "-t" ]; then
	SEARCH="TAGS"
	shift
fi
# Now $* is the search targets 
[ -z "$1" ] && exit 1

if [ ! -f scmtags.db ]; then
	scm-fetch.sh scmtags.db.gz || exit 1
	gunzip -f scmtags.db.gz
	touch scmtags.db
else # Check if the file is older than 5 hours
	age=$((`date +%s` - `date -r scmtags.db +%s`))
	if [ $age -ge 18000 ]; then
		scm-fetch.sh scmtags.db.gz || exit 1
		gunzip -f scmtags.db.gz
		touch scmtags.db
	fi
fi

if [ "$SEARCH" == "NAME" ]; then
	grep -i ^$1 scmtags.db | cut -f1
else
	I=1
	IN="scmtags.db"
	OUT=`mktemp`
	RESULTS="scmtags.lst"
	while [ -n "$1" ]
	do
		if [ "$I" == 1 ]
		then
			grep -i "$1" "$IN" > "$OUT"
		else
			grep -i "$1" "$RESULTS" > "$OUT"
		fi
		cp "$OUT" "$RESULTS"
		shift
		I=`expr "$I" + 1`
	done
	rm "$OUT"
	cat "$RESULTS" | awk '{print $1}'
#	cat "$RESULTS"
fi
