#!/bin/bash


# Downloads the social package with wget.
clone_language_tool_repo() {
	
	local LOG_PATH=$1
	
	local create_git_dir=$(mkdir -p $LANGUAGE_TOOL_DIR)
	echo "create_git_dir:$create_git_dir" >&2
	
	local clone_languate_tool_repo=$(git clone --depth 5 https://github.com/languagetool-org/languagetool.git $LANGUAGE_TOOL_DIR)
	echo "clone_languate_tool_repo:$clone_languate_tool_repo" >&2
	
	# Export the wget_command_log_output to a log file.
	echo $clone_languate_tool_repo > "${LOG_PATH}"
}


# Ensures this script executes the function above.
clone_language_tool_repo "$@"