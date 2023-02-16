#!/bin/bash


# Downloads the social package with wget.
make_install_opendetex() {
	
	local LOG_PATH=$1
	
	local make_install_opendetex=$(sudo make install -C $OPENDETEX_DIR)
	echo "make_install_opendetex:$make_install_opendetex" >&2
	
	# Export the wget_command_log_output to a log file.
	echo $make_install_opendetex > "${LOG_PATH}"
}


# Ensures this script executes the function above.
make_install_opendetex "$@"