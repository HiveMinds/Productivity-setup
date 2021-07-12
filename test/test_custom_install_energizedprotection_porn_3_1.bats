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
	declare -a additional_arguments=("test/testfiles/hostfile_without_porn_pack.txt")
                	
	# Execute the files and commands needed to test this step of the energized protection installer.
	for i in "${!script_names[@]}"; do
		# Pass filename to function that executes the file and passes the argument(s).
		install_energized_protection_porn_package "${script_names[i]}" "${additional_arguments[i]}"	
	done
}


#---------------------------------------------------------------------------------------------------------------------------
# 7.2.a Test: check if the correct starting_line query is returned for a target string that does not contain the 
# startstring. DONE
# 7.2.b Test: check if the correct starting_line query is returned for a target string that does contain the 
# startstring at the first line.
# 7.2.c Test: check if the correct starting_line query is returned for a target string that does contain the 
# startstring at the some line in the middle.
# 7.2.d Test: check if the correct starting_line query is returned for a target string that does contain the 
# startstring at the some line in the end.
# 7.2.e Test: check if the correct starting_line query is returned for a target string that does contain the 
# startstring at two positions in the text.
# 7.2. Returns: starting line query in the form of: <line nr>:<line content>
#-----------------------------------Test execution of custom_install_3_energizedprotection.sh-----------------------------------------------
@test "Tests whether the query that searches the start line outputs an empty log file if the start line is not located in the input file." {
	
	# Read out the log file belonging to that contains the starting line number for the social package
	ACTUAL_RESULT=$(<$FILEPATH_PACKAGE_INDICATOR_LINE_NR)
	
	# The "test/testfiles/hostfile_without_social_pack_startline_at_end.txt" file does not contain the social package starting. Hence expect an empty log file.
	EXPECTED_OUTPUT=""

	# Assert the function that gets the line number of the starting line of the social package returns 10 for an input file that has the starting
	# line of the social package in the last line of that file, being line 10.
	assert_equal "$ACTUAL_RESULT" "$EXPECTED_OUTPUT"
}