#!/bin/bash
apt_update() {
	local LOG_PATH=$1
	echo "Starting nordvpn1" >&2
	
	#install_nordvpn=$(sudo apt-get install nordvpn)
	# TODO: push downloaded file into separate "downloaded files" folder
	install_nordvpn=$(sudo apt-get install ./nordvpn-release_1.0.0_all.deb)
	sudo apt-get update
	yes | sudo apt-get install nordvpn
	# Did not work, command nordvpn not recognized.

	#install_nordvpn=$(sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh))
	echo "Inbetween" >&2
	install_nordvpn=$(sudo usermod -aG nordvpn $USER)
	echo "install_nordvpn:$install_nordvpn" >&2

	# TODO: make user ask: logout and log in and complete verification.

	nordvpn_response=$(yes | nordvpn)
	echo "nordvpn_response:$nordvpn_response" >&2
	
	# TODO: determine why this if condition is always true even if the nordvpn response does not start with "Whoops".
	if  [ ${nordvpn_response:0:6}=="Whoops" ]; then 
		read -p "Please reboot your device and install nordvpn again, had to change some permission settings which require a reboot."
	fi
	
	echo "output:$install_nordvpn" >&2
	echo $install_nordvpn > "${LOG_PATH}"
}
apt_update "$@"