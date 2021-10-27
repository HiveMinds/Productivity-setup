#!/bin/bash
# Verify this script is ran as root.
has_root_privilige() {
	local LOG_PATH=$1
	if [ `whoami` != root ]; then
		echo "Please run this script as root or using sudo" > "${LOG_PATH}"
	fi
}
has_root_privilige "$@"