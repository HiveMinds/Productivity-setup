
#!/bin/bash
apt_update() {
	local LOG_PATH=$1
	echo "Starting nordvpn2" >&2
	# NOTE: These instructions only work for 64 bit Debian-based
	# Linux distributions such as Ubuntu, Mint etc.

	# 1. Install our official public software signing key
	install_ca_certificates=$(sudo apt-get install ca-certificates)
	echo "output:$install_ca_certificates" >&2
	#echo $update > "${LOG_PATH}"
}
apt_update "$@"