#!/bin/bash
# Declare filenames of files that perform commands to install anki
install_anaconda() {
	
	# Declare filenames of files that perform commands
	declare -a arr=("apt_0_update"
                "apt_1_upgrade"
                # "custom_0_get_anaconda_install_script"
				# "custom_1_run_silent_anaconda_install_script"
				"custom_3_install_miniconda"
				#"custom_2_run_anaconda_hook_evaluation"
				#"custom_3_initialise_conda"
				#"custom_4_sync"
				#"custom_5_conda_install_conda"
				#"custom_6_create_some_environment"
                )

	# Loop through files that perform commands
	for i in "${arr[@]}"
	do
		# run main functions that perform some commands
		run_main_functions "$i"
	done
}

# test_anaconda() {
	# ./test/libs/bats/bin/bats test/post_setup/test_custom_install_anaconda_postsetup.bats
# }
