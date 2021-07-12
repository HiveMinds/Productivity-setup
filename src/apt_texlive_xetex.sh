#!/bin/bash
# Declare filenames of files that perform commands to install github
install_texlive_xetex() {
	
	# Declare filenames of files that perform commands
	declare -a arr=("apt_0_update"
                "apt_1_upgrade"
                "apt_9_install_texlive_xetex"
                )
                	
	# Loop through files that perform commands
	for i in "${arr[@]}"
	do
		# run main functions that perform some commands
		run_main_functions "$i"
	done
}

test_texlive_xetex() {
	./test/libs/bats/bin/bats test/post_setup/test_apt_install_texlive_xetex_postsetup.bats
}
