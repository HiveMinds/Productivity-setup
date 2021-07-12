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

@test "assert the right string is not in the tail of the left string." {
	left="Right hand string"
	right="Some string"
	TEST_RESULT=$(right_is_in_tail_of_left "$left" "$right")
	assert_equal $(echo -n $TEST_RESULT | tail -c 5) "false"
}

@test "assert the right string is in the tail of the left string." {
	left="Right hand string Some string"
	right="Some string"
	TEST_RESULT=$(right_is_in_tail_of_left "$left" "$right")
	assert_equal "$(echo -n "$TEST_RESULT" | tail -c 4)" "true"
}

@test "assert the right string is not in the head of the left string." {
	left="Right hand string"
	right="Some string"
	allowed_size=${#right}
	TEST_RESULT=$(right_is_in_tail_of_left "$left" "$right")
	assert_equal $(echo -n $TEST_RESULT | tail -c 5) "false"
}

@test "assert the right string is in the head of the right left." {
	left="Some string Right hand string"
	right="Some string"
	allowed_size=${#right}
	TEST_RESULT=$(right_is_in_head_of_left "$left" "$right")
	assert_equal "$(echo -n "$TEST_RESULT" | tail -c 4)" "true"
}

@test "Test if equality function returns false on unequal input." {
	left="Some string"
	right="Different string"
	TEST_RESULT=$(equal_strings "$left" "$right")
	assert_equal $(echo -n $TEST_RESULT | tail -c 5) "false"
}

@test "Test if equality function returns false on unequally capitalized input." {
	left="Some string"
	right="some string"
	TEST_RESULT=$(equal_strings "$left" "$right")
	assert_equal $(echo -n $TEST_RESULT | tail -c 5) "false"
}

@test "Test if equality function returns true on equal input." {
	left="Some string"
	right="Some string"
	TEST_RESULT=$(equal_strings "$left" "$right")
	assert_equal "$(echo -n "$TEST_RESULT" | tail -c 4)" "true"
}

@test "Test if the function returns true if the left string contains right string." {
	left="Some string that does not contains a substring somewhere in the middle."
	right="a substring that is not contained"
	TEST_RESULT=$(left_contains_right "$left" "$right")
	assert_equal $(echo -n $TEST_RESULT | tail -c 5) "false"
}

@test "Test if the function returns false if the left string does not contain right string." {
	left="Some string that contains a substring somewhere in the middle."
	right="a substring somewhere"
	TEST_RESULT=$(left_contains_right "$left" "$right")
	assert_equal "$(echo -n "$TEST_RESULT" | tail -c 4)" "true"
}
