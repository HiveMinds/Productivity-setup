#!/bin/bash


# Downloads the social package with wget.
make_opendetex() {
	
	local LOG_PATH=$1
	
	local make_opendetex=$(make -C $OPENDETEX_DIR)
	echo "make_opendetex:$make_opendetex" >&2
	
	# Export the wget_command_log_output to a log file.
	echo $make_opendetex > "${LOG_PATH}"
}


# Ensures this script executes the function above.
make_opendetex "$@"