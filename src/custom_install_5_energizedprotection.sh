#!/bin/bash


# Exports the amount of lines that exist between the starting line of the social package in
# some input file, and the last line of that input file.
Compute_amount_of_lines_between_starting_line_of_social_package_and_input_file_ending() {

	# Hardcoded variables:
	# FILEPATH_PACKAGE_INDICATOR_LINE_NR
	# FILEPATH_NR_LINES_HOSTFILE
	# FILEPATH_NR_LINES_IN_HOSTFILE_AFTER_PACKAGE_INDICATOR
	
	# Input variables:
	# None
	
	# Relies on functions:
	# 3. Get package indicator line nr (directly).
	# 4. Get total amount of lines in host file (directly).
	
	# Receive a filepath that is scanned for the occurrence of the unmodified social package text.
	local package_type=$1
	local filepath_dummy_host=$2
	
	# Call child functions.
	# Remove old log files if exist
	if [ -f "$LOG_LOCATION""custom_install_4_energizedprotection"".txt" ] ; then
	    rm "$LOG_LOCATION""custom_install_4_energizedprotection"".txt"
	fi
	chmod +x ./src/custom_install_4_energizedprotection.sh
	source ./src/custom_install_4_energizedprotection.sh $package_type $filepath_dummy_host

	# Read the starting nr line from the file that contains the starting line of an input file.
	local line_nr_package_indicator=$(<"$FILEPATH_PACKAGE_INDICATOR_LINE_NR")
	
	# Read the starting nr line from the file that contains the total amount of lines of an input file.
	local nr_lines_hostfile=$(<"$FILEPATH_NR_LINES_HOSTFILE")
		
	# Check if both line numbers are found by previously executed functions.
	if [ "$line_nr_package_indicator" != "" ] && [ "$nr_lines_hostfile" != "" ]; then
		
		# Compute the amount of lines between the starting line of the social package and the last
		# line of some input package.
		local nr_lines_in_hostfile_after_pacakge_indicator="$(("$nr_lines_hostfile"-"$line_nr_package_indicator"))"
		
		# Export how many lines remain in some input file, after the starting line in that input file. Output that number to a log file.
		echo "$nr_lines_in_hostfile_after_pacakge_indicator" > "${FILEPATH_NR_LINES_IN_HOSTFILE_AFTER_PACKAGE_INDICATOR}"
	fi 
}


# Ensures this script executes the function above.
Compute_amount_of_lines_between_starting_line_of_social_package_and_input_file_ending "$@"