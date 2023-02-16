#!/bin/bash
apt_update() {
	local LOG_PATH=$1
	update=$(sudo apt update)
	echo $update > "${LOG_PATH}"
}
apt_update "$@"
