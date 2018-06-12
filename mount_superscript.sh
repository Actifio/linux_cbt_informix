#!/bin/sh

###############################################
# this script will ensure that the mount point
# is pointing to a directory you specify in the
# infromix.conf (DB_MOUNT=) file.
###############################################

dir_path=$(dirname $0)

set -x

[ -f ${dir_path}/informix.conf ] && {
        . ${dir_path}/informix.conf
        export DB_MOUNT
} || {
        echo "ERROR: unable to find the configuration"
        exit 1
}

case $ACT_PHASE in
        post)
        	mount_point=$(df -P | awk "\$1~/$ACT_JOBNAME/ { print \$6 }")
		[ -d $DB_MOUNT ] || {
			mkdir -p $DB_MOUNT
		}
		mount --bind $mount_point $DB_MOUNT
		;;
esac

