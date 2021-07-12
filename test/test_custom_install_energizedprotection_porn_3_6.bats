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

# Copy the source target file to a dummy that can be modified
cp "test/testfiles/hostfile_with_modified_social_pack.txt" "test/testfiles/dummy_hostfile_with_modified_social_pack.txt" 


# Method that executes all tested main code before running tests.
setup() {
	# print test filename to screen.
	if [ "${BATS_TEST_NUMBER}" = 1 ];then
		echo "# Testfile: $(basename "${BATS_TEST_FILENAME}")-" >&3
	fi
	
	# Declare filenames of scripts needed to test this step of the energized protection installer.
	# 0=Download the social package from this repo
	# 1=Unpack the downloaded social_package zip
	# 2=Check if the social package is in the target file and export the true-false boolean to a file.
	# 3=Exports the line number of the startline in an incoming file.
	# 4=export the total nr of lines in host file
	# 5=Export the number of remaining lines of the target file after the lines uptill the start line of social package are removed.
	# 6=Export the remaining lines of the target file after the lines uptill the start line of social package are removed.
	# 7=Creates a new output target file that contains the remainder after the detected starting line position.
	# 8=Outputs the absolute line end nr of the social package in the original host file.
	# 9=Export a boolean indicating whether the modified social package is contained.
	# 10=If modified social package is found in the input  path, remove it.
	# 11=Appends the new social pack if the unmodified social package is not yet included.
	declare -a script_names=("custom_install_3_energizedprotection")
	
	# Specify an additional array with arguments
	declare -a additional_arguments=("test/testfiles/dummy_hostfile_with_modified_porn_pack.txt")

	# Execute the files and commands needed to test this step of the energized protection installer.
	for i in "${!script_names[@]}"; do
		# Pass filename to function that executes the file and passes the argument(s).
		install_energized_protection_porn_package "${script_names[i]}" "${additional_arguments[i]}"	
	done
}


#-----------------------------------Test execution of custom_install_3_energizedprotection.sh-----------------------------------------------
@test "Tests whether the query that searches the start line outputs the correct line number also works for the modified social package" {
	
	# Read out the log file belonging to that contains the starting line number for the social package
	ACTUAL_RESULT=$(<$FILEPATH_PACKAGE_INDICATOR_LINE_NR)
	
	# The "test/testfiles/hostfile_without_social_pack_startline_at_end.txt" file has the modified social package, and unmodified social package starting line in line 33, hence expect 33.
	EXPECTED_OUTPUT="33"

	# Assert the function that gets the line number of the starting line of the social package also works for the modified social package.
	assert_equal "$ACTUAL_RESULT" "$EXPECTED_OUTPUT"
}