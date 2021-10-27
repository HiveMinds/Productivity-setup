#!/bin/bash

# Declare filenames of files that perform commands to install nordvpn
install_zotero() {
	
	# Source: https://support.nordvpn.com/Connectivity/Linux/1325531132/Installing-and-using-NordVPN-on-Debian-Ubuntu-Raspberry-Pi-Elementary-OS-and-Linux-Mint.htm
	
	# Declare filenames of files that perform commands
	declare -a arr=(
		"apt_install_zotero_0"
		"apt_install_zotero_1"
		"apt_install_zotero_2"
		"apt_install_zotero_3"
		"apt_install_zotero_4"
		"apt_install_zotero_5"
		"apt_0_update"
		"apt_install_zotero_6"
		# TODO: detect if libreoffice is installed, and if yes, install the libreoffice plugin
		# TODO: detect if libreoffice is being installed, and if yes, do that first.
		# TODO: detect if brave is installed, and if yes, install the brave plugin
		# TODO: detect if brave is being installed, and if yes, install the brave plugin
		# TODO: specify pdf storage location
	)
	
	# Loop through files that perform commands
	for i in "${arr[@]}"
	do
		# run main functions that perform some commands
		run_main_functions "$i"
		echo "i=$i"
	done
}

test_zotero() {
	./test/libs/bats/bin/bats test/post_setup/test_apt_install_zotero_postsetup.bats
}
