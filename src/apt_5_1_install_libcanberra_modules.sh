#!/bin/bash
# Source: https://askubuntu.com/questions/342202/failed-to-load-module-canberra-gtk-module-but-already-installed#872397
apt_update() {
	local LOG_PATH=$1
	update=$(yes | sudo apt install libcanberra-gtk-module libcanberra-gtk3-module)
	echo $update > "${LOG_PATH}"
}
apt_update "$@"
