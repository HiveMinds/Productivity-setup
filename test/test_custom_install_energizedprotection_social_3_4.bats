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
	declare -a script_names=("custom_install_3_energizedprotection")
	
	# Specify an additional array with arguments
	declare -a additional_arguments=("test/testfiles/hostfile_with_social_pack_indicator_line_at_end.txt")

	# Execute the files and commands needed to test this step of the energized protection installer.
	for i in "${!script_names[@]}"; do
		# Pass filename to function that executes the file and passes the argument(s).
		install_energized_protection_social_package "${script_names[i]}" "${additional_arguments[i]}"	
	done
}


#-----------------------------------Test execution of custom_install_3_energizedprotection.sh-----------------------------------------------
@test "Tests whether the query that searches the start line outputs the correct line number if the start line is located at the end of the input file." {
	
	# Read out the log file belonging to that contains the starting line number for the social package
	ACTUAL_RESULT=$(<$FILEPATH_PACKAGE_INDICATOR_LINE_NR)
	
	# The "test/testfiles/hostfile_without_social_pack_startline_at_end.txt" file has the social package starting line in line 10, hence expect 10.
	EXPECTED_OUTPUT="10"

	# Assert the function that gets the line number of the starting line of the social package returns 10 for an input file that has the starting
	# line of the social package in the last line of that file, being line 10.
	assert_equal "$ACTUAL_RESULT" "$EXPECTED_OUTPUT"
}