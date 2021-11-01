#!/bin/bash

source src/helper.sh

# Specify Zotero application file location.
APPDIR="/home/$(whoami)/.local/share/applications"

# Source: https://askubuntu.com/questions/141229/how-to-add-a-shell-script-to-launcher-as-shortcut
# Copy the desktop.application file to settings.
{ # try
		sudo rm "$APPDIR/zotero.desktop"
		true
	} || { # catch
		true
	}
cp "src/submodules/zotero/zotero-standalone-build/linux/zotero.desktop"  "$APPDIR/zotero.desktop"

# Set launcher icon
if [ -w "$APPDIR/zotero.desktop" ]; then
	sed -i -e "s@^Icon=.*@Icon=$PWD/src/submodules/zotero/zotero-standalone-build/staging/Zotero_linux-x86_64/chrome/icons/default/default256.png@" "$APPDIR/zotero.desktop"
else
	echo "$APPDIR/zotero.desktop" is not writable
	exit 1
fi

# Change execution line:
new_exec_line="Exec=$PWD/src/submodules/zotero/zotero-standalone-build/staging/Zotero_linux-x86_64/zotero"
#echo "new_exec_line=$new_exec_line"

# Substitute old execution command with new execution command
line_nr=$(get_line_nr "Exec=" "$APPDIR/zotero.desktop")
replace_line_in_file_with_string "$line_nr" "$APPDIR/zotero.desktop" "$new_exec_line"