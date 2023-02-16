#!/bin/bash
# Source: https://community.openvpn.net/openvpn/wiki/OpenVPN3Linux
apt_update() {
	local LOG_PATH=$1
	# get distro codename (version)
	. /etc/lsb-release
	
	# TODO: include check if distro ==focal,.. if distro==groovy,..., else log output: distro not found
	# get the right repository matching the distro version
	update=$(yes | sudo wget -O /etc/apt/sources.list.d/openvpn3.list https://swupdate.openvpn.net/community/openvpn3/repos/openvpn3-$DISTRIB_CODENAME.list)
	echo $update > "${LOG_PATH}"
}
apt_update "$@"
