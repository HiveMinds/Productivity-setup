#!/bin/bash

# Load bats testing packages
load '../../test/libs/bats-support/load'
load '../../test/libs/bats-assert/load'
load '../../test/libs/bats-file/load'

# Load hardcoded variables and helper functions.
source src/hardcoded_variables.txt
source src/helper.sh
source test/helper.sh


#-----------------------------------Test execution of custom_install_9_energizedprotection.sh-----------------------------------------------
@test "Tests if the install 9 correctly outputs false if a target file without social package is fed as input." {
	
	# Read out the log file that contains whether an unmodified social package is contained.
	ACTUAL_RESULT=$(<$FILEPATH_HOSTFILE_CONTAINS_MODIFIED_PACKAGE)
	
	# If an input file is fed that does not contain the social pack, the function should output false.
	EXPECTED_OUTPUT="false"

	# Assert the function that determines wheter a modified social package is contained, outputs the false value if no social package is contained.
	assert_equal "$ACTUAL_RESULT" "$EXPECTED_OUTPUT"
}