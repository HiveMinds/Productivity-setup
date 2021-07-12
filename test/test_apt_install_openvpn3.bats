#!./test/libs/bats/bin/bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'
load 'libs/bats-file/load'

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
	declare -a arr=("apt_7_0_enable_apt_https_support"
		"apt_7_1_wget_public_openvpn_repository"
		"apt_7_2_add_openvpn_to_repository_list"
		"apt_7_3_wget_distro_dependent_repository"
		"apt_0_update"
		"apt_7_4_install_openvpn3"
		"apt_7_5_remove_openvpn-repo-pkg-key"
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
	assert_equal "$(echo -n "$TEST_RESULT" | tail -c 4)" "true"
	
		
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
