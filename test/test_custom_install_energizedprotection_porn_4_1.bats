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
}


#-----------------------------------Test execution of custom_install_4_energizedprotection.sh-----------------------------------------------
@test "Tests whether an exception is thrown when computing the total nr of lines, if the file is not found ERRROR." {
	# The test passes based if the assert failure directly follows this command (which throws an error because the file is not found).
	run install_energized_protection_porn_package "custom_install_4_energizedprotection" "test/testfiles/nonexistant_filename.txt"
	
	# The test fails if the assert failure directly follows this (working) command. 
	#run install_energized_protection_porn_package "custom_install_4_energizedprotection" "test/testfiles/hostfile_with_social_pack.txt"
	
	# Expect the command to fail when it is passed a path to a file that does not exist.
	assert_failure
}