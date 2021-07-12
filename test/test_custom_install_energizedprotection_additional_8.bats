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
	declare -a script_names=(
		"custom_install_8_energizedprotection"
	)
	
	# Specify an additional array with arguments
	declare -a additional_arguments=(
		"test/testfiles/hostfile_with_additional_pack.txt"
	)

	# Execute the files and commands needed to test this step of the energized protection installer.
	for i in "${!script_names[@]}"; do
		# Pass filename to function that executes the file and passes the argument(s).
		install_energized_protection_additional_package "${script_names[i]}" "${additional_arguments[i]}"	
	done
}

#-----------------------------------Test execution of custom_install_8_energizedprotection.sh-----------------------------------------------
@test "Tests the remaining number of lines after the starting line in the target file is computed correctly." {
	
	# Read out the log file that contains the absolute line number of the ending line of the social package.
	ACTUAL_RESULT=$(<$FILEPATH_LINE_NR_PACKAGE_END_IN_HOSTFILE)
	
	# The ending line of the social package in the test file is located at line 316089. Hence expect 316089.
	EXPECTED_OUTPUT="316089"

	# Assert the function that gets the line number of the ending line in the social package returns the correct line number for a given test file.
	assert_equal "$ACTUAL_RESULT" "$EXPECTED_OUTPUT"
}