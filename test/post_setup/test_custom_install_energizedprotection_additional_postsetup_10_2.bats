#!/bin/bash

# Load bats testing packages
load '../../test/libs/bats-support/load'
load '../../test/libs/bats-assert/load'
load '../../test/libs/bats-file/load'

# Load hardcoded variables and helper functions.
source src/hardcoded_variables.txt
source src/helper.sh
source test/helper.sh



#-----------------------------------Test execution of custom_install_10_energizedprotection.sh-----------------------------------------------
# This checks a dummy test file between steps of the installation. However currently the tests is executed at the end of the
# installation, meaning the expected effect is not observable anymore. Furthermore, the test is written expecting some predetermined variant of the 
# hostfile, whereas there is no control over the host file content in the actual installation. Hence this test is ommitted.
#@test "Tests if 10 removes the modified social package." {
#	
#	# Read out the md5 checksum of the input file to which any changes may have been written by the function.
#	md5_of_actual_target_after_social_package_removal=$(sudo md5sum "test/testfiles/dummy_hostfile_with_modified_additional_pack.txt")
#	
#	# Extract actual md5 checksum from the md5 command response.
#	md5_of_actual_target_after_social_package_removal_head=${md5_of_actual_target_after_social_package_removal:0:32}
#	
#	# The function should have removed the modified social package, so expect the host file with social_package removed.
#	EXPECTED_TARGET_FILEPATH="test/testfiles/hostfile_with_modified_additional_pack_removed.txt"
#	
#	# Read out the md5 checksum of the host file with the modified social package removed.
#	md5_of_expected_lines=$(sudo md5sum "$EXPECTED_TARGET_FILEPATH")
#	
#	# Extract actual md5 checksum from the md5 command response.
#	md5_of_expected_lines_head=${md5_of_expected_lines:0:32}
#	
#	# Assert the function did not modify the input file.
#	assert_equal "$md5_of_expected_lines_head" "$md5_of_actual_target_after_social_package_removal_head"
#}