#!/bin/bash

# Load bats testing packages
load '../../test/libs/bats-support/load'
load '../../test/libs/bats-assert/load'
load '../../test/libs/bats-file/load'

# Load hardcoded variables and helper functions.
source src/hardcoded_variables.txt
source src/helper.sh
source test/helper.sh

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
	assert_equal "$md5_of_social_package_head" "c53fd7afc655b6265a4047bf4732ca91"
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
	assert_equal "$md5_of_social_package_head" "cbc901b34cc82dc89e1799c4b092e003"
}


#-----------------------------------Test execution of custom_install_2_energizedprotection.sh-----------------------------------------------
@test "Tests check for target contains social package outputs true or false." {
	
	# Read out the log file belonging to custom_install_2_energizedprotection.sh.
	ACTUAL_RESULT=$(<$FILEPATH_HOSTFILE_CONTAINS_UNMODIFIED_PACKAGE)
	
	# Specify the allowed results, the function should always output "true" or "false"
	ALLOWED_RESULTS=(
		"true"
		"false"
	)
	
	# Call a helper function returning "true" or "false" that checks if the actual result is contained in the allowed results.
	TEST_RESULT=$(actual_result_contains_any_allowed_result "$ACTUAL_RESULT" "${ALLOWED_RESULTS[@]}")
	
	# Assert the output of the helper function that checks whether the actual result was an allowed result, returns true.
	assert_equal "$(echo -n "$TEST_RESULT" | tail -c 4)" "true"
}