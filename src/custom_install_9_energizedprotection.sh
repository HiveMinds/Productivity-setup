#!/bin/bash


# Exports a boolean indicating whether the modified social package is contained. Outputs true if the 
# modified social package is contained. Outputs false if the unmodified social package is contained 
# outputs false if no social package is contained.
contains_modified_social_package() {

	# Hardcoded variables:
	# FILEPATH_HOSTFILE_CONTAINS_UNMODIFIED_PACKAGE
	# FILEPATH_PACKAGE_INDICATOR_LINE_NR
	# FILEPATH_RELATIVE_ENDING_LINE_NR_OF_PACKAGE
	# FILEPATH_HOSTFILE_CONTAINS_MODIFIED_PACKAGE
	
	# Input variables:
	# None.
	
	# Relies on functions:
	# 2.
	# 3.
	# 7.
	
	# Receive a filepath that is scanned for the occurrence of the unmodified social package text.
	local package_type=$1
	local filepath_dummy_host=$2
	
	# Call child functions.
	# Remove old log files if exist
	if [ -f "$LOG_LOCATION""custom_install_8_energizedprotection"".txt" ] ; then
	    rm "$LOG_LOCATION""custom_install_8_energizedprotection"".txt"
	fi
	chmod +x ./src/custom_install_8_energizedprotection.sh
	source ./src/custom_install_8_energizedprotection.sh $package_type $filepath_dummy_host

	# Get boolean indicating whether exact social package is in target file.
	local target_contains_unmodified_social_package=$(<"$FILEPATH_HOSTFILE_CONTAINS_UNMODIFIED_PACKAGE")
	
	# Get the starting line of the social package in an input/target file.
	local line_nr_of_starting_line_in_target=$(<"$FILEPATH_PACKAGE_INDICATOR_LINE_NR")
	
	# Get the ending line of the social package in a log file that contains the remaining text
	# of an input/target file, after the starting line of the social package.
	local relative_end_line_nr=$(<"$FILEPATH_RELATIVE_ENDING_LINE_NR_OF_PACKAGE")	
	
	# Initialise default value that is outputted by this function.
	local target_contains_modified_social_package=false
	
	# Check if an input file contains the unmodified social package.
	if [ "$target_contains_unmodified_social_package" == "false" ]; then 
		
		# If no unmodified social package is found, check if a social package is found.
		if [ "$line_nr_of_starting_line_in_target" != "" ] && [ "$relative_end_line_nr" != "" ]; then
			
			# A social package is found, since it was not the unmodified social package, it must be modified.
			target_contains_modified_social_package=true
		
		fi
	
	fi
	
	# Export whether some input file contains a modified social package or not as a string.
	echo $target_contains_modified_social_package > "${FILEPATH_HOSTFILE_CONTAINS_MODIFIED_PACKAGE}"
}


# Ensures this script executes the function above.
contains_modified_social_package "$@"