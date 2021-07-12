#!/bin/bash
# Declare filenames of files that perform commands to install github
install_github() {
	
	# Declare filenames of files that perform commands
	declare -a arr=("apt_0_update"
                "apt_1_upgrade"
                "apt_2_install_git"
                )
                	
	# Loop through files that perform commands
	for i in "${arr[@]}"
	do
		# run main functions that perform some commands
		run_main_functions "$i"
	done
}

test_github() {
	./test/libs/bats/bin/bats test/post_setup/test_apt_install_git_postsetup.bats
}
