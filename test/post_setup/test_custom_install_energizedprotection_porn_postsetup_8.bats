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
	
	# The ending line of the social package in the test file is located at line 316089. Hence expect 316089.
	local original_expected_line_nr="316089"
	
	# The social package can be added before this package, so two possible answers are allowed.
	local additional_allowed_line_nr="$((original_expected_line_nr+LENGTH_SOCIAL_PACKAGE))"
	
	ALLOWED_RESULTS=(
		$original_expected_line_nr
		$additional_allowed_line_nr
	)
	
	# Assert the function that gets the line number of the ending line in the social package returns the correct line number for a given test file.
	TEST_RESULT=$(actual_result_has_any_allowed_result_in_head "$ACTUAL_RESULT" "${ALLOWED_RESULTS[@]}")
	assert_equal "$(echo -n "$TEST_RESULT" | tail -c 4)" "true"
}