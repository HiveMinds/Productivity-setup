#!/bin/bash

# Load bats testing packages
load '../../test/libs/bats-support/load'
load '../../test/libs/bats-assert/load'
load '../../test/libs/bats-file/load'

# Load hardcoded variables and helper functions.
source src/hardcoded_variables.txt
source src/helper.sh
source test/helper.sh

#-----------------------------------Test execution of custom_install_4_energizedprotection.sh-----------------------------------------------
@test "Tests whether an exception is thrown when computing the total nr of lines, if the file is not found ERRROR." {
	# The test passes based if the assert failure directly follows this command (which throws an error because the file is not found).
	run install_energized_protection_social_package "custom_install_4_energizedprotection" "test/testfiles/nonexistant_filename.txt"
	
	# The test fails if the assert failure directly follows this (working) command. 
	#run install_energized_protection_social_package "custom_install_4_energizedprotection" "test/testfiles/hostfile_with_social_pack.txt"
	
	# Expect the command to fail when it is passed a path to a file that does not exist.
	assert_failure
}