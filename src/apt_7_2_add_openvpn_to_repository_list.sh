#!/bin/bash
# Source: https://community.openvpn.net/openvpn/wiki/OpenVPN3Linux
apt_update() {
	local LOG_PATH=$1
	update=$(yes | sudo apt-key add openvpn-repo-pkg-key.pub)
	echo $update > "${LOG_PATH}"
}
apt_update "$@"
