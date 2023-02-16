#!/bin/bash


# Downloads the social package with wget.
custom_2_run_maven_test() {
	
	local LOG_PATH=$1
	
	local run_maven_test=$(mvn clean test -f $LANGUAGE_TOOL_DIR/pom.xml)
	echo "run_maven_test:$run_maven_test" >&2
	
	
	# Export the wget_command_log_output to a log file.
	echo $run_maven_test > "${LOG_PATH}"
}


# Ensures this script executes the function above.
custom_2_run_maven_test "$@"