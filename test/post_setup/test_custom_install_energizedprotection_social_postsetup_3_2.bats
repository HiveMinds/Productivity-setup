#!/bin/bash

# Load bats testing packages
load '../../test/libs/bats-support/load'
load '../../test/libs/bats-assert/load'
load '../../test/libs/bats-file/load'

# Load hardcoded variables and helper functions.
source src/hardcoded_variables.txt
source src/helper.sh
source test/helper.sh


#-----------------------------------Test execution of custom_install_3_energizedprotection.sh-----------------------------------------------
@test "Tests whether the query that searches the start line outputs the correct line number if the start line is located in an arbitrary line in the input file." {
	
	# Read out the log file belonging to that contains the starting line number for the social package
	ACTUAL_RESULT=$(<$FILEPATH_PACKAGE_INDICATOR_LINE_NR)
	
	# The "test/testfiles/hostfile_without_social_pack_startline_at_end.txt" file has the social package starting line in line 33, hence expect 3.
	EXPECTED_OUTPUT="33"

	# Assert the function that gets the line number of the starting line of the social package returns 1 for an input file that has the starting
	# line of the social package in an arbitrary position in the file, being line 33.
	assert_equal "$ACTUAL_RESULT" "$EXPECTED_OUTPUT"
}