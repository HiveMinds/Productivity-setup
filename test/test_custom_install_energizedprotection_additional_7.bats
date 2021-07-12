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
		"custom_install_7_energizedprotection"
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


#-----------------------------------Test execution of custom_install_7_energizedprotection.sh-----------------------------------------------
@test "Tests whether the query that searches the ending line of the social package returns the right line number." {

	# Read out the log file that contains the first occurance of the ending line string of the social package.
	ACTUAL_RESULT=$(<$FILEPATH_RELATIVE_ENDING_LINE_NR_OF_PACKAGE)
	
	# The ending line string in the used test file occurs at line 316056. The test file used in this test is 
	# the remainder of the lines of the social package after the first starting line that indicates the 
	# file content is the social package.
	EXPECTED_OUTPUT="316056"
		
	# Assert the function that gets the ending line number in a file with the remainder of a social package after
	# the starting line of the social package exports the correct ending line number.
	assert_equal "$ACTUAL_RESULT" "$EXPECTED_OUTPUT"
}