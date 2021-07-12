#!/bin/bash
apt_install_icedtea_netx() {
	local LOG_PATH=$1
	update=$(yes | sudo apt install icedtea-netx)
	echo $update > "${LOG_PATH}"
}
apt_install_icedtea_netx "$@"
