
#!/bin/bash
apt_update() {
	local LOG_PATH=$1
	
	# TODO: move into separate file
	yes | sudo apt install wget
	yes | sudo apt install curl
	
	# Delete key if it already existed from previous installation
	if [ -f nordvpn-release_1.0.0_all.deb ]; then
		sudo rm nordvpn-release_1.0.0_all.deb
	fi
	
	# get the nordvpn installation file
	# TODO: push downloaded file into separate "downloaded files" folder
	update=$(yes | sudo wget https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb)
	
	# throw error if the key is not downloaded again
	if [ ! -f nordvpn-release_1.0.0_all.deb ]; then
		echo "ERROR:nordvpn-release_1.0.0_all.deb not downloaded"  > "${LOG_PATH}"
	fi
	echo $update > "${LOG_PATH}"
}
apt_update "$@"
