#!/bin/bash


# Exports the line number of the startline if it is found in an incoming file, to the a log file with a name that indicates it contains the line nr of the starting line/string
# of the social package. Else, exports an empty log file.
get_starting_line_of_social_package() {

	# Hardcoded variables:
	# SOCIAL_PACKAGE_INDICATOR_LINE
	# FILEPATH_PACKAGE_INDICATOR_LINE_NR
	#$SOCIAL_PACKAGE_INDICATOR_LINE
	
	# Input variables:
	# FILEPATH_DUMMY_HOST
	
	# Relies on functions:
	# 0. Download  host gz (indirectly).
	# 1. Unpack (directly).
	
	# Receive a filepath that is scanned for the occurrence of the unmodified social package text.
	local package_type=$1
	local filepath_dummy_host=$2
	
	# Call child functions.
	# Remove old log files if exist
	if [ -f "$LOG_LOCATION""custom_install_2_energizedprotection"".txt" ] ; then
	    rm "$LOG_LOCATION""custom_install_2_energizedprotection"".txt"
	fi
	chmod +x ./src/custom_install_2_energizedprotection.sh
	source ./src/custom_install_2_energizedprotection.sh $package_type $filepath_dummy_host
	
	if [ "$package_type" == "social" ]; then
		local package_indicator_line="$SOCIAL_PACKAGE_INDICATOR_LINE"
	elif [ "$package_type" == "porn" ]; then
		local package_indicator_line="$PORN_PACKAGE_INDICATOR_LINE"
	elif [ "$package_type" == "additional" ]; then
		local package_indicator_line="$ADDITIONAL_PACKAGE_INDICATOR_LINE"
	fi	
		
	# Get the line nr in which the startline of the social package occurs, in the input file.
	local package_indicator_line_nr="$(grep -n "$package_indicator_line" "$filepath_dummy_host" | head -n 1 | cut -d: -f1)"
	
	# Write the line number or empty string to the log file that stores the line number of the starting string/line of the social package.
	echo "$package_indicator_line_nr" > "${FILEPATH_PACKAGE_INDICATOR_LINE_NR}"
}


# Ensures this script executes the function above.
get_starting_line_of_social_package "$@"