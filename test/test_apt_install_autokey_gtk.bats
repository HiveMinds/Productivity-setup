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
                "apt_4_install_autokey_gtk"
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

@test "running the apt install autokey_gtk function in some file and verifying log output." {
	LOG_ENDING=$(head -c 123 $LOG_LOCATION"apt_4_install_autokey_gtk.txt")
	EXPECTED_OUTPUT="Reading package lists... Building dependency tree... Reading state information... autokey-gtk is already the newest version"
		
	assert_equal "$LOG_ENDING" "$EXPECTED_OUTPUT"
}

@test "Checking autokey_gtk version response." {
	COMMAND_OUTPUT=$(autokey-gtk --help)
	EXPECTED_OUTPUT="Usage: autokey-gtk [options]

Options:
  -h, --help       show this help message and exit
  -l, --verbose    Enable verbose logging
  -c, --configure  Show the configuration window on startup"
	COMMAND_OUTPUT_CHECKSUM=$(echo -e $COMMAND_OUTPUT | md5sum)
	EXPECTED_OUTPUT_CHECKSUM=$(echo -e $EXPECTED_OUTPUT | md5sum)

	assert_equal "$COMMAND_OUTPUT" "$EXPECTED_OUTPUT"
	assert_equal "$COMMAND_OUTPUT_CHECKSUM" "$EXPECTED_OUTPUT_CHECKSUM"
}
