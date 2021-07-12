#!/bin/bash
# Source: https://linuxhint.com/install_keepass_ubuntu/
# Declare filenames of files that perform commands to install keepass2

install_keepass2() {
	
	# Declare filenames of files that perform commands
	declare -a arr=("apt_5_0_add_keepass2_ppa"
		"apt_0_update"
		"apt_1_upgrade"
		"apt_5_1_install_libcanberra_modules"
		"apt_5_2_remove_mono_config"
		"apt_5_3_install_keepass2"
                )
                	
	# Loop through files that perform commands
	for i in "${arr[@]}"
	do
		# run main functions that perform some commands
		run_main_functions "$i"
	done
}

test_keepass2() {
	./test/libs/bats/bin/bats test/post_setup/test_apt_install_keepass2_postsetup.bats
}
