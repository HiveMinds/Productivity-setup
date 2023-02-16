#!/bin/bash
apt_install_maven() {
	local LOG_PATH=$1
	update=$(yes | sudo apt install maven)
	echo $update > "${LOG_PATH}"
}
apt_install_maven "$@"
