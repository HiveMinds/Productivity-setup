#!/bin/bash
# Declare filenames of files that perform commands to install anki
install_anki() {
	
	# Declare filenames of files that perform commands
	declare -a arr=("apt_0_update"
                "apt_1_upgrade"
                "snap_0_install_anki"
                )

	# Loop through files that perform commands
	for i in "${arr[@]}"
	do
		# run main functions that perform some commands
		run_main_functions "$i"
	done
}

test_anki() {
	./test/libs/bats/bin/bats test/post_setup/test_snap_install_anki_postsetup.bats
}
