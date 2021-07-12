#!/bin/bash

# Load bats testing packages
load '../../test/libs/bats-support/load'
load '../../test/libs/bats-assert/load'
load '../../test/libs/bats-file/load'

# Load hardcoded variables and helper functions.
source src/hardcoded_variables.txt
source src/helper.sh
source test/helper.sh


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
# No control over the actual host file, so this test is ommitted because it requires a specific type of hostfile
#@test "Tests whether the query that searches the start line outputs an empty log file if the start line is not located in the input file." {
#	
#	# Read out the log file belonging to that contains the starting line number for the social package
#	ACTUAL_RESULT=$(<$FILEPATH_PACKAGE_INDICATOR_LINE_NR)
#	
#	# The "test/testfiles/hostfile_without_social_pack_startline_at_end.txt" file does not contain the social package starting. Hence expect an empty log file.
#	EXPECTED_OUTPUT=""
#
#	# Assert the function that gets the line number of the starting line of the social package returns 10 for an input file that has the starting
#	# line of the social package in the last line of that file, being line 10.
#	assert_equal "$ACTUAL_RESULT" "$EXPECTED_OUTPUT"
#