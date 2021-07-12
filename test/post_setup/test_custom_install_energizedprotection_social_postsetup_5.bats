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
	# testfile is 3994 [lines]. Hence expect 3994.
	local original_expected_line_nr="3994"
	
	# The social package can be added before this package, so two possible answers are allowed.
	local additional_allowed_line_nr="$((original_expected_line_nr+LENGTH_PORN_PACKAGE))"
	
	ALLOWED_RESULTS=(
		$original_expected_line_nr
		$additional_allowed_line_nr
	)
	
	# Assert the function that counts the number of lines between the starting line of the social package and the end line of some input file exports 
	# the correct number of lines.
	TEST_RESULT=$(actual_result_has_any_allowed_result_in_head "$ACTUAL_RESULT" "${ALLOWED_RESULTS[@]}")
	assert_equal "$(echo -n "$TEST_RESULT" | tail -c 4)" "true"

	
	
}