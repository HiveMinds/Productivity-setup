#!/bin/bash
# Do something with a keyring
specify_keyring() {
	local LOG_PATH=$1
	#testone=$(-f "/etc/apt/trusted.gpg")
	#echo "testone=$testone"
	
	if [[ -f "/etc/apt/trusted.gpg" && -f "/usr/bin/apt-key" && "$(apt-key --keyring /etc/apt/trusted.gpg list dpkg@iris-advies.com)" = "" ]]; then
		echo "apt-key will show it is deprecated -- don't worry, we're just migrating the package signing key to a new format" > "${LOG_PATH}"
		sudo apt-key --keyring /etc/apt/trusted.gpg del 1C349BCF
	fi
	# Get some keys
	if [ -x "$(command -v curl)" ]; then
		curl --silent -L https://github.com/retorquere/zotero-deb/releases/download/apt-get/deb.gpg.key | gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/zotero.gpg --import -
	elif [ -x "$(command -v wget)" ]; then
		wget -qO- https://github.com/retorquere/zotero-deb/releases/download/apt-get/deb.gpg.key | gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/zotero.gpg --import -
	else
		echo "Error: need wget or curl installed." > "${LOG_PATH}"
		exit 1
	fi
}
specify_keyring "$@"