#!/bin/bash
apt_install_make() {
	local LOG_PATH=$1
	update=$(yes | sudo apt install make)
	echo $update > "${LOG_PATH}"
}
apt_install_make "$@"
