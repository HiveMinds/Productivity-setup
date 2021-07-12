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

@test "running the apt install signal part 1/3 function in some file and verifying log output." {
	LOG_ENDING=$(head -c 2 $LOG_LOCATION"apt_3_1_install_signal.txt")
	EXPECTED_OUTPUT="OK"
		
	assert_equal "$LOG_ENDING" "$EXPECTED_OUTPUT"
}

@test "running the apt install signal part 2/3 function in some file and verifying log output." {	
	LOG_CONTENT=$(cat $LOG_LOCATION"apt_3_2_install_signal.txt")
	ALLOWED_RESULTS=("deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main"
        	"The signal repository was already added to the list of signal repositories."
        )
	TEST_RESULT=$(actual_result_has_any_allowed_result_in_tail "$LOG_CONTENT" "${ALLOWED_RESULTS[@]}")
	assert_equal $(echo -n $TEST_RESULT | tail -c 4) "true"
	
	TEST_RESULT=$(actual_result_has_any_allowed_result_in_head "$LOG_CONTENT" "${ALLOWED_RESULTS[@]}")
	assert_equal $(echo -n $TEST_RESULT | tail -c 4) "true"
}

@test "running the apt install signal part 1/3 function in some file and verifying head of log output." {
	LOG_CONTENT=$(cat $LOG_LOCATION"apt_3_4_install_signal.txt")
	ALLOWED_RESULTS=("Reading package lists... Building dependency tree... Reading state information... signal-desktop is already the newest version"
        )
        
	TEST_RESULT=$(actual_result_has_any_allowed_result_in_head "$LOG_CONTENT" "${ALLOWED_RESULTS[@]}")
	assert_equal $(echo -n $TEST_RESULT | tail -c 4) "true"
}

@test "running the apt install signal part 1/3 function in some file and verifying tail of log output." {
	LOG_CONTENT=$(cat $LOG_LOCATION"apt_3_4_install_signal.txt")
	ALLOWED_RESULTS=("0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded."
	"1 upgraded, 0 newly installed, 0 to remove and 0 not upgraded."
	"0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded."
        )
        
	TEST_RESULT=$(actual_result_has_any_allowed_result_in_tail "$LOG_CONTENT" "${ALLOWED_RESULTS[@]}")
	assert_equal $(echo -n $TEST_RESULT | tail -c 4) "true"
}
# TODO: test the actual installed software package with: something like:signal-desktop --version
