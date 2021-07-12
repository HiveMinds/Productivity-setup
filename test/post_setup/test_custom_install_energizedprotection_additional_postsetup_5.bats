#!/bin/bash

# Load bats testing packages
load '../../test/libs/bats-support/load'
load '../../test/libs/bats-assert/load'
load '../../test/libs/bats-file/load'

# Load hardcoded variables and helper functions.
source src/hardcoded_variables.txt
source src/helper.sh
source test/helper.sh


#-----------------------------------Test execution of custom_install_5_energizedprotection.sh-----------------------------------------------
@test "Tests the remaining number of lines after the starting line in the target file is computed correctly." {
	
	# Read out the log file that contains the number of lines of an input file.
	ACTUAL_RESULT=$(<$FILEPATH_NR_LINES_IN_HOSTFILE_AFTER_PACKAGE_INDICATOR)
	echo "ACTUAL_RESULT= "
	echo $ACTUAL_RESULT
	
	# The amount of lines in the test file between the starting line of the social package, and the end line of the
	# testfile is 316056 [lines]. Hence expect 316056.
	EXPECTED_OUTPUT="316056"

	# Assert the function that counts the number of lines between the starting line of the social package and the end line of some input file exports 
	# the correct number of lines.
	assert_equal "$ACTUAL_RESULT" "$EXPECTED_OUTPUT"
}