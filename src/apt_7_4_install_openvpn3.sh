#!/bin/bash
# Source: https://community.openvpn.net/openvpn/wiki/OpenVPN3Linux
apt_update() {
	local LOG_PATH=$1
	update=$(yes | sudo apt install openvpn3)
	echo $update > "${LOG_PATH}"
}
apt_update "$@"
