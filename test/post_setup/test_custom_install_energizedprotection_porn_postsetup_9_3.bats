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
# No control over the actual host file, so this test is ommitted because it requires a specific type of hostfile
#@test "Tests if the install 9 correctly outputs true if the modified social package is contained." {
#	
#	# Read out the log file that contains whether an unmodified social package is contained.
#	ACTUAL_RESULT=$(<$FILEPATH_HOSTFILE_CONTAINS_MODIFIED_PACKAGE)
#	
#	# If an input file is fed that contains a modified social pack, the function should output true.
#	EXPECTED_OUTPUT="true"
#
#	# Assert the function that determines wheter a modified social package is contained, outputs the true value if 
#	# a modified social package is contained.
#	assert_equal "$ACTUAL_RESULT" "$EXPECTED_OUTPUT"
#}