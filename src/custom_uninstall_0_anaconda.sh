#!/bin/bash
# Source; https://docs.anaconda.com/anaconda/install/uninstall/
custom_uninstall() {
	local LOG_PATH=$1
	
	# check if conda is installed
	COMMAND_OUTPUT=$(conda -V)
	COMMAND_OUTPUT_HEAD=${COMMAND_OUTPUT:0:8}
	
	if [ "$COMMAND_OUTPUT_HEAD" == "conda 4." ]; then
		#echo "FOUND ANACONDA"
		output=$(conda install anaconda-clean -y)
		echo $output > "${LOG_PATH}"
	fi
}
custom_uninstall "$@"
