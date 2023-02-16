#!/bin/bash
# Source: https://github.com/mono/mono/issues/18238
apt_update() {
	local LOG_PATH=$1
	update=$(yes | rm -Rf ~/.config/.mono)
	echo $update > "${LOG_PATH}"
}
apt_update "$@"
