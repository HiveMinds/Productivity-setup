#!/bin/bash
source src/helper.sh

apt_install_zotero_11() {
	local LOG_PATH=$1
	
	# Get the random dir
	random_dirs="$(cd "/home/name/.zotero/zotero/" && ls)"
	while IFS= read -r line; do
			if [ "${line:8}" == ".default" ]; then
				found_dir="$line"
				echo "found_dir=$found_dir"
			fi
	done <<< "$random_dirs"
	extensions_json_path="/home/$(whoami)/.zotero/zotero/$found_dir/extensions.json"
	duplicated_json_path="src/submodules/zotero/duplicated.json"
	changed_id_path="src/submodules/zotero/changed_id.json"
	changed_path_path="src/submodules/zotero/changed_path.json"
	
	if [ -f "$extensions_json_path" ] ; then
		
		# TODO REMOVE BEFORE DEPLOYMENT
		#cp "/home/$(whoami)/Desktop/extensions.json" "$extensions_json_path"
		
		# read the current JSON file.
		json=$(cat "$extensions_json_path" | jq '.' )
		
		# Get the addons (only one).
		
		
		# Duplicate the addon, one for libreoffice, one for the extra addons
		# Source: https://stackoverflow.com/questions/48983196/how-can-i-duplicate-an-existing-object-within-a-json-array-using-jq
		# todo assert len addons =1
		duplicated=$(jq '.addons |= . + [.[-1]]' "$extensions_json_path")
		echo "$duplicated" > "$duplicated_json_path"
		#echo "duplicated=$duplicated"

		# todo assert len addons =2
		
		# Modify: id
		tmp=$(mktemp)
		changed_id=$(jq '.addons[1].id = "scihub@example.com"' "$duplicated_json_path")
		echo "$changed_id" > "$changed_id_path"
		#echo "changed_id=$changed_id"
		
		changed_id=$(jq '.addons[1].defaultLocale.name = "Sci-Hub Integration"' "$changed_id_path")
		echo "$changed_id" > "$changed_id_path"
		
		# Modify: syncGUID
		# Modify: path
		addon_dir="$PWD/src/submodules/zotero/zotero-scihub/build"
		changed_path=$(jq ".addons[1].path = \"$addon_dir\"" "$changed_id_path")
		echo "$changed_path" > "$extensions_json_path"
		
		# change location
		echo "$(jq ".addons[1].location = \"app-profile\"" "$extensions_json_path")" > "$extensions_json_path"
		
		# change location
		echo "$(jq ".addons[1].version = \"1.3.0\"" "$extensions_json_path")" > "$extensions_json_path"
		
		updateURL="https://github.com/ethanwillis/zotero-scihub/releases/download/release/update.rdf"
		echo "$(jq ".addons[1].updateURL= \"$updateURL\"" "$extensions_json_path")" > "$extensions_json_path"
		
		optionsURL="https://github.com/ethanwillis/zotero-scihub/releases/download/release/update.rdf"
		echo "$(jq ".addons[1].optionsURL= \"null\"" "$extensions_json_path")" > "$extensions_json_path"
		
		defaultLocale_name="Sci-Hub Plugin for Zotero"
		echo "$(jq ".addons[1].defaultLocale.name= \"$defaultLocale_name\"" "$extensions_json_path")" > "$extensions_json_path"
		
		defaultLocale_creator="ethanwillis"
		echo "$(jq ".addons[1].defaultLocale.name= \"$defaultLocale_creator\"" "$extensions_json_path")" > "$extensions_json_path"
		
		targetApplications_id="zotero@chnm.gmu.edu"
		echo "$(jq ".addons[1].targetApplications[0].id= \"$targetApplications_id\"" "$extensions_json_path")" > "$extensions_json_path"
		
		targetApplications_id="juris-m@juris-m.github.io"
		echo "$(jq ".addons[1].targetApplications[1].id= \"$targetApplications_id\"" "$extensions_json_path")" > "$extensions_json_path"
		
		targetApplications_minVersion="5.0.79"
		echo "$(jq ".addons[1].targetApplications[0].minVersion= \"$targetApplications_minVersion\"" "$extensions_json_path")" > "$extensions_json_path"
		
		targetApplications_minVersion="5.0.79"
		echo "$(jq ".addons[1].targetApplications[1].minVersion= \"$targetApplications_minVersion\"" "$extensions_json_path")" > "$extensions_json_path"
		
		iconURL="chrome://zotero-scihub/skin/sci-hub-logo.svg"
		echo "$(jq ".addons[1].iconURL= \"null\"" "$extensions_json_path")" > "$extensions_json_path"
		
		final_result=$(jq ".addons[1].location = \"app-profile\"" "$extensions_json_path")
		echo "final_result=$final_result"
		# Write the new combined json object to file.
		#read -p "FOUND file line_nr=$line_nr"
	else
		read -p "DID not find file at: $abs_filepath"
	fi
}
apt_install_zotero_11 "$@"
