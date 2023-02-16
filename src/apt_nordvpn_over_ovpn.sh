#!/bin/bash
# Declare filenames of files that perform commands to install nordvpn
install_nordvpn_over_ovpn() {
	
	# Declare filenames of files that perform commands
	declare -a arr=(
		"apt_install_nordvpn_over_ovpn_1"
		"apt_install_nordvpn_over_ovpn_2"
		"apt_install_nordvpn_over_ovpn_3"
		"apt_install_nordvpn_over_ovpn_4"
		"apt_install_nordvpn_over_ovpn_5"
	)

	# Loop through files that perform commands
	for i in "${arr[@]}"
	do
		# run main functions that perform some commands
		run_main_functions "$i"
	done
}

test_nordvpn() {
	./test/libs/bats/bin/bats test/post_setup/test_apt_install_nordvpn_over_ovpn_postsetup.bats
}
