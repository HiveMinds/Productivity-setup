#!/bin/bash

# Load bats testing packages
load '../../test/libs/bats-support/load'
load '../../test/libs/bats-assert/load'
load '../../test/libs/bats-file/load'

# Load hardcoded variables and helper functions.
source src/hardcoded_variables.txt
source src/helper.sh
source test/helper.sh


#-----------------------------------Test execution of custom_install_6_energizedprotection.sh-----------------------------------------------
# No control over the host file in the actual setup, so the host file can contain other packages, which yield a different 
# remainder of host files, hence this test is skipped.
#@test "Tests the remaining number of lines after the starting line in the target file is computed correctly." {
#	
#	# Read out the md5 checksum of the log file that is created containing the remaining lines of some input file
#	# after the starting line that indicates it contains the social package.
#	md5_of_actual_remaining_lines=$(sudo md5sum $FILEPATH_REMAINING_LINES_HOSTFILE_AFTER_PACKAGE_INDICATOR)
#	
#	# Extract actual md5 checksum from the md5 command response.
#	md5_of_actual_remaining_lines_head=${md5_of_actual_remaining_lines:0:32}
#	
#	# Specify the filepath towards the test file that contains the expected output.
#	expected_output_filename="test/testfiles/remainder_of_hostfile_with_porn_pack_after_startline.txt"
#	
#	# Read out the md5 checksum of the test file that contains the expected output.
#	md5_of_expected_remaining_lines=$(sudo md5sum "$expected_output_filename")
#	
#	# Extract actual md5 checksum from the md5 command response.
#	md5_of_expected_remaining_lines_head=${md5_of_expected_remaining_lines:0:32}
#	
#	# Assert that the remaining amount of lines that are put into the log file equal the expected lines.
#	assert_equal "$md5_of_expected_remaining_lines_head" "$md5_of_actual_remaining_lines_head"
#}