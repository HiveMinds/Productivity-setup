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

@test "running the apt install keepass2 function in some file and verifying log output." {
	LOG_ENDING=$(head -c 123 $LOG_LOCATION"apt_5_3_install_keepass2.txt")
	#EXPECTED_OUTPUT="Reading package lists... Building dependency tree... Reading state information... keepass2 is already the newest version"
	#assert_equal "$LOG_ENDING" "$EXPECTED_OUTPUT"
	
	ALLOWED_RESULTS=("Reading package lists... Building dependency tree... Reading state information... All packages are up to date."
		"Reading package lists... Building dependency tree... Reading state information... keepass2 is already the newest version"
		"Reading package lists... Building dependency tree... Reading state information... The following packages were automatically"
        	"packages can be upgraded. Run 'apt list --upgradable' to see them."
        )
	TEST_RESULT=$(actual_result_has_any_allowed_result_in_head "$LOG_ENDING" "${ALLOWED_RESULTS[@]}")
	assert_equal $(echo -n $TEST_RESULT | tail -c 4) "true"
	
		
}

@test "Checking autokey_gtk version response." {
	COMMAND_OUTPUT=$(keepass2 --version)
	EXPECTED_OUTPUT="KeePass 2.45
Copyright © 2003-2020 Dominik Reichl"
	COMMAND_OUTPUT_CHECKSUM=$(echo -e $COMMAND_OUTPUT | md5sum)
	EXPECTED_OUTPUT_CHECKSUM=$(echo -e $EXPECTED_OUTPUT | md5sum)

	assert_equal "$COMMAND_OUTPUT" "$EXPECTED_OUTPUT"
	assert_equal "$COMMAND_OUTPUT_CHECKSUM" "$EXPECTED_OUTPUT_CHECKSUM"
}

# TODO: test if the version command does not return: missing canberra-gtk-module
@test "Checking keepass2 version does not respond with Failed to load module canberra-gtk-module." {
	COMMAND_OUTPUT=$(keepass2 --version)
	
	EXPECTED_OUTPUT='Gtk-Message: 15:29:44.377: Failed to load module "canberra-gtk-module"
KeePass 2.45
Copyright © 2003-2020 Dominik Reichl'

	COMMAND_OUTPUT_CHECKSUM=$(echo -e $COMMAND_OUTPUT | md5sum)
	EXPECTED_OUTPUT_CHECKSUM=$(echo -e $EXPECTED_OUTPUT | md5sum)

	#assert_equal "$COMMAND_OUTPUT" "$EXPECTED_OUTPUT"
	#refute_equal "$COMMAND_OUTPUT" "$EXPECTED_OUTPUT"
	#refute_output_contains "Gtk-Message"
	refute [ assert_equal "$COMMAND_OUTPUT" "$EXPECTED_OUTPUT" ]
	assert_equal "$COMMAND_OUTPUT" "$EXPECTED_OUTPUT"

	#assert_equal "$COMMAND_OUTPUT_CHECKSUM" "$EXPECTED_OUTPUT_CHECKSUM"
}

# TODO: test if the ppa package is added correctly
# TODO: test if the libcanberra-gtk-module is installed correctly
# TODO: test if the libcanberra-gtk3-module is installed correctly
# TODO: test if the mono config is removed correctly
