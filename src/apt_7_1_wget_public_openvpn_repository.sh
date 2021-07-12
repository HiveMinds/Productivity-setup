#!/bin/bash
# Source: https://community.openvpn.net/openvpn/wiki/OpenVPN3Linux
apt_update() {
	local LOG_PATH=$1
	
	# Delete key if it already existed from previous installation
	if [ -f openvpn-repo-pkg-key.pub ]; then
		sudo rm openvpn-repo-pkg-key.pub
	fi
	
	# get the ovpn public key
	update=$(yes | sudo wget https://swupdate.openvpn.net/repos/openvpn-repo-pkg-key.pub)
	
	# throw error if the key is not downloaded again
	if [ ! -f openvpn-repo-pkg-key.pub ]; then
		echo "ERROR:openvpn-repo-pkg-key.pub not downloaded"  > "${LOG_PATH}"
	fi
	echo $update > "${LOG_PATH}"
}
apt_update "$@"
