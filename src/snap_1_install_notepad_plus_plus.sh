#!/bin/bash
apt_update() {
	local LOG_PATH=$1
	update=$(yes | sudo snap install notepad-plus-plus)
	echo $update > "${LOG_PATH}"
}
apt_update "$@"
