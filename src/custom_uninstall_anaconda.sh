#!/bin/bash
# Source; https://docs.anaconda.com/anaconda/install/uninstall/
# Do a full uninstall

# Declare filenames of files that perform commands to uninstallation of anaconda
uninstall_anaconda() {
	
	# check if conda is installed
	COMMAND_OUTPUT=$(conda -V)
	COMMAND_OUTPUT_HEAD=${COMMAND_OUTPUT:0:8}
	
	if [ "$COMMAND_OUTPUT_HEAD" == "conda 4." ]; then
	
		# Declare filenames of files that perform commands
		declare -a arr=("custom_uninstall_0_anaconda"
			"custom_uninstall_1_anaconda"
			"custom_uninstall_2_anaconda"
			"custom_uninstall_3_anaconda"
			"custom_uninstall_4_anaconda"
			)

		# Loop through files that perform commands
		for i in "${arr[@]}"
		do
			# run main functions that perform some commands
			run_main_functions "$i"
		done
	else
		echo 'Anaconda_is_not_recognised_on_this_system._This_is_normal_if_you_try_to_de-install_it_from_the_same_terminal_that_you_just_used_to_install_it._Please_restart_your_terminal_and_try_again_to_fully_remove_anaconda_automatically.'
	fi
}

test_anaconda_uninstallation() {
	./test/libs/bats/bin/bats test/post_uninstall/test_custom_uninstall_anaconda_postsetup.bats
}
