#!/bin/bash
apt_install_detex() {
	local LOG_PATH=$1
	update=$(yes | sudo apt install detex)
	echo $update > "${LOG_PATH}"
}
apt_install_detex "$@"
