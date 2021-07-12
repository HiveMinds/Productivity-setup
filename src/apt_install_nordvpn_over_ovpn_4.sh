
#!/bin/bash
apt_update() {
	local LOG_PATH=$1
	echo "Starting nordvpn4" >&2
	# NOTE: These instructions only work for 64 bit Debian-based
	# Linux distributions such as Ubuntu, Mint etc.

	# 1. Install our official public software signing key
	unzip=$(sudo unzip /etc/openvpn/ovpn.zip -d /etc/openvpn)
	echo "Output:$unzip" >&2
	echo $unzip > "${LOG_PATH}"
}
apt_update "$@"