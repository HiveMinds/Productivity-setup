#!/bin/bash


# Computes and exports the line nr of the first occurrence of the string "PACKAGE_END_INDICATOR_LINE", 
# in the file with the remaining lines after the start of the package. This ending line line nr is exported to a log file if the line/string is found. Else, creates empty log file.
get_line_nr_of_first_ending_line_of_social_package() {

	# Hardcoded variables:
	# PACKAGE_END_INDICATOR_LINE
	# FILEPATH_RELATIVE_ENDING_LINE_NR_OF_PACKAGE
	
	# Input variables:
	# None.
	
	# Relies on functions:
	
	# Receive a filepath that is scanned for the occurrence of the unmodified social package text.
	local package_type=$1
	local filepath_dummy_host=$2
	
	# Call child functions.
	# Remove old log files if exist
	if [ -f "$LOG_LOCATION""custom_install_6_energizedprotection"".txt" ] ; then
	    rm "$LOG_LOCATION""custom_install_6_energizedprotection"".txt"
	fi
	chmod +x ./src/custom_install_6_energizedprotection.sh
	source ./src/custom_install_6_energizedprotection.sh $package_type $filepath_dummy_host
		
	if [ "$package_type" == "social" ]; then
		local package_end_indicator_line="$SOCIAL_PACKAGE_END_INDICATOR_LINE"
	elif [ "$package_type" == "porn" ]; then
		local package_end_indicator_line="$PORN_PACKAGE_END_INDICATOR_LINE"
	elif [ "$package_type" == "additional" ]; then
		local package_end_indicator_line="$ADDITIONAL_PACKAGE_END_INDICATOR_LINE"
	fi
	
	# Gets the first occurrence of the ending line string of the social package some input file
	local line_nr_package_end_indicator_wrt_package_indicator="$(grep -n "$package_end_indicator_line" "$FILEPATH_REMAINING_LINES_HOSTFILE_AFTER_PACKAGE_INDICATOR" | head -n 1 | cut -d: -f1)"
	
	# Write the line number or empty string to the log file that stores the line number of the first
	#	occurrance of the ending string/line of the social package.
	echo "$line_nr_package_end_indicator_wrt_package_indicator" > "${FILEPATH_RELATIVE_ENDING_LINE_NR_OF_PACKAGE}"
}


# Ensures this script executes the function above.
get_line_nr_of_first_ending_line_of_social_package "$@"