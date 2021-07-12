#!./test/libs/bats/bin/bats

load '../../test/libs/bats-support/load'
load '../../test/libs/bats-assert/load'

source src/hardcoded_variables.txt
source test/helper.sh

@test "running the apt update function in some file and verifying log output." {
	LOG_CONTENT=$(cat $LOG_LOCATION"apt_0_update.txt")
        ALLOWED_RESULTS=("Reading package lists... Building dependency tree... Reading state information... All packages are up to date."
        	"packages can be upgraded. Run 'apt list --upgradable' to see them."
        )
	TEST_RESULT=$(actual_result_has_any_allowed_result_in_tail "$LOG_CONTENT" "${ALLOWED_RESULTS[@]}")
	
	assert_equal $(echo -n $TEST_RESULT | tail -c 4) "true"
}

@test "running the apt upgrade function in some file and verifying log output." {
	LOG_ENDING=$(tail -c 11 $LOG_LOCATION"apt_1_upgrade.txt")
	EXPECTED_OUTPUT=" upgraded."
		
	assert_equal "$LOG_ENDING" "$EXPECTED_OUTPUT"
}

@test "running the apt install anki function in some file and verifying log output." {
	LOG_ENDING=$(head -c 115 $LOG_LOCATION"snap_0_install_anki.txt")
	EXPECTED_OUTPUT=""
		
	assert_equal "$LOG_ENDING" "$EXPECTED_OUTPUT"
}

@test "Checking notepad++ is installed." {
	COMMAND_OUTPUT=$(snap list)
	EXPECTED_OUTPUT="notepad-plus-plus"
	
	string='My long string'
	if [[ $COMMAND_OUTPUT == *"anki-woodrow"* ]]; then
		echo "It's there!"
		assert_equal true true
	else
		assert_equal true false
	fi

	#assert_contains "$COMMAND_OUTPUT" "$EXPECTED_OUTPUT" #assert_contains: command not found

}
