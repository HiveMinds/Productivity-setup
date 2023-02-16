#!/bin/bash
apt_install_brave_browser() {
	local LOG_PATH=$1
	update=$(echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list)
	echo $update > "${LOG_PATH}"
}
apt_install_brave_browser "$@"
