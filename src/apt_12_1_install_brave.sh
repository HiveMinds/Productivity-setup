#!/bin/bash
apt_install_brave_browser() {
	local LOG_PATH=$1
	update=$(yes | sudo apt install apt-transport-https curl)

	echo $update > "${LOG_PATH}"
}
apt_install_brave_browser "$@"
