#!/bin/bash
# Declare filenames of files that perform commands to install nordvpn
install_nordvpn() {
	
	# Source: https://support.nordvpn.com/Connectivity/Linux/1325531132/Installing-and-using-NordVPN-on-Debian-Ubuntu-Raspberry-Pi-Elementary-OS-and-Linux-Mint.htm
	
	# Declare filenames of files that perform commands
	declare -a arr=(
		"apt_install_nordvpn_0"
		"apt_install_nordvpn_1"
		"apt_0_update"
		"apt_install_nordvpn_2" 
		#"apt_install_nordvpn_3" # skip default connect
		#"apt_install_nordvpn_4" # no dedicated ip found yet
		"apt_install_nordvpn_5"
	)

	# Loop through files that perform commands
	for i in "${arr[@]}"
	do
		# run main functions that perform some commands
		run_main_functions "$i"
	done
}

test_nordvpn() {
	./test/libs/bats/bin/bats test/post_setup/test_apt_install_nordvpn_postsetup.bats
}
