#!/bin/bash
apt_install_zotero_9() {
	local LOG_PATH=$1
	
	# Get the random dir
	random_dirs="$(cd "/home/$(whoami)/.zotero/zotero/" && ls)"
	while IFS= read -r line; do
			if [ "${line:8}" == ".default" ]; then
				found_dir="$line"
				echo "found_dir=$found_dir"
			fi
	done <<< "$random_dirs"
	zotero_dir="/home/$(whoami)/.zotero/zotero/$found_dir"
	
	# TODO: assert file exists
	#zotero "src/submodules/zotero-scihub-1.3.0.xpi"
	echo "zotero_dir=$zotero_dir"
	#if [ -d "~/.zotero/zotero/*/extensions" ] ; then
	#if [ -d "~/.zotero/zotero/sngvlbel.default/extensions/" ] ; then
	if [ -d "$zotero_dir/extensions" ] ; then
	#if [ -d "/home/$(whoami)/.zotero/zotero/*default/extensions" ] ; then
		cp "src/submodules/zotero-scihub/xpi/zotero-scihub-add-on.xpi" "$zotero_dir/extensions/"
		read -p "FOUND DIR"
	fi
}
apt_install_zotero_9 "$@"
