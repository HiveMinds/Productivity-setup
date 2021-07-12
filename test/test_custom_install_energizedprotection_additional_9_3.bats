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
	# 3=export the starting_line
	# 4=export the total nr of lines
	# 5=export the remaining amount of lines
	# 6=output the remainder lines of the target file
	declare -a script_names=(
		"custom_install_9_energizedprotection"
	)
	
	# Specify an additional array with arguments
	declare -a additional_arguments=(
		"test/testfiles/hostfile_with_modified_additional_pack.txt"
	)

	# Execute the files and commands needed to test this step of the energized protection installer.
	for i in "${!script_names[@]}"; do
		# Pass filename to function that executes the file and passes the argument(s).
		install_energized_protection_additional_package "${script_names[i]}" "${additional_arguments[i]}"	
	done
}


#-----------------------------------Test execution of custom_install_9_energizedprotection.sh-----------------------------------------------
@test "Tests if the install 9 correctly outputs true if the modified social package is contained." {
	
	# Read out the log file that contains whether an unmodified social package is contained.
	ACTUAL_RESULT=$(<$FILEPATH_HOSTFILE_CONTAINS_MODIFIED_PACKAGE)
	
	# If an input file is fed that contains a modified social pack, the function should output true.
	EXPECTED_OUTPUT="true"

	# Assert the function that determines wheter a modified social package is contained, outputs the true value if 
	# a modified social package is contained.
	assert_equal "$ACTUAL_RESULT" "$EXPECTED_OUTPUT"
}