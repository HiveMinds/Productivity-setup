#!/bin/bash


# Downloads the social package with wget.
clone_opendetex_repo() {
	
	local LOG_PATH=$1
	
	local create_git_dir=$(mkdir -p $OPENDETEX_DIR)
	echo "create_git_dir:$create_git_dir" >&2
	
	local clone_opendetex_repo=$(git clone https://github.com/pkubowicz/opendetex.git $OPENDETEX_DIR)
	echo "clone_opendetex_repo:$clone_opendetex_repo" >&2
	
	# Export the wget_command_log_output to a log file.
	echo $clone_opendetex_repo > "${LOG_PATH}"
}


# Ensures this script executes the function above.
clone_opendetex_repo "$@"