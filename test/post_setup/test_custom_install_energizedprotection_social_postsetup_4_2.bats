#!/bin/bash

# Load bats testing packages
load '../../test/libs/bats-support/load'
load '../../test/libs/bats-assert/load'
load '../../test/libs/bats-file/load'

# Load hardcoded variables and helper functions.
source src/hardcoded_variables.txt
source src/helper.sh
source test/helper.sh


#-----------------------------------Test execution of custom_install_4_energizedprotection.sh-----------------------------------------------
@test "Tests whether an exception is thrown when computing the total nr of lines, if the file is not found." {
	
	# Read out the log file that contains the number of lines of an input file.
	ACTUAL_RESULT=$(<$FILEPATH_NR_LINES_HOSTFILE)
	
	# The amount of lines in the test file that is used is 4027 [lines]. Hence expect 4027.
	local original_expected_line_nr="4027"
	
	# The social package can be added before this package, so two possible answers are allowed.
	local additional_allowed_line_nr="$((original_expected_line_nr+LENGTH_PORN_PACKAGE))"
	
	echo "ACTUAL_RESULT"
	echo $ACTUAL_RESULT
	echo "additional_allowed_line_nr"
	echo $additional_allowed_line_nr
	
	ALLOWED_RESULTS=(
		$original_expected_line_nr
		$additional_allowed_line_nr
	)
	
	# Assert the function that counts the number of lines in an output file returns the correct number of lines for the used file with 4027 lines.
	TEST_RESULT=$(actual_result_has_any_allowed_result_in_head "$ACTUAL_RESULT" "${ALLOWED_RESULTS[@]}")
	assert_equal "$(echo -n "$TEST_RESULT" | tail -c 4)" "true"
}