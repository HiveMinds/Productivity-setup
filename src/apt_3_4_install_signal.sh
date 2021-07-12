#!/bin/bash
apt_update() {
	local LOG_PATH=$1
	
	# NOTE: These instructions only work for 64 bit Debian-based
	# Linux distributions such as Ubuntu, Mint etc.

	# 3. Update your package database and install signal
	update=$(sudo apt install signal-desktop)
	echo $update > "${LOG_PATH}"
}
apt_update "$@"
