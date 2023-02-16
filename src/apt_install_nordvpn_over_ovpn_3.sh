
#!/bin/bash
apt_update() {
	local LOG_PATH=$1
	echo "Starting nordvpn3" >&2
	# NOTE: These instructions only work for 64 bit Debian-based
	# Linux distributions such as Ubuntu, Mint etc.

	# 1. Install our official public software signing key
	apt_install_unzip=$(sudo apt-get install unzip)
	echo "Output:$apt_install_unzip" >&2
}
apt_update "$@"