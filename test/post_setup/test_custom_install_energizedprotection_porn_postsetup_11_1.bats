#!/bin/bash

# Load bats testing packages
load '../../test/libs/bats-support/load'
load '../../test/libs/bats-assert/load'
load '../../test/libs/bats-file/load'

# Load hardcoded variables and helper functions.
source src/hardcoded_variables.txt
source src/helper.sh
source test/helper.sh


#---------------------------------------------------------------------------------------------------------------------------
@test "Tests if 11 keeps an unmodified file if the porn package was already included." {
	
	# Specifiy the filepath of the input file to which any changes may have been written by the function.
	ACTUAL_TARGET_FILEPATH="test/testfiles/hostfile_with_porn_pack.txt"
	
	# Read out the md5 checksum of the input file to which any changes may have been written by the function.
	md5_of_actual_target_after_porn_package_adding=$(sudo md5sum $ACTUAL_TARGET_FILEPATH)
	# Extract actual md5 checksum from the md5 command response.
	md5_of_actual_target_after_porn_package_adding_head=${md5_of_actual_target_after_porn_package_adding:0:32}
	
	# The function should have kept the file unchanged because it already contained the unmodified porn package. Hence
	# a hostfile with porn package is expected.
	EXPECTED_TARGET_FILEPATH="test/testfiles/hostfile_with_porn_pack.txt"
	
	# Read out the md5 checksum of the host file with the unmodified porn package.
	md5_of_expected_lines=$(sudo md5sum "$EXPECTED_TARGET_FILEPATH")
	
	# Extract actual md5 checksum from the md5 command response.
	md5_of_expected_lines_head=${md5_of_expected_lines:0:32}
	
	# Assert the function did not modify the input file.
	assert_equal "$md5_of_expected_lines_head" "$md5_of_actual_target_after_porn_package_adding_head"
}