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


@test "running the apt install zotero function in some file and verifying it is already installed succesfully head of log output." {
	LOG_CONTENT=$(cat $LOG_LOCATION"apt_install_zotero_1.txt")
	ALLOWED_RESULTS=("Reading package lists... Building dependency tree... Reading state information... zotero is already the newest version"
        )
        
	TEST_RESULT=$(actual_result_has_any_allowed_result_in_head "$LOG_CONTENT" "${ALLOWED_RESULTS[@]}")
	assert_equal $(echo -n $TEST_RESULT | tail -c 4) "true"
}

@test "Checking Zotero version response." {
	COMMAND_OUTPUT=$(zotero --version)
	EXPECTED_OUTPUT="Zotero Zotero 5."
		
	ALLOWED_RESULTS=("Zotero Zotero 2."
        	"Zotero Zotero 3."
        	"Zotero Zotero 4."
        	"Zotero Zotero 5."
        	"Zotero Zotero 6."
        	"Zotero Zotero 7."
        	"Zotero Zotero 8."
        	"Zotero Zotero 9."
        )
	TEST_RESULT=$(actual_result_has_any_allowed_result_in_head "$COMMAND_OUTPUT" "${ALLOWED_RESULTS[@]}")
	
	assert_equal "$(echo -n "$TEST_RESULT" | tail -c 4)" "true"
}