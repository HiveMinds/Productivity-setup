#!/bin/bash
apt_install_flex() {
	local LOG_PATH=$1
	update=$(yes | sudo apt install flex)
	echo $update > "${LOG_PATH}"
}
apt_install_flex "$@"
