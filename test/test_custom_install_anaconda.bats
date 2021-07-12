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
                "custom_0_get_anaconda_install_script"
				"custom_1_run_silent_anaconda_install_script"
                )
	
	if ! [ -d "/home/$USER/anaconda" ] || [ -d "/home/$USER/anaconda3" ]; then	
		# Loop through files that perform commands
		for i in "${arr[@]}"
		do
			# run main functions that perform some commands
			run_main_functions "$i"
		done
		
	
		# Do a manual installation with a few commands combined as they all have to be ran from 
		# within the conda shell
		./src/custom_6_complete_anaconda_install.sh
	fi
}

@test "running the apt update function in some file and verifying log output, if an installation is performed." {
	if [ -f "$LOG_LOCATION"apt_0_update.txt]; then
		LOG_CONTENT=$(cat $LOG_LOCATION"apt_0_update.txt")
			ALLOWED_RESULTS=("Reading package lists... Building dependency tree... Reading state information... All packages are up to date."
				"packages can be upgraded. Run 'apt list --upgradable' to see them."
			)
		TEST_RESULT=$(actual_result_has_any_allowed_result_in_tail "$LOG_CONTENT" "${ALLOWED_RESULTS[@]}")
		
		assert_equal "$(echo -n "$TEST_RESULT" | tail -c 4)" "true"
	fi
}

@test "running the apt upgrade function in some file and verifying log output, if an installation is performed." {
	if [ -f "$LOG_LOCATION"apt_1_upgrade.txt]; then
		LOG_ENDING=$(tail -c 11 $LOG_LOCATION"apt_1_upgrade.txt")
		EXPECTED_OUTPUT=" upgraded."
			
		assert_equal "$LOG_ENDING" "$EXPECTED_OUTPUT"
	fi
}

@test "running the custom_0_get_anaconda_install_script function in some file and verifying log output, if an installation is performed." {
	if [ -f "$LOG_LOCATION"custom_0_get_anaconda_install_script.txt]; then
		LOG_ENDING=$(head -c 115 $LOG_LOCATION"custom_0_get_anaconda_install_script.txt")
		EXPECTED_OUTPUT="Reading package lists... Building dependency tree... Reading state information... Calculating upgrade... The follow"
			
		assert_equal "$LOG_ENDING" "$EXPECTED_OUTPUT"
	fi
}

@test "Test the conda command is recognized." {
	COMMAND_OUTPUT=$(conda -V)
		
	ALLOWED_RESULTS=("conda 4."
        	"conda 5."
			"conda 6."
			"conda 7."
			"conda 8."
			"conda 9."
			"conda 10."
        )
	TEST_RESULT=$(actual_result_has_any_allowed_result_in_head "$COMMAND_OUTPUT" "${ALLOWED_RESULTS[@]}")
	
	assert_equal "$(echo -n "$TEST_RESULT" | tail -c 4)" "true"
}


@test "Test if either the home/$USER/anaconda3 or .../anaconda directory exists." {
	# does not assert file but bath, hence also supports asserting dirs
	#assert_file_exist /home/$USER/anaconda3 || /home/$USER/anaconda

	# check if either of the two directories exists, one is sufficient.
	if [ -d "/home/$USER/anaconda" ] || [ -d "/home/$USER/anaconda3" ]; then
		assert_equal true true
	else
		assert_equal true false
	fi
}

@test "Checking anaconda content is present in the.bashrc content" {
	filepath=/home/$USER/.bashrc

	starting_line_query=$(grep -n "# >>> conda initialize >>>" $filepath)
	ending_line_query=$(grep -n "# <<< conda initialize <<<" $filepath)
	IFS=':'     # space is set as delimiter

	if [ "$starting_line_query" != "" ] && [ "$ending_line_query" != "" ]; then
		assert_equal true true
	else
		assert_equal true false
	fi
}