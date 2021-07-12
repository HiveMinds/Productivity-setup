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
@test "Tests whether the query that searches the start line outputs the correct line number also works for the modified social package" {
	
	# Read out the log file belonging to that contains the starting line number for the social package
	ACTUAL_RESULT=$(<$FILEPATH_PACKAGE_INDICATOR_LINE_NR)
	
	# The "test/testfiles/hostfile_without_social_pack_startline_at_end.txt" file has the modified social package, and unmodified social package starting line in line 33, hence expect 33.
	local original_expected_line_nr="33"
	
	# The social package can be added before this package, so two possible answers are allowed.
	local additional_allowed_line_nr="$((original_expected_line_nr+LENGTH_SOCIAL_PACKAGE))"
	
	ALLOWED_RESULTS=(
		$original_expected_line_nr
		$additional_allowed_line_nr
	)
	
	# Assert the function that gets the line number of the starting line of the social package also works for the modified social package.
	TEST_RESULT=$(actual_result_has_any_allowed_result_in_head "$ACTUAL_RESULT" "${ALLOWED_RESULTS[@]}")
	assert_equal "$(echo -n "$TEST_RESULT" | tail -c 4)" "true"
}