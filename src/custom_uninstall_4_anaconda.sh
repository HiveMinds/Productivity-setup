#!/bin/bash
# Source; https://docs.anaconda.com/anaconda/install/uninstall/
custom_uninstall() {
	local LOG_PATH=$1
	
	filepath=/home/$USER/.bashrc

	starting_line_query=$(grep -n "# >>> conda initialize >>>" $filepath)
	ending_line_query=$(grep -n "# <<< conda initialize <<<" $filepath)
	IFS=':'     # space is set as delimiter

	if [ "$starting_line_query" != "" ]; then
		if [ "$ending_line_query" != "" ]; then
			read -ra SEPARATED_STARTING_LINE_QUERY <<< "$starting_line_query"
			read -ra SEPARATED_ENDING_LINE_QUERY <<< "$ending_line_query"
			
			starting_line_nr=${SEPARATED_STARTING_LINE_QUERY[0]}
			ending_line_nr=${SEPARATED_ENDING_LINE_QUERY[0]}
			
			IFS=''     # remove delimiter to restore sed command functionality
			
			echo -n $(sed "${starting_line_nr},${ending_line_nr}d" $filepath) > $filepath
			echo $starting_line_query > "${LOG_PATH}"
			echo $ending_line_query >> "${LOG_PATH}"
			
		fi
	fi
}
custom_uninstall "$@"
