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
@test "Tests if 11 removes the unmodified additional package and adds the new additional package." {

	# Specifiy the filepath of the input file to which any changes may have been written by the function.
	ACTUAL_TARGET_FILEPATH="test/testfiles/hostfile_with_additional_pack.txt"
	
	# Read out the md5 checksum of the input file to which any changes may have been written by the function.
	md5_of_actual_target_after_additional_package_adding=$(sudo md5sum $ACTUAL_TARGET_FILEPATH)
	
	# Extract actual md5 checksum from the md5 command response.
	md5_of_actual_target_after_additional_package_adding_head=${md5_of_actual_target_after_additional_package_adding:0:32}
	
	# The function should have removed  the modified additional package and added the newly downloaded unmodified 
	# additional package. Hence, a hostfile with additional package is expected.
	EXPECTED_TARGET_FILEPATH="test/testfiles/hostfile_with_additional_pack.txt"
	
	# Read out the md5 checksum of the host file with the unmodified additional package.
	md5_of_expected_lines=$(sudo md5sum "$EXPECTED_TARGET_FILEPATH")
	
	# Extract actual md5 checksum from the md5 command response.
	md5_of_expected_lines_head=${md5_of_expected_lines:0:32}
	
	# Assert the function correctly created a hostfile with additional package.
	assert_equal "$md5_of_expected_lines_head" "$md5_of_actual_target_after_additional_package_adding_head"
}