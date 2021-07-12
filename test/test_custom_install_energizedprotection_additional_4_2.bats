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
	declare -a script_names=("custom_install_4_energizedprotection")
	# Specify an additional array with arguments
	declare -a additional_arguments=("test/testfiles/hostfile_with_social_pack.txt")

	# Execute the files and commands needed to test this step of the energized protection installer.
	for i in "${!script_names[@]}"; do
		# Pass filename to function that executes the file and passes the argument(s).
		install_energized_protection_additional_package "${script_names[i]}" "${additional_arguments[i]}"	
	done
}


#-----------------------------------Test execution of custom_install_4_energizedprotection.sh-----------------------------------------------
@test "Tests whether an exception is thrown when computing the total nr of lines, if the file is not found." {
	
	# Read out the log file that contains the number of lines of an input file.
	ACTUAL_RESULT=$(<$FILEPATH_NR_LINES_HOSTFILE)
	
	# The amount of lines in the test file that is used is 4027 [lines]. Hence expect 4027.
	EXPECTED_OUTPUT="4027"

	# Assert the function that counts the number of lines in an output file returns the correct number of lines for the used file with 4027 lines.
	assert_equal "$ACTUAL_RESULT" "$EXPECTED_OUTPUT"
}