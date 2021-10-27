#!/bin/bash
# Verify the architecture of the used device is compatible
is_valid_architecture() {
	local LOG_PATH=$1
	architecture=$(uname -m)
	case "$architecture" in
	"i386" | "i686" | "x86_64")
		;;
	*)
		echo "Zotero is only available for architectures i686 and x86_64" > "${LOG_PATH}"
		exit
		;;
	esac
}
is_valid_architecture "$@"