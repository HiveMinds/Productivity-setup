#!./test/libs/bats/bin/bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

source test/helper.sh
source src/hardcoded_variables.txt
source src/ask_user_choice.sh
mkdir -p src/logs

# Makes the main script runnable, removes the log file and runs bash script that is tested.
run_main_functions() {
	local SCRIPT_NAME=$1	
	SCRIPT_PATH=src/"$SCRIPT_NAME".sh
	local LOG_PATH=$LOG_LOCATION"$SCRIPT_NAME".txt
	
	chmod +x $SCRIPT_PATH
	
	# Remove old log files if exist
	if [ -f "$LOG_PATH" ] ; then
	    rm "$LOG_PATH"
	fi
	
	# run the function that updates apt
	run ./$SCRIPT_PATH $LOG_PATH
}

# Method that executes all tested main code before running tests.
setup() {
	# print test filename to screen.
	if [ "${BATS_TEST_NUMBER}" = 1 ];then
		echo "# Testfile: $(basename ${BATS_TEST_FILENAME})-" >&3
	fi
	
	# Declare filenames of files that perform commands
	declare -a arr=("ask_user_choice"
        )
                	
	# Loop through files that perform commands
	for i in "${arr[@]}"
	do
		# run main functions that perform some commands
		run_main_functions "$i"
	done
}

@test "Test if custom user output is created correctly." {
	$(hardcode_user1_choice_example)
	
	# get the selected installation types for testing
	installation_types=($(read_categories "selected")) # outer brackets to convert string to list
	
	# test if the installation types are written correctly to user selected packages log
	for i in "${!INSTALLATION_TYPES[@]}"; do
	    assert_equal "${installation_types[i]}" "${INSTALLATION_TYPES[i]}"
	done
	
	# test if the selected apt packages are written correctly to user selected packages log
	actual_result=($(read_software_packages_per_category "selected" "apt")) # outer brackets to store as list
	for i in "${!USER1_APT_PACKAGES[@]}"; do
	    assert_equal "${actual_result[i]}" "${USER1_APT_PACKAGES[i]}"
	done
	
	# test if the selected snap packages are written correctly to user selected packages log
	actual_result=($(read_software_packages_per_category "selected" "snap")) # outer brackets to store as list
	for i in "${!USER1_SNAP_PACKAGES[@]}"; do
	    assert_equal "${actual_result[i]}" "${USER1_SNAP_PACKAGES[i]}"
	done
	
	# test if the selected custom packages are written correctly to user selected packages log
	actual_result=($(read_software_packages_per_category "selected" "custom")) # outer brackets to store as list
	for i in "${!USER1_CUSTOM_PACKAGES[@]}"; do
	    assert_equal "${actual_result[i]}" "${USER1_CUSTOM_PACKAGES[i]}"
	done
	
	# test if the selected needUserInput packages are written correctly to user selected packages log
	actual_result=($(read_software_packages_per_category "selected" "needUserInput")) # outer brackets to store as list
	for i in "${!USER1_NEEDUSERINPUT_PACKAGES[@]}"; do
	    assert_equal "${actual_result[i]}" "${USER1_NEEDUSERINPUT_PACKAGES[i]}"
	done
	
	# test if the selected deviceDependent packages are written correctly to user selected packages log
	actual_result=($(read_software_packages_per_category "selected" "deviceDependent")) # outer brackets to store as list
	for i in "${!USER1_DEVICEDEPENDENT_PACKAGES[@]}"; do
	    assert_equal "${actual_result[i]}" "${USER1_DEVICEDEPENDENT_PACKAGES[i]}"
	done
}

@test "Verify the categories are read correctly." {
	actual_result=$(read_categories "supported")
	actual_results=($actual_result) # convert single string to list
        #expected_results=("apt" "snap" "custom" "needUserInput" "deviceDependent")
        expected_results=$INSTALLATION_TYPES
	
	for i in "${!expected_results[@]}"; do
	    assert_equal "${actual_results[i]}" "${expected_results[i]}"
	done
}

@test "Verify the supported_software_packages are read correctly for category: apt." {
	tested_category="apt"
	actual_result=$(read_software_packages_per_category "supported" $tested_category)
	actual_results=($actual_result) # convert single string to list
        expected_results=("autokey-gtk"
		"github"
		"keepass2"
		"openvpn3"
		"privoxy"
		"searchmonkey"
		"signal"
		"texlive-xetex"
		"texmaker"
		"wine"
		)
	
	for i in "${!expected_results[@]}"; do
	    assert_equal "${actual_results[i]}" "${expected_results[i]}"
	done
}

@test "Verify the supported_software_packages are read correctly for category: snap." {
	tested_category="snap"
	actual_result=$(read_software_packages_per_category  "supported" $tested_category)
	actual_results=($actual_result) # convert single string to list
        expected_results=("anki"
			"notepad++"
		)
	
	for i in "${!expected_results[@]}"; do
	    assert_equal "${actual_results[i]}" "${expected_results[i]}"
	done
}

@test "Verify the supported_software_packages are read correctly for category: custom." {
	tested_category="custom"
	actual_result=$(read_software_packages_per_category  "supported" $tested_category)
	actual_results=($actual_result) # convert single string to list
        expected_results=("anaconda"
			"energizedprotection_social"
			"energizedprotection_porn"
		)
	
	for i in "${!expected_results[@]}"; do
	    assert_equal "${actual_results[i]}" "${expected_results[i]}"
	done
}

@test "Verify the supported_software_packages are read correctly for category: needUserInput." {
	tested_category="needUserInput"
	actual_result=$(read_software_packages_per_category  "supported" $tested_category)
	actual_results=($actual_result) # convert single string to list
        expected_results=("")
	
	for i in "${!expected_results[@]}"; do
	    assert_equal "${actual_results[i]}" "${expected_results[i]}"
	done
}

@test "Verify the supported_software_packages are read correctly for category: deviceDependent." {
	tested_category="deviceDependent"
	actual_result=$(read_software_packages_per_category  "supported" $tested_category)
	actual_results=($actual_result) # convert single string to list
        expected_results=("")
	
	for i in "${!expected_results[@]}"; do
	    assert_equal "${actual_results[i]}" "${expected_results[i]}"
	done
}

@test "Verify the complete list of supported_software_packages is read correctly." {
	supported_software_packages=$(read_software_packages "supported")
	
	actual_results=($supported_software_packages) # convert single string to list
        expected_results=(
		"autokey-gtk"
		"github"
		"keepass2"
		"openvpn3"
		"privoxy"
		"searchmonkey"
		"signal"
		"texlive-xetex"
		"texmaker"
		"wine"
		"anki"
		"notepad++"
		"anaconda"
		"energizedprotection_social"
		"energizedprotection_porn"
	)
	
	for i in "${!expected_results[@]}"; do
	    assert_equal "${actual_results[i]}" "${expected_results[i]}"
	done
}
