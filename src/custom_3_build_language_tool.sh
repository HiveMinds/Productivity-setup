#!/bin/bash


# Downloads the social package with wget.
custom_3_build_language_tool() {
	
	local LOG_PATH=$1
	
	local build_project=$(mvn --projects languagetool-standalone --also-make package -DskipTests -f $LANGUAGE_TOOL_DIR/pom.xml)
	echo "build_project:$build_project" >&2
	
	
	# That created: languagetool-commandline.jar
	# In: /home/a/Documents/git/Productivity-setup/src/logs/language_tool/languagetool-standalone/target/LanguageTool-5.4-SNAPSHOT/LanguageTool-5.4-SNAPSHOT
	
	# Export the wget_command_log_output to a log file.
	echo $build_project > "${LOG_PATH}"
}


# Ensures this script executes the function above.
custom_3_build_language_tool "$@"