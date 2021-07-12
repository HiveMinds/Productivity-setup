#!/bin/bash

# Load bats testing packages
load '../../test/libs/bats-support/load'
load '../../test/libs/bats-assert/load'
load '../../test/libs/bats-file/load'

# Load hardcoded variables and helper functions.
source src/hardcoded_variables.txt
source src/helper.sh
source test/helper.sh



#-----------------------------------Test execution of custom_install_7_energizedprotection.sh-----------------------------------------------
@test "Tests whether the query that searches the ending line of the social package returns the right line number." {

	# Read out the log file that contains the first occurance of the ending line string of the social package.
	ACTUAL_RESULT=$(<$FILEPATH_RELATIVE_ENDING_LINE_NR_OF_PACKAGE)
	
	# The ending line string in the used test file occurs at line 3994. The test file used in this test is 
	# the remainder of the lines of the social package after the first starting line that indicates the 
	# file content is the social package.
	EXPECTED_OUTPUT="3994"
		
	# Assert the function that gets the ending line number in a file with the remainder of a social package after
	# the starting line of the social package exports the correct ending line number.
	assert_equal "$ACTUAL_RESULT" "$EXPECTED_OUTPUT"
}