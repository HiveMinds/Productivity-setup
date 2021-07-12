#!./test/libs/bats/bin/bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source test/helper.sh
source src/hardcoded_variables.txt
source src/helper.sh

mkdir -p src/logs

# Method that executes all tested main code before running tests.
setup() {
	# print test filename to screen.
	if [ "${BATS_TEST_NUMBER}" = 1 ];then
		echo "# Testfile: $(basename ${BATS_TEST_FILENAME})-" >&3
	fi
		
	# Declare filenames of files that perform commands
	declare -a arr=("apt_0_update"
                "apt_1_upgrade"
                "snap_1_install_notepad_plus_plus"
                )
                	
	# Loop through files that perform commands
	for i in "${arr[@]}"
	do
		# run main functions that perform some commands
		run_main_functions "$i"
	done
}

@test "running the apt update function in some file and verifying log output." {
	LOG_CONTENT=$(cat $LOG_LOCATION"apt_0_update.txt")
        ALLOWED_RESULTS=("Reading package lists... Building dependency tree... Reading state information... All packages are up to date."
        	"packages can be upgraded. Run 'apt list --upgradable' to see them."
        )
	TEST_RESULT=$(actual_result_has_any_allowed_result_in_tail "$LOG_CONTENT" "${ALLOWED_RESULTS[@]}")
	
	assert_equal "$(echo -n "$TEST_RESULT" | tail -c 4)" "true"
}

@test "running the apt upgrade function in some file and verifying log output." {
	LOG_ENDING=$(tail -c 11 $LOG_LOCATION"apt_1_upgrade.txt")
	EXPECTED_OUTPUT=" upgraded."
		
	assert_equal "$LOG_ENDING" "$EXPECTED_OUTPUT"
}

@test "running the apt install git function in some file and verifying log output." {
	LOG_ENDING=$(head -c 115 $LOG_LOCATION"snap_1_install_notepad_plus_plus.txt")
	EXPECTED_OUTPUT=""
		
	assert_equal "$LOG_ENDING" "$EXPECTED_OUTPUT"
}

@test "Checking notepad++ is installed." {
	COMMAND_OUTPUT=$(snap list)
	EXPECTED_OUTPUT="notepad-plus-plus"
	
	string='My long string'
	if [[ $COMMAND_OUTPUT == *"notepad-plus-plus"* ]]; then
		echo "It's there!"
		assert_equal true true
	else
		assert_equal true false
	fi

	#assert_contains "$COMMAND_OUTPUT" "$EXPECTED_OUTPUT" #assert_contains: command not found

}

# TODO: find command to test if notepad++ is installed correctly, e.g. something like notepad-plus-plus --version
