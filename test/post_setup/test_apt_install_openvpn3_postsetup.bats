#!./test/libs/bats/bin/bats

load '../../test/libs/bats-support/load'
load '../../test/libs/bats-assert/load'
load '../../test/libs/bats-file/load'

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

@test "running the apt install openvpn3 function in some file and verifying log output." {
	LOG_ENDING=$(head -c 123 $LOG_LOCATION"apt_7_4_install_openvpn3.txt")
	#EXPECTED_OUTPUT="Reading package lists... Building dependency tree... Reading state information... openvpn3 is already the newest version"
	#assert_equal "$LOG_ENDING" "$EXPECTED_OUTPUT"
	
	ALLOWED_RESULTS=("Reading package lists... Building dependency tree... Reading state information... All packages are up to date."
		"Reading package lists... Building dependency tree... Reading state information... openvpn3 is already the newest version"
		"Reading package lists... Building dependency tree... Reading state information... The following packages were automatically"
        	"packages can be upgraded. Run 'apt list --upgradable' to see them."
        )
	TEST_RESULT=$(actual_result_has_any_allowed_result_in_head "$LOG_ENDING" "${ALLOWED_RESULTS[@]}")
	assert_equal $(echo -n $TEST_RESULT | tail -c 4) "true"
	
		
}

@test "Checking openvpn3 version response." {
	COMMAND_OUTPUT=$(openvpn3 version)
	COMMAND_HEAD=${COMMAND_OUTPUT:0:17}
	EXPECTED_OUTPUT="OpenVPN 3/Linux v"
	assert_equal "$COMMAND_HEAD" "$EXPECTED_OUTPUT"
}

@test "Checking if openvpn-repo-pkg-key.pub artifact is removed." {
	assert_file_not_exist openvpn-repo-pkg-key.pub
}
