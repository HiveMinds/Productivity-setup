#!/bin/bash


# Outputs the absolute line end nr of the social package in the original host file.
get_line_nr_package_end_in_hostfile() {

	# Hardcoded variables:
	# FILEPATH_PACKAGE_INDICATOR_LINE_NR
	# FILEPATH_RELATIVE_ENDING_LINE_NR_OF_PACKAGE
	# FILEPATH_LINE_NR_PACKAGE_END_IN_HOSTFILE
	
	# Input variables:
	
	# Relies on functions:
	# 3. starting line
	# 6. copy_remaining_files_after_social_package_package_indicator_line_nr_to_log_file
	# 7.get_line_nr_of_first_ending_line_of_social_package
	
	# Receive a filepath that is scanned for the occurrence of the unmodified social package text.
	local package_type=$1
	local filepath_dummy_host=$2
	
	# Call child functions.
	# Remove old log files if exist
	if [ -f "$LOG_LOCATION""custom_install_7_energizedprotection"".txt" ] ; then
	    rm "$LOG_LOCATION""custom_install_7_energizedprotection"".txt"
	fi
	chmod +x ./src/custom_install_7_energizedprotection.sh
	source ./src/custom_install_7_energizedprotection.sh $package_type $filepath_dummy_host

	# Read the starting line of the social package from a log file.
	local line_nr_of_starting_line_in_target=$(<"$FILEPATH_PACKAGE_INDICATOR_LINE_NR")
	
	# Read the ending line of the social package from a log file that contains the remainder of 
	# the social package text after the starting line.
	local relative_end_line_nr=$(<"$FILEPATH_RELATIVE_ENDING_LINE_NR_OF_PACKAGE")
		
	# Check if both line numbers are read correctly.
	if [ "$line_nr_of_starting_line_in_target" != "" ] && [ "$relative_end_line_nr" != "" ]; then
		
		# Compute the absolute end line number of the social package in the target/input file.
		local line_nr_package_end_in_hostfile="$((line_nr_of_starting_line_in_target+relative_end_line_nr))"
	fi

	# Write the absolute line number of the ending string of the social package to a log file.
	echo $line_nr_package_end_in_hostfile > "${FILEPATH_LINE_NR_PACKAGE_END_IN_HOSTFILE}"
}


# Ensures this script executes the function above.
get_line_nr_package_end_in_hostfile "$@"