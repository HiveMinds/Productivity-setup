#!/bin/bash
apt_install_gcc() {
	local LOG_PATH=$1
	update=$(yes | sudo apt install gcc)
	echo $update > "${LOG_PATH}"
}
apt_install_gcc "$@"
