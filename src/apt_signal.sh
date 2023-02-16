#!/bin/bash
# Declare filenames of files that perform commands to install signal
install_signal() {
	
	# Declare filenames of files that perform commands
	declare -a arr=("apt_3_1_install_signal"
                "apt_3_2_install_signal"
                "apt_0_update"
                "apt_3_4_install_signal"
                )

	# Loop through files that perform commands
	for i in "${arr[@]}"
	do
		# run main functions that perform some commands
		run_main_functions "$i"
	done
}

test_signal() {
	./test/libs/bats/bin/bats test/post_setup/test_apt_install_signal_postsetup.bats
}
