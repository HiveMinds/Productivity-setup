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

@test "running the apt install privoxy function in some file and verifying log output." {
	LOG_ENDING=$(head -c 123 $LOG_LOCATION"apt_6_install_privoxy.txt")
	ALLOWED_RESULTS=("Reading package lists... Building dependency tree... Reading state information... All packages are up to date."
		"Reading package lists... Building dependency tree... Reading state information... privoxy is already the newest version"
		"Reading package lists... Building dependency tree... Reading state information... The following packages were automatically"
        	"packages can be upgraded. Run 'apt list --upgradable' to see them."
        )
	TEST_RESULT=$(actual_result_has_any_allowed_result_in_head "$LOG_ENDING" "${ALLOWED_RESULTS[@]}")
	assert_equal $(echo -n $TEST_RESULT | tail -c 4) "true"		
}

@test "Checking privoxy version response." {
	COMMAND_OUTPUT=$(privoxy --version)
	ALLOWED_RESULTS=("Privoxy version 3."
        	"privoxy version 4."
        	"privoxy version 5."
        	"privoxy version 6."
        	"privoxy version 7."
        	"privoxy version 8."
        	"privoxy version 9."
        )
        
	TEST_RESULT=$(actual_result_has_any_allowed_result_in_head "$COMMAND_OUTPUT" "${ALLOWED_RESULTS[@]}")
	assert_equal $(echo -n $TEST_RESULT | tail -c 4) "true"
}
