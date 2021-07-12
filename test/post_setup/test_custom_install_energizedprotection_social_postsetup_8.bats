#!/bin/bash

# Load bats testing packages
load '../../test/libs/bats-support/load'
load '../../test/libs/bats-assert/load'
load '../../test/libs/bats-file/load'

# Load hardcoded variables and helper functions.
source src/hardcoded_variables.txt
source src/helper.sh
source test/helper.sh


#-----------------------------------Test execution of custom_install_8_energizedprotection.sh-----------------------------------------------
@test "Tests the remaining number of lines after the starting line in the target file is computed correctly." {
	
	# Read out the log file that contains the absolute line number of the ending line of the social package.
	ACTUAL_RESULT=$(<$FILEPATH_LINE_NR_PACKAGE_END_IN_HOSTFILE)
	
	# The ending line of the social package in the test file is located at line 4027. Hence expect 4027.
	EXPECTED_OUTPUT="4027"

	# Assert the function that gets the line number of the ending line in the social package returns the correct line number for a given test file.
	assert_equal "$ACTUAL_RESULT" "$EXPECTED_OUTPUT"
}