#!/bin/bash
# Declare filenames of files that perform commands to install github
install_energizedprotection() {
	
	# read the package type from the incoming argument
	local package_type=$1
	
	# Declare filenames of files that perform commands
	# 0=Download the social package from this repo
	# 1=Unpack the downloaded social_package zip
	# 2=Check if the social package is in the target file and export the true-false boolean to a file.#INPUT_PATH
	# 3=Exports the line number of the startline in an incoming file. #INPUT_PATH
	# 4=export the total nr of lines in host file#INPUT_PATH
	# 5=Export the number of remaining lines of the target file after the lines uptill the start line of social package are removed.
	# 6=Export the remaining lines of the target file after the lines uptill the start line of social package are removed.#INPUT_PATH
	# 7=Creates a new output target file that contains the remainder after the detected starting line position.#INPUT_PATH
	# 8=Outputs the absolute line end nr of the social package in the original host file.#INPUT_PATH
	# 9=Export a boolean indicating whether the modified social package is contained.
	# 10=If modified social package is found in the input  path, remove it.#INPUT_PATH
	# 11=Appends the new social pack if the unmodified social package is not yet included.#INPUT_PATH
	declare -a script_names=("custom_install_11_energizedprotection")
	
	# Specify an additional array with arguments
	declare -a additional_arguments=("/etc/hosts")

	# Loop through files that perform commands
	for i in "${!script_names[@]}"; do
	
		# run main functions that perform some commands
		package_type
		if [ "$package_type" == social ]; then
			install_energized_protection_social_package "${script_names[i]}" "${additional_arguments[i]}"	
		elif [ "$package_type" == porn ]; then
			install_energized_protection_porn_package "${script_names[i]}" "${additional_arguments[i]}"	
		elif [ "$package_type" == additional ]; then
			install_energized_protection_additional_package "${script_names[i]}" "${additional_arguments[i]}"	
		fi
	done
}

test_energizedprotection() {
	package_type=$1
	if [ "$package_type" == social ]; then
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_social_postsetup_0.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_social_postsetup_1.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_social_postsetup_2_1.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_social_postsetup_2_2.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_social_postsetup_2_3.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_social_postsetup_3_1.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_social_postsetup_3_2.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_social_postsetup_3_3.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_social_postsetup_3_4.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_social_postsetup_3_5.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_social_postsetup_3_6.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_social_postsetup_4_1.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_social_postsetup_4_2.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_social_postsetup_5.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_social_postsetup_6.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_social_postsetup_7.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_social_postsetup_8.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_social_postsetup_9_1.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_social_postsetup_9_2.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_social_postsetup_9_3.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_social_postsetup_10_1.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_social_postsetup_10_2.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_social_postsetup_11_1.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_social_postsetup_11_2.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_social_postsetup_12.bats
	elif [ "$package_type" == porn ]; then
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_porn_postsetup_0.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_porn_postsetup_1.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_porn_postsetup_2_1.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_porn_postsetup_2_2.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_porn_postsetup_2_3.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_porn_postsetup_3_1.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_porn_postsetup_3_2.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_porn_postsetup_3_3.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_porn_postsetup_3_4.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_porn_postsetup_3_5.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_porn_postsetup_3_6.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_porn_postsetup_4_1.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_porn_postsetup_4_2.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_porn_postsetup_5.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_porn_postsetup_6.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_porn_postsetup_7.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_porn_postsetup_8.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_porn_postsetup_9_1.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_porn_postsetup_9_2.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_porn_postsetup_9_3.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_porn_postsetup_10_1.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_porn_postsetup_10_2.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_porn_postsetup_11_1.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_porn_postsetup_11_2.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_porn_postsetup_12.bats
	elif [ "$package_type" == additional ]; then
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_additional_postsetup_0.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_additional_postsetup_1.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_additional_postsetup_2_1.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_additional_postsetup_2_2.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_additional_postsetup_2_3.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_additional_postsetup_3_1.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_additional_postsetup_3_2.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_additional_postsetup_3_3.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_additional_postsetup_3_4.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_additional_postsetup_3_5.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_additional_postsetup_3_6.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_additional_postsetup_4_1.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_additional_postsetup_4_2.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_additional_postsetup_5.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_additional_postsetup_6.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_additional_postsetup_7.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_additional_postsetup_8.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_additional_postsetup_9_1.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_additional_postsetup_9_2.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_additional_postsetup_9_3.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_additional_postsetup_10_1.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_additional_postsetup_10_2.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_additional_postsetup_11_1.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_additional_postsetup_11_2.bats
		./test/libs/bats/bin/bats test/post_setup/test_custom_install_energizedprotection_additional_postsetup_12.bats
	fi
}