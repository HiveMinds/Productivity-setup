#!/bin/bash
# cleaning up artifact
apt_update() {
	local LOG_PATH=$1
	update=$(yes | sudo rm openvpn-repo-pkg-key.pub)
	echo $update > "${LOG_PATH}"
}
apt_update "$@"
