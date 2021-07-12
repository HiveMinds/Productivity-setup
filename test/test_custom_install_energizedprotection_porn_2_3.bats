#!/bin/bash

# Load bats testing packages
load 'libs/bats-support/load'
load 'libs/bats-assert/load'
load 'libs/bats-file/load'

# Load hardcoded variables and helper functions.
source src/hardcoded_variables.txt
source src/helper.sh
source test/helper.sh

# Create the path to the log file folder.
mkdir -p src/logs


# Method that executes all tested main code before running tests.
setup() {
	# print test filename to screen.
	if [ "${BATS_TEST_NUMBER}" = 1 ];then
		echo "# Testfile: $(basename "${BATS_TEST_FILENAME}")-" >&3
	fi
	
	# Declare filenames of scripts needed to test this step of the energized protection installer.
	declare -a script_names=(
		"custom_install_2_energizedprotection"
	)
	
	# Specify an additional array with arguments
	declare -a additional_arguments=(
		#""
		#""
		"test/testfiles/hostfile_without_social_pack.txt"
	)

	# Execute the files and commands needed to test this step of the energized protection installer.
	for i in "${!script_names[@]}"; do
		# Pass filename to function that executes the file and passes the argument(s).
		install_energized_protection_porn_package "${script_names[i]}" "${additional_arguments[i]}"	
	done
}


#-----------------------------------Test execution of custom_install_0_energizedprotection.sh-----------------------------------------------
@test "custom_install_0_energizedprotection.sh ran the wget function to download the social package. This test verifies the log output is empty." {
	
	# Read the first 115 characters of the log file belonging to custom_install_0_energizedprotection.sh.
	LOG_ENDING=$(head -c 115 "$LOG_LOCATION""custom_install_0_energizedprotection.txt")
	
	# If the log file is empty, the wget command executed correctly. So expect an empty start/head of the log file.
	EXPECTED_OUTPUT=""
		
	# Assert that the log file content matches the expected input.
	assert_equal "$LOG_ENDING" "$EXPECTED_OUTPUT"
}


@test "Verifying the host.gz file is retrieved with wget." {
	assert_file_exist "$FILEPATH_DOWNLOADED_PACKAGE_GZ"
}


@test "Verifying the host.gz md5 is as expected." {
	
	# Read out the md5 checksum of the downloaded social package.
	md5_of_social_package=$(sudo md5sum "$FILEPATH_DOWNLOADED_PACKAGE_GZ")
	
	# Extract actual md5 checksum from the md5 command response.
	md5_of_social_package_head=${md5_of_social_package:0:32}
	
	# Assert the measured md5 checksum equals the hardcoded md5 checksum of the expected file.
	assert_equal "$md5_of_social_package_head" "54f9cec847f33a352b69a2ed83c68854"
}


#-----------------------------------Test execution of custom_install_1_energizedprotection.sh-----------------------------------------------
@test "Verifying the unpacked host.gz  exists." {
	assert_file_exist $FILEPATH_UNPACKED_PACKAGE
}


@test "Verifying the unpacked host.gz file md5  checksum is as expected." {
	
	# Read out the md5 checksum of the downloaded and unpacked social package file.
	md5_of_social_package=$(sudo md5sum "$FILEPATH_UNPACKED_PACKAGE")
	
	# Extract actual md5 checksum from the md5 command response.
	md5_of_social_package_head=${md5_of_social_package:0:32}
	
	# Assert the measured md5 checksum equals the hardcoded md5 checksum of the expected file.
	assert_equal "$md5_of_social_package_head" "161dbeb0b199c72953835b2708918204"
}


#-----------------------------------Test execution of custom_install_2_energizedprotection.sh-----------------------------------------------
@test "Tests whether the function that checks if the social package is contained in an target/input file returns false if an input file without social package is fed." {
	
	# Read out the log file belonging to custom_install_2_energizedprotection.sh.
	ACTUAL_RESULT=$(<$FILEPATH_HOSTFILE_CONTAINS_UNMODIFIED_PACKAGE)
	
	# Assert the function that checks if the social package is contained in an target/input file returns false if an input file without social package is fed.
	assert_equal "$ACTUAL_RESULT" "false"
}