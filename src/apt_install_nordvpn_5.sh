
#!/bin/bash
apt_update() {
	local LOG_PATH=$1
	
	nordvpn_login=$(nordvpn connect)
	echo "output:$nordvpn_login" >&2
	echo $nordvpn_login > "${LOG_PATH}"
}
apt_update "$@"