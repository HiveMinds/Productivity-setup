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

# Method that executes all tested main code before running tests.
setup() {
	
	# print test filename to screen.
	if [ "${BATS_TEST_NUMBER}" = 1 ];then
		echo "# Testfile: $(basename "${BATS_TEST_FILENAME}")-" >&3
	fi
	
	# Declare filenames of scripts needed to test this step of the energized protection installer.
	# 3=export the starting_line
	# 4=export the total nr of lines
	# 5=export the remaining amount of lines
	# 6=output the remainder lines of the target file
	declare -a script_names=(
		"custom_install_6_energizedprotection"
	)
	
	# Specify an additional array with arguments
	declare -a additional_arguments=(
		"test/testfiles/hostfile_with_social_pack.txt"
	)

	# Execute the files and commands needed to test this step of the energized protection installer.
	for i in "${!script_names[@]}"; do
		# Pass filename to function that executes the file and passes the argument(s).
		install_energized_protection_social_package "${script_names[i]}" "${additional_arguments[i]}"	
	done
}


#-----------------------------------Test execution of custom_install_6_energizedprotection.sh-----------------------------------------------
@test "Tests the remaining number of lines after the starting line in the target file is computed correctly." {
	
	# Read out the md5 checksum of the log file that is created containing the remaining lines of some input file
	# after the starting line that indicates it contains the social package.
	md5_of_actual_remaining_lines=$(sudo md5sum $FILEPATH_REMAINING_LINES_HOSTFILE_AFTER_PACKAGE_INDICATOR)
	
	# Extract actual md5 checksum from the md5 command response.
	md5_of_actual_remaining_lines_head=${md5_of_actual_remaining_lines:0:32}
	
	# Specify the filepath towards the test file that contains the expected output.
	expected_output_filename="test/testfiles/remainder_of_hostfile_with_social_pack_after_startline.txt"
	
	# Read out the md5 checksum of the test file that contains the expected output.
	md5_of_expected_remaining_lines=$(sudo md5sum "$expected_output_filename")
	
	# Extract actual md5 checksum from the md5 command response.
	md5_of_expected_remaining_lines_head=${md5_of_expected_remaining_lines:0:32}
	
	# Assert that the remaining amount of lines that are put into the log file equal the expected lines.
	assert_equal "$md5_of_expected_remaining_lines_head" "$md5_of_actual_remaining_lines_head"
}