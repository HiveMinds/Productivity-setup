#!/bin/bash
# Declare filenames of files that perform commands to install bravehub
install_brave() {
	
	# Declare filenames of files that perform commands
	declare -a arr=("apt_0_update"
                "apt_1_upgrade"
                "apt_12_1_install_brave"
                "apt_12_2_install_brave"
                "apt_12_3_install_brave"
				"apt_0_update"
                "apt_12_4_install_brave"
				"apt_12_5_install_brave"
                )
                	
	# Loop through files that perform commands
	for i in "${arr[@]}"
	do
		# run main functions that perform some commands
		run_main_functions "$i"
	done
}

test_brave() {
	./test/libs/bats/bin/bats test/post_setup/test_apt_install_brave_postsetup.bats
}
