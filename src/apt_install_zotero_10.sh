#!/bin/bash
source src/helper.sh

apt_install_zotero_10() {
	local LOG_PATH=$1
	
	# Get the random dir
	random_dirs="$(cd "/home/$(whoami)/.zotero/zotero/" && ls)"
	while IFS= read -r line; do
			if [ "${line:8}" == ".default" ]; then
				found_dir="$line"
				echo "found_dir=$found_dir"
			fi
	done <<< "$random_dirs"
	abs_filepath="/home/$(whoami)/.zotero/zotero/$found_dir/prefs.js"
	
	if [ -f "$abs_filepath" ] ; then
	
		# remove two lines from prefs.js
		line_nr=$(get_line_nr "extensions.lastAppBuildId" "$abs_filepath")
		replace_line_in_file_with_string "$line_nr" "$abs_filepath" ""
		read -p "FOUND file line_nr=$line_nr"
	else
		read -p "DID not find file at: $abs_filepath"
	fi
}
apt_install_zotero_10 "$@"
