
#!/bin/bash
apt_update() {
	local LOG_PATH=$1
	echo "Starting nordvpn5" >&2
	# NOTE: These instructions only work for 64 bit Debian-based
	# Linux distributions such as Ubuntu, Mint etc.

	# 1. Install our official public software signing key
	openvpn_command=$(sudo openvpn /etc/openvpn/ovpn_udp/cy13.nordvpn.com.udp.ovpn)
	echo "Output:$openvpn_command" >&2
	echo $openvpn_command > "${LOG_PATH}"
}
apt_update "$@"