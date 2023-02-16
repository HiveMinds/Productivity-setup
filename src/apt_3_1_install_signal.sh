
#!/bin/bash
apt_update() {
	local LOG_PATH=$1
	
	# NOTE: These instructions only work for 64 bit Debian-based
	# Linux distributions such as Ubuntu, Mint etc.

	# 1. Install our official public software signing key
	update=$(wget -O- https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -)
	echo $update > "${LOG_PATH}"
}
apt_update "$@"