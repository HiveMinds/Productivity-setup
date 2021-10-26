#!/bin/bash
install_prerequisites() {
	yes | sudo apt install wget
	yes | sudo apt install curl
}

# Verify this script is ran as root.
has_root_privilige() {
	if [ `whoami` != root ]; then
		echo Please run this script as root or using sudo
		exit
	fi
}
	
# Verify the architecture of the used device is compatible
is_valid_architecture() {
	case `uname -m` in
	"i386" | "i686" | "x86_64")
		;;
	*)
		echo "Zotero is only available for architectures i686 and x86_64"
		exit
		;;
	esac
}

# Do something with a keyring

specify_keyring() {	
	if [[ -f "/etc/apt/trusted.gpg" && -f "/usr/bin/apt-key" && "$(apt-key --keyring /etc/apt/trusted.gpg list dpkg@iris-advies.com)" = "" ]]; then
		echo "apt-key will show it is deprecated -- don't worry, we're just migrating the package signing key to a new format"
		sudo apt-key --keyring /etc/apt/trusted.gpg del 1C349BCF
	fi
	
	# Get some keys
	if [ -x "$(command -v curl)" ]; then
		curl --silent -L https://github.com/retorquere/zotero-deb/releases/download/apt-get/deb.gpg.key | gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/zotero.gpg --import -
	elif [ -x "$(command -v wget)" ]; then
		wget -qO- https://github.com/retorquere/zotero-deb/releases/download/apt-get/deb.gpg.key | gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/zotero.gpg --import -
	else
		echo "Error: need wget or curl installed." >&2
		exit 1
	fi
}

# Make some key accessible
modify_keyfile_permission() {		
	sudo chmod 644 /etc/apt/trusted.gpg.d/zotero.gpg
}

install_prerequisites "$@"
has_root_privilige "$@"
is_valid_architecture "$@"
specify_keyring "$@"
modify_keyfile_permission "$@"

# Get a list of files (that the zotero installation presumably uses).
cat << EOF | sudo tee /etc/apt/sources.list.d/zotero.list
deb https://github.com/retorquere/zotero-deb/releases/download/apt-get/ ./
EOF

