#!/bin/bash


# Exports the text after the starting line to another log file, if the starting line is found. Else, it does nothing.
copy_remaining_files_after_social_package_package_indicator_line_nr_to_log_file() {

	# Hardcoded variables:
	# FILEPATH_REMAINING_LINES_HOSTFILE_AFTER_PACKAGE_INDICATOR
	# FILEPATH_PACKAGE_INDICATOR_LINE_NR
	
	# Input variables:
	# filepath_dummy_host----filepath_dummy_host
	
	# Relies on functions:
	# 3. Get package indicator line nr (directly).
	
	# Receive a filepath that is scanned for the occurrence of the unmodified social package text.
	local package_type=$1
	local filepath_dummy_host=$2
	
	# Call child functions.
	# Remove old log files if exist
	if [ -f "$LOG_LOCATION""custom_install_5_energizedprotection"".txt" ] ; then
	    rm "$LOG_LOCATION""custom_install_5_energizedprotection"".txt"
	fi
	chmod +x ./src/custom_install_5_energizedprotection.sh
	source ./src/custom_install_5_energizedprotection.sh $package_type $filepath_dummy_host

	# Copy the input file to a file that is destined to contain the remaining lines of this operation.
	cp "$filepath_dummy_host" "$FILEPATH_REMAINING_LINES_HOSTFILE_AFTER_PACKAGE_INDICATOR"

	# Read the starting line number that indicates presence of  the social package, from a log file.
	local package_indicator_line_nr=$(<"$FILEPATH_PACKAGE_INDICATOR_LINE_NR")
	
	# Check if the starting line is indeed found in some input file.
	if [ "$package_indicator_line_nr" != "" ]; then
		
		# Remove first n lines from the input file content, and write the remaining text into a new file, with n=package_indicator_line_nr.
		sed "1,${package_indicator_line_nr}d" "$filepath_dummy_host" > "$FILEPATH_REMAINING_LINES_HOSTFILE_AFTER_PACKAGE_INDICATOR"
	fi
}


# Ensures this script executes the function above.
copy_remaining_files_after_social_package_package_indicator_line_nr_to_log_file "$@"