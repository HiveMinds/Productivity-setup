#!/bin/bash
apt_update() {
	local LOG_PATH=$1
	update=$(yes | sudo apt install git)
	echo $update > "${LOG_PATH}"
}
apt_update "$@"
