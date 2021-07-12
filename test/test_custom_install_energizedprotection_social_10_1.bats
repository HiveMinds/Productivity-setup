#!/bin/bash

# Load bats testing packages
load 'libs/bats-support/load'
load 'libs/bats-assert/load'
load 'libs/bats-file/load'

# Load hardcoded variables and helper functions.
source src/hardcoded_variables.txt
source src/helper.sh
source test/helper.sh

# Create the path to the log file folder.
mkdir -p src/logs

# Copy the source target file to a dummy that can be modified
cp "test/testfiles/hostfile_with_social_pack.txt" "test/testfiles/dummy_hostfile_with_social_pack.txt"


# Method that executes all tested main code before running tests.
setup() {
	# print test filename to screen.
	if [ "${BATS_TEST_NUMBER}" = 1 ];then
		echo "# Testfile: $(basename "${BATS_TEST_FILENAME}")-" >&3
	fi
	
	# Declare filenames of scripts needed to test this step of the energized protection installer.
	# 0=Download the social package from this repo
	# 1=Unpack the downloaded social_package zip
	# 2=Check if the social package is in the target file and export the true-false boolean to a file.
	# 3=Exports the line number of the startline in an incoming file.
	# 4=export the total nr of lines in host file
	# 5=Export the number of remaining lines of the target file after the lines uptill the start line of social package are removed.
	# 6=Export the remaining lines of the target file after the lines uptill the start line of social package are removed.
	# 7=Creates a new output target file that contains the remainder after the detected starting line position.
	# 8=Outputs the absolute line end nr of the social package in the original host file.
	# 9=Export a boolean indicating whether the modified social package is contained.
	# 10=If modified social package is found in the input  path, remove it.
	declare -a script_names=(
		"custom_install_10_energizedprotection"
	)
	
	# Specify an additional array with arguments
	declare -a additional_arguments=(
		"test/testfiles/dummy_hostfile_with_social_pack.txt"
	)

	# Execute the files and commands needed to test this step of the energized protection installer.
	for i in "${!script_names[@]}"; do
		# Pass filename to function that executes the file and passes the argument(s).
		install_energized_protection_social_package "${script_names[i]}" "${additional_arguments[i]}"	
	done
}

#-----------------------------------Test execution of custom_install_10_energizedprotection.sh-----------------------------------------------
@test "Tests if 10 keeps the target file unchanged if the original social package is contained." {
	
	# Specifiy the filepath of the input file to which any changes may have been written by the function.
	ACTUAL_TARGET_FILEPATH="test/testfiles/dummy_hostfile_with_social_pack.txt"
	
	# Read out the md5 checksum of the input file to which any changes may have been written by the function.
	md5_of_actual_target_after_social_package_removal=$(sudo md5sum $ACTUAL_TARGET_FILEPATH)
	
	# Extract actual md5 checksum from the md5 command response.
	md5_of_actual_target_after_social_package_removal_head=${md5_of_actual_target_after_social_package_removal:0:32}
		
	# No change expected, so expect the host file with the unmodified social package.
	EXPECTED_TARGET_FILEPATH="test/testfiles/hostfile_with_social_pack.txt"
	
	# Read out the md5 checksum of the host file with the unmodified social package.
	md5_of_expected_lines=$(sudo md5sum "$EXPECTED_TARGET_FILEPATH")
	
	# Extract actual md5 checksum from the md5 command response.
	md5_of_expected_lines_head=${md5_of_expected_lines:0:32}
	
	# Assert the function did not modify the input file.
	assert_equal "$md5_of_expected_lines_head" "$md5_of_actual_target_after_social_package_removal_head"
}