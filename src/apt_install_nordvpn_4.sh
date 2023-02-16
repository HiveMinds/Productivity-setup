
#!/bin/bash
apt_update() {
	local LOG_PATH=$1
	echo "Starting nordvpn4" >&2
	
	Dedicated_IP=1.1.1.1 # TODO
	
	nordvpn_connect_dedicated_ip=$(nordvpn connect $Dedicated_IP)
	echo "output:$nordvpn_login" >&2
	echo $nordvpn_login > "${LOG_PATH}"
}
apt_update "$@"