#!/bin/sh

dir_path=$(dirname $0)

set -x

[ -f ${dir_path}/informix.conf ] && {
	. ${dir_path}/informix.conf
	export INFORMIXDIR
	export INFORMIXSERVER
	export B_TIMEOUT
	export MAX_FREEZE_TIME
} || {
	echo "ERROR: unable to find the configuration"
	exit 1
}

while [ $MAX_FREEZE_TIME -gt 0 ]
do
	# check every 10 seconds
	sleep 10
	MAX_FREEZE_TIME=$(expr $MAX_FREEZE_TIME - 10)

	echo "INFO: time remaining to watchdog-release: $MAX_FREEZE_TIME"
	
	[ $(${INFORMIXDIR}/bin/onstat | awk -F: '$1 == "Blocked" { print $2 }')x == "x" ] && {
		exit 0
	}
done

#time to call quits

[ $(${INFORMIXDIR}/bin/onstat | awk -F: '$1 == "Blocked" { print $2 }')x == "x" ] || {
	echo "INFO: watchdog releasing the informix database"
        ${INFORMIXDIR}/bin/onmode -c unblock
}
