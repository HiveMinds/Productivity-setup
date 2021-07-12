#!/bin/bash
# Source: https://community.openvpn.net/openvpn/wiki/OpenVPN3Linux
# Declare filenames of files that perform commands to install OpenVPN3
install_openvpn3() {
	
	# Declare filenames of files that perform commands
	declare -a arr=("apt_7_0_enable_apt_https_support"
		"apt_7_1_wget_public_openvpn_repository"
		"apt_7_2_add_openvpn_to_repository_list"
		"apt_7_3_wget_distro_dependent_repository"
		"apt_0_update"
		"apt_7_4_install_openvpn3"
		"apt_7_5_remove_openvpn-repo-pkg-key"
                )
                	
	# Loop through files that perform commands
	for i in "${arr[@]}"
	do
		# run main functions that perform some commands
		run_main_functions "$i"
	done
}

test_openvpn3() {
	./test/libs/bats/bin/bats test/post_setup/test_apt_install_openvpn3_postsetup.bats
}
