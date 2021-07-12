#!./test/libs/bats/bin/bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source test/helper.sh

setup() {
	# print test filename to screen.
	if [ "${BATS_TEST_NUMBER}" = 1 ];then
		echo "# Testfile: $(basename ${BATS_TEST_FILENAME})-" >&3
	fi
}

@test "Tests if actual_result_has_any_allowed_result_in_head method returns false if the actual result does not contain any of the allowed/expected results." {
	ACTUAL_RESULT="this is an output with the expected output at the head"
	ALLOWED_RESULTS=(
		"a different output"
		"another different output"
    		"an extra different output"
	)
	TEST_RESULT=$(actual_result_has_any_allowed_result_in_head "$ACTUAL_RESULT" "${ALLOWED_RESULTS[@]}")
	assert_equal $(echo -n $TEST_RESULT | tail -c 5) "false"
}

@test "Tests if actual_result_has_any_allowed_result_in_head method returns true if the actual result head equals the first list element of the allowed/expected results." {
	ACTUAL_RESULT="this is an output with the expected output at the head"
	ALLOWED_RESULTS=(
		"this is an output"
		"a different output"
		"another different output"
    		"an extra different output"
	)
	TEST_RESULT=$(actual_result_has_any_allowed_result_in_head "$ACTUAL_RESULT" "${ALLOWED_RESULTS[@]}")
	assert_equal "$(echo -n "$TEST_RESULT" | tail -c 4)" "true"
}

@test "Tests if actual_result_has_any_allowed_result_in_head method returns true if the actual result head equals the second list element of the allowed/expected results." {
	ACTUAL_RESULT="this is an output with the expected output at the head"
	ALLOWED_RESULTS=(
		"a different output"
		"this is an output"
		"another different output"
    		"an extra different output"
	)
	TEST_RESULT=$(actual_result_has_any_allowed_result_in_head "$ACTUAL_RESULT" "${ALLOWED_RESULTS[@]}")
	assert_equal "$(echo -n "$TEST_RESULT" | tail -c 4)" "true"
}

@test "Tests if actual_result_has_any_allowed_result_in_head method returns true if the actual result head equals the third list element of the allowed/expected results." {
	ACTUAL_RESULT="this is an output with the expected output at the head"
	ALLOWED_RESULTS=(
		"a different output"
		"another different output"
    		"this is an output"
    		"an extra different output"
	)
	TEST_RESULT=$(actual_result_has_any_allowed_result_in_head "$ACTUAL_RESULT" "${ALLOWED_RESULTS[@]}")
	assert_equal "$(echo -n "$TEST_RESULT" | tail -c 4)" "true"
}

@test "Tests if actual_result_has_any_allowed_result_in_head method returns true if the actual result head equals the last list element of the allowed/expected results." {
	ACTUAL_RESULT="this is an output with the expected output at the head"
	ALLOWED_RESULTS=(
		"a different output"
		"another different output"
    		"an extra different output"
    		"this is an output"
	)
	TEST_RESULT=$(actual_result_has_any_allowed_result_in_head "$ACTUAL_RESULT" "${ALLOWED_RESULTS[@]}")
	assert_equal "$(echo -n "$TEST_RESULT" | tail -c 4)" "true"
}

@test "Tests if actual_result_has_any_allowed_result_in_head method returns true if the actual result head equals the second and last list element of the allowed/expected results." {
	ACTUAL_RESULT="this is an output with the expected output at the head"
	ALLOWED_RESULTS=(
		"a different output"
		"this is an output"
		"another different output"
    		"an extra different output"
    		"this is an output"
	)
	TEST_RESULT=$(actual_result_has_any_allowed_result_in_head "$ACTUAL_RESULT" "${ALLOWED_RESULTS[@]}")
	assert_equal "$(echo -n "$TEST_RESULT" | tail -c 4)" "true"
}

@test "Tests if actual_result_has_any_allowed_result_in_head method returns false if only the actual result is passed without passing expected results." {
	ACTUAL_RESULT="this is an output with the expected output at the head"
	TEST_RESULT=$(actual_result_has_any_allowed_result_in_head "$ACTUAL_RESULT")
	assert_equal $(echo -n $TEST_RESULT | tail -c 5) "false"
}
